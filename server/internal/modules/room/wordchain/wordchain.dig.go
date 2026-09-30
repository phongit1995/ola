package wordchain

import (
	"ola-chat-server/internal/transport/kafka"

	"go.uber.org/dig"
)

func provideEventPublisher(producer *kafka.Producer) EventPublisher {
	return producer
}

func Provider(c *dig.Container) error {
	providers := []interface{}{
		NewDictionary,
		NewVerifier,
		NewStore,
		provideEventPublisher,
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
