package chatbot

import (
	"context"
	"errors"
	"fmt"
	"strings"
	"time"

	"ola-chat-server/internal/constants"
	"ola-chat-server/internal/modules/setting"
	"ola-chat-server/internal/services"

	"github.com/google/uuid"
	"go.uber.org/zap"
)

var (
	errEmptyPrompt  = errors.New("chat bot prompt is empty")
	ErrBotDisabled  = errors.New("chat bot is disabled")
	ErrDailyLimit   = errors.New("chat bot daily limit reached")
	dailyCounterTTL = 48 * time.Hour
)

type Service struct {
	gemini   *GeminiClient
	settings *setting.Service
	cache    *services.CacheService
	location *time.Location
	logger   *zap.SugaredLogger
}

type Admission struct {
	persona    persona
	counterKey string
}

func NewService(gemini *GeminiClient, settings *setting.Service, cache *services.CacheService, logger *zap.SugaredLogger) *Service {
	location, err := time.LoadLocation(constants.ChatBotDailyResetTZ)
	if err != nil {
		location = time.FixedZone("ICT", 7*60*60)
	}
	return &Service{gemini: gemini, settings: settings, cache: cache, location: location, logger: logger.Named("[chat_bot_service]")}
}

func (s *Service) Admit(userID uuid.UUID, botType string) (*Admission, error) {
	cfg, err := s.settings.GetChatBot()
	if err != nil {
		s.logger.Warnw("Failed to load chat_bot config, using defaults", "error", err)
		cfg = setting.DefaultChatBotConfig()
	}
	botType = normalizeBotType(botType)
	botCfg := cfg.Bot(botType)
	if !botCfg.Enabled {
		return nil, ErrBotDisabled
	}

	admission := &Admission{persona: personaOf(botType, botCfg)}
	if cfg.DailyLimit <= 0 {
		return admission, nil
	}

	key := fmt.Sprintf(constants.CacheKeyChatBotDaily, userID.String(), time.Now().In(s.location).Format("2006-01-02"))
	count, err := s.cache.Increment(key)
	if err != nil {
		s.logger.Warnw("Failed to count chat bot usage, allowing request", "user_id", userID, "error", err)
		return admission, nil
	}
	if count == 1 {
		if err := s.cache.SetExpire(key, dailyCounterTTL); err != nil {
			s.logger.Warnw("Failed to set chat bot counter expiry", "key", key, "error", err)
		}
	}
	if count > int64(cfg.DailyLimit) {
		s.release(key)
		return nil, ErrDailyLimit
	}
	admission.counterKey = key
	return admission, nil
}

func (s *Service) Refund(admission *Admission) {
	if admission != nil && admission.counterKey != "" {
		s.release(admission.counterKey)
	}
}

func (s *Service) release(key string) {
	if _, err := s.cache.Decrement(key); err != nil {
		s.logger.Warnw("Failed to release chat bot usage", "key", key, "error", err)
	}
}

func (s *Service) Complete(ctx context.Context, req *CompletionRequest, admission *Admission) (*CompletionResponse, string, error) {
	prompt, err := buildPrompt(req, admission.persona)
	if err != nil {
		return nil, "", err
	}

	text, err := s.gemini.Generate(ctx, prompt)
	if err != nil {
		return nil, prompt, err
	}
	if strings.TrimSpace(text) == "" {
		return nil, prompt, ErrEmptyResponse
	}

	return &CompletionResponse{
		Content:      text,
		FinishReason: constants.ChatBotFinishReasonStop,
	}, prompt, nil
}

// Stream đẩy từng delta qua emit và trả về prompt + full text đã sinh.
func (s *Service) Stream(ctx context.Context, req *CompletionRequest, admission *Admission, emit func(delta string) error) (string, string, error) {
	prompt, err := buildPrompt(req, admission.persona)
	if err != nil {
		return "", "", err
	}

	var full strings.Builder
	err = s.gemini.GenerateStream(ctx, prompt, func(delta string) error {
		full.WriteString(delta)
		return emit(delta)
	})
	return prompt, full.String(), err
}
