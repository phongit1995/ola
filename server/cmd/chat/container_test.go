package main

import (
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/modules/room/wordchain"
	"ola-chat-server/internal/push"
	"ola-chat-server/internal/transport/kafka"
	"ola-chat-server/internal/transport/websocket"

	"go.uber.org/dig"
	"go.uber.org/zap"
)

func TestContainerResolvesEveryDependency(t *testing.T) {
	c, err := NewContainer(dig.DryRun(true))
	if err != nil {
		t.Fatal(err)
	}
	invocations := []interface{}{
		func(*config.Config, *zap.SugaredLogger) {},
		func(*websocket.Server, *kafka.Consumer, *kafka.KafkaEventAdapter, *push.Sender, *wordchain.Access, *config.Config) {
		},
	}
	for _, invoke := range invocations {
		if err := c.Invoke(invoke); err != nil {
			t.Fatal(err)
		}
	}
}
