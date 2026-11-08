package giftcode

import (
	"ola-chat-server/internal/modules/setting"

	"go.uber.org/dig"
)

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewRepository,
		NewService,
		func(s *Service) setting.GiftCodeActivity { return s },
		NewController,
		NewRouter,
		NewCleaner,
	}

	for _, p := range providers {
		if err := c.Provide(p); err != nil {
			return err
		}
	}

	return nil
}
