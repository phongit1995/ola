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
	spectatorsKey       = "GAME:%s:MATCH:%s:SPECTATORS"
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
	ClosedRoom         *Room                 `json:"closedRoom,omitempty"`
}

type ActiveMatchRepository interface {
	Save(snapshot ActiveMatchSnapshot) error
	Delete(gameID, matchID string, userIDs ...string) error
	DeleteIfStatus(gameID, matchID, status string, userIDs ...string) (bool, error)
	Get(gameID, matchID string) (ActiveMatchSnapshot, bool, error)
	List(gameID string) ([]ActiveMatchSnapshot, error)
	AddSpectator(gameID, matchID, spectatorID string, limit int) (count int, status SpectatorAddStatus, err error)
	RemoveSpectator(gameID, matchID, spectatorID string) error
	SpectatorCount(gameID, matchID string) (int, error)
	ClearSpectators(gameID, matchID string) error
}

type SpectatorAddStatus uint8

const (
	SpectatorAdded SpectatorAddStatus = iota
	SpectatorFull
	SpectatorMatchNotFound
)

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
	keys := matchDeleteKeys(gameID, matchID, userIDs)
	const deleteMatchScript = `
redis.call("DEL", KEYS[1])
redis.call("SREM", KEYS[2], ARGV[1])
redis.call("DEL", KEYS[3])
for i = 4, #KEYS do
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
	keys := matchDeleteKeys(gameID, matchID, userIDs)
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
redis.call("DEL", KEYS[3])
for i = 4, #KEYS do
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

func matchDeleteKeys(gameID, matchID string, userIDs []string) []string {
	keys := []string{
		fmt.Sprintf(activeMatchKey, gameID, matchID),
		fmt.Sprintf(activeMatchesKey, gameID),
		fmt.Sprintf(spectatorsKey, gameID, matchID),
	}
	for _, userID := range userIDs {
		if userID != "" {
			keys = append(keys, fmt.Sprintf(userMatchKey, gameID, userID))
		}
	}
	return keys
}

func (s *MatchStore) AddSpectator(gameID, matchID, spectatorID string, limit int) (int, SpectatorAddStatus, error) {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	const addSpectatorScript = `
local raw = redis.call("GET", KEYS[2])
if not raw then
  return -2
end
local snapshot = cjson.decode(raw)
if snapshot["status"] ~= ARGV[4] then
  return -2
end
if redis.call("SISMEMBER", KEYS[1], ARGV[1]) == 1 then
  return redis.call("SCARD", KEYS[1])
end
local count = redis.call("SCARD", KEYS[1])
if count >= tonumber(ARGV[2]) then
  return -1
end
redis.call("SADD", KEYS[1], ARGV[1])
redis.call("EXPIRE", KEYS[1], ARGV[3])
return count + 1`
	keys := []string{
		fmt.Sprintf(spectatorsKey, gameID, matchID),
		fmt.Sprintf(activeMatchKey, gameID, matchID),
	}
	count, err := s.cache.GetClient().
		Eval(ctx, addSpectatorScript, keys, spectatorID, limit, int(activeMatchTTL.Seconds()), matchStatusPlaying).
		Int()
	if err != nil {
		return 0, SpectatorFull, fmt.Errorf("add spectator: %w", err)
	}
	switch {
	case count == -2:
		return 0, SpectatorMatchNotFound, nil
	case count < 0:
		return limit, SpectatorFull, nil
	}
	return count, SpectatorAdded, nil
}

func (s *MatchStore) RemoveSpectator(gameID, matchID, spectatorID string) error {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	if err := s.cache.GetClient().SRem(ctx, fmt.Sprintf(spectatorsKey, gameID, matchID), spectatorID).Err(); err != nil {
		return fmt.Errorf("remove spectator: %w", err)
	}
	return nil
}

func (s *MatchStore) SpectatorCount(gameID, matchID string) (int, error) {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	count, err := s.cache.GetClient().SCard(ctx, fmt.Sprintf(spectatorsKey, gameID, matchID)).Result()
	if err != nil {
		return 0, fmt.Errorf("count spectators: %w", err)
	}
	return int(count), nil
}

func (s *MatchStore) ClearSpectators(gameID, matchID string) error {
	ctx, cancel := gameRedisContext(s.cache)
	defer cancel()
	if err := s.cache.GetClient().Del(ctx, fmt.Sprintf(spectatorsKey, gameID, matchID)).Err(); err != nil {
		return fmt.Errorf("clear spectators: %w", err)
	}
	return nil
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
