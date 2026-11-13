package engine

import (
	"sync"
	"time"

	"ola-chat-server/internal/utils"
)

func nextBackoff(current, limit time.Duration) time.Duration {
	if current >= limit {
		return current
	}
	return min(current*2, limit)
}

func (e *Engine) runUniqueJob(mu *sync.Mutex, jobs map[string]struct{}, key string, run func()) {
	mu.Lock()
	if _, exists := jobs[key]; exists {
		mu.Unlock()
		return
	}
	jobs[key] = struct{}{}
	mu.Unlock()

	utils.SafeGo(e.logger, func() {
		defer func() {
			mu.Lock()
			delete(jobs, key)
			mu.Unlock()
		}()
		run()
	})
}
