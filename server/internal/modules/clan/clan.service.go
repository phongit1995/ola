package clan

import (
	"bytes"
	"context"
	"errors"
	"fmt"
	"image"
	_ "image/gif"
	_ "image/jpeg"
	_ "image/png"
	"io"
	"mime/multipart"
	"net/http"
	"regexp"
	"strings"
	"time"

	_ "golang.org/x/image/webp"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/me"
	"ola-chat-server/internal/modules/notification"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	errInvalidHandle    = errors.New("clan name must be 2-32 lowercase letters or digits, no spaces or accents")
	errInvalidPolicy    = errors.New("invalid clan policy")
	errOnlyOwner        = errors.New("only the clan owner can do this")
	errOnlyStaff        = errors.New("only clan staff can do this")
	errCannotBanOwner   = errors.New("cannot ban clan staff")
	errClanImageMissing = errors.New("image file is required")
)

var handlePattern = regexp.MustCompile(`^[a-z0-9]{2,32}$`)

type Service struct {
	repo            *Repository
	meService       *me.Service
	meRepo          *me.Repository
	notificationSvc *notification.Service
	userCache       *userModule.CacheService
	wsServer        *websocket.Server
	s3              *services.S3Service
	cache           *services.CacheService
	cfg             *config.Config
	logger          *zap.SugaredLogger
}

func NewService(
	repo *Repository,
	meService *me.Service,
	meRepo *me.Repository,
	notificationSvc *notification.Service,
	userCache *userModule.CacheService,
	wsServer *websocket.Server,
	s3 *services.S3Service,
	cache *services.CacheService,
	cfg *config.Config,
	logger *zap.SugaredLogger,
) *Service {
	return &Service{
		repo:            repo,
		meService:       meService,
		meRepo:          meRepo,
		notificationSvc: notificationSvc,
		userCache:       userCache,
		wsServer:        wsServer,
		s3:              s3,
		cache:           cache,
		cfg:             cfg,
		logger:          logger.Named("[clan_service]"),
	}
}

func NormalizeHandle(name string) (string, error) {
	handle := strings.ToLower(strings.TrimSpace(name))
	handle = strings.TrimPrefix(handle, "#")
	if !handlePattern.MatchString(handle) {
		return "", errInvalidHandle
	}
	return handle, nil
}

func (s *Service) CheckName(name string) (*CheckNameResponse, error) {
	handle, err := NormalizeHandle(name)
	if err != nil {
		return nil, err
	}

	resp := &CheckNameResponse{Name: handle, Cost: s.cfg.ClanCreateCost}
	clan, err := s.repo.GetByHandle(handle)
	if err != nil {
		if errors.Is(err, ErrClanNotFound) {
			resp.Available = true
			return resp, nil
		}
		return nil, err
	}

	preview := &ClanPreviewResponse{
		Handle:      clan.Handle,
		MemberCount: clan.MemberCount,
		VisitCount:  clan.VisitCount,
	}
	staff, err := s.repo.GetStaff(clan.ID)
	if err == nil {
		for i := range staff {
			if staff[i].User == nil {
				continue
			}
			switch staff[i].Role {
			case models.ClanRoleOwner:
				preview.Owner = staff[i].User.Username
			case models.ClanRoleDeputy:
				preview.Deputy = staff[i].User.Username
			case models.ClanRoleAmbassador:
				preview.Ambassador = staff[i].User.Username
			}
		}
	}
	resp.Clan = preview
	return resp, nil
}

func (s *Service) Create(userID uuid.UUID, req *CreateClanRequest) (*ClanResponse, error) {
	handle, err := NormalizeHandle(req.Name)
	if err != nil {
		return nil, err
	}

	result, err := s.repo.CreateClan(CreateClanParams{
		OwnerID:     userID,
		Handle:      handle,
		Description: strings.TrimSpace(req.Description),
		Cost:        s.cfg.ClanCreateCost,
	})
	if err != nil {
		return nil, err
	}

	s.invalidateUser(userID)
	s.emitKenUpdate(userID, result.KenBalance)
	s.logger.Infow("Clan created", "clan_id", result.Clan.ID, "handle", handle, "owner_id", userID, "cost", s.cfg.ClanCreateCost)

	resp, err := s.buildClanResponse(userID, result.Clan)
	if err != nil {
		return nil, err
	}
	balance := result.KenBalance
	resp.KenBalance = &balance
	return resp, nil
}

func (s *Service) Mine(userID uuid.UUID) ([]ClanResponse, error) {
	clans, err := s.repo.ListByUser(userID)
	if err != nil {
		return nil, err
	}
	items := make([]ClanResponse, 0, len(clans))
	for i := range clans {
		resp, err := s.buildClanResponse(userID, &clans[i])
		if err != nil {
			return nil, err
		}
		items = append(items, *resp)
	}
	return items, nil
}

func (s *Service) GetByID(viewerID, clanID uuid.UUID) (*ClanResponse, error) {
	clan, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	return s.viewClan(viewerID, clan)
}

func (s *Service) GetByHandle(viewerID uuid.UUID, name string) (*ClanResponse, error) {
	handle, err := NormalizeHandle(name)
	if err != nil {
		return nil, err
	}
	clan, err := s.repo.GetByHandle(handle)
	if err != nil {
		return nil, err
	}
	return s.viewClan(viewerID, clan)
}

func (s *Service) viewClan(viewerID uuid.UUID, clan *models.Clan) (*ClanResponse, error) {
	s.trackVisit(viewerID, clan.ID)
	return s.buildClanResponse(viewerID, clan)
}

func (s *Service) trackVisit(viewerID, clanID uuid.UUID) {
	if s.cache == nil {
		return
	}
	key := fmt.Sprintf(constants.CacheKeyClanVisitGuard, clanID.String(), viewerID.String())
	acquired, err := s.cache.SetNX(key, "1", time.Duration(constants.ClanVisitGuardTTLSeconds)*time.Second)
	if err != nil || !acquired {
		return
	}
	utils.SafeGo(s.logger, func() {
		if err := s.repo.IncrementVisit(clanID); err != nil {
			s.logger.Warnw("Failed to increment clan visit count", "clan_id", clanID, "error", err.Error())
		}
	})
}

func (s *Service) Update(userID, clanID uuid.UUID, req *UpdateClanRequest) (*ClanResponse, error) {
	clan, err := s.requireOwner(userID, clanID)
	if err != nil {
		return nil, err
	}

	updates := map[string]interface{}{}
	if req.Description != nil {
		updates["description"] = strings.TrimSpace(*req.Description)
	}
	if req.Policy != nil {
		policy := models.ClanPolicy(*req.Policy)
		if !policy.Valid() {
			return nil, errInvalidPolicy
		}
		updates["policy"] = policy
	}
	if req.MemberPublicPost != nil {
		updates["member_public_post"] = *req.MemberPublicPost
	}
	if len(updates) > 0 {
		if err := s.repo.UpdateFields(clan.ID, updates); err != nil {
			return nil, err
		}
	}

	if req.MemberPublicPost != nil && !*req.MemberPublicPost && clan.MemberPublicPost {
		staff, err := s.repo.GetStaff(clan.ID)
		if err != nil {
			return nil, err
		}
		keep := make([]uuid.UUID, 0, 2)
		for i := range staff {
			if staff[i].Role == models.ClanRoleOwner || staff[i].Role == models.ClanRoleDeputy {
				keep = append(keep, staff[i].UserID)
			}
		}
		if err := s.meRepo.DowngradeClanPublicPosts(clan.ID, keep); err != nil {
			return nil, err
		}
	}

	updated, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	return s.buildClanResponse(userID, updated)
}

func (s *Service) Join(userID, clanID uuid.UUID) (*ClanResponse, error) {
	clan, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	if clan.Policy == models.ClanPolicyClosed {
		return nil, ErrClanClosed
	}
	banned, err := s.repo.IsBanned(clanID, userID)
	if err != nil {
		return nil, err
	}
	if banned {
		return nil, ErrClanBanned
	}
	if err := s.repo.Join(clanID, userID); err != nil {
		return nil, err
	}

	updated, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	return s.buildClanResponse(userID, updated)
}

func (s *Service) Leave(userID, clanID uuid.UUID) (*ClanResponse, error) {
	member, err := s.repo.GetMember(clanID, userID)
	if err != nil {
		return nil, err
	}
	if member == nil {
		return nil, ErrNotClanMember
	}
	if member.Role == models.ClanRoleOwner {
		return nil, ErrOwnerCannotLeave
	}
	if err := s.repo.Leave(clanID, userID); err != nil {
		return nil, err
	}

	updated, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	return s.buildClanResponse(userID, updated)
}

func (s *Service) Members(viewerID, clanID uuid.UUID, verifiedOnly bool, limit, offset int) (*MemberListResponse, error) {
	if err := s.repo.CanView(viewerID, clanID); err != nil {
		return nil, err
	}

	members, total, err := s.repo.ListMembers(clanID, verifiedOnly, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]MemberResponse, 0, len(members))
	for i := range members {
		items = append(items, MemberResponse{
			User:     toClanUserResponse(members[i].User),
			Role:     string(members[i].Role),
			Verified: members[i].Verified,
			JoinedAt: members[i].CreatedAt.UTC().Format(time.RFC3339),
		})
	}
	return &MemberListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) AssignRole(userID, clanID uuid.UUID, req *AssignRoleRequest) (*ClanResponse, error) {
	clan, err := s.requireOwner(userID, clanID)
	if err != nil {
		return nil, err
	}
	role := models.ClanRole(req.Role)
	if role != models.ClanRoleDeputy && role != models.ClanRoleAmbassador {
		return nil, errors.New("invalid clan role")
	}

	target, err := s.repo.FindUserByUsername(req.Username)
	if err != nil {
		return nil, err
	}
	banned, err := s.repo.IsBanned(clanID, target.ID)
	if err != nil {
		return nil, err
	}
	if banned {
		return nil, ErrClanBanned
	}

	if err := s.repo.AssignRole(clanID, target.ID, role); err != nil {
		return nil, err
	}

	actorID := userID
	s.notificationSvc.Create(target.ID, &actorID, models.AppNotificationClanRoleAssigned, &clan.ID, "#"+clan.Handle+" · "+string(role))

	updated, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	return s.buildClanResponse(userID, updated)
}

func (s *Service) RevokeRole(userID, clanID uuid.UUID, roleName string) (*ClanResponse, error) {
	clan, err := s.requireOwner(userID, clanID)
	if err != nil {
		return nil, err
	}
	role := models.ClanRole(roleName)
	if role != models.ClanRoleDeputy && role != models.ClanRoleAmbassador {
		return nil, errors.New("invalid clan role")
	}

	member, err := s.repo.RevokeRole(clanID, role)
	if err != nil {
		return nil, err
	}

	actorID := userID
	s.notificationSvc.Create(member.UserID, &actorID, models.AppNotificationClanRoleRevoked, &clan.ID, "#"+clan.Handle+" · "+string(role))

	updated, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	return s.buildClanResponse(userID, updated)
}

func (s *Service) SetVerified(userID, clanID uuid.UUID, username string, verified bool) error {
	clan, err := s.requireOwner(userID, clanID)
	if err != nil {
		return err
	}
	target, err := s.repo.FindUserByUsername(username)
	if err != nil {
		return err
	}
	if err := s.repo.SetVerified(clanID, target.ID, verified); err != nil {
		return err
	}

	actorID := userID
	ntype := models.AppNotificationClanVerified
	if !verified {
		ntype = models.AppNotificationClanUnverified
	}
	s.notificationSvc.Create(target.ID, &actorID, ntype, &clan.ID, "#"+clan.Handle)
	return nil
}

func (s *Service) Ban(userID, clanID uuid.UUID, username string) error {
	clan, err := s.requireStaff(userID, clanID)
	if err != nil {
		return err
	}
	target, err := s.repo.FindUserByUsername(username)
	if err != nil {
		return err
	}
	if target.ID == clan.OwnerID {
		return errCannotBanOwner
	}
	if err := s.repo.Ban(clanID, target.ID, userID); err != nil {
		return err
	}

	actorID := userID
	s.notificationSvc.Create(target.ID, &actorID, models.AppNotificationClanBanned, &clan.ID, "#"+clan.Handle)
	return nil
}

func (s *Service) Unban(userID, clanID, targetID uuid.UUID) error {
	if _, err := s.requireStaff(userID, clanID); err != nil {
		return err
	}
	return s.repo.Unban(clanID, targetID)
}

func (s *Service) Bans(userID, clanID uuid.UUID, limit, offset int) (*BanListResponse, error) {
	if _, err := s.requireStaff(userID, clanID); err != nil {
		return nil, err
	}
	bans, total, err := s.repo.ListBans(clanID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]BanResponse, 0, len(bans))
	for i := range bans {
		items = append(items, BanResponse{
			User:     toClanUserResponse(bans[i].User),
			BannedAt: bans[i].CreatedAt.UTC().Format(time.RFC3339),
		})
	}
	return &BanListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) CreatePost(userID, clanID uuid.UUID, req *me.CreateMeRequest) (*me.MeResponse, error) {
	return s.meService.CreateClanPost(userID, clanID, req)
}

func (s *Service) Posts(viewerID, clanID uuid.UUID, cursor string, limit int) (*ClanPostsResponse, error) {
	clan, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	if err := s.repo.CanView(viewerID, clanID); err != nil {
		return nil, err
	}

	feed, err := s.meService.ClanFeed(viewerID, clanID, clan.MeTopPostID, cursor, limit)
	if err != nil {
		return nil, err
	}

	resp := &ClanPostsResponse{Items: feed.Items, NextCursor: feed.NextCursor}
	if clan.MeTopPostID != nil && cursor == "" {
		if pinned, err := s.meService.GetByID(viewerID, *clan.MeTopPostID); err == nil {
			resp.Pinned = pinned
		}
	}
	return resp, nil
}

func (s *Service) Pin(userID, clanID, postID uuid.UUID) error {
	if _, err := s.requireStaff(userID, clanID); err != nil {
		return err
	}
	post, err := s.meRepo.GetByID(postID)
	if err != nil {
		return ErrNotClanPost
	}
	if post.ClanID == nil || *post.ClanID != clanID || !post.Enabled {
		return ErrNotClanPost
	}
	return s.repo.SetMeTop(clanID, &postID)
}

func (s *Service) Unpin(userID, clanID uuid.UUID) error {
	if _, err := s.requireStaff(userID, clanID); err != nil {
		return err
	}
	return s.repo.SetMeTop(clanID, nil)
}

func (s *Service) DeletePost(userID, clanID, postID uuid.UUID) error {
	if _, err := s.requireStaff(userID, clanID); err != nil {
		return err
	}
	post, err := s.meRepo.GetByID(postID)
	if err != nil {
		return ErrNotClanPost
	}
	if post.ClanID == nil || *post.ClanID != clanID {
		return ErrNotClanPost
	}
	if err := s.meRepo.Disable(postID); err != nil {
		return err
	}
	s.repo.OnPostDisabled(postID)
	return nil
}

func (s *Service) DeletePostsByUser(userID, clanID, authorID uuid.UUID) error {
	clan, err := s.requireStaff(userID, clanID)
	if err != nil {
		return err
	}
	if err := s.meRepo.DisableAllByClanAuthor(clanID, authorID); err != nil {
		return err
	}
	if clan.MeTopPostID != nil {
		if pinned, err := s.meRepo.GetByID(*clan.MeTopPostID); err == nil && !pinned.Enabled {
			_ = s.repo.SetMeTop(clanID, nil)
		}
	}
	return nil
}

func (s *Service) UploadAvatar(ctx context.Context, userID, clanID uuid.UUID, fileHeader *multipart.FileHeader) (*UploadClanImageResponse, error) {
	return s.uploadClanImage(ctx, userID, clanID, fileHeader, "avatar")
}

func (s *Service) UploadCover(ctx context.Context, userID, clanID uuid.UUID, fileHeader *multipart.FileHeader) (*UploadClanImageResponse, error) {
	return s.uploadClanImage(ctx, userID, clanID, fileHeader, "cover")
}

func (s *Service) uploadClanImage(ctx context.Context, userID, clanID uuid.UUID, fileHeader *multipart.FileHeader, field string) (*UploadClanImageResponse, error) {
	clan, err := s.requireOwner(userID, clanID)
	if err != nil {
		return nil, err
	}
	if fileHeader == nil {
		return nil, errClanImageMissing
	}
	if fileHeader.Size > constants.MaxImageUploadSize {
		return nil, errors.New("image too large")
	}

	file, err := fileHeader.Open()
	if err != nil {
		return nil, errors.New("failed to open image")
	}
	defer file.Close()

	head := make([]byte, 512)
	n, _ := io.ReadFull(file, head)
	head = head[:n]
	mimeType := http.DetectContentType(head)
	if !isAllowedImageMime(mimeType) {
		return nil, errors.New("unsupported image type")
	}

	rest, err := io.ReadAll(file)
	if err != nil {
		return nil, errors.New("failed to read image")
	}
	data := append(head, rest...)
	if int64(len(data)) > constants.MaxImageUploadSize {
		return nil, errors.New("image too large")
	}
	if _, _, err := image.DecodeConfig(bytes.NewReader(data)); err != nil {
		return nil, errors.New("failed to decode image")
	}

	folder := fmt.Sprintf("%s/%s", constants.UploadFolderClans, time.Now().Format(constants.UploadDateLayout))
	upload, err := s.s3.UploadFile(ctx, &clanFileReader{Reader: bytes.NewReader(data)}, field+extensionForMime(mimeType), folder)
	if err != nil {
		s.logger.Errorw("Failed to upload clan image", "clan_id", clan.ID, "field", field, "error", err)
		return nil, errors.New("failed to upload image")
	}

	if err := s.repo.UpdateFields(clan.ID, map[string]interface{}{field: upload.URL}); err != nil {
		return nil, err
	}
	return &UploadClanImageResponse{URL: upload.URL}, nil
}

func (s *Service) requireOwner(userID, clanID uuid.UUID) (*models.Clan, error) {
	clan, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	if clan.OwnerID != userID {
		return nil, errOnlyOwner
	}
	return clan, nil
}

func (s *Service) requireStaff(userID, clanID uuid.UUID) (*models.Clan, error) {
	clan, err := s.repo.GetByID(clanID)
	if err != nil {
		return nil, err
	}
	if clan.OwnerID == userID {
		return clan, nil
	}
	member, err := s.repo.GetMember(clanID, userID)
	if err != nil {
		return nil, err
	}
	if member == nil || member.Role != models.ClanRoleDeputy {
		return nil, errOnlyStaff
	}
	return clan, nil
}

func (s *Service) buildClanResponse(viewerID uuid.UUID, clan *models.Clan) (*ClanResponse, error) {
	resp := &ClanResponse{
		ID:               clan.ID.String(),
		Handle:           clan.Handle,
		Description:      clan.Description,
		Avatar:           clan.Avatar,
		Cover:            clan.Cover,
		Policy:           int16(clan.Policy),
		MemberPublicPost: clan.MemberPublicPost,
		MemberCount:      clan.MemberCount,
		VisitCount:       clan.VisitCount,
		CreatedAt:        clan.CreatedAt.UTC().Format(time.RFC3339),
	}
	if clan.MeTopPostID != nil {
		resp.MeTopPostID = clan.MeTopPostID.String()
	}

	staff, err := s.repo.GetStaff(clan.ID)
	if err != nil {
		return nil, err
	}
	for i := range staff {
		user := toClanUserResponse(staff[i].User)
		switch staff[i].Role {
		case models.ClanRoleOwner:
			resp.Owner = user
		case models.ClanRoleDeputy:
			resp.Deputy = user
		case models.ClanRoleAmbassador:
			resp.Ambassador = user
		}
	}
	if resp.Owner == nil && clan.Owner != nil {
		resp.Owner = toClanUserResponse(clan.Owner)
	}

	member, err := s.repo.GetMember(clan.ID, viewerID)
	if err != nil {
		return nil, err
	}
	if member != nil {
		resp.MyRole = string(member.Role)
		resp.MyVerified = member.Verified
		resp.IsMember = true
	}
	banned, err := s.repo.IsBanned(clan.ID, viewerID)
	if err != nil {
		return nil, err
	}
	resp.IsBanned = banned
	return resp, nil
}

func (s *Service) emitKenUpdate(userID uuid.UUID, ken int) {
	if s.wsServer == nil {
		return
	}
	payload := utils.WrapWebSocketMessage(constants.WebSocketEventKenUpdated, map[string]interface{}{
		"ken": ken,
	})
	s.wsServer.EmitToUser(userID.String(), constants.WebSocketMessageEvent, payload)
}

func (s *Service) invalidateUser(userID uuid.UUID) {
	if err := s.userCache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after clan create", "user_id", userID, "error", err.Error())
	}
}

func toClanUserResponse(u *models.User) *ClanUserResponse {
	if u == nil {
		return nil
	}
	return &ClanUserResponse{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}

func isAllowedImageMime(mime string) bool {
	for _, m := range constants.AllowedImageMimes {
		if strings.EqualFold(m, mime) {
			return true
		}
	}
	return false
}

func extensionForMime(mime string) string {
	switch mime {
	case "image/png":
		return ".png"
	case "image/gif":
		return ".gif"
	case "image/webp":
		return ".webp"
	default:
		return ".jpg"
	}
}

type clanFileReader struct {
	*bytes.Reader
}

func (r *clanFileReader) Close() error { return nil }

var _ multipart.File = (*clanFileReader)(nil)
