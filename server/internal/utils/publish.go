package utils

import (
	"context"
	"time"

	"go.uber.org/zap"
)

const publishTimeout = 5 * time.Second

func PublishWithTimeout(logger *zap.SugaredLogger, action string, publish func(ctx context.Context) error) {
	ctx, cancel := context.WithTimeout(context.Background(), publishTimeout)
	defer cancel()
	if err := publish(ctx); err != nil && logger != nil {
		logger.Errorw("Failed to publish "+action, "error", err)
	}
}

func PublishAsync(logger *zap.SugaredLogger, action string, publish func(ctx context.Context) error) {
	SafeGo(logger, func() { PublishWithTimeout(logger, action, publish) })
}
