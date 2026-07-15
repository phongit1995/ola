package config

import (
	"fmt"
	"strings"

	"ola-chat-server/internal/utils"

	"github.com/caarlos0/env/v11"
	"github.com/go-playground/validator/v10"
	"github.com/joho/godotenv"
)

type Config struct {
	ServerHost  string `env:"SERVER_HOST" envDefault:"0.0.0.0"`
	ServerPort  int    `env:"SERVER_PORT" envDefault:"8080" validate:"min=1,max=65535"`
	Env         string `env:"GIN_MODE" envDefault:"debug" validate:"oneof=debug release test"`
	ServiceName string `env:"SERVICE_NAME" envDefault:"chat-service"`

	ChatPort int `env:"CHAT_PORT" envDefault:"8081" validate:"min=1,max=65535"`

	DBHost     string `env:"DB_HOST"`
	DBPort     int    `env:"DB_PORT" envDefault:"5432" validate:"omitempty,min=1,max=65535"`
	DBName     string `env:"DB_NAME"`
	DBUser     string `env:"DB_USER"`
	DBPassword string `env:"DB_PASSWORD"`
	DBSSLMode  string `env:"DB_SSL_MODE" envDefault:"disable" validate:"omitempty,oneof=disable enable require verify-ca verify-full"`

	RedisHost     string `env:"REDIS_HOST"`
	RedisPort     int    `env:"REDIS_PORT" envDefault:"6379" validate:"omitempty,min=1,max=65535"`
	RedisPassword string `env:"REDIS_PASSWORD"`
	RedisDB       int    `env:"REDIS_DB" envDefault:"0" validate:"min=0,max=15"`

	WebSocketRedisHost     string `env:"WEBSOCKET_REDIS_HOST"`
	WebSocketRedisPort     int    `env:"WEBSOCKET_REDIS_PORT" envDefault:"6379" validate:"omitempty,min=1,max=65535"`
	WebSocketRedisPassword string `env:"WEBSOCKET_REDIS_PASSWORD"`
	WebSocketRedisDB       int    `env:"WEBSOCKET_REDIS_DB" envDefault:"1" validate:"min=0,max=15"`

	ScyllaHost        string `env:"SCYLLA_HOST"`
	ScyllaPort        int    `env:"SCYLLA_PORT" envDefault:"9042" validate:"omitempty,min=1,max=65535"`
	ScyllaKeyspace    string `env:"SCYLLA_KEYSPACE"`
	ScyllaConsistency string `env:"SCYLLA_CONSISTENCY" envDefault:"QUORUM" validate:"omitempty,oneof=ANY ONE TWO THREE QUORUM ALL LOCAL_QUORUM EACH_QUORUM LOCAL_ONE"`

	JWTSecret          string `env:"JWT_SECRET"`
	JWTExpiry          string `env:"JWT_EXPIRY" envDefault:"15m"`
	RefreshTokenExpiry string `env:"REFRESH_TOKEN_EXPIRY" envDefault:"720h"`

	APIGuardSecret string `env:"API_GUARD_SECRET"`

	CORSAllowedOrigins []string `env:"CORS_ALLOWED_ORIGINS" envSeparator:","`

	WSReadBufferSize  int `env:"WS_READ_BUFFER_SIZE" envDefault:"1024" validate:"min=1024"`
	WSWriteBufferSize int `env:"WS_WRITE_BUFFER_SIZE" envDefault:"1024" validate:"min=1024"`

	KafkaBrokers           []string `env:"KAFKA_BROKERS" envSeparator:"," validate:"required,min=1"`
	KafkaConsumerWorkers   int      `env:"KAFKA_CONSUMER_WORKERS" envDefault:"10" validate:"min=1,max=100"`
	KafkaMessageTimeoutSec int      `env:"KAFKA_MESSAGE_TIMEOUT_SEC" envDefault:"10" validate:"min=1,max=300"`

	S3Endpoint  string `env:"S3_ENDPOINT" envDefault:"localhost:9000"`
	S3AccessKey string `env:"S3_ACCESS_KEY"`
	S3SecretKey string `env:"S3_SECRET_KEY"`
	S3Bucket    string `env:"S3_BUCKET" envDefault:"chat-uploads"`
	S3UseSSL    bool   `env:"S3_USE_SSL" envDefault:"false"`
	S3PublicURL string `env:"S3_PUBLIC_URL" envDefault:""`

	ResendAPIKey string `env:"RESEND_API_KEY" envDefault:"re_Qrsr5SLt_HR2pmoKUyENNmsMWjjMzyE6o"`
	MailFrom     string `env:"MAIL_FROM" envDefault:"Ola Chat <noreply@olachat.net>"`

	LiveKitURL             string `env:"LIVEKIT_URL" envDefault:""`
	LiveKitAPIKey          string `env:"LIVEKIT_API_KEY" envDefault:""`
	LiveKitAPISecret       string `env:"LIVEKIT_API_SECRET" envDefault:""`
	CallRingTimeoutSeconds int    `env:"CALL_RING_TIMEOUT_SECONDS" envDefault:"30" validate:"min=2,max=300"`

	MessageDeleteWindowSeconds int `env:"MESSAGE_DELETE_WINDOW_SECONDS" envDefault:"7200" validate:"min=0"`

	RoomMessageRetentionDays int `env:"ROOM_MESSAGE_RETENTION_DAYS" envDefault:"90" validate:"min=1"`
}

func LoadConfig() (*Config, error) {
	if err := godotenv.Load(); err != nil {
		_ = godotenv.Load("../.env")
	}

	cfg := &Config{}

	if err := env.Parse(cfg); err != nil {
		return nil, fmt.Errorf("failed to parse environment variables: %w", err)
	}

	for i := range cfg.CORSAllowedOrigins {
		cfg.CORSAllowedOrigins[i] = strings.TrimSpace(cfg.CORSAllowedOrigins[i])
	}

	validate := validator.New()
	if err := validate.Struct(cfg); err != nil {
		return nil, utils.FormatValidationError("", err)
	}

	return cfg, nil
}
