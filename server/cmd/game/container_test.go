package main

import (
	"testing"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game"

	"go.uber.org/dig"
)

func TestContainerResolvesEveryDependency(t *testing.T) {
	c, err := NewContainer(dig.DryRun(true))
	if err != nil {
		t.Fatal(err)
	}
	if err := c.Invoke(func(*game.Server, *config.Config) {}); err != nil {
		t.Fatal(err)
	}
}
