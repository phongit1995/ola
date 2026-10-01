package wordchain

import (
	"context"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/models"
	"time"

	"github.com/google/uuid"
)

var gmt7 = time.FixedZone("GMT+7", 7*60*60)

type TimeRange struct {
	From time.Time
	To   time.Time
}

func normalizeLeaderboardSort(sort string) string {
	if _, ok := leaderboardOrders[sort]; ok {
		return sort
	}
	return constants.WordChainLeaderboardSortPoints
}

func normalizeLeaderboardPeriod(period string) string {
	switch period {
	case constants.WordChainLeaderboardPeriodDay, constants.WordChainLeaderboardPeriodWeek, constants.WordChainLeaderboardPeriodMonth:
		return period
	}
	return constants.WordChainLeaderboardPeriodAll
}

func periodRange(now time.Time, period string) *TimeRange {
	if period == constants.WordChainLeaderboardPeriodAll {
		return nil
	}
	local := now.In(gmt7)
	start := time.Date(local.Year(), local.Month(), local.Day(), 0, 0, 0, 0, gmt7)
	switch period {
	case constants.WordChainLeaderboardPeriodWeek:
		start = start.AddDate(0, 0, -((int(local.Weekday()) + 6) % 7))
	case constants.WordChainLeaderboardPeriodMonth:
		start = time.Date(local.Year(), local.Month(), 1, 0, 0, 0, 0, gmt7)
	}
	return &TimeRange{From: start.UTC(), To: now.UTC()}
}

func (s *Service) recordScore(ctx context.Context, score *models.WordChainScore) {
	recordCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), constants.WordChainBackgroundTimeout)
	defer cancel()
	err := s.scores.Record(recordCtx, score)
	for attempt := 1; err != nil && attempt < constants.WordChainScoreRecordAttempts && recordCtx.Err() == nil; attempt++ {
		s.logger.Warnw("Failed to record word chain score, retrying", "message_id", score.MessageID, "attempt", attempt, "error", err)
		time.Sleep(time.Duration(attempt) * constants.WordChainScoreRecordBackoff)
		err = s.scores.Record(recordCtx, score)
	}
	if err != nil {
		s.logger.Errorw("Failed to record word chain score", "message_id", score.MessageID, "user_id", score.UserID, "is_win", score.IsWin, "error", err)
	}
}

func (s *Service) Leaderboard(ctx context.Context, userID uuid.UUID, sort, period string) (*LeaderboardResponse, error) {
	sort, period = normalizeLeaderboardSort(sort), normalizeLeaderboardPeriod(period)
	rows, err := s.scores.Leaderboard(ctx, sort, periodRange(time.Now(), period), userID, constants.WordChainLeaderboardLimit)
	if err != nil {
		return nil, err
	}
	ids := make([]uuid.UUID, 0, len(rows))
	for _, row := range rows {
		ids = append(ids, row.UserID)
	}
	users := s.userCache.GetUsersBatch(ids, true)

	resp := &LeaderboardResponse{Items: make([]LeaderboardEntry, 0, len(rows)), Sort: sort, Period: period}
	for _, row := range rows {
		entry := LeaderboardEntry{Rank: int(row.Rank), UserID: row.UserID.String(), Points: row.Points, Wins: row.Wins}
		if u := users[row.UserID]; u != nil {
			entry.Username, entry.FullName, entry.Avatar = u.Username, u.FullName, u.Avatar
		}
		resp.Total = row.Total
		if row.Rank <= constants.WordChainLeaderboardLimit {
			resp.Items = append(resp.Items, entry)
		}
		if row.UserID == userID {
			me := entry
			resp.Me = &me
		}
	}
	return resp, nil
}

func (s *Service) winPage(ctx context.Context, filter *uuid.UUID, before string, limit int) ([]models.WordChainScore, bool, error) {
	var cursor *uuid.UUID
	if before != "" {
		id, err := uuid.Parse(before)
		if err != nil {
			return nil, false, ErrBadCursor
		}
		cursor = &id
	}
	rows, err := s.scores.Wins(ctx, filter, cursor, limit+1)
	if err != nil {
		return nil, false, err
	}
	if len(rows) > limit {
		return rows[:limit], true, nil
	}
	return rows, false, nil
}

func (s *Service) Wins(ctx context.Context, userID uuid.UUID, mine bool, before string, limit int) (*WinListResponse, error) {
	var filter *uuid.UUID
	if mine {
		filter = &userID
	}
	return s.winList(ctx, filter, before, limit)
}

func (s *Service) winList(ctx context.Context, filter *uuid.UUID, before string, limit int) (*WinListResponse, error) {
	rows, hasMore, err := s.winPage(ctx, filter, before, limit)
	if err != nil {
		return nil, err
	}
	seen := make(map[uuid.UUID]struct{}, len(rows))
	ids := make([]uuid.UUID, 0, len(rows))
	for _, row := range rows {
		if _, ok := seen[row.UserID]; ok {
			continue
		}
		seen[row.UserID] = struct{}{}
		ids = append(ids, row.UserID)
	}
	users := s.userCache.GetUsersBatch(ids, true)

	items := make([]WinEntry, 0, len(rows))
	for _, row := range rows {
		item := WinEntry{
			ID:           row.MessageID.String(),
			UserID:       row.UserID.String(),
			Word:         row.Word,
			PreviousWord: row.PreviousWord,
			CreatedAt:    row.CreatedAt.UTC().Format(time.RFC3339Nano),
		}
		if u := users[row.UserID]; u != nil {
			item.Username, item.FullName, item.Avatar = u.Username, u.FullName, u.Avatar
		}
		items = append(items, item)
	}
	resp := &WinListResponse{Items: items, HasMore: hasMore}
	if hasMore {
		resp.NextBefore = items[len(items)-1].ID
	}
	return resp, nil
}
