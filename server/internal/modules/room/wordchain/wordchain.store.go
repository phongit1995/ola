package wordchain

import (
	"context"
	"encoding/json"
	"errors"
	"ola-chat-server/internal/services"
	"strconv"

	"github.com/redis/go-redis/v9"
)

type ScoreEntry struct {
	UserID string
	Score  int64
}

type Store struct {
	client *redis.Client
}

func NewStore(cache *services.CacheService) *Store {
	return &Store{client: cache.GetClient()}
}

func (s *Store) LoadState(ctx context.Context) (GameState, error) {
	raw, err := s.client.Get(ctx, CacheKeyState).Bytes()
	if errors.Is(err, redis.Nil) {
		return GameState{History: []string{}}, nil
	}
	if err != nil {
		return GameState{}, err
	}
	var state GameState
	if err := json.Unmarshal(raw, &state); err != nil {
		return GameState{}, err
	}
	if state.History == nil {
		state.History = []string{}
	}
	return state, nil
}

type Mutation struct {
	State       *GameState
	ScoreUserID string
	WinUserID   string
	Messages    []Message
}

func (s *Store) Apply(ctx context.Context, m *Mutation) (int64, error) {
	var seqCmd, revCmd *redis.IntCmd
	if _, err := s.client.Pipelined(ctx, func(pipe redis.Pipeliner) error {
		if len(m.Messages) > 0 {
			seqCmd = pipe.IncrBy(ctx, CacheKeyMsgSeq, int64(len(m.Messages)))
		}
		if m.State != nil {
			revCmd = pipe.Incr(ctx, CacheKeyStateRev)
		}
		return nil
	}); err != nil {
		return 0, err
	}

	var stateData []byte
	if m.State != nil {
		m.State.Revision = revCmd.Val()
		data, err := json.Marshal(m.State)
		if err != nil {
			return 0, err
		}
		stateData = data
	}
	messageData := make([][]byte, len(m.Messages))
	if len(m.Messages) > 0 {
		first := seqCmd.Val() - int64(len(m.Messages)) + 1
		for i := range m.Messages {
			m.Messages[i].Seq = first + int64(i)
			data, err := json.Marshal(m.Messages[i].stored())
			if err != nil {
				return 0, err
			}
			messageData[i] = data
		}
	}

	var points *redis.FloatCmd
	if _, err := s.client.TxPipelined(ctx, func(pipe redis.Pipeliner) error {
		if stateData != nil {
			pipe.Set(ctx, CacheKeyState, stateData, 0)
		}
		if m.ScoreUserID != "" {
			points = pipe.ZIncrBy(ctx, CacheKeyPoints, PointsPerWord, m.ScoreUserID)
		}
		if m.WinUserID != "" {
			pipe.ZIncrBy(ctx, CacheKeyWins, 1, m.WinUserID)
		}
		for i, msg := range m.Messages {
			pipe.HSet(ctx, CacheKeyMsgData, msg.ID, messageData[i])
			pipe.ZAdd(ctx, CacheKeyMsgIndex, redis.Z{Score: float64(msg.Seq), Member: msg.ID})
		}
		return nil
	}); err != nil {
		return 0, err
	}

	if points == nil {
		return 0, nil
	}
	return int64(points.Val()), nil
}

func (s *Store) TrimMessages(ctx context.Context) error {
	size, err := s.client.ZCard(ctx, CacheKeyMsgIndex).Result()
	if err != nil {
		return err
	}
	overflow := size - MaxStoredMessages
	if overflow <= 0 {
		return nil
	}
	oldest, err := s.client.ZPopMin(ctx, CacheKeyMsgIndex, overflow).Result()
	if err != nil {
		return err
	}
	ids := make([]string, 0, len(oldest))
	for _, z := range oldest {
		if id, ok := z.Member.(string); ok {
			ids = append(ids, id)
		}
	}
	if len(ids) == 0 {
		return nil
	}
	return s.client.HDel(ctx, CacheKeyMsgData, ids...).Err()
}

func (s *Store) ListMessages(ctx context.Context, limit int, beforeID string) ([]storedMessage, error) {
	var ids []string
	var err error
	if beforeID == "" {
		ids, err = s.client.ZRevRange(ctx, CacheKeyMsgIndex, 0, int64(limit-1)).Result()
	} else {
		score, scoreErr := s.client.ZScore(ctx, CacheKeyMsgIndex, beforeID).Result()
		if errors.Is(scoreErr, redis.Nil) {
			return []storedMessage{}, nil
		}
		if scoreErr != nil {
			return nil, scoreErr
		}
		ids, err = s.client.ZRevRangeByScore(ctx, CacheKeyMsgIndex, &redis.ZRangeBy{
			Max:   "(" + strconv.FormatFloat(score, 'f', -1, 64),
			Min:   "-inf",
			Count: int64(limit),
		}).Result()
	}
	if err != nil {
		return nil, err
	}
	if len(ids) == 0 {
		return []storedMessage{}, nil
	}
	raws, err := s.client.HMGet(ctx, CacheKeyMsgData, ids...).Result()
	if err != nil {
		return nil, err
	}
	out := make([]storedMessage, 0, len(raws))
	for _, raw := range raws {
		text, ok := raw.(string)
		if !ok {
			continue
		}
		var msg storedMessage
		if err := json.Unmarshal([]byte(text), &msg); err != nil {
			continue
		}
		out = append(out, msg)
	}
	return out, nil
}

func (s *Store) Score(ctx context.Context, key, userID string) (int64, error) {
	score, err := s.client.ZScore(ctx, key, userID).Result()
	if errors.Is(err, redis.Nil) {
		return 0, nil
	}
	return int64(score), err
}

func (s *Store) Scores(ctx context.Context, key string, userIDs []string) (map[string]int64, error) {
	scores := make(map[string]int64, len(userIDs))
	if len(userIDs) == 0 {
		return scores, nil
	}
	cmds := make([]*redis.FloatCmd, len(userIDs))
	if _, err := s.client.Pipelined(ctx, func(pipe redis.Pipeliner) error {
		for i, userID := range userIDs {
			cmds[i] = pipe.ZScore(ctx, key, userID)
		}
		return nil
	}); err != nil && !errors.Is(err, redis.Nil) {
		return nil, err
	}
	for i, cmd := range cmds {
		score, err := cmd.Result()
		if errors.Is(err, redis.Nil) {
			continue
		}
		if err != nil {
			return nil, err
		}
		scores[userIDs[i]] = int64(score)
	}
	return scores, nil
}

func (s *Store) Count(ctx context.Context, key string) (int64, error) {
	return s.client.ZCard(ctx, key).Result()
}

func (s *Store) Top(ctx context.Context, key string, limit int) ([]ScoreEntry, int64, error) {
	rows, err := s.client.ZRevRangeWithScores(ctx, key, 0, int64(limit-1)).Result()
	if err != nil {
		return nil, 0, err
	}
	total, err := s.client.ZCard(ctx, key).Result()
	if err != nil {
		return nil, 0, err
	}
	out := make([]ScoreEntry, 0, len(rows))
	for _, row := range rows {
		userID, _ := row.Member.(string)
		out = append(out, ScoreEntry{UserID: userID, Score: int64(row.Score)})
	}
	return out, total, nil
}

func (s *Store) Rank(ctx context.Context, key, userID string) (int64, int64, bool, error) {
	rank, err := s.client.ZRevRank(ctx, key, userID).Result()
	if errors.Is(err, redis.Nil) {
		return 0, 0, false, nil
	}
	if err != nil {
		return 0, 0, false, err
	}
	score, err := s.Score(ctx, key, userID)
	if err != nil {
		return 0, 0, false, err
	}
	return rank + 1, score, true, nil
}
