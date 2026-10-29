package moment

import (
	"cmp"
	"context"
	"maps"
	"net/http"
	"slices"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"ola-chat-server/internal/utils"

	"github.com/google/uuid"
)

var errInvalidReaction = utils.NewHTTPError(http.StatusBadRequest, "invalid reaction type")

func (s *Service) React(ctx context.Context, viewerID, momentID uuid.UUID, reaction string, count int) (*ReactMomentResponse, error) {
	if !slices.Contains(constants.AllowedReactionTypes, reaction) {
		return nil, errInvalidReaction
	}
	now := s.now()
	moments, err := s.repo.FindSeenable(viewerID, now, []uuid.UUID{momentID})
	if err != nil {
		return nil, err
	}
	if len(moments) == 0 {
		return nil, errMomentNotFound
	}
	total, first, err := s.store.AddReaction(ctx, moments[0], viewerID, reaction, clampReactionCount(count), now)
	if err != nil {
		s.logger.Warnw("Failed to save moment reaction", "moment_id", momentID, "viewer_id", viewerID, "error", err)
		return nil, errStateUnavailable
	}
	if first && s.notifier != nil {
		s.notifier.MomentReacted(moments[0].AuthorID, viewerID, momentID, reaction)
	}
	if err := s.recordViews(ctx, viewerID, moments, now); err != nil {
		s.logger.Warnw("Moment reaction saved without a view", "moment_id", momentID, "viewer_id", viewerID, "error", err)
	}
	return &ReactMomentResponse{Type: reaction, Count: total}, nil
}

func (s *Service) ReactionSummaries(ctx context.Context, moments []*models.Moment) map[uuid.UUID][]MomentReactionCount {
	live, err := s.store.ReactionTotals(ctx, moments)
	if err != nil {
		s.logger.Warnw("Failed to read live moment reactions", "error", err)
		live = map[uuid.UUID]map[string]int64{}
	}
	summaries := make(map[uuid.UUID][]MomentReactionCount, len(moments))
	for _, moment := range moments {
		summaries[moment.ID] = reactionList(mergeReactionCounts(moment.ReactionCounts, live[moment.ID]))
	}
	return summaries
}

func (s *Service) Reactors(ctx context.Context, userID, momentID uuid.UUID, limit, offset int) (*MomentReactorsResponse, error) {
	if _, err := s.ownedMoment(userID, momentID); err != nil {
		return nil, err
	}
	page, total, err := s.store.ReactorPage(ctx, momentID, offset, limit)
	if err != nil {
		s.logger.Warnw("Failed to read moment reactors", "moment_id", momentID, "error", err)
		return nil, errStateUnavailable
	}
	ranked, err := s.rankedUsers(page)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, len(ranked))
	for i, entry := range ranked {
		ids[i] = entry.user.ID
	}
	reactions := s.viewerReactions(ctx, momentID, ids)
	resp := &MomentReactorsResponse{
		Items:      make([]MomentReactorResponse, 0, len(ranked)),
		Total:      total,
		Limit:      limit,
		Offset:     offset,
		NextOffset: nextViewerOffset(offset, len(page), total),
	}
	for _, entry := range ranked {
		userReactions := reactions[entry.user.ID]
		if userReactions == nil {
			userReactions = []MomentReactionCount{}
		}
		resp.Items = append(resp.Items, MomentReactorResponse{
			User:      toAuthorResponse(entry.user),
			ReactedAt: entry.at.Format(time.RFC3339),
			Reactions: userReactions,
		})
	}
	return resp, nil
}

func (s *Service) AttachViewerReactions(ctx context.Context, momentID uuid.UUID, viewers []MomentViewerResponse) {
	ids := make([]uuid.UUID, len(viewers))
	for i, viewer := range viewers {
		ids[i], _ = uuid.Parse(viewer.User.ID)
	}
	reactions := s.viewerReactions(ctx, momentID, ids)
	for i := range viewers {
		viewers[i].Reactions = reactions[ids[i]]
	}
}

func (s *Service) viewerReactions(ctx context.Context, momentID uuid.UUID, viewerIDs []uuid.UUID) map[uuid.UUID][]MomentReactionCount {
	counts, err := s.store.ViewerReactions(ctx, momentID, viewerIDs)
	if err != nil {
		s.logger.Warnw("Failed to read moment viewer reactions", "moment_id", momentID, "error", err)
		return map[uuid.UUID][]MomentReactionCount{}
	}
	byViewer := make(map[uuid.UUID][]MomentReactionCount, len(counts))
	for viewerID, viewerCounts := range counts {
		byViewer[viewerID] = reactionList(viewerCounts)
	}
	return byViewer
}

func clampReactionCount(count int) int {
	return min(max(count, 1), MomentReactionMaxPerRequest)
}

func mergeReactionCounts(stored models.MomentReactionCounts, live map[string]int64) models.MomentReactionCounts {
	merged := make(models.MomentReactionCounts, len(stored)+len(live))
	maps.Copy(merged, stored)
	for reaction, count := range live {
		merged[reaction] = max(merged[reaction], count)
	}
	return merged
}

func staleReactionCounts(moments []*models.Moment, live map[uuid.UUID]map[string]int64) map[uuid.UUID]models.MomentReactionCounts {
	stale := make(map[uuid.UUID]models.MomentReactionCounts)
	for _, moment := range moments {
		merged := mergeReactionCounts(moment.ReactionCounts, live[moment.ID])
		if !maps.Equal(merged, moment.ReactionCounts) {
			stale[moment.ID] = merged
		}
	}
	return stale
}

func reactionList(counts map[string]int64) []MomentReactionCount {
	list := make([]MomentReactionCount, 0, len(counts))
	for reaction, count := range counts {
		if count > 0 {
			list = append(list, MomentReactionCount{Type: reaction, Count: count})
		}
	}
	slices.SortFunc(list, compareReactions)
	return list
}

func compareReactions(a, b MomentReactionCount) int {
	if a.Count != b.Count {
		return cmp.Compare(b.Count, a.Count)
	}
	return cmp.Compare(slices.Index(constants.AllowedReactionTypes, a.Type), slices.Index(constants.AllowedReactionTypes, b.Type))
}

func ReactionTotal(reactions []MomentReactionCount) int64 {
	var total int64
	for _, reaction := range reactions {
		total += reaction.Count
	}
	return total
}
