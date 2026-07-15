package game

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game/engine"

	_ "ola-chat-server/internal/game/games/caro"
	_ "ola-chat-server/internal/game/games/war-god"

	"go.uber.org/dig"
	"go.uber.org/zap"
)

func Provider(c *dig.Container) error {
	if err := c.Provide(func(cfg *config.Config, logger *zap.SugaredLogger) *engine.Engine {
		return engine.NewEngine(logger, cfg.GameTurnSeconds)
	}); err != nil {
		return err
	}
	return c.Provide(NewServer)
}
