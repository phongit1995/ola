package minigame

import (
	"errors"
	"regexp"
	"strings"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

var (
	ErrMiniGameNotFound = errors.New("mini game not found")
	ErrSlugTaken        = errors.New("slug already exists")
	ErrInvalidSlug      = errors.New("slug must be lowercase letters, numbers and dashes")

	slugPattern = regexp.MustCompile(`^[a-z0-9]+(-[a-z0-9]+)*$`)
)

type Service struct {
	repo *Repository
}

func NewService(repo *Repository) *Service {
	return &Service{repo: repo}
}

func (s *Service) ListEnabled() ([]models.MiniGame, error) {
	return s.repo.List(true)
}

func (s *Service) ListAll() (*MiniGameListResponse, error) {
	games, err := s.repo.List(false)
	if err != nil {
		return nil, err
	}
	return &MiniGameListResponse{Total: int64(len(games)), Items: games}, nil
}

func (s *Service) Create(req CreateMiniGameRequest) (*models.MiniGame, error) {
	slug := strings.TrimSpace(strings.ToLower(req.Slug))
	if !slugPattern.MatchString(slug) {
		return nil, ErrInvalidSlug
	}
	taken, err := s.repo.SlugExists(slug)
	if err != nil {
		return nil, err
	}
	if taken {
		return nil, ErrSlugTaken
	}

	game := &models.MiniGame{
		Slug:        slug,
		Name:        strings.TrimSpace(req.Name),
		Description: strings.TrimSpace(req.Description),
		IconURL:     strings.TrimSpace(req.IconURL),
		GameURL:     strings.TrimSpace(req.GameURL),
		IsEnabled:   true,
		SortOrder:   req.SortOrder,
	}
	if req.IsEnabled != nil {
		game.IsEnabled = *req.IsEnabled
	}
	if err := s.repo.Create(game); err != nil {
		return nil, err
	}
	return game, nil
}

func (s *Service) Update(id uuid.UUID, req UpdateMiniGameRequest) (*models.MiniGame, error) {
	game, err := s.repo.FindByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, ErrMiniGameNotFound
		}
		return nil, err
	}

	if req.Name != nil {
		game.Name = strings.TrimSpace(*req.Name)
	}
	if req.Description != nil {
		game.Description = strings.TrimSpace(*req.Description)
	}
	if req.IconURL != nil {
		game.IconURL = strings.TrimSpace(*req.IconURL)
	}
	if req.GameURL != nil {
		game.GameURL = strings.TrimSpace(*req.GameURL)
	}
	if req.IsEnabled != nil {
		game.IsEnabled = *req.IsEnabled
	}
	if req.SortOrder != nil {
		game.SortOrder = *req.SortOrder
	}

	if err := s.repo.Save(game); err != nil {
		return nil, err
	}
	return game, nil
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.repo.FindByID(id); err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return ErrMiniGameNotFound
		}
		return err
	}
	return s.repo.Delete(id)
}
