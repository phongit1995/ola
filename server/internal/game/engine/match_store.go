package engine

import (
	"encoding/json"
	"fmt"
	"time"

	"ola-chat-server/internal/game/protocol"
	"ola-chat-server/internal/services"

	"github.com/redis/go-redis/v9"
)

const (
	activeMatchTTL      = 6 * time.Hour
	activeMatchKey      = "GAME:%s:MATCH:%s"
	userMatchKey        = "GAME:%s:USERMATCH:%s"
	activeMatchesKey    = "GAME:%s:ACTIVE_MATCHES"
	matchStatusPlaying  = "playing"
	matchStatusFinished = "finished"
	matchStatusAborting = "aborting"
)

type ActiveMatchSnapshot struct {
	ID                 string                `json:"id"`
	GameID             string                `json:"gameId"`
	Players            []protocol.PlayerInfo `json:"players"`
	State              json.RawMessage       `json:"state"`
	StateVersion       int                   `json:"stateVersion"`
	TurnIndex          int                   `json:"turnIndex"`
	TimeoutRuns        []int                 `json:"timeoutRuns"`
	Quit               []int                 `json:"quit,omitempty"`
	TurnDeadline       int64                 `json:"turnDeadline"`
	Bet                int                   `json:"bet"`
	StartedAt          int64                 `json:"startedAt"`
	Status             string                `json:"status"`
	WinnerID           string                `json:"winnerId,omitempty"`
	ResultReason       string                `json:"resultReason,omitempty"`
	FinishedAt         int64                 `json:"finishedAt,omitempty"`
	Disconnected       map[int]bool          `json:"disconnected,omitempty"`
	GraceDeadline      int64                 `json:"graceDeadline,omitempty"`
	PausedRemainMillis int64                 `json:"pausedRemainMillis,omitempty"`
	Room               *Room                 `json:"room,omitempty"`
}

type ActiveMatchRepository interface {
	Save(snapshot ActiveMatchSnapshot) error
	Delete(gameID, matchID string, userIDs ...string) error
	DeleteIfStatus(gameID, matchID, status string, userIDs ...string) (bool, error)
	Get(gameID, matchID string) (ActiveMatchSnapshot, bool, error)
	List(gameID string) ([]ActiveMatchSnapshot, error)
}

type MatchStore struct {
	cache *services.CacheService
}

func NewMatchStore(cache *services.CacheService) *MatchStore {
	return &MatchStore{cache: cache}
}

func (s *MatchStore) Save(snapshot ActiveMatchSnapshot) error {
	data, err := json.Marshal(snapshot)
	if err != nil {
		return fmt.Errorf("marshal active match: %w", err)
	}

	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	pipe := s.cache.GetClient().TxPipeline()
	matchKey := fmt.Sprintf(activeMatchKey, snapshot.GameID, snapshot.ID)
	setKey := fmt.Sprintf(activeMatchesKey, snapshot.GameID)
	pipe.Set(ctx, matchKey, data, activeMatchTTL)
	pipe.SAdd(ctx, setKey, snapshot.ID)
	pipe.Expire(ctx, setKey, activeMatchTTL)
	for _, player := range snapshot.Players {
		if player.ID != "" {
			pipe.Set(ctx, fmt.Sprintf(userMatchKey, snapshot.GameID, player.ID), snapshot.ID, activeMatchTTL)
		}
	}
	if _, err := pipe.Exec(ctx); err != nil {
		return fmt.Errorf("save active match: %w", err)
	}
	return nil
}

func (s *MatchStore) Delete(gameID, matchID string, userIDs ...string) error {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	keys := []string{
		fmt.Sprintf(activeMatchKey, gameID, matchID),
		fmt.Sprintf(activeMatchesKey, gameID),
	}
	for _, userID := range userIDs {
		if userID != "" {
			keys = append(keys, fmt.Sprintf(userMatchKey, gameID, userID))
		}
	}
	const deleteMatchScript = `
redis.call("DEL", KEYS[1])
redis.call("SREM", KEYS[2], ARGV[1])
for i = 3, #KEYS do
  if redis.call("GET", KEYS[i]) == ARGV[1] then
    redis.call("DEL", KEYS[i])
  end
end
return 1`
	if _, err := s.cache.GetClient().Eval(ctx, deleteMatchScript, keys, matchID).Result(); err != nil {
		return fmt.Errorf("delete active match: %w", err)
	}
	return nil
}

func (s *MatchStore) DeleteIfStatus(gameID, matchID, status string, userIDs ...string) (bool, error) {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	keys := []string{
		fmt.Sprintf(activeMatchKey, gameID, matchID),
		fmt.Sprintf(activeMatchesKey, gameID),
	}
	for _, userID := range userIDs {
		if userID != "" {
			keys = append(keys, fmt.Sprintf(userMatchKey, gameID, userID))
		}
	}
	const deleteMatchIfStatusScript = `
local raw = redis.call("GET", KEYS[1])
if raw then
  local snapshot = cjson.decode(raw)
  if snapshot["status"] ~= ARGV[2] then
    return 0
  end
end
redis.call("DEL", KEYS[1])
redis.call("SREM", KEYS[2], ARGV[1])
for i = 3, #KEYS do
  if redis.call("GET", KEYS[i]) == ARGV[1] then
    redis.call("DEL", KEYS[i])
  end
end
return 1`
	deleted, err := s.cache.GetClient().
		Eval(ctx, deleteMatchIfStatusScript, keys, matchID, status).
		Int()
	if err != nil {
		return false, fmt.Errorf("conditionally delete active match: %w", err)
	}
	return deleted == 1, nil
}

func (s *MatchStore) Get(gameID, matchID string) (ActiveMatchSnapshot, bool, error) {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	raw, err := s.cache.GetClient().Get(ctx, fmt.Sprintf(activeMatchKey, gameID, matchID)).Bytes()
	if err != nil {
		if err == redis.Nil {
			return ActiveMatchSnapshot{}, false, nil
		}
		return ActiveMatchSnapshot{}, false, fmt.Errorf("load active match: %w", err)
	}
	var snapshot ActiveMatchSnapshot
	if err := json.Unmarshal(raw, &snapshot); err != nil {
		return ActiveMatchSnapshot{}, false, fmt.Errorf("decode active match: %w", err)
	}
	return snapshot, true, nil
}

func (s *MatchStore) List(gameID string) ([]ActiveMatchSnapshot, error) {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	client := s.cache.GetClient()
	setKey := fmt.Sprintf(activeMatchesKey, gameID)
	ids, err := client.SMembers(ctx, setKey).Result()
	if err != nil {
		return nil, fmt.Errorf("list active match ids: %w", err)
	}
	if len(ids) == 0 {
		return []ActiveMatchSnapshot{}, nil
	}

	keys := make([]string, len(ids))
	for i, id := range ids {
		keys[i] = fmt.Sprintf(activeMatchKey, gameID, id)
	}
	values, err := client.MGet(ctx, keys...).Result()
	if err != nil {
		return nil, fmt.Errorf("load active matches: %w", err)
	}

	matches := make([]ActiveMatchSnapshot, 0, len(values))
	staleIDs := make([]any, 0)
	for i, value := range values {
		if value == nil {
			staleIDs = append(staleIDs, ids[i])
			continue
		}
		raw, ok := value.(string)
		if !ok {
			staleIDs = append(staleIDs, ids[i])
			continue
		}
		var snapshot ActiveMatchSnapshot
		if err := json.Unmarshal([]byte(raw), &snapshot); err != nil {
			staleIDs = append(staleIDs, ids[i])
			continue
		}
		matches = append(matches, snapshot)
	}
	if len(staleIDs) > 0 {
		_ = client.SRem(ctx, setKey, staleIDs...).Err()
	}
	return matches, nil
}
