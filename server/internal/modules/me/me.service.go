package me

import (
	"errors"
	"time"

	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/moderation"
	"ola-chat-server/internal/modules/relationships"
	userModule "ola-chat-server/internal/modules/user"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"

	"github.com/google/uuid"
	"go.uber.org/dig"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type ClanGate interface {
	CanPost(userID, clanID uuid.UUID, visibility models.MeVisibility) error
	CanView(userID, clanID uuid.UUID) error
	OnPostDisabled(postID uuid.UUID)
}

type Service struct {
	repo           *Repository
	relRepo        *relationships.Repository
	userSettingSvc *usersetting.Service
	s3             *services.S3Service
	kafkaProducer  *kafka.Producer
	cache          *services.CacheService
	userCache      *userModule.CacheService
	clanGate       ClanGate
	moderation     *moderation.Service
	logger         *zap.SugaredLogger
}

type ServiceParams struct {
	dig.In

	Repo           *Repository
	RelRepo        *relationships.Repository
	UserSettingSvc *usersetting.Service
	S3             *services.S3Service
	KafkaProducer  *kafka.Producer
	Cache          *services.CacheService
	UserCache      *userModule.CacheService
	ClanGate       ClanGate            `optional:"true"`
	Moderation     *moderation.Service `optional:"true"`
	Logger         *zap.SugaredLogger
}

func NewService(p ServiceParams) *Service {
	return &Service{
		repo:           p.Repo,
		relRepo:        p.RelRepo,
		userSettingSvc: p.UserSettingSvc,
		s3:             p.S3,
		kafkaProducer:  p.KafkaProducer,
		cache:          p.Cache,
		userCache:      p.UserCache,
		clanGate:       p.ClanGate,
		moderation:     p.Moderation,
		logger:         p.Logger.Named("[post_service]"),
	}
}

var (
	errMaxImages            = errors.New("max 5 images")
	errMaxAudios            = errors.New("max 1 audio")
	errInvalidAudio         = errors.New("invalid post audio")
	errEmptyPost            = errors.New("post must have content or attachments")
	errPostNotFound         = errors.New("post not found")
	errNotYourPost          = errors.New("not your post")
	errEditExpired          = errors.New("post is too old to edit")
	errMeFriendsOnly        = errors.New("this profile is visible to friends only")
	errMeCommentFriendsOnly = errors.New("only friends can comment on this post")
	errClanUnavailable      = errors.New("clan posting is unavailable")
	errCannotPinClanPost    = errors.New("cannot pin a clan post")
	errInvalidImageCleanup  = errors.New("invalid post image cleanup request")
	errInvalidPostUpload    = errors.New("invalid or expired post image upload")
)

const editWindow = time.Hour

func (s *Service) getPost(id uuid.UUID) (*models.Me, error) {
	post, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errPostNotFound
		}
		return nil, err
	}
	return post, nil
}

func (s *Service) viewablePost(viewerID, postID uuid.UUID) (*models.Me, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if post.AuthorID == viewerID && hiddenByAdmin(post) && s.moderation != nil {
		return nil, s.moderation.HiddenPostError(postID)
	}
	if !s.canView(viewerID, post) {
		return nil, errPostNotFound
	}
	return post, nil
}

func hiddenByAdmin(post *models.Me) bool {
	return !post.Enabled && post.HiddenBy != nil && *post.HiddenBy == MeHiddenByAdmin
}

func (s *Service) ownedPost(userID, postID uuid.UUID) (*models.Me, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if post.AuthorID != userID {
		return nil, errNotYourPost
	}
	return post, nil
}

func (s *Service) canView(viewerID uuid.UUID, post *models.Me) bool {
	if !post.Enabled {
		return false
	}
	if post.ClanID != nil {
		if s.clanGate == nil {
			return false
		}
		return s.clanGate.CanView(viewerID, *post.ClanID) == nil
	}
	if post.Visibility == models.MeVisibilityPublic {
		return true
	}
	if post.AuthorID == viewerID {
		return true
	}
	if post.Visibility == models.MeVisibilityFriend {
		return s.isFriend(viewerID, post.AuthorID)
	}
	return false
}

func parseClanVisibility(value string) models.MeVisibility {
	if value == string(models.MeVisibilityPublic) {
		return models.MeVisibilityPublic
	}
	return models.MeVisibilityPrivate
}

func parseVisibility(value string) models.MeVisibility {
	switch value {
	case string(models.MeVisibilityFriend):
		return models.MeVisibilityFriend
	case string(models.MeVisibilityPrivate):
		return models.MeVisibilityPrivate
	default:
		return models.MeVisibilityPublic
	}
}

func (s *Service) isFriend(a, b uuid.UUID) bool {
	friends, _ := s.relRepo.AreFriends(a, b)
	return friends
}
