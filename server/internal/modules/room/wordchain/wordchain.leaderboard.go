package wordchain

import (
	"context"
	"ola-chat-server/internal/models"
	"time"

	"github.com/google/uuid"
)

var gmt7 = time.FixedZone("GMT+7", 7*60*60)

func normalizeLeaderboardSort(sort string) string {
	if sort == LeaderboardSortWins {
		return LeaderboardSortWins
	}
	return LeaderboardSortPoints
}

func normalizeLeaderboardPeriod(period string) string {
	switch period {
	case LeaderboardPeriodDay, LeaderboardPeriodWeek, LeaderboardPeriodMonth:
		return period
	}
	return LeaderboardPeriodAll
}

func periodRange(now time.Time, period string) (time.Time, time.Time) {
	local := now.In(gmt7)
	start := time.Date(local.Year(), local.Month(), local.Day(), 0, 0, 0, 0, gmt7)
	switch period {
	case LeaderboardPeriodWeek:
		start = start.AddDate(0, 0, -((int(local.Weekday()) + 6) % 7))
	case LeaderboardPeriodMonth:
		start = time.Date(local.Year(), local.Month(), 1, 0, 0, 0, 0, gmt7)
	}
	return start.UTC(), now.UTC()
}

func (s *Service) scoreRecord(userID uuid.UUID, move Message, previousWord string, now time.Time) *models.WordChainScore {
	messageID, err := uuid.Parse(move.ID)
	if err != nil {
		s.logger.Errorw("Invalid word chain message id for score", "message_id", move.ID, "error", err)
		return nil
	}
	sessionID, err := uuid.Parse(move.SessionID)
	if err != nil {
		s.logger.Errorw("Invalid word chain session id for score", "session_id", move.SessionID, "error", err)
		return nil
	}
	return &models.WordChainScore{
		MessageID:    messageID,
		SessionID:    sessionID,
		UserID:       userID,
		Word:         move.Word,
		PreviousWord: previousWord,
		Points:       PointsPerWord,
		IsWin:        move.Code == CodeWin,
		CreatedAt:    now.UTC(),
	}
}

func (s *Service) recordScore(ctx context.Context, score *models.WordChainScore) {
	recordCtx, cancel := context.WithTimeout(context.WithoutCancel(ctx), BackgroundTimeout)
	defer cancel()
	if err := s.scores.Record(recordCtx, score); err != nil {
		s.logger.Errorw("Failed to record word chain score", "message_id", score.MessageID, "user_id", score.UserID, "is_win", score.IsWin, "error", err)
	}
}

func (s *Service) Leaderboard(ctx context.Context, userID uuid.UUID, sort, period string) (*LeaderboardResponse, error) {
	sort, period = normalizeLeaderboardSort(sort), normalizeLeaderboardPeriod(period)
	rows, err := s.leaderboardRows(ctx, userID, sort, period)
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
		if row.Rank <= LeaderboardLimit {
			resp.Items = append(resp.Items, entry)
		}
		if row.UserID == userID {
			me := entry
			resp.Me = &me
		}
	}
	return resp, nil
}

func (s *Service) leaderboardRows(ctx context.Context, userID uuid.UUID, sort, period string) ([]LeaderboardRow, error) {
	if period != LeaderboardPeriodAll {
		from, to := periodRange(time.Now(), period)
		return s.scores.Leaderboard(ctx, sort, from, to, userID, LeaderboardLimit)
	}
	key, otherKey := CacheKeyPoints, CacheKeyWins
	if sort == LeaderboardSortWins {
		key, otherKey = CacheKeyWins, CacheKeyPoints
	}
	top, total, err := s.store.Top(ctx, key, LeaderboardLimit)
	if err != nil {
		return nil, err
	}
	entries := make([]ScoreEntry, 0, len(top)+1)
	ranks := make([]int64, 0, len(top)+1)
	for i, entry := range top {
		entries = append(entries, entry)
		ranks = append(ranks, int64(i+1))
	}
	rank, score, ranked, err := s.store.Rank(ctx, key, userID.String())
	if err != nil {
		return nil, err
	}
	if ranked && rank > int64(len(top)) {
		entries = append(entries, ScoreEntry{UserID: userID.String(), Score: score})
		ranks = append(ranks, rank)
	}
	ids := make([]string, len(entries))
	for i, entry := range entries {
		ids[i] = entry.UserID
	}
	others, err := s.store.Scores(ctx, otherKey, ids)
	if err != nil {
		return nil, err
	}

	rows := make([]LeaderboardRow, 0, len(entries))
	for i, entry := range entries {
		id, err := uuid.Parse(entry.UserID)
		if err != nil {
			continue
		}
		row := LeaderboardRow{UserID: id, Rank: ranks[i], Total: total, Points: entry.Score, Wins: others[entry.UserID]}
		if sort == LeaderboardSortWins {
			row.Points, row.Wins = others[entry.UserID], entry.Score
		}
		rows = append(rows, row)
	}
	return rows, nil
}

func (s *Service) winPage(ctx context.Context, userID uuid.UUID, mine bool, before string, limit int) ([]models.WordChainScore, bool, error) {
	var filter, cursor *uuid.UUID
	if mine {
		filter = &userID
	}
	if before != "" {
		id, err := uuid.Parse(before)
		if err != nil {
			return nil, false, nil
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
	rows, hasMore, err := s.winPage(ctx, userID, mine, before, limit)
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
