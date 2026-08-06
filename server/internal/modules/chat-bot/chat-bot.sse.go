package chatbot

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"sync"
	"time"

	"ola-chat-server/internal/constants"

	"github.com/gin-gonic/gin"
)

type sseSession struct {
	writer  io.Writer
	flusher http.Flusher
	mu      sync.Mutex
}

// Ghi header + ping ngay khi mở phiên để proxy không cắt kết nối trong lúc
// chờ delta đầu tiên của upstream.
func newSSESession(c *gin.Context) (*sseSession, bool) {
	flusher, ok := c.Writer.(http.Flusher)
	if !ok {
		return nil, false
	}

	c.Writer.Header().Set("Content-Type", "text/event-stream")
	c.Writer.Header().Set("Cache-Control", "no-cache")
	c.Writer.Header().Set("Connection", "keep-alive")
	c.Writer.Header().Set("X-Accel-Buffering", "no")
	c.Writer.WriteHeader(http.StatusOK)

	session := &sseSession{writer: c.Writer, flusher: flusher}
	_ = session.writeFrame(constants.ChatBotSSEHeartbeat)
	return session, true
}

// Mutex vì heartbeat ghi từ goroutine riêng song song với luồng delta.
func (s *sseSession) writeFrame(payload string) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	if _, err := io.WriteString(s.writer, payload); err != nil {
		return err
	}
	s.flusher.Flush()
	return nil
}

func (s *sseSession) writeChunk(chunk StreamChunk) error {
	payload, err := json.Marshal(chunk)
	if err != nil {
		return err
	}
	return s.writeFrame(fmt.Sprintf("data: %s\n\n", payload))
}

func (s *sseSession) writeDone() {
	_ = s.writeFrame(fmt.Sprintf("data: %s\n\n", constants.ChatBotSSEDoneMarker))
}

func (s *sseSession) fail(completionID, message string) {
	if s.writeChunk(StreamChunk{ID: completionID, Error: message}) != nil {
		return
	}
	s.writeDone()
}

func (s *sseSession) finish(completionID string) {
	_ = s.writeChunk(StreamChunk{
		ID:           completionID,
		FinishReason: constants.ChatBotFinishReasonStop,
	})
	s.writeDone()
}

func (s *sseSession) startHeartbeat(ctx context.Context) func() {
	done := make(chan struct{})
	stopped := make(chan struct{})

	go func() {
		defer close(stopped)
		ticker := time.NewTicker(constants.ChatBotSSEHeartbeatEvery)
		defer ticker.Stop()
		for {
			select {
			case <-done:
				return
			case <-ctx.Done():
				return
			case <-ticker.C:
				if s.writeFrame(constants.ChatBotSSEHeartbeat) != nil {
					return
				}
			}
		}
	}()

	return func() {
		close(done)
		<-stopped
	}
}
