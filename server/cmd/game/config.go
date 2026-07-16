package main

import (
	"ola-chat-server/internal/config"
	"ola-chat-server/internal/utils"

	"github.com/go-playground/validator/v10"
)

type GameConfigValidator struct {
	JWTSecret  string `validate:"required,min=32"`
	GamePort   int    `validate:"required,min=1,max=65535"`
	DBHost     string `validate:"required"`
	DBName     string `validate:"required"`
	DBUser     string `validate:"required"`
	DBPassword string `validate:"required"`
	RedisHost  string `validate:"required"`
}

func LoadGameConfig() (*config.Config, error) {
	cfg, err := config.LoadConfig()
	if err != nil {
		return nil, err
	}

	if err := validateGameConfig(cfg); err != nil {
		return nil, err
	}

	return cfg, nil
}

func validateGameConfig(cfg *config.Config) error {
	v := &GameConfigValidator{
		JWTSecret:  cfg.JWTSecret,
		GamePort:   cfg.GamePort,
		DBHost:     cfg.DBHost,
		DBName:     cfg.DBName,
		DBUser:     cfg.DBUser,
		DBPassword: cfg.DBPassword,
		RedisHost:  cfg.RedisHost,
	}

	validate := validator.New()
	if err := validate.Struct(v); err != nil {
		return utils.FormatValidationError("Game", err)
	}

	return nil
}
