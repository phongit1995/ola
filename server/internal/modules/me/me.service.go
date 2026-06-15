package me

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

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type Service struct {
	repo    *Repository
	relRepo *relationships.Repository
	minio   *services.MinIOService
	logger  *zap.SugaredLogger
}

func NewService(repo *Repository, relRepo *relationships.Repository, minio *services.MinIOService, logger *zap.SugaredLogger) *Service {
	return &Service{
		repo:    repo,
		relRepo: relRepo,
		minio:   minio,
		logger:  logger.Named("[post_service]"),
	}
}

func (s *Service) Create(userID uuid.UUID, req *CreatePostRequest) (*PostResponse, error) {
	if len(req.Images) > constants.MaxPostImages {
		return nil, errors.New("max 5 images")
	}
	content := strings.TrimSpace(req.Content)
	if content == "" && len(req.Images) == 0 {
		return nil, errors.New("post must have content or images")
	}

	post := &models.Post{
		AuthorID:   userID,
		Content:    content,
		Images:     toModelImages(req.Images),
		Mentions:   s.resolveMentions(content),
		CheckIn:    toModelCheckIn(req.CheckIn),
		Sticker:    strings.TrimSpace(req.Sticker),
		Visibility: parseVisibility(req.Visibility),
	}
	if err := s.repo.Create(post); err != nil {
		return nil, err
	}

	created, err := s.repo.GetByID(post.ID)
	if err != nil {
		return nil, err
	}
	resp := toPostResponse(created, nil)
	return &resp, nil
}

func (s *Service) Update(userID, postID uuid.UUID, req *UpdatePostRequest) (*PostResponse, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if post.AuthorID != userID {
		return nil, errors.New("not your post")
	}

	if req.Content != nil {
		post.Content = strings.TrimSpace(*req.Content)
		post.Mentions = s.resolveMentions(post.Content)
	}
	if req.Images != nil {
		if len(*req.Images) > constants.MaxPostImages {
			return nil, errors.New("max 5 images")
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
		return nil, errors.New("post must have content or images")
	}

	if err := s.repo.UpdateEditable(post); err != nil {
		return nil, err
	}

	updated, err := s.repo.GetByID(postID)
	if err != nil {
		return nil, err
	}
	resp := toPostResponse(updated, s.myReaction(userID, postID))
	return &resp, nil
}

func (s *Service) Delete(userID, postID uuid.UUID) error {
	post, err := s.getPost(postID)
	if err != nil {
		return err
	}
	if post.AuthorID != userID {
		return errors.New("not your post")
	}
	return s.repo.SoftDelete(postID)
}

func (s *Service) GetByID(viewerID, postID uuid.UUID) (*PostResponse, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if !s.canView(viewerID, post) {
		return nil, errors.New("post not found")
	}
	resp := toPostResponse(post, s.myReaction(viewerID, postID))
	return &resp, nil
}

func (s *Service) Feed(viewerID uuid.UUID, limit, offset int) (*PostListResponse, error) {
	posts, total, err := s.repo.Feed(viewerID, s.friendIDs(viewerID), limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(viewerID, posts, total, limit, offset)
}

func (s *Service) MentionsFeed(viewerID uuid.UUID, limit, offset int) (*PostListResponse, error) {
	posts, total, err := s.repo.FeedMentions(viewerID, s.friendIDs(viewerID), limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(viewerID, posts, total, limit, offset)
}

func (s *Service) MediaFeed(viewerID uuid.UUID, limit, offset int) (*PostListResponse, error) {
	posts, total, err := s.repo.FeedMedia(viewerID, s.friendIDs(viewerID), limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(viewerID, posts, total, limit, offset)
}

func (s *Service) ListMine(userID uuid.UUID, limit, offset int) (*PostListResponse, error) {
	all := []models.PostVisibility{models.PostVisibilityPublic, models.PostVisibilityFriend, models.PostVisibilityPrivate}
	posts, total, err := s.repo.ListByAuthor(userID, all, limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(userID, posts, total, limit, offset)
}

func (s *Service) ListByUser(viewerID, authorID uuid.UUID, limit, offset int) (*PostListResponse, error) {
	posts, total, err := s.repo.ListByAuthor(authorID, s.visibleScopes(viewerID, authorID), limit, offset)
	if err != nil {
		return nil, err
	}
	return s.buildList(viewerID, posts, total, limit, offset)
}

func (s *Service) visibleScopes(viewerID, authorID uuid.UUID) []models.PostVisibility {
	if viewerID == authorID {
		return []models.PostVisibility{models.PostVisibilityPublic, models.PostVisibilityFriend, models.PostVisibilityPrivate}
	}
	if s.isFriend(viewerID, authorID) {
		return []models.PostVisibility{models.PostVisibilityPublic, models.PostVisibilityFriend}
	}
	return []models.PostVisibility{models.PostVisibilityPublic}
}

func (s *Service) Likers(viewerID, postID uuid.UUID, limit, offset int) (*LikerListResponse, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if !s.canView(viewerID, post) {
		return nil, errors.New("post not found")
	}
	users, total, err := s.repo.ListLikers(postID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]AuthorResponse, 0, len(users))
	for _, u := range users {
		items = append(items, AuthorResponse{
			ID:       u.ID.String(),
			Username: u.Username,
			FullName: u.FullName,
			Avatar:   u.Avatar,
		})
	}
	return &LikerListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) React(userID, postID uuid.UUID, reactionType string) (*PostResponse, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if !s.canView(userID, post) {
		return nil, errors.New("post not found")
	}

	t := models.PostReactionType(reactionType)
	if t != models.PostReactionLike && t != models.PostReactionDislike {
		return nil, errors.New("invalid reaction type")
	}

	updated, current, err := s.repo.React(postID, userID, t)
	if err != nil {
		return nil, err
	}
	resp := toPostResponse(updated, current)
	return &resp, nil
}

func (s *Service) RemoveReaction(userID, postID uuid.UUID) (*PostResponse, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if !s.canView(userID, post) {
		return nil, errors.New("post not found")
	}

	updated, err := s.repo.RemoveReaction(postID, userID)
	if err != nil {
		return nil, err
	}
	resp := toPostResponse(updated, nil)
	return &resp, nil
}

func (s *Service) AddComment(viewerID, postID uuid.UUID, req *CreateCommentRequest) (*CommentResponse, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if !s.canView(viewerID, post) {
		return nil, errors.New("post not found")
	}

	comment := &models.PostComment{
		PostID:   postID,
		AuthorID: viewerID,
		Content:  strings.TrimSpace(req.Content),
	}
	created, err := s.repo.CreateComment(comment)
	if err != nil {
		return nil, err
	}
	resp := toCommentResponse(created)
	return &resp, nil
}

func (s *Service) ListComments(viewerID, postID uuid.UUID, limit, offset int) (*CommentListResponse, error) {
	post, err := s.getPost(postID)
	if err != nil {
		return nil, err
	}
	if !s.canView(viewerID, post) {
		return nil, errors.New("post not found")
	}

	comments, total, err := s.repo.ListComments(postID, limit, offset)
	if err != nil {
		return nil, err
	}
	items := make([]CommentResponse, 0, len(comments))
	for _, c := range comments {
		items = append(items, toCommentResponse(c))
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

	folder := fmt.Sprintf("%s/%s", constants.UploadFolderPosts, userID.String())
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

	upload, err := s.minio.UploadFile(ctx, &postFileReader{Reader: bytes.NewReader(data)}, "image"+extensionForMime(mimeType), folder)
	if err != nil {
		s.logger.Errorw("Failed to upload post image", "error", err)
		return nil, errors.New("failed to upload image")
	}

	return &UploadedImage{URL: upload.URL, Width: cfg.Width, Height: cfg.Height, MimeType: mimeType}, nil
}

func (s *Service) buildList(viewerID uuid.UUID, posts []*models.Post, total int64, limit, offset int) (*PostListResponse, error) {
	ids := make([]uuid.UUID, 0, len(posts))
	for _, p := range posts {
		ids = append(ids, p.ID)
	}

	reactions, err := s.repo.GetUserReactions(viewerID, ids)
	if err != nil {
		return nil, err
	}

	items := make([]PostResponse, 0, len(posts))
	for _, p := range posts {
		var mr *models.PostReactionType
		if t, ok := reactions[p.ID]; ok {
			rt := t
			mr = &rt
		}
		items = append(items, toPostResponse(p, mr))
	}
	return &PostListResponse{Items: items, Total: total, Limit: limit, Offset: offset}, nil
}

func (s *Service) getPost(id uuid.UUID) (*models.Post, error) {
	post, err := s.repo.GetByID(id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, errors.New("post not found")
		}
		return nil, err
	}
	return post, nil
}

func (s *Service) canView(viewerID uuid.UUID, post *models.Post) bool {
	if post.Visibility == models.PostVisibilityPublic {
		return true
	}
	if post.AuthorID == viewerID {
		return true
	}
	if post.Visibility == models.PostVisibilityFriend {
		return s.isFriend(viewerID, post.AuthorID)
	}
	return false
}

func parseVisibility(value string) models.PostVisibility {
	switch value {
	case string(models.PostVisibilityFriend):
		return models.PostVisibilityFriend
	case string(models.PostVisibilityPrivate):
		return models.PostVisibilityPrivate
	default:
		return models.PostVisibilityPublic
	}
}

func (s *Service) isFriend(a, b uuid.UUID) bool {
	rel, err := s.relRepo.FindByUsers(a, b)
	if err != nil {
		return false
	}
	return rel.Status == models.RelationshipStatusAccepted
}

func (s *Service) friendIDs(userID uuid.UUID) []uuid.UUID {
	rels, _, err := s.relRepo.GetFriends(userID, 1000, 0)
	if err != nil {
		return nil
	}
	ids := make([]uuid.UUID, 0, len(rels))
	for _, rel := range rels {
		if rel.RequesterID == userID {
			ids = append(ids, rel.AddresseeID)
		} else {
			ids = append(ids, rel.RequesterID)
		}
	}
	return ids
}

func (s *Service) myReaction(userID, postID uuid.UUID) *models.PostReactionType {
	reaction, err := s.repo.GetReaction(postID, userID)
	if err != nil {
		return nil
	}
	return &reaction.Type
}

var mentionPattern = regexp.MustCompile(`@([A-Za-z0-9_]+)`)

func parseMentionUsernames(content string) []string {
	matches := mentionPattern.FindAllStringSubmatch(content, -1)
	seen := make(map[string]bool, len(matches))
	names := make([]string, 0, len(matches))
	for _, match := range matches {
		name := match[1]
		if !seen[name] {
			seen[name] = true
			names = append(names, name)
		}
	}
	return names
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
		Name:    name,
		Address: strings.TrimSpace(input.Address),
		Lat:     input.Lat,
		Lng:     input.Lng,
	}
}

func toCheckInResponse(checkIn *models.CheckIn) *CheckInResponse {
	if checkIn == nil {
		return nil
	}
	return &CheckInResponse{
		Name:    checkIn.Name,
		Address: checkIn.Address,
		Lat:     checkIn.Lat,
		Lng:     checkIn.Lng,
	}
}

func toModelImages(inputs []PostImageInput) models.PostImages {
	images := make(models.PostImages, 0, len(inputs))
	for _, img := range inputs {
		images = append(images, models.PostImage{
			URL:      img.URL,
			Width:    img.Width,
			Height:   img.Height,
			MimeType: img.MimeType,
		})
	}
	return images
}

func toPostResponse(post *models.Post, myReaction *models.PostReactionType) PostResponse {
	images := make([]PostImageResponse, 0, len(post.Images))
	for _, img := range post.Images {
		images = append(images, PostImageResponse{
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

	resp := PostResponse{
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
		CreatedAt:    post.CreatedAt.UTC().Format(time.RFC3339),
		UpdatedAt:    post.UpdatedAt.UTC().Format(time.RFC3339),
	}
	if post.Author != nil {
		resp.Author = &AuthorResponse{
			ID:       post.Author.ID.String(),
			Username: post.Author.Username,
			FullName: post.Author.FullName,
			Avatar:   post.Author.Avatar,
		}
	}
	return resp
}

func toCommentResponse(comment *models.PostComment) CommentResponse {
	resp := CommentResponse{
		ID:        comment.ID.String(),
		PostID:    comment.PostID.String(),
		Content:   comment.Content,
		CreatedAt: comment.CreatedAt.UTC().Format(time.RFC3339),
	}
	if comment.Author != nil {
		resp.Author = &AuthorResponse{
			ID:       comment.Author.ID.String(),
			Username: comment.Author.Username,
			FullName: comment.Author.FullName,
			Avatar:   comment.Author.Avatar,
		}
	}
	return resp
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
