package clan

import (
	"ola-chat-server/internal/modules/me"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewRepository,
		NewService,
		NewController,
		NewRouter,
		func(r *Repository) me.ClanGate { return r },
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return err
		}
	}

	return nil
}
