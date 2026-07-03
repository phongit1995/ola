package marriagediary

import (
	"errors"
	"strings"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrNotMarried    = errors.New("you must be married to use the diary")
	ErrEmptyContent  = errors.New("diary content cannot be empty")
	ErrEntryNotFound = errors.New("marriage diary entry not found")
	ErrNotYourEntry  = errors.New("diary entry does not belong to you")
)

type Service struct {
	repo   *Repository
	logger *zap.SugaredLogger
}

func NewService(repo *Repository, logger *zap.SugaredLogger) *Service {
	return &Service{repo: repo, logger: logger.Named("[marriage_diary_service]")}
}

func (s *Service) Create(userID uuid.UUID, req CreateDiaryRequest) (*DiaryEntryItem, error) {
	content := strings.TrimSpace(req.Content)
	if content == "" {
		return nil, ErrEmptyContent
	}

	marriageID, ok, err := s.repo.GetActiveMarriageID(userID)
	if err != nil {
		return nil, err
	}
	if !ok {
		return nil, ErrNotMarried
	}

	entry := &models.MarriageDiaryEntry{
		MarriageID: marriageID,
		AuthorID:   userID,
		Content:    content,
	}
	if err := s.repo.Create(entry); err != nil {
		return nil, err
	}

	created, err := s.repo.FindByID(entry.ID)
	if err != nil {
		return nil, err
	}
	item := toItem(created)
	return &item, nil
}

func (s *Service) List(userID uuid.UUID, limit, offset int) (*DiaryListResponse, error) {
	marriageID, ok, err := s.repo.GetActiveMarriageID(userID)
	if err != nil {
		return nil, err
	}
	if !ok {
		return nil, ErrNotMarried
	}

	items, total, err := s.repo.ListByMarriage(marriageID, limit, offset)
	if err != nil {
		return nil, err
	}
	out := make([]DiaryEntryItem, 0, len(items))
	for i := range items {
		out = append(out, toItem(&items[i]))
	}
	return &DiaryListResponse{Total: int(total), Limit: limit, Offset: offset, Items: out}, nil
}

func (s *Service) Delete(userID, entryID uuid.UUID) error {
	entry, err := s.repo.FindByID(entryID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrEntryNotFound
		}
		return err
	}
	if entry.AuthorID != userID {
		return ErrNotYourEntry
	}
	return s.repo.SoftDelete(entryID)
}

func toItem(e *models.MarriageDiaryEntry) DiaryEntryItem {
	item := DiaryEntryItem{
		ID:        e.ID.String(),
		Content:   e.Content,
		CreatedAt: e.CreatedAt.Format(time.RFC3339),
	}
	if e.Author != nil {
		item.Author = toBrief(e.Author)
	}
	return item
}

func toBrief(u *models.User) *UserBrief {
	return &UserBrief{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}
