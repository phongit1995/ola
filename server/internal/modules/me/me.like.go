package me

import (
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

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
			ID:            row.ID.String(),
			Username:      row.Username,
			FullName:      row.FullName,
			Avatar:        row.Avatar,
			AvatarFrameID: row.activeAvatarFrameID(),
			IsFriend:      row.IsFriend,
			IsSelf:        row.ID == viewerID,
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

	release, err := s.acquireLikeGuard(userID.String(), postID.String())
	if err != nil {
		return nil, err
	}
	defer release()

	updated, current, err := s.repo.React(postID, userID, t)
	if err != nil {
		return nil, err
	}
	s.invalidateTopLikers(CacheKeyMePostTopLikers, postID)
	if current != nil && *current == models.MeReactionLike {
		s.createMeNotification(post.AuthorID, userID, models.MeNotificationLike, postID, nil, "")
	} else {
		s.removeMeNotification(post.AuthorID, userID, models.MeNotificationLike, postID, nil)
	}
	resp := toMeResponse(updated, current)
	s.attachTopLikers(&resp, postID)
	return &resp, nil
}

func (s *Service) RemoveReaction(userID, postID uuid.UUID) (*MeResponse, error) {
	post, err := s.viewablePost(userID, postID)
	if err != nil {
		return nil, err
	}

	release, err := s.acquireLikeGuard(userID.String(), postID.String())
	if err != nil {
		return nil, err
	}
	defer release()

	updated, err := s.repo.RemoveReaction(postID, userID)
	if err != nil {
		return nil, err
	}
	s.invalidateTopLikers(CacheKeyMePostTopLikers, postID)
	s.removeMeNotification(post.AuthorID, userID, models.MeNotificationLike, postID, nil)
	resp := toMeResponse(updated, nil)
	s.attachTopLikers(&resp, postID)
	return &resp, nil
}

func (s *Service) attachTopLikers(resp *MeResponse, postID uuid.UUID) {
	topLikers, err := s.topLikersCached(CacheKeyMePostTopLikers, []uuid.UUID{postID}, func(ids []uuid.UUID) (map[uuid.UUID][]uuid.UUID, error) {
		return s.repo.TopLikerIDsByPosts(ids, 3)
	})
	if err != nil {
		return
	}
	if likers, ok := topLikers[postID]; ok {
		resp.TopLikers = likers
	}
}

func (s *Service) myReaction(userID, postID uuid.UUID) *models.MeReactionType {
	reaction, err := s.repo.GetReaction(postID, userID)
	if err != nil {
		return nil
	}
	return &reaction.Type
}

var (
	errLikeRateLimited = errors.New("too many requests, please slow down")
	errLikeInProgress  = errors.New("like in progress, please retry")
)

func (s *Service) topLikersCached(keyFmt string, ids []uuid.UUID, compute func([]uuid.UUID) (map[uuid.UUID][]uuid.UUID, error)) (map[uuid.UUID][]AuthorResponse, error) {
	result := make(map[uuid.UUID][]AuthorResponse, len(ids))
	if len(ids) == 0 {
		return result, nil
	}

	likerIDsByEntity, err := s.topLikerIDs(keyFmt, ids, compute)
	if err != nil {
		return nil, err
	}

	seen := make(map[uuid.UUID]struct{})
	allLikerIDs := make([]uuid.UUID, 0)
	for _, likerIDs := range likerIDsByEntity {
		for _, lid := range likerIDs {
			if _, ok := seen[lid]; ok {
				continue
			}
			seen[lid] = struct{}{}
			allLikerIDs = append(allLikerIDs, lid)
		}
	}

	users := s.userCache.GetUsersBatch(allLikerIDs, true)
	for id, likerIDs := range likerIDsByEntity {
		list := make([]AuthorResponse, 0, len(likerIDs))
		for _, lid := range likerIDs {
			if u, ok := users[lid]; ok {
				list = append(list, *toAuthorResponse(u))
			}
		}
		result[id] = list
	}
	return result, nil
}

func (s *Service) topLikerIDs(keyFmt string, ids []uuid.UUID, compute func([]uuid.UUID) (map[uuid.UUID][]uuid.UUID, error)) (map[uuid.UUID][]uuid.UUID, error) {
	if s.cache == nil {
		return compute(ids)
	}

	keys := make([]string, len(ids))
	for i, id := range ids {
		keys[i] = fmt.Sprintf(keyFmt, id.String())
	}

	byEntity := make(map[uuid.UUID][]uuid.UUID, len(ids))
	missIDs := make([]uuid.UUID, 0, len(ids))
	values, mgetErr := s.cache.GetClient().MGet(s.cache.GetContext(), keys...).Result()
	if mgetErr != nil {
		s.logger.Warnw("me top-likers MGET failed, recomputing", "error", mgetErr.Error())
		missIDs = ids
	} else {
		for i, id := range ids {
			raw, ok := values[i].(string)
			if !ok {
				missIDs = append(missIDs, id)
				continue
			}
			var idStrs []string
			if err := json.Unmarshal([]byte(raw), &idStrs); err != nil {
				missIDs = append(missIDs, id)
				continue
			}
			byEntity[id] = parseUUIDs(idStrs)
		}
	}

	if len(missIDs) == 0 {
		return byEntity, nil
	}

	computed, err := compute(missIDs)
	if err != nil {
		return nil, err
	}
	ttl := time.Duration(MeTopLikersTTLSeconds) * time.Second
	for _, id := range missIDs {
		likerIDs := computed[id]
		byEntity[id] = likerIDs
		if len(likerIDs) == 0 {
			continue
		}
		if setErr := s.cache.Set(fmt.Sprintf(keyFmt, id.String()), uuidsToStrings(likerIDs), ttl); setErr != nil {
			s.logger.Warnw("me top-likers cache set failed", "id", id.String(), "error", setErr.Error())
		}
	}
	return byEntity, nil
}

func parseUUIDs(strs []string) []uuid.UUID {
	ids := make([]uuid.UUID, 0, len(strs))
	for _, str := range strs {
		if id, err := uuid.Parse(str); err == nil {
			ids = append(ids, id)
		}
	}
	return ids
}

func uuidsToStrings(ids []uuid.UUID) []string {
	strs := make([]string, 0, len(ids))
	for _, id := range ids {
		strs = append(strs, id.String())
	}
	return strs
}

func (s *Service) invalidateTopLikers(keyFmt string, id uuid.UUID) {
	if s.cache == nil {
		return
	}
	s.cache.Delete(fmt.Sprintf(keyFmt, id.String()))
}

func (s *Service) checkLikeRateLimit(userID string) bool {
	if s.cache == nil {
		return true
	}
	key := fmt.Sprintf(CacheKeyRateLimitMeLike, userID)
	count, err := s.cache.Increment(key)
	if err != nil {
		s.logger.Warnw("me like rate-limit redis error, allowing", "key", key, "error", err.Error())
		return true
	}
	if count == 1 {
		if expErr := s.cache.SetExpire(key, time.Duration(constants.RateLimitReactionWindowSeconds)*time.Second); expErr != nil {
			s.cache.Delete(key)
		}
	}
	return count <= int64(constants.RateLimitReactionMaxRequests)
}

func (s *Service) acquireLikeGuard(userID, entityID string) (func(), error) {
	if s.cache == nil {
		return func() {}, nil
	}
	if !s.checkLikeRateLimit(userID) {
		return nil, errLikeRateLimited
	}
	lockKey := fmt.Sprintf(CacheKeyMeLikeLock, entityID)
	ttl := time.Duration(constants.ReactionLockTTLSeconds) * time.Second
	acquired, err := s.cache.SetNX(lockKey, "1", ttl)
	if err != nil {
		s.logger.Warnw("me like lock error, proceeding", "key", lockKey, "error", err.Error())
		return func() {}, nil
	}
	if !acquired {
		time.Sleep(time.Duration(constants.ReactionLockRetryMs) * time.Millisecond)
		acquired, err = s.cache.SetNX(lockKey, "1", ttl)
		if err != nil {
			s.logger.Warnw("me like lock retry error, proceeding", "key", lockKey, "error", err.Error())
			return func() {}, nil
		}
		if !acquired {
			return nil, errLikeInProgress
		}
	}
	return func() { s.cache.Delete(lockKey) }, nil
}
