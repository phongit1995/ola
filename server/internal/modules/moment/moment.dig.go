package moment

import (
	"ola-chat-server/internal/modules/me"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewRepository,
		NewRedisStore,
		NewTranscoder,
		NewProcessor,
		newNotifier,
		NewService,
		NewCleaner,
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

func newNotifier(meService *me.Service) Notifier {
	return meService
}
