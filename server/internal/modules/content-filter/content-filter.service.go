package contentfilter

import (
	"slices"
	"sync"

	"ola-chat-server/internal/modules/setting"

	"go.uber.org/zap"
)

type Result struct {
	Blocked bool   `json:"blocked" example:"true"`
	Reason  string `json:"reason,omitempty" example:"banned_word"`
	Word    string `json:"word,omitempty" example:"lừa đảo"`
}

type Service struct {
	settings *setting.Service
	logger   *zap.SugaredLogger

	mu            sync.Mutex
	compiledWords []string
	compiled      []phrase
}

func NewService(settings *setting.Service, logger *zap.SugaredLogger) *Service {
	return &Service{settings: settings, logger: logger.Named("[content_filter]")}
}

func (s *Service) phrases() []phrase {
	cfg, err := s.settings.GetContentFilter()
	if err != nil {
		s.logger.Warnw("Failed to read content filter, using stored or default words", "error", err.Error())
	}
	s.mu.Lock()
	defer s.mu.Unlock()
	if s.compiled == nil || !slices.Equal(s.compiledWords, cfg.BannedWords) {
		s.compiledWords = slices.Clone(cfg.BannedWords)
		s.compiled = compilePhrases(cfg.BannedWords)
	}
	return s.compiled
}

func (s *Service) Check(text string) Result {
	if ContainsLink(text) {
		return Result{Blocked: true, Reason: ReasonLink}
	}
	if word, ok := matchPhrases(text, s.phrases()); ok {
		return Result{Blocked: true, Reason: ReasonBannedWord, Word: word}
	}
	return Result{}
}
