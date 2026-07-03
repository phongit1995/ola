package kafka

import (
	callEvents "ola-chat-server/internal/domain/call"
	conversationEvents "ola-chat-server/internal/domain/conversation"
	kenChestEvents "ola-chat-server/internal/domain/kenchest"
	meNotificationEvents "ola-chat-server/internal/domain/me-notification"
	messageEvents "ola-chat-server/internal/domain/message"
	roomEvents "ola-chat-server/internal/domain/room"

	"go.uber.org/dig"
)

func ProvideConsumer(c *dig.Container) error {
	providers := []interface{}{
		NewProducer,
		NewConsumer,
		NewKafkaEventAdapter,
	}

	for _, provider := range providers {
		if err := c.Provide(provider); err != nil {
			return err
		}
	}

	modules := []func(*dig.Container) error{
		messageEvents.Provider,
		conversationEvents.Provider,
		callEvents.Provider,
		roomEvents.Provider,
		kenChestEvents.Provider,
		meNotificationEvents.Provider,
	}

	for _, module := range modules {
		if err := module(c); err != nil {
			return err
		}
	}

	return nil
}
