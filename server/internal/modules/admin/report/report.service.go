package adminreport

import (
	"errors"
	"net/http"
	"strings"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

var ErrReportNotFound = utils.NewHTTPError(http.StatusNotFound, "report not found")

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{repo: repo}
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

	note := utils.TruncateRunes(strings.TrimSpace(req.Note), ReportHandlerNoteMax)
	affected, err := s.repo.HandleTarget(report, req.Status, note, adminID)
	if err != nil {
		return nil, err
	}

	updated, err := s.repo.FindByID(id)
	if err != nil {
		return nil, err
	}
	return &UpdateStatusResponse{Report: toReportItem(updated), Affected: affected}, nil
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
