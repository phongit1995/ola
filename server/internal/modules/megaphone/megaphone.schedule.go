package megaphone

import (
	"encoding/json"
	"errors"
	"fmt"
	"strconv"
	"time"

	megaphoneEvents "ola-chat-server/internal/domain/megaphone"
	"ola-chat-server/internal/services"

	"github.com/redis/go-redis/v9"
)

type scheduledItem struct {
	Megaphone    megaphoneEvents.Megaphone `json:"megaphone"`
	Weight       int                       `json:"weight"`
	LastPlayedAt *time.Time                `json:"lastPlayedAt,omitempty"`
}

type scheduleEntry struct {
	ID   string
	Pass float64
	Item *scheduledItem
}

func repeatInterval(repeatBaseSeconds, weight int) time.Duration {
	return time.Duration(float64(repeatBaseSeconds) / float64(weight) * float64(time.Second))
}

func queueWait(waiting, slotSeconds int, runningSlot time.Duration) time.Duration {
	return runningSlot + time.Duration(waiting*slotSeconds)*time.Second
}

func (e scheduleEntry) expired(now time.Time) bool {
	return e.Item == nil || !now.Before(e.Item.Megaphone.ExpiresAt)
}

func (e scheduleEntry) eligible(now time.Time, repeatBaseSeconds int) bool {
	last := e.Item.LastPlayedAt
	return last == nil || now.Sub(*last) >= repeatInterval(repeatBaseSeconds, e.Item.Weight)
}

func selectNext(entries []scheduleEntry, now time.Time, repeatBaseSeconds int) int {
	for i := range entries {
		if !entries[i].expired(now) && entries[i].eligible(now, repeatBaseSeconds) {
			return i
		}
	}
	return -1
}

func advancePass(pass, virtualPass float64, repeatBaseSeconds, weight int) (float64, float64) {
	if pass > virtualPass {
		virtualPass = pass
	}
	return virtualPass + float64(repeatBaseSeconds)/float64(weight), virtualPass
}

type Schedule struct {
	cache *services.CacheService
}

func NewSchedule(cache *services.CacheService) *Schedule {
	return &Schedule{cache: cache}
}

func itemKey(id string) string {
	return fmt.Sprintf(CacheKeyMegaphoneItem, id)
}

func itemTTL(item scheduledItem) time.Duration {
	return time.Until(item.Megaphone.ExpiresAt) + itemTTLSlack
}

func (s *Schedule) VirtualPass() (float64, error) {
	value, err := s.cache.GetClient().Get(s.cache.GetContext(), CacheKeyMegaphoneVirtualPass).Float64()
	if errors.Is(err, redis.Nil) {
		return 0, nil
	}
	return value, err
}

func (s *Schedule) NextSlot() (time.Time, error) {
	value, err := s.cache.GetClient().Get(s.cache.GetContext(), CacheKeyMegaphoneNextSlot).Int64()
	if errors.Is(err, redis.Nil) {
		return time.Time{}, nil
	}
	return time.UnixMilli(value), err
}

func (s *Schedule) SetNextSlot(at time.Time) error {
	return s.cache.GetClient().Set(s.cache.GetContext(), CacheKeyMegaphoneNextSlot, at.UnixMilli(), 0).Err()
}

func (s *Schedule) Add(item scheduledItem) error {
	data, err := json.Marshal(item)
	if err != nil {
		return err
	}
	pass, err := s.VirtualPass()
	if err != nil {
		return err
	}
	client, ctx := s.cache.GetClient(), s.cache.GetContext()
	pipe := client.TxPipeline()
	pipe.SetNX(ctx, itemKey(item.Megaphone.ID), data, itemTTL(item))
	pipe.ZAddNX(ctx, CacheKeyMegaphoneSchedule, redis.Z{Score: pass, Member: item.Megaphone.ID})
	_, err = pipe.Exec(ctx)
	return err
}

func (s *Schedule) Remove(id string) error {
	client, ctx := s.cache.GetClient(), s.cache.GetContext()
	pipe := client.TxPipeline()
	pipe.ZRem(ctx, CacheKeyMegaphoneSchedule, id)
	pipe.Del(ctx, itemKey(id))
	_, err := pipe.Exec(ctx)
	return err
}

func (s *Schedule) Entries() ([]scheduleEntry, error) {
	client, ctx := s.cache.GetClient(), s.cache.GetContext()
	members, err := client.ZRangeWithScores(ctx, CacheKeyMegaphoneSchedule, 0, -1).Result()
	if err != nil || len(members) == 0 {
		return nil, err
	}
	keys := make([]string, len(members))
	entries := make([]scheduleEntry, len(members))
	for i, member := range members {
		id, _ := member.Member.(string)
		keys[i] = itemKey(id)
		entries[i] = scheduleEntry{ID: id, Pass: member.Score}
	}
	values, err := client.MGet(ctx, keys...).Result()
	if err != nil {
		return nil, err
	}
	for i, value := range values {
		raw, ok := value.(string)
		if !ok {
			continue
		}
		var item scheduledItem
		if json.Unmarshal([]byte(raw), &item) == nil {
			entries[i].Item = &item
		}
	}
	return entries, nil
}

func (s *Schedule) RecordPlay(entry scheduleEntry, pass, virtualPass float64, playedAt time.Time) error {
	item := *entry.Item
	item.LastPlayedAt = &playedAt
	data, err := json.Marshal(item)
	if err != nil {
		return err
	}
	client, ctx := s.cache.GetClient(), s.cache.GetContext()
	pipe := client.TxPipeline()
	pipe.Set(ctx, itemKey(entry.ID), data, itemTTL(item))
	pipe.ZAddXX(ctx, CacheKeyMegaphoneSchedule, redis.Z{Score: pass, Member: entry.ID})
	pipe.Set(ctx, CacheKeyMegaphoneVirtualPass, strconv.FormatFloat(virtualPass, 'f', -1, 64), 0)
	_, err = pipe.Exec(ctx)
	return err
}
