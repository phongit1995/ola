package config

import (
	"os"
	"strings"
	"testing"
)

func unsetEnvForTest(t *testing.T, key string) {
	t.Helper()
	value, existed := os.LookupEnv(key)
	if err := os.Unsetenv(key); err != nil {
		t.Fatal(err)
	}
	t.Cleanup(func() {
		if existed {
			_ = os.Setenv(key, value)
			return
		}
		_ = os.Unsetenv(key)
	})
}

func TestCaroCommissionPercentDefaultsToFive(t *testing.T) {
	unsetEnvForTest(t, "CARO_COMMISSION_PERCENT")
	t.Setenv("KAFKA_BROKERS", "localhost:9092")

	cfg, err := LoadConfig()
	if err != nil {
		t.Fatal(err)
	}
	if cfg.CaroCommissionPercent != 5 {
		t.Fatalf("caro commission = %d, want 5", cfg.CaroCommissionPercent)
	}
}

func TestCaroCommissionPercentRejectsOutOfRangeValue(t *testing.T) {
	t.Setenv("CARO_COMMISSION_PERCENT", "101")
	t.Setenv("KAFKA_BROKERS", "localhost:9092")

	_, err := LoadConfig()
	if err == nil || !strings.Contains(err.Error(), "CaroCommissionPercent") {
		t.Fatalf("invalid Caro commission error = %v", err)
	}
}
