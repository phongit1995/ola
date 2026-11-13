package main

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/db"
	"ola-chat-server/internal/logger"
	"ola-chat-server/internal/modules/room/wordchain"
	"ola-chat-server/internal/modules/setting"
	userModule "ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/push"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"

	"github.com/gocql/gocql"
	"go.uber.org/dig"
	"go.uber.org/zap"
)

func provideConfig() (*config.Config, error) {
	return LoadChatConfig()
}

func provideOptionalScylla(cfg *config.Config, log *zap.SugaredLogger) *gocql.Session {
	if cfg.ScyllaHost == "" {
		log.Warn("SCYLLA_HOST not set: conversation member cache misses cannot be backfilled")
		return nil
	}
	session, err := db.NewScyllaDB(cfg, log)
	if err != nil {
		log.Errorw("ScyllaDB unavailable: conversation member cache misses cannot be backfilled", "error", err)
		return nil
	}
	return session
}

func NewContainer(opts ...dig.Option) (*dig.Container, error) {
	c := dig.New(opts...)

	providers := []interface{}{
		provideConfig,
		logger.CreateLogger,
		services.NewCacheService,
		services.NewJWTService,
		db.NewPostgresDB,
		provideOptionalScylla,
		push.NewFCMClient,
		push.NewSender,
		setting.NewRepository,
		setting.NewService,
		userModule.NewCacheService,
		wordchain.NewAccess,
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return nil, err
		}
	}

	modules := []func(*dig.Container) error{
		websocket.Provider,
		kafka.ProvideConsumer,
	}

	for _, module := range modules {
		if err := module(c); err != nil {
			return nil, err
		}
	}

	return c, nil
}
