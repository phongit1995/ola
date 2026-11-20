package me

import (
	"context"

	"ola-chat-server/internal/constants"
	friendContentEvents "ola-chat-server/internal/domain/friend-content"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

func (s *Service) MomentPublished(authorID, momentID uuid.UUID) {
	s.publishFriendContent(constants.FriendContentMoment, authorID, momentID, "")
}

func (s *Service) notifyFriendsOfPost(post *models.Me) {
	if post.ClanID != nil || !post.Visibility.ShownInFeeds() {
		return
	}
	s.publishFriendContent(constants.FriendContentPost, post.AuthorID, post.ID, excerptText(post.Content))
}

func (s *Service) publishFriendContent(kind string, authorID, contentID uuid.UUID, preview string) {
	if s.kafkaProducer == nil {
		return
	}
	event := &friendContentEvents.Event{
		AuthorID:  authorID.String(),
		Kind:      kind,
		ContentID: contentID.String(),
		Preview:   preview,
	}
	utils.PublishAsync(s.logger, "friend content", func(ctx context.Context) error {
		return s.kafkaProducer.PublishFriendContent(ctx, event)
	})
}
