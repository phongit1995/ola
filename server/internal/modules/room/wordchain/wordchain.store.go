package wordchain

import (
	"context"
	"encoding/json"
	"errors"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/services"
	"strconv"

	"github.com/redis/go-redis/v9"
)

type Store struct {
	client *redis.Client
}

func NewStore(cache *services.CacheService) *Store {
	return &Store{client: cache.GetClient()}
}

func (s *Store) LoadState(ctx context.Context) (GameState, error) {
	raw, err := s.client.Get(ctx, constants.CacheKeyWordChainState).Bytes()
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
	State    *GameState
	Messages []Message
}

func (s *Store) Apply(ctx context.Context, m *Mutation) error {
	var seqCmd, revCmd *redis.IntCmd
	if _, err := s.client.Pipelined(ctx, func(pipe redis.Pipeliner) error {
		if len(m.Messages) > 0 {
			seqCmd = pipe.IncrBy(ctx, constants.CacheKeyWordChainMsgSeq, int64(len(m.Messages)))
		}
		if m.State != nil {
			revCmd = pipe.Incr(ctx, constants.CacheKeyWordChainStateRev)
		}
		return nil
	}); err != nil {
		return err
	}

	var stateData []byte
	if m.State != nil {
		m.State.Revision = revCmd.Val()
		data, err := json.Marshal(m.State)
		if err != nil {
			return err
		}
		stateData = data
	}
	messageData := make([][]byte, len(m.Messages))
	if len(m.Messages) > 0 {
		first := seqCmd.Val() - int64(len(m.Messages)) + 1
		for i := range m.Messages {
			m.Messages[i].Seq = first + int64(i)
			data, err := json.Marshal(m.Messages[i].storedMessage)
			if err != nil {
				return err
			}
			messageData[i] = data
		}
	}

	_, err := s.client.TxPipelined(ctx, func(pipe redis.Pipeliner) error {
		if stateData != nil {
			pipe.Set(ctx, constants.CacheKeyWordChainState, stateData, 0)
		}
		for i, msg := range m.Messages {
			pipe.HSet(ctx, constants.CacheKeyWordChainMsgData, msg.ID, messageData[i])
			pipe.ZAdd(ctx, constants.CacheKeyWordChainMsgIndex, redis.Z{Score: float64(msg.Seq), Member: msg.ID})
		}
		return nil
	})
	return err
}

func (s *Store) TrimMessages(ctx context.Context) error {
	size, err := s.client.ZCard(ctx, constants.CacheKeyWordChainMsgIndex).Result()
	if err != nil {
		return err
	}
	overflow := size - constants.WordChainMaxStoredMessages
	if overflow <= 0 {
		return nil
	}
	oldest, err := s.client.ZPopMin(ctx, constants.CacheKeyWordChainMsgIndex, overflow).Result()
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
	return s.client.HDel(ctx, constants.CacheKeyWordChainMsgData, ids...).Err()
}

func (s *Store) ListMessages(ctx context.Context, limit int, beforeID string) ([]storedMessage, error) {
	var ids []string
	var err error
	if beforeID == "" {
		ids, err = s.client.ZRevRange(ctx, constants.CacheKeyWordChainMsgIndex, 0, int64(limit-1)).Result()
	} else {
		score, scoreErr := s.client.ZScore(ctx, constants.CacheKeyWordChainMsgIndex, beforeID).Result()
		if errors.Is(scoreErr, redis.Nil) {
			return []storedMessage{}, nil
		}
		if scoreErr != nil {
			return nil, scoreErr
		}
		ids, err = s.client.ZRevRangeByScore(ctx, constants.CacheKeyWordChainMsgIndex, &redis.ZRangeBy{
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
	raws, err := s.client.HMGet(ctx, constants.CacheKeyWordChainMsgData, ids...).Result()
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
