package utils

import (
	"runtime/debug"

	"go.uber.org/zap"
)

func SafeGo(logger *zap.SugaredLogger, fn func()) {
	go func() {
		defer func() {
			if r := recover(); r != nil && logger != nil {
				logger.Errorw("recovered from panic in goroutine", "panic", r, "stack", string(debug.Stack()))
			}
		}()
		fn()
	}()
}
