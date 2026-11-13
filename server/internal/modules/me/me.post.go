package me

import (
	"strings"
	"time"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func hasPostBody(content string, attachmentCount int, sticker string, hasCheckIn bool) bool {
	return strings.TrimSpace(content) != "" ||
		attachmentCount > 0 ||
		strings.TrimSpace(sticker) != "" ||
		hasCheckIn
}

func (s *Service) Create(userID uuid.UUID, req *CreateMeRequest) (*MeResponse, error) {
	return s.createPost(userID, nil, req)
}

func (s *Service) CreateClanPost(userID, clanID uuid.UUID, req *CreateMeRequest) (*MeResponse, error) {
	if s.clanGate == nil {
		return nil, errClanUnavailable
	}
	visibility := parseClanVisibility(req.Visibility)
	req.Visibility = string(visibility)
	if err := s.clanGate.CanPost(userID, clanID, visibility); err != nil {
		return nil, err
	}
	return s.createPost(userID, &clanID, req)
}

func (s *Service) createPost(userID uuid.UUID, clanID *uuid.UUID, req *CreateMeRequest) (*MeResponse, error) {
	if len(req.Images) > MaxPostImages {
		return nil, errMaxImages
	}
	if len(req.Audios) > MaxPostAudios {
		return nil, errMaxAudios
	}
	content := strings.TrimSpace(req.Content)
	checkIn := toModelCheckIn(req.CheckIn)
	if !hasPostBody(content, len(req.Images)+len(req.Audios), req.Sticker, checkIn != nil) {
		return nil, errEmptyPost
	}
	audios, err := toModelAudios(req.Audios, nil)
	if err != nil {
		return nil, err
	}
	pendingUploads, err := s.pendingPostUploads(
		userID,
		append(imageUploadRefs(req.Images), audioUploadRefs(req.Audios)...),
		nil,
	)
	if err != nil {
		return nil, err
	}

	visibility := parseVisibility(req.Visibility)

	post := &models.Me{
		AuthorID:   userID,
		ClanID:     clanID,
		Content:    content,
		Images:     toModelImages(req.Images),
		Audios:     audios,
		Mentions:   s.resolveMentions(content),
		CheckIn:    checkIn,
		Sticker:    strings.TrimSpace(req.Sticker),
		Visibility: visibility,
		Enabled:    true,
	}
	claimedUploads, err := s.claimPostUploads(pendingUploads)
	if err != nil {
		s.deletePostUploadRecordsAsync(claimedUploads)
		return nil, err
	}
	if err := s.repo.Create(post); err != nil {
		s.deletePostUploadRecordsAsync(claimedUploads)
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
	existingImages := post.Images
	existingAudios := post.Audios
	if req.Content != nil {
		post.Content = strings.TrimSpace(*req.Content)
		post.Mentions = s.resolveMentions(post.Content)
	}
	if req.Images != nil {
		if len(*req.Images) > MaxPostImages {
			return nil, errMaxImages
		}
		post.Images = toModelImages(*req.Images)
	}
	if req.Audios != nil {
		if len(*req.Audios) > MaxPostAudios {
			return nil, errMaxAudios
		}
		audios, err := toModelAudios(*req.Audios, existingAudios)
		if err != nil {
			return nil, err
		}
		post.Audios = audios
	}
	if req.ClearCheckIn {
		post.CheckIn = nil
	} else if req.CheckIn != nil {
		post.CheckIn = toModelCheckIn(req.CheckIn)
	}
	if req.Sticker != nil {
		post.Sticker = strings.TrimSpace(*req.Sticker)
	}
	if req.Visibility != nil {
		newVisibility := parseVisibility(*req.Visibility)
		if post.ClanID != nil {
			newVisibility = parseClanVisibility(*req.Visibility)
			if newVisibility != post.Visibility {
				if s.clanGate == nil {
					return nil, errClanUnavailable
				}
				if err := s.clanGate.CanPost(userID, *post.ClanID, newVisibility); err != nil {
					return nil, err
				}
			}
		}
		post.Visibility = newVisibility
	}
	if !hasPostBody(post.Content, len(post.Images)+len(post.Audios), post.Sticker, post.CheckIn != nil) {
		return nil, errEmptyPost
	}
	var pendingUploads []postUploadRecord
	if req.Images != nil || req.Audios != nil {
		refs := make([]postUploadRef, 0)
		if req.Images != nil {
			refs = append(refs, imageUploadRefs(*req.Images)...)
		}
		if req.Audios != nil {
			refs = append(refs, audioUploadRefs(*req.Audios)...)
		}
		pendingUploads, err = s.pendingPostUploads(
			userID,
			refs,
			append(knownImageURLs(existingImages), knownAudioURLs(existingAudios)...),
		)
		if err != nil {
			return nil, err
		}
	}

	claimedUploads, err := s.claimPostUploads(pendingUploads)
	if err != nil {
		s.deletePostUploadRecordsAsync(claimedUploads)
		return nil, err
	}
	if err := s.repo.UpdateEditable(post); err != nil {
		s.deletePostUploadRecordsAsync(claimedUploads)
		return nil, err
	}

	s.notifyMentions(userID, postID, addedMentions(oldMentions, post.Mentions), excerptText(post.Content))

	updated, err := s.repo.GetByID(postID)
	if err != nil {
		return nil, err
	}
	resp := toMeResponse(updated, s.myReaction(userID, postID))
	s.attachTopLikers(&resp, postID)
	return &resp, nil
}

func (s *Service) Delete(userID, postID uuid.UUID) error {
	post, err := s.ownedPost(userID, postID)
	if err != nil {
		return err
	}
	if err := s.repo.Disable(postID, MeHiddenByOwner); err != nil {
		return err
	}
	if post.ClanID != nil && s.clanGate != nil {
		s.clanGate.OnPostDisabled(postID)
	}
	return nil
}

func (s *Service) SetPinned(userID, postID uuid.UUID, pinned bool) (*MeResponse, error) {
	post, err := s.ownedPost(userID, postID)
	if err != nil {
		return nil, err
	}
	if pinned && post.ClanID != nil {
		return nil, errCannotPinClanPost
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
