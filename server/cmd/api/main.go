package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"os"
	"os/signal"
	"syscall"
	"time"

	"go.uber.org/zap"
	"gorm.io/gorm"
)

// @title           Chat Server API
// @version         1.0
// @description     A chat server API with authentication and real-time messaging
// @termsOfService  http://swagger.io/terms/

// @contact.name   API Support
// @contact.email  support@chatserver.com

// @license.name  Apache 2.0
// @license.url   http://www.apache.org/licenses/LICENSE-2.0.html

// @BasePath  /api/v1
// @schemes   http https

// @securityDefinitions.apikey BearerAuth
// @in header
// @name Authorization
// @description Type "Bearer" followed by a space and JWT token.

func main() {
	time.Local = time.UTC

	c, err := NewContainer()
	if err != nil {
		log.Fatalf("❌ Failed to initialize container: %v", err)
	}

	if err := c.Invoke(func(db *gorm.DB) error {
		return nil
	}); err != nil {
		log.Fatalf("❌ Failed to connect database: %v", err)
	}

	if err := c.Invoke(func(cfg *config.Config, logger *zap.SugaredLogger) error {
		ctx, cancel := context.WithTimeout(context.Background(), 2*time.Minute)
		defer cancel()
		specs := kafka.DefaultTopicSpecs(constants.AllKafkaTopics())
		return kafka.EnsureTopics(ctx, cfg.KafkaBrokers, specs, logger)
	}); err != nil {
		log.Fatalf("❌ Failed to ensure Kafka topics: %v", err)
	}

	rootCtx, cancelRoot := context.WithCancel(context.Background())
	defer cancelRoot()
	var schedulers Schedulers
	if err := c.Invoke(func(s Schedulers) {
		schedulers = s
	}); err != nil {
		log.Fatalf("❌ Failed to init schedulers: %v", err)
	}
	schedulers.Start(rootCtx)

	var (
		srv      *http.Server
		wsServer *websocket.Server
		producer *kafka.Producer
	)
	if err := c.Invoke(func(s *Server, ws *websocket.Server, p *kafka.Producer, cfg *config.Config) {
		wsServer = ws
		producer = p
		srv = &http.Server{
			Addr:    fmt.Sprintf(":%d", cfg.ServerPort),
			Handler: s.Router,
		}
	}); err != nil {
		log.Fatalf("❌ Failed to init server: %v", err)
	}

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	errChan := make(chan error, 1)

	go func() {
		log.Println("🚀 API Service started")
		log.Printf("📡 HTTP REST API running on %s\n", srv.Addr)
		log.Printf("🔌 WebSocket server available at ws://localhost%s/socket.io/\n", srv.Addr)
		log.Println("📤 Kafka Producer ready")
		log.Println("👉 Press Ctrl+C to stop server")

		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			errChan <- err
		}
	}()

	select {
	case err := <-errChan:
		log.Fatalf("❌ Server error: %v", err)
	case sig := <-quit:
		log.Printf("📡 Received signal: %v", sig)
		log.Println("🛑 API Service shutdown...")

		cancelRoot()

		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()

		if err := srv.Shutdown(ctx); err != nil {
			log.Printf("❌ Server shutdown error: %v", err)
		}

		log.Println("🔌 Closing WebSocket connections...")
		wsServer.Close()

		schedulers.Wait(ctx)

		if err := producer.Close(); err != nil {
			log.Printf("❌ Kafka producer close error: %v", err)
		}

		log.Println("✅ API Service shutdown successfully!")
	}
}
