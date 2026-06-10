package main

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/db"
	domConversation "ola-chat-server/internal/domain/conversation"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"
	"ola-chat-server/internal/logger"
	"ola-chat-server/internal/middleware"
	"ola-chat-server/internal/modules/admin"
	"ola-chat-server/internal/modules/auth"
	"ola-chat-server/internal/modules/call"
	"ola-chat-server/internal/modules/conversation"
	"ola-chat-server/internal/modules/health"
	"ola-chat-server/internal/modules/message"
	"ola-chat-server/internal/modules/relationships"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"

	"go.uber.org/dig"
)

func provideConfig() (*config.Config, error) {
	return LoadAPIConfig()
}

func NewContainer() (*dig.Container, error) {
	c := dig.New()
	providers := []interface{}{
		provideConfig,
		logger.CreateLogger,
		db.NewPostgresDB,
		db.NewScyllaDB,
		services.NewCacheService,
		services.NewJWTService,
		services.NewMinIOService,
		middleware.NewAuthMiddleware,
		CreateServer,
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return nil, err
		}
	}

	modules := []func(*dig.Container) error{
		kafka.ProvideProducer,
		domConversation.Provider,
		websocket.Provider,
		auth.Provider,
		admin.Provider,
		health.Provider,
		user.Provider,
		relationships.Provider,
		conversation.Provider,
		message.Provider,
		call.Provider,
	}

	for _, module := range modules {
		if err := module(c); err != nil {
			return nil, err
		}
	}

	return c, nil
}
