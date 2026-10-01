package room

import (
	"ola-chat-server/internal/modules/room/wordchain"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	if err := wordchain.Provider(c); err != nil {
		return err
	}

	providers := []interface{}{
		NewRepository,
		NewMessageRepository,
		NewRedisMessageRepository,
		NewBlockRepository,
		NewService,
		NewController,
		NewRouter,
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return err
		}
	}

	return nil
}
