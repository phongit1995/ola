package me

import (
	"bytes"
	"context"
	"encoding/base64"
	"encoding/json"
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

	"ola-chat-server/internal/apperr"
	"ola-chat-server/internal/constants"
	meNotificationEvents "ola-chat-server/internal/domain/me-notification"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	usersetting "ola-chat-server/internal/modules/user-setting"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo           *Repository
	relRepo        *relationships.Repository
	userSettingSvc *usersetting.Service
	s3             *services.S3Service
	kafkaProducer  *kafka.Producer
	logger         *zap.SugaredLogger
}

func NewService(repo *Repository, relRepo *relationships.Repository, userSettingSvc *usersetting.Service, s3 *services.S3Service, kafkaProducer *kafka.Producer, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:           repo,
		relRepo:        relRepo,
		userSettingSvc: userSettingSvc,
		s3:             s3,
		kafkaProducer:  kafkaProducer,
		logger:         logger.Named("[post_service]"),
	}
}

var (
	errMaxImages            = errors.New("max 5 images")
	errEmptyPost            = errors.New("post must have content or images")
	errPostNotFound         = errors.New("post not found")
	errNotYourPost          = errors.New("not your post")
	errEditExpired          = errors.New("post is too old to edit")
	errMeFriendsOnly        = errors.New("this profile is visible to friends only")
	errMeCommentFriendsOnly = errors.New("only friends can comment on this post")
)

const editWindow = time.Hour

func (s *Service) Create(userID uuid.UUID, req *CreateMeRequest) (*MeResponse, error) {
	if len(req.Images) > constants.MaxPostImages {
		return nil, errMaxImages
	}
	content := strings.TrimSpace(req.Content)
	if content == "" && len(req.Images) == 0 {
		return nil, errEmptyPost
	}

	post := &models.Me{
		AuthorID:   userID,
		Content:    content,
		Images:     toModelImages(req.Images),
		Mentions:   s.resolveMentions(content),
		CheckIn:    toModelCheckIn(req.CheckIn),
		Sticker:    strings.TrimSpace(req.Sticker),
		Visibility: parseVisibility(req.Visibility),
		Enabled:    true,
	}
	if err := s.repo.Create(post); err != nil {
		return nil, err
	}

	s.notifyMentions(userID, post.ID, post.Mentions, excerptText(content))

	created, err := s.repo.GetByID(post.ID)
	if err != nil {
		return nil, err
	}
	resp := toMeResponse(created, nil)
	return &resp, nil
}

func (s *Service) Update(userID, postID uuid.UUID, req *UpdateMeRequest) (*MeResponse, error) {
	post, err := s.ownedPost(userID, postID)
	if err != nil {
		return nil, err
	}
	if time.Since(post.CreatedAt) > editWindow {
		return nil, errEditExpired
	}

	oldMentions := post.Mentions

	if req.Content != nil {
		post.Content = strings.TrimSpace(*req.Content)
		post.Mentions = s.resolveMentions(post.Content)
	}
	if req.Images != nil {
		if len(*req.Images) > constants.MaxPostImages {
			return nil, errMaxImages
		}
		post.Images = toModelImages(*req.Images)
	}
	if req.CheckIn != nil {
		post.CheckIn = toModelCheckIn(req.CheckIn)
	}
	if req.Sticker != nil {
		post.Sticker = strings.TrimSpace(*req.Sticker)
	}
	if req.Visibility != nil {
		post.Visibility = parseVisibility(*req.Visibility)
	}
	if strings.TrimSpace(post.Content) == "" && len(post.Images) == 0 {
		return nil, errEmptyPost
	}

	if err := s.repo.UpdateEditable(post); err != nil {
		return nil, err
	}

	s.notifyMentions(userID, postID, addedMentions(oldMentions, post.Mentions), excerptText(post.Content))

	updated, err := s.repo.GetByID(postID)
	if err != nil {
		return nil, err
	}
	resp := toMeResponse(updated, s.myReaction(userID, postID))
	return &resp, nil
}

func (s *Service) Delete(userID, postID uuid.UUID) error {
	if _, err := s.ownedPost(userID, postID); err != nil {
		return err
	}
	return s.repo.Disable(postID)
}

func (s *Service) SetPinned(userID, postID uuid.UUID, pinned bool) (*MeResponse, error) {
	if _, err := s.ownedPost(userID, postID); err != nil {
		return nil, err
	}
	if err := s.repo.SetPinned(userID, postID, pinned); err != nil {
		return nil, err
	}
	updated, err := s.repo.GetByID(postID)
	if err != nil {
		return nil, err
	}
	resp := toMeResponse(updated, s.myReaction(userID, postID))
	return &resp, nil
}

func (s *Service) GetByID(viewerID, postID uuid.UUID) (*MeResponse, error) {
	post, err := s.viewablePost(viewerID, postID)
	if err != nil {
		return nil, err
	}
	resp := toMeResponse(post, s.myReaction(viewerID, postID))
	return &resp, nil
}

func (s *Service) Feed(viewerID uuid.UUID, filter, cursor string, limit int) (*MeFeedResponse, error) {
	cursorTime, cursorID, err := decodeFeedCursor(cursor)
	if err != nil {
		return nil, err
	}
	posts, hasMore, err := s.repo.FeedPage(viewerID, filter, cursorTime, cursorID, limit)
	if err != nil {
		return nil, err
	}
	items, err := s.enrich(viewerID, posts)
	if err != nil {
		return nil, err
	}
	var nextCursor string
	if hasMore && len(posts) > 0 {
		last := posts[len(posts)-1]
		nextCursor = encodeFeedCursor(last.CreatedAt, last.ID)
	}
	return &MeFeedResponse{Items: items, NextCursor: nextCursor}, nil
}

func (s *Service) ListMine(userID uuid.UUID, limit, offset int) (*MeListResponse, error) {
	all := []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend, models.MeVisibilityPrivate}
	posts, total, err := s.repo.ListByAuthor(userID, all, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(userID, posts, total, limit, offset)
}

func (s *Service) ListMyPhotos(userID uuid.UUID, limit, offset int) (*MePhotoListResponse, error) {
	all := []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend, models.MeVisibilityPrivate}
	rows, total, err := s.repo.ListPhotosByAuthor(userID, all, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]MePhotoResponse, 0, len(rows))
	for _, row := range rows {
		items = append(items, MePhotoResponse{
			URL:       row.URL,
			Width:     row.Width,
			Height:    row.Height,
			MimeType:  row.MimeType,
			PostID:    row.PostID.String(),
			CreatedAt: row.CreatedAt.UTC().Format(time.RFC3339),
		})
	}
	return &MePhotoListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) ListLiked(userID uuid.UUID, limit, offset int) (*MeListResponse, error) {
	posts, total, err := s.repo.ListLikedByUser(userID, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(userID, posts, total, limit, offset)
}

func (s *Service) ListByUser(viewerID, authorID uuid.UUID, limit, offset int) (*MeListResponse, error) {
	scopes := []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend, models.MeVisibilityPrivate}
	if viewerID != authorID {
		blocked, err := s.relRepo.IsBlocked(authorID, viewerID)
		if err != nil {
			return nil, err
		}
		if blocked {
			return nil, apperr.ErrUserNotFound
		}
		friends, err := s.relRepo.AreFriends(viewerID, authorID)
		if err != nil {
			return nil, err
		}
		if friends {
			scopes = []models.MeVisibility{models.MeVisibilityPublic, models.MeVisibilityFriend}
		} else {
			settings, err := s.userSettingSvc.GetSettings(authorID)
			if err != nil {
				return nil, err
			}
			if settings.MeVisibility == models.SettingMeVisibilityFriends {
				return nil, errMeFriendsOnly
			}
			scopes = []models.MeVisibility{models.MeVisibilityPublic}
		}
	}
	posts, total, err := s.repo.ListByAuthor(authorID, scopes, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(viewerID, posts, total, limit, offset)
}

func (s *Service) Likers(viewerID, postID uuid.UUID, limit, offset int) (*LikerListResponse, error) {
	if _, err := s.viewablePost(viewerID, postID); err != nil {
		return nil, err
	}
	rows, total, err := s.repo.ListLikers(viewerID, postID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]AuthorResponse, 0, len(rows))
	for _, row := range rows {
		items = append(items, AuthorResponse{
			ID:       row.ID.String(),
			Username: row.Username,
			FullName: row.FullName,
			Avatar:   row.Avatar,
			IsFriend: row.IsFriend,
			IsSelf:   row.ID == viewerID,
		})
	}
	return &LikerListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) React(userID, postID uuid.UUID, reactionType string) (*MeResponse, error) {
	post, err := s.viewablePost(userID, postID)
	if err != nil {
		return nil, err
	}

	t := models.MeReactionType(reactionType)
	if t != models.MeReactionLike && t != models.MeReactionDislike {
		return nil, errors.New("invalid reaction type")
	}

	updated, current, err := s.repo.React(postID, userID, t)
	if err != nil {
		return nil, err
	}
	if current != nil && *current == models.MeReactionLike {
		s.createMeNotification(post.AuthorID, userID, models.MeNotificationLike, postID, nil, "")
	}
	resp := toMeResponse(updated, current)
	s.attachTopLikers(&resp, postID)
	return &resp, nil
}

func (s *Service) RemoveReaction(userID, postID uuid.UUID) (*MeResponse, error) {
	if _, err := s.viewablePost(userID, postID); err != nil {
		return nil, err
	}

	updated, err := s.repo.RemoveReaction(postID, userID)
	if err != nil {
		return nil, err
	}
	resp := toMeResponse(updated, nil)
	s.attachTopLikers(&resp, postID)
	return &resp, nil
}

func (s *Service) attachTopLikers(resp *MeResponse, postID uuid.UUID) {
	topLikers, err := s.repo.TopLikersByPosts([]uuid.UUID{postID}, 3)
	if err != nil {
		return
	}
	likers, ok := topLikers[postID]
	if !ok {
		return
	}
	tl := make([]AuthorResponse, 0, len(likers))
	for _, u := range likers {
		tl = append(tl, *toAuthorResponse(u))
	}
	resp.TopLikers = tl
}

func (s *Service) AddComment(viewerID, postID uuid.UUID, req *CreateCommentRequest) (*CommentResponse, error) {
	post, err := s.viewablePost(viewerID, postID)
	if err != nil {
		return nil, err
	}

	if viewerID != post.AuthorID {
		settings, err := s.userSettingSvc.GetSettings(post.AuthorID)
		if err != nil {
			return nil, err
		}
		if settings.CommentPrivacy == models.SettingCommentPrivacyFriends && !s.isFriend(viewerID, post.AuthorID) {
			return nil, errMeCommentFriendsOnly
		}
	}

	var parent *models.MeComment
	if req.ParentID != nil {
		parentID, parseErr := uuid.Parse(*req.ParentID)
		if parseErr != nil {
			return nil, errors.New("comment not found")
		}
		parent, err = s.repo.GetCommentByID(parentID)
		if err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return nil, errors.New("comment not found")
			}
			return nil, err
		}
		if parent.PostID != postID {
			return nil, errors.New("comment not found")
		}
	}

	comment := &models.MeComment{
		PostID:   postID,
		AuthorID: viewerID,
		Content:  strings.TrimSpace(req.Content),
	}
	if parent != nil {
		comment.ParentID = &parent.ID
	}
	created, err := s.repo.CreateComment(comment)
	if err != nil {
		return nil, err
	}
	commentID := created.ID
	if parent != nil {
		s.createMeNotification(parent.AuthorID, viewerID, models.MeNotificationReply, postID, &commentID, excerptText(created.Content))
	} else {
		s.createMeNotification(post.AuthorID, viewerID, models.MeNotificationComment, postID, &commentID, excerptText(created.Content))
	}
	resp := toCommentResponse(created)
	resp.ReplyTo = replySnapshotFrom(parent)
	return &resp, nil
}

func (s *Service) ListNotifications(recipientID uuid.UUID, cursor string, limit int) (*MeNotificationListResponse, error) {
	cursorTime, cursorID, err := decodeFeedCursor(cursor)
	if err != nil {
		return nil, err
	}

	items, hasMore, err := s.repo.ListMeNotificationsPage(recipientID, cursorTime, cursorID, limit)
	if err != nil {
		return nil, err
	}
	unread, err := s.repo.CountUnreadMeNotifications(recipientID)
	if err != nil {
		return nil, err
	}

	out := make([]MeNotificationResponse, 0, len(items))
	for _, it := range items {
		out = append(out, toMeNotificationResponse(it))
	}

	var nextCursor string
	if hasMore && len(items) > 0 {
		last := items[len(items)-1]
		nextCursor = encodeFeedCursor(last.CreatedAt, last.ID)
	}

	return &MeNotificationListResponse{
		Items:       out,
		UnreadCount: unread,
		NextCursor:  nextCursor,
	}, nil
}

func (s *Service) UnreadNotificationCount(recipientID uuid.UUID) (int64, error) {
	return s.repo.CountUnreadMeNotifications(recipientID)
}

func (s *Service) MarkAllNotificationsRead(recipientID uuid.UUID) error {
	return s.repo.MarkAllMeNotificationsRead(recipientID)
}

func (s *Service) createMeNotification(recipientID, actorID uuid.UUID, ntype string, postID uuid.UUID, commentID *uuid.UUID, preview string) {
	if recipientID == actorID {
		return
	}
	utils.SafeGo(s.logger, func() {
		n := &models.MeNotification{
			RecipientID: recipientID,
			ActorID:     actorID,
			Type:        ntype,
			PostID:      postID,
			CommentID:   commentID,
			Preview:     preview,
		}
		created, err := s.repo.CreateMeNotification(n)
		if err != nil {
			s.logger.Warnw("Failed to create me notification", "recipient_id", recipientID, "type", ntype, "error", err.Error())
			return
		}
		s.publishMeNotification(recipientID, created)
	})
}

func (s *Service) publishMeNotification(recipientID uuid.UUID, notif *models.MeNotification) {
	if s.kafkaProducer == nil {
		return
	}
	unread, err := s.repo.CountUnreadMeNotifications(recipientID)
	if err != nil {
		s.logger.Warnw("Failed to count unread me notifications", "recipient_id", recipientID, "error", err.Error())
		return
	}
	notifBytes, err := json.Marshal(toMeNotificationResponse(notif))
	if err != nil {
		s.logger.Warnw("Failed to marshal me notification", "recipient_id", recipientID, "error", err.Error())
		return
	}
	event := &meNotificationEvents.Event{
		RecipientID:  recipientID.String(),
		Notification: notifBytes,
		UnreadCount:  unread,
	}
	utils.PublishAsync(s.logger, "me notification", func(ctx context.Context) error {
		return s.kafkaProducer.PublishMeNotification(ctx, event)
	})
}

func (s *Service) ListComments(viewerID, postID uuid.UUID, limit, offset int) (*CommentListResponse, error) {
	if _, err := s.viewablePost(viewerID, postID); err != nil {
		return nil, err
	}

	comments, total, err := s.repo.ListComments(postID, limit, offset)
	if err != nil {
		return nil, err
	}

	parentIDs := make([]uuid.UUID, 0)
	for _, c := range comments {
		if c.ParentID != nil {
			parentIDs = append(parentIDs, *c.ParentID)
		}
	}
	parentByID := make(map[uuid.UUID]*models.MeComment)
	if len(parentIDs) > 0 {
		parents, perr := s.repo.GetCommentsByIDs(parentIDs)
		if perr != nil {
			return nil, perr
		}
		for _, p := range parents {
			parentByID[p.ID] = p
		}
	}

	items := make([]CommentResponse, 0, len(comments))
	for _, c := range comments {
		resp := toCommentResponse(c)
		if c.ParentID != nil {
			resp.ReplyTo = replySnapshotFrom(parentByID[*c.ParentID])
		}
		items = append(items, resp)
	}
	return &CommentListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) DeleteComment(viewerID, postID, commentID uuid.UUID) error {
	post, err := s.getPost(postID)
	if err != nil {
		return err
	}

	comment, err := s.repo.GetCommentByID(commentID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return errors.New("comment not found")
		}
		return err
	}
	if comment.PostID != postID {
		return errors.New("comment not found")
	}
	if comment.AuthorID != viewerID && post.AuthorID != viewerID {
		return errors.New("not your comment")
	}
	return s.repo.DeleteComment(postID, commentID)
}

func (s *Service) UploadImages(ctx context.Context, userID uuid.UUID, files []*multipart.FileHeader) (*UploadImagesResponse, error) {
	if len(files) == 0 {
		return nil, errors.New("no images provided")
	}
	if len(files) > constants.MaxPostImages {
		return nil, errors.New("max 5 images")
	}

	folder := fmt.Sprintf("%s/%s", constants.UploadFolderPosts, time.Now().Format(constants.UploadDateLayout))
	images := make([]UploadedImage, 0, len(files))
	for _, fileHeader := range files {
		img, err := s.uploadImage(ctx, folder, fileHeader)
		if err != nil {
			return nil, err
		}
		images = append(images, *img)
	}
	return &UploadImagesResponse{Images: images}, nil
}

func (s *Service) uploadImage(ctx context.Context, folder string, fileHeader *multipart.FileHeader) (*UploadedImage, error) {
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

	cfg, _, err := image.DecodeConfig(bytes.NewReader(data))
	if err != nil {
		return nil, errors.New("failed to decode image")
	}

	upload, err := s.s3.UploadFile(ctx, &postFileReader{Reader: bytes.NewReader(data)}, "image"+extensionForMime(mimeType), folder)
	if err != nil {
		s.logger.Errorw("Failed to upload post image", "error", err)
		return nil, errors.New("failed to upload image")
	}

	return &UploadedImage{URL: upload.URL, Width: cfg.Width, Height: cfg.Height, MimeType: mimeType}, nil
}

func (s *Service) buildList(viewerID uuid.UUID, posts []*models.Me, total int64, limit, offset int) (*MeListResponse, error) {
	items, err := s.enrich(viewerID, posts)
	if err != nil {
		return nil, err
	}
	return &MeListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) enrich(viewerID uuid.UUID, posts []*models.Me) ([]MeResponse, error) {
	ids := make([]uuid.UUID, 0, len(posts))
	for _, p := range posts {
		ids = append(ids, p.ID)
	}

	reactions, err := s.repo.GetUserReactions(viewerID, ids)
	if err != nil {
		return nil, err
	}

	topLikers, err := s.repo.TopLikersByPosts(ids, 3)
	if err != nil {
		return nil, err
	}

	items := make([]MeResponse, 0, len(posts))
	for _, p := range posts {
		var mr *models.MeReactionType
		if t, ok := reactions[p.ID]; ok {
			rt := t
			mr = &rt
		}
		resp := toMeResponse(p, mr)
		if likers, ok := topLikers[p.ID]; ok {
			tl := make([]AuthorResponse, 0, len(likers))
			for _, u := range likers {
				tl = append(tl, *toAuthorResponse(u))
			}
			resp.TopLikers = tl
		}
		items = append(items, resp)
	}
	return items, nil
}

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
	if !s.canView(viewerID, post) {
		return nil, errPostNotFound
	}
	return post, nil
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

func encodeFeedCursor(t time.Time, id uuid.UUID) string {
	raw := t.UTC().Format(time.RFC3339Nano) + "|" + id.String()
	return base64.RawURLEncoding.EncodeToString([]byte(raw))
}

func decodeFeedCursor(cursor string) (*time.Time, *uuid.UUID, error) {
	if cursor == "" {
		return nil, nil, nil
	}
	data, err := base64.RawURLEncoding.DecodeString(cursor)
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	parts := strings.SplitN(string(data), "|", 2)
	if len(parts) != 2 {
		return nil, nil, errors.New("invalid cursor")
	}
	t, err := time.Parse(time.RFC3339Nano, parts[0])
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	id, err := uuid.Parse(parts[1])
	if err != nil {
		return nil, nil, errors.New("invalid cursor")
	}
	return &t, &id, nil
}

func (s *Service) myReaction(userID, postID uuid.UUID) *models.MeReactionType {
	reaction, err := s.repo.GetReaction(postID, userID)
	if err != nil {
		return nil
	}
	return &reaction.Type
}

var mentionPattern = regexp.MustCompile(`@([A-Za-z0-9][A-Za-z0-9._-]*[A-Za-z0-9])`)

func parseMentionUsernames(content string) []string {
	matches := mentionPattern.FindAllStringSubmatch(content, -1)
	seen := make(map[string]bool, len(matches))
	names := make([]string, 0, len(matches))
	for _, match := range matches {
		name := strings.ToLower(match[1])
		if !seen[name] {
			seen[name] = true
			names = append(names, name)
		}
	}
	return names
}

func (s *Service) notifyMentions(authorID, postID uuid.UUID, mentions models.MentionIDs, preview string) {
	for _, idStr := range mentions {
		mentionedID, err := uuid.Parse(idStr)
		if err != nil {
			continue
		}
		s.createMeNotification(mentionedID, authorID, models.MeNotificationMention, postID, nil, preview)
	}
}

func addedMentions(old, current models.MentionIDs) models.MentionIDs {
	existing := make(map[string]bool, len(old))
	for _, id := range old {
		existing[id] = true
	}
	added := make(models.MentionIDs, 0, len(current))
	for _, id := range current {
		if !existing[id] {
			added = append(added, id)
		}
	}
	return added
}

func (s *Service) resolveMentions(content string) models.MentionIDs {
	names := parseMentionUsernames(content)
	if len(names) == 0 {
		return nil
	}
	idMap, err := s.repo.FindUserIDsByUsernames(names)
	if err != nil {
		s.logger.Warnw("failed to resolve mentions", "error", err)
		return nil
	}
	if len(idMap) == 0 {
		return nil
	}
	ids := make(models.MentionIDs, 0, len(idMap))
	for _, id := range idMap {
		ids = append(ids, id.String())
	}
	return ids
}

func toModelCheckIn(input *CheckInInput) *models.CheckIn {
	if input == nil {
		return nil
	}
	name := strings.TrimSpace(input.Name)
	if name == "" {
		return nil
	}
	return &models.CheckIn{
		Name:       name,
		Address:    strings.TrimSpace(input.Address),
		Lat:        input.Lat,
		Lng:        input.Lng,
		Action:     strings.TrimSpace(input.Action),
		ActionIcon: strings.TrimSpace(input.ActionIcon),
	}
}

func toCheckInResponse(checkIn *models.CheckIn) *CheckInResponse {
	if checkIn == nil {
		return nil
	}
	return &CheckInResponse{
		Name:       checkIn.Name,
		Address:    checkIn.Address,
		Lat:        checkIn.Lat,
		Lng:        checkIn.Lng,
		Action:     checkIn.Action,
		ActionIcon: checkIn.ActionIcon,
	}
}

func toModelImages(inputs []MeImageInput) models.MeImages {
	images := make(models.MeImages, 0, len(inputs))
	for _, img := range inputs {
		images = append(images, models.MeImage{
			URL:      img.URL,
			Width:    img.Width,
			Height:   img.Height,
			MimeType: img.MimeType,
		})
	}
	return images
}

func toMeResponse(post *models.Me, myReaction *models.MeReactionType) MeResponse {
	images := make([]MeImageResponse, 0, len(post.Images))
	for _, img := range post.Images {
		images = append(images, MeImageResponse{
			URL:      img.URL,
			Width:    img.Width,
			Height:   img.Height,
			MimeType: img.MimeType,
		})
	}

	var reaction *string
	if myReaction != nil {
		v := string(*myReaction)
		reaction = &v
	}

	resp := MeResponse{
		ID:           post.ID.String(),
		Content:      post.Content,
		Images:       images,
		Mentions:     []string(post.Mentions),
		CheckIn:      toCheckInResponse(post.CheckIn),
		Sticker:      post.Sticker,
		Visibility:   string(post.Visibility),
		LikeCount:    post.LikeCount,
		DislikeCount: post.DislikeCount,
		CommentCount: post.CommentCount,
		MyReaction:   reaction,
		IsPinned:     post.PinnedAt != nil,
		Author:       toAuthorResponse(post.Author),
		CreatedAt:    post.CreatedAt.UTC().Format(time.RFC3339),
		UpdatedAt:    post.UpdatedAt.UTC().Format(time.RFC3339),
	}
	return resp
}

func toAuthorResponse(u *models.User) *AuthorResponse {
	if u == nil {
		return nil
	}
	return &AuthorResponse{
		ID:       u.ID.String(),
		Username: u.Username,
		FullName: u.FullName,
		Avatar:   u.Avatar,
	}
}

func toMeNotificationResponse(n *models.MeNotification) MeNotificationResponse {
	resp := MeNotificationResponse{
		ID:        n.ID.String(),
		Type:      n.Type,
		Actor:     toAuthorResponse(n.Actor),
		PostID:    n.PostID.String(),
		Preview:   n.Preview,
		IsRead:    n.IsRead,
		CreatedAt: n.CreatedAt.UTC().Format(time.RFC3339),
	}
	if n.CommentID != nil {
		resp.CommentID = n.CommentID.String()
	}
	return resp
}

func excerptText(s string) string {
	s = strings.TrimSpace(s)
	runes := []rune(s)
	if len(runes) <= 120 {
		return s
	}
	return string(runes[:120]) + "…"
}

func toCommentResponse(comment *models.MeComment) CommentResponse {
	resp := CommentResponse{
		ID:        comment.ID.String(),
		PostID:    comment.PostID.String(),
		Content:   comment.Content,
		Author:    toAuthorResponse(comment.Author),
		CreatedAt: comment.CreatedAt.UTC().Format(time.RFC3339),
	}
	if comment.ParentID != nil {
		resp.ParentID = comment.ParentID.String()
	}
	return resp
}

func commentAuthorName(comment *models.MeComment) string {
	if comment == nil || comment.Author == nil {
		return ""
	}
	if comment.Author.FullName != "" {
		return comment.Author.FullName
	}
	return comment.Author.Username
}

func replySnapshotFrom(parent *models.MeComment) *CommentReplySnapshot {
	if parent == nil {
		return nil
	}
	return &CommentReplySnapshot{
		CommentID:  parent.ID.String(),
		AuthorName: commentAuthorName(parent),
		Excerpt:    excerptText(parent.Content),
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

type postFileReader struct {
	*bytes.Reader
}

func (r *postFileReader) Close() error { return nil }

var _ multipart.File = (*postFileReader)(nil)
