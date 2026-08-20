package game

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/game/engine"
	"ola-chat-server/internal/services"

	_ "ola-chat-server/internal/game/games/caro"
	_ "ola-chat-server/internal/game/games/thirteen"
	_ "ola-chat-server/internal/game/games/war-god"

	"go.uber.org/dig"
	"go.uber.org/zap"
)

func Provider(c *dig.Container) error {
	if err := c.Provide(func(cfg *config.Config, logger *zap.SugaredLogger, cache *services.CacheService, settlement engine.Settlement) *engine.Engine {
		e := engine.NewEngine(
			logger,
			cfg.GameTurnSeconds,
			cfg.GameReconnectGraceSeconds,
			engine.NewRoomStore(cache),
			engine.NewMatchStore(cache),
		)
		e.SetSettlement(settlement)
		return e
	}); err != nil {
		return err
	}
	if err := c.Provide(NewRepository); err != nil {
		return err
	}
	if err := c.Provide(NewSettlementRepository); err != nil {
		return err
	}
	return c.Provide(NewServer)
}
