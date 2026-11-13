package room

import (
	"context"
	"errors"
	"net/http"
	"time"

	"ola-chat-server/internal/media"
	"ola-chat-server/internal/models"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var (
	ErrRoomFileTooLarge      = media.ErrFileTooLarge
	ErrRoomUploadRateLimit   = media.ErrUploadRateLimit
	ErrRoomUnsupportedImage  = media.ErrUnsupportedImage
	ErrRoomDecodeImage       = media.ErrDecodeImage
	ErrRoomMessageInProgress = media.ErrUploadInProgress
	errRoomTooManyRequests   = errors.New("too many requests")
	ErrRoomClientMessageUsed = errors.New("client message ID already used")
	ErrRoomBlockSelf         = errors.New("cannot block yourself")
	ErrRoomBlockUserNotFound = errors.New("user not found")
	ErrRoomBlockLimit        = errors.New("room block limit reached")
	ErrRoomVipRequired       = utils.NewHTTPErrorWithCode(http.StatusForbidden, "Phòng này chỉ dành cho thành viên VIP.", ErrorCodeRoomVipRequired)
)

type Service struct {
	repo      *Repository
	redisMsg  *RedisMessageRepository
	blockRepo *BlockRepository
	userCache *userModule.CacheService
	wsServer  *websocket.Server
	producer  *kafka.Producer
	cache     *services.CacheService
	s3        *services.S3Service
	logger    *zap.SugaredLogger
}

func NewService(repo *Repository, redisMsg *RedisMessageRepository, blockRepo *BlockRepository, userCache *userModule.CacheService, wsServer *websocket.Server, producer *kafka.Producer, cache *services.CacheService, s3 *services.S3Service, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:      repo,
		redisMsg:  redisMsg,
		blockRepo: blockRepo,
		userCache: userCache,
		wsServer:  wsServer,
		producer:  producer,
		cache:     cache,
		s3:        s3,
		logger:    logger.Named("[room_service]"),
	}
}

func (s *Service) Create(adminID uuid.UUID, req *CreateRoomRequest) (*RoomResponse, error) {
	room := &models.Room{
		Name:          req.Name,
		Description:   req.Description,
		ImageURL:      req.ImageURL,
		MaxMembers:    req.MaxMembers,
		Index:         req.Index,
		Enabled:       true,
		VipRequired:   req.VipRequired,
		VipMinMembers: req.VipMinMembers,
		CreatedBy:     adminID,
	}
	if err := s.repo.CreateAt(room, req.Index); err != nil {
		return nil, err
	}
	s.logger.Infow("Room created", "room_id", room.ID, "admin_id", adminID)
	return toRoomResponse(room, 0), nil
}

func (s *Service) Update(ctx context.Context, id uuid.UUID, req *UpdateRoomRequest) (*RoomResponse, error) {
	room, err := s.getRoom(id)
	if err != nil {
		return nil, err
	}
	if req.Name != nil {
		room.Name = *req.Name
	}
	if req.Description != nil {
		room.Description = *req.Description
	}
	if req.ImageURL != nil {
		room.ImageURL = *req.ImageURL
	}
	if req.MaxMembers != nil {
		room.MaxMembers = *req.MaxMembers
	}
	if req.Enabled != nil {
		room.Enabled = *req.Enabled
	}
	if req.VipRequired != nil {
		room.VipRequired = *req.VipRequired
	}
	if req.VipMinMembers != nil {
		room.VipMinMembers = *req.VipMinMembers
	}
	if req.Index != nil && *req.Index != room.Index {
		err = s.repo.SaveAt(room, *req.Index)
	} else {
		err = s.repo.SaveKeepingPosition(room)
	}
	if err != nil {
		return nil, err
	}
	count, _ := s.wsServer.GetRoomPresence().MemberCount(ctx, room.ID.String())
	return toRoomResponse(room, count), nil
}

func (s *Service) Reorder(ids []uuid.UUID) error {
	return s.repo.Reorder(ids)
}

func (s *Service) Delete(id uuid.UUID) error {
	if _, err := s.getRoom(id); err != nil {
		return err
	}
	return s.repo.SoftDelete(id)
}

func (s *Service) ListAdmin(ctx context.Context, query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListAll(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(ctx, rooms, total, limit, offset), nil
}

func (s *Service) ListPublic(ctx context.Context, query string, limit, offset int) (*RoomListResponse, error) {
	rooms, total, err := s.repo.ListPublic(query, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(ctx, rooms, total, limit, offset), nil
}

func (s *Service) GetByID(ctx context.Context, id uuid.UUID) (*RoomResponse, error) {
	room, err := s.getRoom(id)
	if err != nil {
		return nil, err
	}
	count, _ := s.wsServer.GetRoomPresence().MemberCount(ctx, id.String())
	return toRoomResponse(room, count), nil
}

func (s *Service) ListMembers(ctx context.Context, roomID uuid.UUID) (*RoomMembersResponse, error) {
	if _, err := s.getRoom(roomID); err != nil {
		return nil, err
	}
	ids, err := s.wsServer.GetRoomPresence().OnlineMembers(ctx, roomID.String())
	if err != nil {
		return nil, err
	}

	uuids := make([]uuid.UUID, 0, len(ids))
	for _, id := range ids {
		if uid, err := uuid.Parse(id); err == nil {
			uuids = append(uuids, uid)
		}
	}

	usersMap := s.userCache.GetUsersBatch(uuids, true)
	memberIDs := make([]string, 0, len(uuids))
	for _, uid := range uuids {
		memberIDs = append(memberIDs, uid.String())
	}
	presenceMap := s.wsServer.GetPresenceService().GetPresenceBatch(memberIDs)
	items := make([]RoomMemberResponse, 0, len(uuids))
	for _, uid := range uuids {
		u, ok := usersMap[uid]
		if !ok || u == nil {
			continue
		}
		member := RoomMemberResponse{
			UserID:     uid.String(),
			Username:   u.Username,
			FullName:   u.FullName,
			Avatar:     u.Avatar,
			Gender:     u.Gender,
			Bio:        u.Bio,
			BioImage:   u.BioImage,
			VipUsed:    u.VipUsed,
			DeviceType: presenceMap[uid.String()].DeviceType,
		}
		if u.VipEndTime != nil {
			vipEnd := u.VipEndTime.Format(time.RFC3339)
			member.VipEndTime = &vipEnd
		}
		items = append(items, member)
	}
	return &RoomMembersResponse{Items: items, Total: len(items)}, nil
}

func (s *Service) RequestJoin(ctx context.Context, userID, roomID uuid.UUID) (*JoinRoomResponse, error) {
	room, err := s.getRoom(roomID)
	if err != nil {
		return nil, err
	}
	if !room.Enabled {
		return nil, errors.New("room is disabled")
	}

	presence := s.wsServer.GetRoomPresence()
	if room.MaxMembers > 0 || room.VipRequired {
		isMember, err := presence.IsMember(ctx, roomID.String(), userID.String())
		if err != nil {
			return nil, err
		}
		if !isMember {
			count, err := presence.MemberCount(ctx, roomID.String())
			if err != nil {
				return nil, err
			}
			if room.MaxMembers > 0 && count >= room.MaxMembers {
				return nil, errors.New("room is full")
			}
			// shortcut: the VIP threshold is checked when the ticket is issued, so concurrent joins can pass it by a few; enforce it in presence.Join if it must be exact
			if room.VipRequired && count >= room.VipMinMembers && !s.hasActiveVip(userID) {
				return nil, ErrRoomVipRequired
			}
		}
	}

	ticket, err := presence.IssueJoinTicket(ctx, roomID.String(), userID.String(), room.MaxMembers)
	if err != nil {
		return nil, err
	}
	return &JoinRoomResponse{Ticket: ticket, ExpiresIn: websocket.RoomJoinTicketTTLSeconds}, nil
}

func (s *Service) RoomEnabled(roomID string) (bool, error) {
	id, err := uuid.Parse(roomID)
	if err != nil {
		return false, errors.New("invalid room id")
	}
	room, err := s.getRoom(id)
	if err != nil {
		return false, err
	}
	return room.Enabled, nil
}

func (s *Service) getRoom(id uuid.UUID) (*models.Room, error) {
	room, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("room not found")
		}
		return nil, err
	}
	return room, nil
}

func (s *Service) buildList(ctx context.Context, rooms []*models.Room, total int64, limit, offset int) *RoomListResponse {
	ids := make([]string, 0, len(rooms))
	for _, room := range rooms {
		ids = append(ids, room.ID.String())
	}
	counts := s.wsServer.GetRoomPresence().MemberCounts(ctx, ids)

	items := make([]RoomResponse, 0, len(rooms))
	for _, room := range rooms {
		items = append(items, *toRoomResponse(room, counts[room.ID.String()]))
	}
	return &RoomListResponse{Items: items, Total: total, Limit: limit, Offset: offset}
}

func (s *Service) hasActiveVip(userID uuid.UUID) bool {
	u, err := s.userCache.GetUserCache(userID, true)
	return err == nil && u.HasActiveVip(time.Now())
}

func toRoomResponse(room *models.Room, memberCount int) *RoomResponse {
	return &RoomResponse{
		ID:            room.ID.String(),
		Name:          room.Name,
		Description:   room.Description,
		ImageURL:      room.ImageURL,
		MaxMembers:    room.MaxMembers,
		Index:         room.Index,
		MemberCount:   memberCount,
		Enabled:       room.Enabled,
		VipRequired:   room.VipRequired,
		VipMinMembers: room.VipMinMembers,
		CreatedBy:     room.CreatedBy.String(),
		CreatedAt:     room.CreatedAt.UTC().Format(time.RFC3339),
	}
}
