package moderation

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	appNotificationEvents "ola-chat-server/internal/domain/app-notification"
	userBanEvents "ola-chat-server/internal/domain/user-ban"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/notification"
	"ola-chat-server/internal/modules/session"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrUserNotFound      = utils.NewHTTPError(http.StatusNotFound, "Người vi phạm không còn tồn tại")
	ErrViolationNotFound = utils.NewHTTPError(http.StatusNotFound, "Không tìm thấy vi phạm hoặc vi phạm đã được gỡ")
)

type Service struct {
	repo           *Repository
	settings       *setting.Service
	notifications  *notification.Service
	sessionService *session.Service
	producer       *kafka.Producer
	logger         *zap.SugaredLogger
}

func NewService(repo *Repository, settings *setting.Service, notifications *notification.Service, sessionService *session.Service, producer *kafka.Producer, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:           repo,
		settings:       settings,
		notifications:  notifications,
		sessionService: sessionService,
		producer:       producer,
		logger:         logger.Named("[moderation_service]"),
	}
}

func (s *Service) RecordPenalty(tx *gorm.DB, in PenaltyInput) (*Penalty, error) {
	cfg, err := s.settings.GetModeration()
	if err != nil {
		return nil, err
	}
	repo := s.repo.WithTx(tx)
	now := time.Now().UTC()
	violation := &models.UserViolation{
		ID:             uuid.New(),
		UserID:         in.UserID,
		Source:         in.Source,
		TargetType:     in.TargetType,
		TargetID:       in.TargetID,
		ReportID:       in.ReportID,
		Reason:         in.Reason,
		Severity:       in.Severity,
		Points:         pointsFor(in.Severity, cfg),
		ContentRemoved: in.ContentRemoved,
		Note:           utils.TruncateRunes(strings.TrimSpace(in.Note), ViolationNoteMaxRunes),
		AdminID:        &in.AdminID,
		CreatedAt:      now,
	}
	result, err := repo.Record(violation, cfg, now)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, ErrUserNotFound
	}
	if err != nil {
		return nil, err
	}

	outcome := &PenaltyOutcome{
		Counted:   result.counted,
		Total:     result.total,
		Threshold: cfg.Threshold(),
		Locked:    result.locked,
	}
	if result.counted {
		outcome.Points = violation.Points
	}
	if result.lockedUntil != nil {
		outcome.LockedUntil = result.lockedUntil.Format(time.RFC3339)
	}
	return &Penalty{Outcome: outcome, input: in, violation: violation, result: result, cfg: cfg}, nil
}

func (s *Service) ApplyPenalty(p *Penalty) {
	var devices []appNotificationEvents.PushDevice
	if p.result.locked {
		devices = s.signedInDevices(p.input.UserID)
		s.EndSessions(p.input.UserID)
		s.logger.Infow("Account locked after reaching violation threshold", "user_id", p.input.UserID, "points", p.result.total, "locked_until", p.Outcome.LockedUntil)
	}
	if !p.result.counted || (p.violation.Points == 0 && !p.input.ContentRemoved) {
		return
	}
	message := violationMessage(p.input, p.violation.Points, p.result, p.cfg)
	if len(devices) > 0 {
		s.notifications.CreateForDevices(p.input.UserID, models.AppNotificationContentViolation, &p.violation.ID, message, devices)
		return
	}
	s.notifications.Create(p.input.UserID, nil, models.AppNotificationContentViolation, &p.violation.ID, message)
}

func (s *Service) signedInDevices(userID uuid.UUID) []appNotificationEvents.PushDevice {
	tokens, err := s.repo.ActiveDeviceTokens(userID)
	if err != nil {
		s.logger.Warnw("Failed to load devices before locking account", "user_id", userID, "error", err.Error())
		return nil
	}
	devices := make([]appNotificationEvents.PushDevice, 0, len(tokens))
	for _, t := range tokens {
		devices = append(devices, appNotificationEvents.PushDevice{Token: t.Token, Platform: t.Platform})
	}
	return devices
}

func (s *Service) NotifyReporters(reports []*models.Report) {
	notified := make(map[uuid.UUID]bool, len(reports))
	for _, r := range reports {
		if notified[r.ReporterID] {
			continue
		}
		notified[r.ReporterID] = true
		reportID := r.ID
		s.notifications.Create(r.ReporterID, nil, models.AppNotificationReportResolved, &reportID, reporterMessage(r.TargetType))
	}
}

func (s *Service) EndSessions(userID uuid.UUID) {
	if n, err := s.sessionService.RevokeAllForBannedUser(userID); err != nil {
		s.logger.Warnw("Failed to revoke sessions on ban", "user_id", userID, "error", err.Error())
	} else {
		s.logger.Infow("Revoked sessions on ban", "user_id", userID, "count", n)
	}
	event := &userBanEvents.Event{UserID: userID.String()}
	utils.PublishAsync(s.logger, "user banned", func(ctx context.Context) error {
		return s.producer.PublishUserBanned(ctx, event)
	})
}

func (s *Service) Summary(userID uuid.UUID) (*ViolationSummary, error) {
	cfg, err := s.settings.GetModeration()
	if err != nil {
		return nil, err
	}
	total, err := s.repo.ActivePoints(userID, cfg, time.Now().UTC())
	if err != nil {
		return nil, err
	}
	items, err := s.repo.ListByUser(userID, ViolationListLimit)
	if err != nil {
		return nil, err
	}
	summary := &ViolationSummary{
		Items:       make([]ViolationItem, 0, len(items)),
		Total:       total,
		Threshold:   cfg.Threshold(),
		ExpireHours: cfg.ExpireHours,
		LockSteps:   cfg.LockSteps,
	}
	for _, item := range items {
		summary.Items = append(summary.Items, toViolationItem(item))
	}
	return summary, nil
}

func (s *Service) Revoke(adminID, userID, violationID uuid.UUID) error {
	revoked, err := s.repo.Revoke(userID, violationID, adminID, time.Now().UTC())
	if err != nil {
		return err
	}
	if !revoked {
		return ErrViolationNotFound
	}
	return nil
}

func (s *Service) RevokeActive(adminID, userID uuid.UUID) (int64, error) {
	cfg, err := s.settings.GetModeration()
	if err != nil {
		return 0, err
	}
	return s.repo.RevokeActive(userID, adminID, cfg, time.Now().UTC())
}

func (s *Service) HiddenPostError(postID uuid.UUID) error {
	message := "Bài viết đã bị quản trị viên ẩn."
	violation, err := s.repo.LatestRemovalForTarget(constants.ReportTargetPost, postID.String())
	if err != nil {
		s.logger.Warnw("Failed to read hidden post violation", "post_id", postID, "error", err)
	}
	if violation != nil {
		message = fmt.Sprintf("Bài viết đã bị ẩn do %s.", reasonLabel(violation.Reason))
	}
	return utils.NewHTTPErrorWithCode(http.StatusForbidden, message, ErrorCodePostHiddenByAdmin)
}

func pointsFor(severity string, cfg setting.ModerationConfig) int {
	switch severity {
	case SeverityViolation:
		return 1
	case SeverityDeliberate:
		return cfg.DeliberatePoints
	default:
		return 0
	}
}

func reasonLabel(reason string) string {
	if label, ok := reasonLabels[reason]; ok {
		return label
	}
	return reasonLabels[reasonOther]
}

func contentLabel(targetType string) string {
	if label, ok := contentLabels[targetType]; ok {
		return label
	}
	return "Nội dung"
}

func violationMessage(in PenaltyInput, points int, result *recordResult, cfg setting.ModerationConfig) string {
	var b strings.Builder
	b.WriteString(contentLabel(in.TargetType))
	b.WriteString(" của bạn ")
	switch {
	case !in.ContentRemoved:
		b.WriteString("vi phạm tiêu chuẩn cộng đồng")
	case hiddenTargets[in.TargetType]:
		b.WriteString("đã bị ẩn")
	default:
		b.WriteString("đã bị xoá")
	}
	b.WriteString(" do ")
	b.WriteString(reasonLabel(in.Reason))
	b.WriteString(". ")
	switch {
	case points == 0:
		b.WriteString("Lần này không bị tính điểm vi phạm.")
		return b.String()
	case result.locked && result.lockedUntil != nil:
		fmt.Fprintf(&b, "Bạn đã có %d điểm vi phạm nên tài khoản bị khoá đến %s.", result.total, result.lockedUntil.In(vietnamTime).Format(lockTimeLayout))
	case result.locked:
		fmt.Fprintf(&b, "Bạn đã có %d điểm vi phạm nên tài khoản bị khoá vĩnh viễn.", result.total)
		return b.String()
	default:
		fmt.Fprintf(&b, "Bạn bị tính %d điểm vi phạm, hiện có %d điểm.", points, result.total)
	}
	if next, ok := cfg.NextStep(result.total); ok {
		fmt.Fprintf(&b, " Đủ %d điểm tài khoản sẽ bị khoá %s.", next.Points, lockDuration(next))
	}
	return b.String()
}

func lockDuration(step setting.ModerationLockStep) string {
	switch {
	case step.Permanent():
		return "vĩnh viễn"
	case step.Hours%24 == 0:
		return fmt.Sprintf("%d ngày", step.Hours/24)
	default:
		return fmt.Sprintf("%d giờ", step.Hours)
	}
}

func reporterMessage(targetType string) string {
	return fmt.Sprintf("Báo cáo của bạn về %s đã được xử lý. Cảm ơn bạn đã giúp cộng đồng an toàn hơn.", strings.ToLower(contentLabel(targetType)))
}
