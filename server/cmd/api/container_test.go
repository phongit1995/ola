package main

import (
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/transport/websocket"

	"go.uber.org/dig"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

func TestContainerResolvesEveryDependency(t *testing.T) {
	c, err := NewContainer(dig.DryRun(true))
	if err != nil {
		t.Fatal(err)
	}
	invocations := []interface{}{
		func(*gorm.DB) {},
		func(*config.Config, *zap.SugaredLogger) {},
		func(Schedulers) {},
		func(*Server, *websocket.Server, *config.Config) {},
	}
	for _, invoke := range invocations {
		if err := c.Invoke(invoke); err != nil {
			t.Fatal(err)
		}
	}
}
