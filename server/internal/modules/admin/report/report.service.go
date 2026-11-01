package adminreport

import (
	"errors"
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/moderation"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

var (
	ErrReportNotFound       = utils.NewHTTPError(http.StatusNotFound, "report not found")
	ErrPenaltyWithoutTarget = utils.NewHTTPError(http.StatusBadRequest, "Báo cáo này không có người bị báo cáo để tính vi phạm")
	ErrReportAlreadyHandled = utils.NewHTTPError(http.StatusConflict, "Báo cáo này đã được xử lý trước đó nên không tính điểm lại, tải lại trang để xem kết quả")
)

type Service struct {
	repo       *Repository
	moderation *moderation.Service
}

func NewService(repo *Repository, moderationService *moderation.Service) *Service {
	return &Service{repo: repo, moderation: moderationService}
}

func (s *Service) List(f ListFilter) (*ReportListResponse, error) {
	reports, total, err := s.repo.List(f)
	if err != nil {
		return nil, err
	}

	targetIDs := make([]string, 0, len(reports))
	for _, report := range reports {
		targetIDs = append(targetIDs, report.TargetID)
	}
	counts, err := s.repo.PendingCountsByTarget(targetIDs)
	if err != nil {
		return nil, err
	}

	items := make([]ReportItem, 0, len(reports))
	for _, report := range reports {
		item := toReportItem(report)
		item.SameTargetPending = counts[targetKey{TargetType: report.TargetType, TargetID: report.TargetID}]
		items = append(items, item)
	}
	return &ReportListResponse{Items: items, Total: total, Limit: f.Limit, Offset: f.Offset}, nil
}

func (s *Service) Summary() (*ReportSummaryResponse, error) {
	pending, err := s.repo.CountPending()
	if err != nil {
		return nil, err
	}
	return &ReportSummaryResponse{Pending: pending}, nil
}

func (s *Service) UpdateStatus(adminID, id uuid.UUID, req *UpdateStatusRequest) (*UpdateStatusResponse, error) {
	report, err := s.repo.FindByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrReportNotFound
		}
		return nil, err
	}

	resolved := req.Status == constants.ReportStatusResolved
	note := utils.TruncateRunes(strings.TrimSpace(req.Note), ReportHandlerNoteMax)
	var (
		penalty  *moderation.Penalty
		pending  []*models.Report
		affected int64
	)
	err = s.repo.Transaction(func(tx *gorm.DB, repo *Repository) error {
		locked, err := repo.LockTarget(report)
		if err != nil {
			return err
		}
		pending = pendingReports(locked)
		if resolved && req.Penalty != nil {
			if !stillUnresolved(locked, report.ID) {
				return ErrReportAlreadyHandled
			}
			if penalty, err = s.penalize(tx, adminID, report, req.Penalty, note); err != nil {
				return err
			}
		}
		affected, err = repo.HandleTarget(report, req.Status, note, adminID)
		return err
	})
	if err != nil {
		return nil, err
	}
	var outcome *moderation.PenaltyOutcome
	if penalty != nil {
		s.moderation.ApplyPenalty(penalty)
		outcome = penalty.Outcome
	}
	if resolved {
		s.moderation.NotifyReporters(pending)
	}

	updated, err := s.repo.FindByID(id)
	if err != nil {
		return nil, err
	}
	return &UpdateStatusResponse{Report: toReportItem(updated), Affected: affected, Penalty: outcome}, nil
}

func pendingReports(reports []*models.Report) []*models.Report {
	pending := make([]*models.Report, 0, len(reports))
	for _, r := range reports {
		if r.Status == constants.ReportStatusPending {
			pending = append(pending, r)
		}
	}
	return pending
}

func stillUnresolved(reports []*models.Report, id uuid.UUID) bool {
	for _, r := range reports {
		if r.ID == id {
			return r.Status != constants.ReportStatusResolved
		}
	}
	return false
}

func (s *Service) penalize(tx *gorm.DB, adminID uuid.UUID, report *models.Report, req *PenaltyRequest, note string) (*moderation.Penalty, error) {
	if report.ReportedUserID == nil {
		return nil, ErrPenaltyWithoutTarget
	}
	reportID := report.ID
	return s.moderation.RecordPenalty(tx, moderation.PenaltyInput{
		UserID:         *report.ReportedUserID,
		AdminID:        adminID,
		Source:         moderation.SourceReport,
		TargetType:     report.TargetType,
		TargetID:       report.TargetID,
		ReportID:       &reportID,
		Reason:         report.Reason,
		Severity:       req.Severity,
		Note:           note,
		ContentRemoved: req.ContentRemoved,
	})
}

func toReportItem(report *models.Report) ReportItem {
	item := ReportItem{
		ID:          report.ID.String(),
		TargetType:  report.TargetType,
		TargetID:    report.TargetID,
		Reason:      report.Reason,
		Note:        report.Note,
		Snapshot:    report.Snapshot,
		Status:      report.Status,
		HandlerNote: report.HandlerNote,
		CreatedAt:   report.CreatedAt.UTC().Format(time.RFC3339),
	}
	if report.ContextID != nil {
		item.ContextID = *report.ContextID
	}
	if report.HandledAt != nil {
		item.HandledAt = report.HandledAt.UTC().Format(time.RFC3339)
	}
	item.Reporter = toUserBrief(report.Reporter)
	item.ReportedUser = toUserBrief(report.ReportedUser)
	if report.Handler != nil {
		item.HandledBy = &AdminBrief{
			ID:       report.Handler.ID.String(),
			Username: report.Handler.Username,
			FullName: report.Handler.FullName,
		}
	}
	return item
}

func toUserBrief(user *models.User) *UserBrief {
	if user == nil {
		return nil
	}
	return &UserBrief{
		ID:       user.ID.String(),
		Username: user.Username,
		FullName: user.FullName,
		Avatar:   user.Avatar,
		IsActive: user.IsActive,
	}
}
