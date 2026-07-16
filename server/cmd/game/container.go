package main

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/db"
	"ola-chat-server/internal/game"
	"ola-chat-server/internal/logger"
	"ola-chat-server/internal/modules/user"
	"ola-chat-server/internal/services"

	"go.uber.org/dig"
)

func provideConfig() (*config.Config, error) {
	return LoadGameConfig()
}

func NewContainer() (*dig.Container, error) {
	c := dig.New()

	providers := []interface{}{
		provideConfig,
		logger.CreateLogger,
		services.NewJWTService,
		db.NewPostgresDB,
		services.NewCacheService,
		user.NewCacheService,
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return nil, err
		}
	}

	modules := []func(*dig.Container) error{
		game.Provider,
	}

	for _, module := range modules {
		if err := module(c); err != nil {
			return nil, err
		}
	}

	return c, nil
}
