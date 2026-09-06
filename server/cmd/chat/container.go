package main

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/db"
	"ola-chat-server/internal/logger"
	"ola-chat-server/internal/push"
	"ola-chat-server/internal/services"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"

	"go.uber.org/dig"
)

func provideConfig() (*config.Config, error) {
	return LoadChatConfig()
}

func NewContainer() (*dig.Container, error) {
	c := dig.New()

	providers := []interface{}{
		provideConfig,
		logger.CreateLogger,
		services.NewCacheService,
		services.NewJWTService,
		db.NewPostgresDB,
		push.NewFCMClient,
		push.NewSender,
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
