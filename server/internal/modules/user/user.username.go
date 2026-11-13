package user

import (
	"errors"
	"regexp"
	"strings"
	"time"

	"ola-chat-server/internal/modules/setting"

	"github.com/google/uuid"
)

const (
	usernameMinLen = 2
	usernameMaxLen = 20
)

var (
	ErrInvalidUsername        = errors.New("invalid username format")
	ErrUsernameChangeDisabled = errors.New("username change is disabled")
	ErrUsernameCostChanged    = errors.New("username change cost has changed")
	ErrRevokeSessionsFailed   = errors.New("username changed but failed to revoke sessions")
)

const (
	revokeSessionsAttempts = 3
	revokeSessionsBackoff  = 200 * time.Millisecond
)

func normalizeUsername(username string) (string, error) {
	name := strings.ToLower(strings.TrimSpace(username))
	name = strings.TrimPrefix(name, "@")
	if len(name) < usernameMinLen || len(name) > usernameMaxLen || !IsValidUsernameFormat(name) {
		return "", ErrInvalidUsername
	}
	return name, nil
}

func (s *Service) resolveUsernameChangeCost(username string, client setting.Client) (int, error) {
	cfg, err := s.settingSvc.GetUsernameChange()
	if err != nil {
		return 0, err
	}
	if !cfg.EnabledFor(client.Platform, client.AppVersion) {
		return 0, ErrUsernameChangeDisabled
	}
	cost := cfg.CostFor(len(username))
	if cost < 0 {
		return 0, ErrInvalidUsername
	}
	return cost, nil
}

func (s *Service) CheckUsername(userID uuid.UUID, username string, client setting.Client) (*CheckUsernameResponse, error) {
	name, err := normalizeUsername(username)
	if err != nil {
		return nil, err
	}
	cost, err := s.resolveUsernameChangeCost(name, client)
	if err != nil {
		return nil, err
	}
	taken, err := s.repo.UsernameTaken(name, userID)
	if err != nil {
		return nil, err
	}
	return &CheckUsernameResponse{
		Username:  name,
		Available: !taken,
		Cost:      cost,
	}, nil
}

func (s *Service) ChangeUsername(userID uuid.UUID, username string, expectedCost int, client setting.Client) (*ChangeUsernameResponse, error) {
	name, err := normalizeUsername(username)
	if err != nil {
		return nil, err
	}
	cost, err := s.resolveUsernameChangeCost(name, client)
	if err != nil {
		return nil, err
	}
	if cost != expectedCost {
		return nil, ErrUsernameCostChanged
	}
	taken, err := s.repo.UsernameTaken(name, userID)
	if err != nil {
		return nil, err
	}
	if taken {
		return nil, ErrUsernameTaken
	}

	result, err := s.repo.ChangeUsername(ChangeUsernameParams{
		UserID:      userID,
		NewUsername: name,
		Cost:        cost,
	})
	if err != nil {
		return nil, err
	}

	if err := s.cache.InvalidateUser(userID); err != nil {
		s.logger.Warnw("Failed to invalidate user cache after username change",
			"user_id", userID,
			"error", err.Error(),
		)
	}
	var revokeErr error
	for attempt := 1; attempt <= revokeSessionsAttempts; attempt++ {
		if _, revokeErr = s.sessionSvc.RevokeAllForUser(userID); revokeErr == nil {
			break
		}
		s.logger.Warnw("Failed to revoke sessions after username change, retrying",
			"user_id", userID,
			"attempt", attempt,
			"error", revokeErr.Error(),
		)
		time.Sleep(revokeSessionsBackoff)
	}
	if revokeErr != nil {
		s.logger.Errorw("Sessions not revoked after username change",
			"user_id", userID,
			"error", revokeErr.Error(),
		)
		return nil, ErrRevokeSessionsFailed
	}

	s.logger.Infow("Username changed",
		"user_id", userID,
		"old_username", result.OldUsername,
		"new_username", name,
		"cost", cost,
	)

	return &ChangeUsernameResponse{
		Username:   name,
		Cost:       cost,
		KenBalance: result.KenBalance,
	}, nil
}

var usernameRegex = regexp.MustCompile(`^[a-z][a-z0-9]*$`)

const UsernameFormatMessage = "username may only contain lowercase letters and numbers, and must start with a letter"

func IsValidUsernameFormat(username string) bool {
	return usernameRegex.MatchString(username)
}
