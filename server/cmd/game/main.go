package main

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game"
)

type filteredWriter struct {
	out    io.Writer
	ignore []byte
}

func (w filteredWriter) Write(p []byte) (int, error) {
	if bytes.Contains(p, w.ignore) {
		return len(p), nil
	}
	return w.out.Write(p)
}

func newHTTPErrorLog() *log.Logger {
	w := filteredWriter{out: os.Stderr, ignore: []byte("superfluous response.WriteHeader call")}
	return log.New(w, "", log.LstdFlags)
}

func main() {
	time.Local = time.UTC

	c, err := NewContainer()
	if err != nil {
		log.Fatalf("❌ Failed to initialize container: %v", err)
	}

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	errChan := make(chan error, 1)

	var gameServer *game.Server
	var srv *http.Server

	go func() {
		if err := c.Invoke(func(gs *game.Server, cfg *config.Config) error {
			gameServer = gs

			mux := http.NewServeMux()
			mux.HandleFunc("/socket.io/", func(w http.ResponseWriter, r *http.Request) {
				gs.ServeHTTP(w, r)
			})
			mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
				w.WriteHeader(http.StatusOK)
				_, _ = w.Write([]byte(`{"status":"ok","service":"game"}`))
			})

			addr := fmt.Sprintf(":%d", cfg.GamePort)
			srv = &http.Server{
				Addr:     addr,
				Handler:  mux,
				ErrorLog: newHTTPErrorLog(),
			}

			log.Println("🚀 Game Service started")
			log.Printf("🎮 Game WebSocket listening on ws://localhost%s/socket.io/\n", addr)
			log.Println("👉 Press Ctrl+C to stop service")

			if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
				return err
			}

			return nil
		}); err != nil {
			errChan <- err
		}
	}()

	select {
	case err := <-errChan:
		log.Fatalf("❌ Game Service error: %v", err)
	case sig := <-quit:
		log.Printf("📡 Received signal: %v", sig)
		log.Println("🛑 Game Service shutdown...")

		shutdownCtx, shutdownCancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer shutdownCancel()

		if srv != nil {
			if err := srv.Shutdown(shutdownCtx); err != nil {
				log.Printf("⚠️ Error shutting down HTTP server: %v", err)
			}
		}
		if gameServer != nil {
			gameServer.Close()
		}

		log.Println("✅ Game Service shutdown successfully!")
	}
}
