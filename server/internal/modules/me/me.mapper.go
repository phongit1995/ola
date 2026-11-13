package me

import (
	"strings"
	"time"

	"ola-chat-server/internal/media"
	"ola-chat-server/internal/models"
)

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

func toModelAudios(inputs []MeAudioInput, existing models.MeAudios) (models.MeAudios, error) {
	audios := make(models.MeAudios, 0, len(inputs))
	for _, input := range inputs {
		if kept, ok := findExistingAudio(existing, input.URL); ok {
			audios = append(audios, kept)
			continue
		}
		if !media.IsAllowedAudioMime(input.MimeType) {
			return nil, errInvalidAudio
		}
		if err := media.ValidateDuration(input.Duration); err != nil {
			return nil, errInvalidAudio
		}
		if input.Duration > MaxPostAudioDurationSeconds {
			return nil, errInvalidAudio
		}
		if err := media.ValidateWaveform(input.Waveform, media.MaxAudioWaveformSamples); err != nil {
			return nil, errInvalidAudio
		}
		audios = append(audios, models.MeAudio{
			URL:      input.URL,
			MimeType: media.BaseMime(input.MimeType),
			Size:     input.Size,
			Duration: input.Duration,
			Waveform: input.Waveform,
		})
	}
	return audios, nil
}

func findExistingAudio(existing models.MeAudios, rawURL string) (models.MeAudio, bool) {
	target := normalizedPostImageURL(rawURL)
	for _, audio := range existing {
		if normalizedPostImageURL(audio.URL) == target {
			return audio, true
		}
	}
	return models.MeAudio{}, false
}

func toAudioResponses(audios models.MeAudios) []MeAudioResponse {
	result := make([]MeAudioResponse, 0, len(audios))
	for _, audio := range audios {
		result = append(result, MeAudioResponse{
			URL:      audio.URL,
			MimeType: audio.MimeType,
			Size:     audio.Size,
			Duration: audio.Duration,
			Waveform: audio.Waveform,
		})
	}
	return result
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
		ClanID:       clanIDString(post),
		ClanHandle:   clanHandleString(post),
		Images:       images,
		Audios:       toAudioResponses(post.Audios),
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

func clanIDString(post *models.Me) string {
	if post.ClanID == nil {
		return ""
	}
	return post.ClanID.String()
}

func clanHandleString(post *models.Me) string {
	if post.Clan == nil {
		return ""
	}
	return post.Clan.Handle
}

func toAuthorResponse(u *models.User) *AuthorResponse {
	if u == nil {
		return nil
	}
	return &AuthorResponse{
		ID:            u.ID.String(),
		Username:      u.Username,
		FullName:      u.FullName,
		Avatar:        u.Avatar,
		AvatarFrameID: u.ActiveAvatarFrameID(time.Now()),
	}
}
