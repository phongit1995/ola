package services

import (
	"context"
	"errors"
	"fmt"
	"testing"
	"time"

	"ola-chat-server/internal/config"
	"ola-chat-server/internal/constants"

	"github.com/alicebob/miniredis/v2"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"github.com/redis/go-redis/v9"
)

const testJWTSecret = "test-secret-test-secret-test-secret-123"

func newTestJWTService() *JWTService {
	return NewJWTService(&config.Config{JWTSecret: testJWTSecret, JWTExpiry: "24h", RefreshTokenExpiry: "720h"})
}

func signLegacyToken(t *testing.T, lifetime time.Duration) string {
	t.Helper()
	now := time.Now()
	claims := TokenClaims{
		Data: map[string]interface{}{ClaimUserID: uuid.NewString(), ClaimSessionID: uuid.NewString()},
		RegisteredClaims: jwt.RegisteredClaims{
			ID:        uuid.NewString(),
			ExpiresAt: jwt.NewNumericDate(now.Add(lifetime)),
			IssuedAt:  jwt.NewNumericDate(now),
			NotBefore: jwt.NewNumericDate(now),
		},
	}
	token, err := jwt.NewWithClaims(jwt.SigningMethodHS256, claims).SignedString([]byte(testJWTSecret))
	if err != nil {
		t.Fatal(err)
	}
	return token
}

func TestAccessAndRefreshTokensAreNotInterchangeable(t *testing.T) {
	s := newTestJWTService()
	userID, sessionID := uuid.New(), uuid.New()

	access, err := s.GenerateTokenWithSession(userID, sessionID)
	if err != nil {
		t.Fatal(err)
	}
	refresh, err := s.GenerateRefreshTokenWithSession(userID, sessionID)
	if err != nil {
		t.Fatal(err)
	}

	claims, err := s.VerifyAccessToken(access)
	if err != nil {
		t.Fatalf("access token rejected: %v", err)
	}
	if got, _ := UserIDFromClaims(claims); got != userID {
		t.Fatalf("user id = %v, want %v", got, userID)
	}
	if got, _ := SessionIDFromClaims(claims); got != sessionID {
		t.Fatalf("session id = %v, want %v", got, sessionID)
	}
	if _, err := s.VerifyRefreshToken(refresh); err != nil {
		t.Fatalf("refresh token rejected: %v", err)
	}
	if _, err := s.VerifyAccessToken(refresh); !errors.Is(err, ErrWrongTokenUse) {
		t.Fatalf("refresh token used as access: err = %v", err)
	}
	if _, err := s.VerifyRefreshToken(access); !errors.Is(err, ErrWrongTokenUse) {
		t.Fatalf("access token used as refresh: err = %v", err)
	}
}

func TestLegacyTokensClassifiedByLifetime(t *testing.T) {
	s := newTestJWTService()

	legacyAccess := signLegacyToken(t, 24*time.Hour)
	if _, err := s.VerifyAccessToken(legacyAccess); err != nil {
		t.Fatalf("legacy access token rejected: %v", err)
	}
	if _, err := s.VerifyRefreshToken(legacyAccess); err == nil {
		t.Fatal("legacy access token accepted as refresh")
	}

	legacyRefresh := signLegacyToken(t, 720*time.Hour)
	if _, err := s.VerifyRefreshToken(legacyRefresh); err != nil {
		t.Fatalf("legacy refresh token rejected: %v", err)
	}
	if _, err := s.VerifyAccessToken(legacyRefresh); !errors.Is(err, ErrWrongTokenUse) {
		t.Fatalf("legacy refresh token used as access: err = %v", err)
	}
}

func TestAuthenticateUserAccessTokenRejectsAdminAndRefresh(t *testing.T) {
	s := newTestJWTService()

	admin, err := s.GenerateTokenWithClaims(map[string]interface{}{
		ClaimUserID: uuid.NewString(), ClaimSessionID: uuid.NewString(),
		ClaimType: TokenTypeAdmin, ClaimIsAdmin: true, ClaimTokenUse: TokenUseAccess,
	})
	if err != nil {
		t.Fatal(err)
	}
	if _, err := AuthenticateUserAccessToken(s, nil, admin); !errors.Is(err, ErrAccessTokenAdmin) {
		t.Fatalf("admin token: err = %v", err)
	}

	refresh, _ := s.GenerateRefreshTokenWithSession(uuid.New(), uuid.New())
	if _, err := AuthenticateUserAccessToken(s, nil, refresh); !errors.Is(err, ErrAccessTokenInvalid) {
		t.Fatalf("refresh token: err = %v", err)
	}

	userID, sessionID := uuid.New(), uuid.New()
	access, _ := s.GenerateTokenWithSession(userID, sessionID)
	identity, err := AuthenticateUserAccessToken(s, nil, access)
	if err != nil {
		t.Fatal(err)
	}
	if identity.UserID != userID || identity.SessionID != sessionID {
		t.Fatalf("identity = %+v", identity)
	}
}

func TestLegacyTokenClassificationIgnoresServiceAccessExpiry(t *testing.T) {
	s := NewJWTService(&config.Config{JWTSecret: testJWTSecret, JWTExpiry: "15m", RefreshTokenExpiry: "720h"})

	if _, err := s.VerifyAccessToken(signLegacyToken(t, 24*time.Hour)); err != nil {
		t.Fatalf("legacy 24h access token rejected by service with 15m expiry: %v", err)
	}
	if _, err := s.VerifyAccessToken(signLegacyToken(t, 720*time.Hour)); !errors.Is(err, ErrWrongTokenUse) {
		t.Fatalf("legacy refresh token accepted as access: err = %v", err)
	}
}

func TestAuthenticateUserAccessTokenRevocation(t *testing.T) {
	s := newTestJWTService()
	mr := miniredis.RunT(t)
	cache := &CacheService{client: redis.NewClient(&redis.Options{Addr: mr.Addr()}), ctx: context.Background()}

	userID, sessionID := uuid.New(), uuid.New()
	access, _ := s.GenerateTokenWithSession(userID, sessionID)
	claims, _ := s.VerifyAccessToken(access)

	identity, err := AuthenticateUserAccessToken(s, cache, access)
	if err != nil || identity.RevocationCheckErr != nil {
		t.Fatalf("valid token: identity=%+v err=%v", identity, err)
	}

	if err := mr.Set(fmt.Sprintf(constants.CacheKeySessionRevoked, sessionID.String()), "1"); err != nil {
		t.Fatal(err)
	}
	if _, err := AuthenticateUserAccessToken(s, cache, access); !errors.Is(err, ErrAccessSessionRevoked) {
		t.Fatalf("revoked session: err = %v", err)
	}

	if err := mr.Set(fmt.Sprintf(constants.CacheKeyTokenBlacklist, claims.ID), "1"); err != nil {
		t.Fatal(err)
	}
	if _, err := AuthenticateUserAccessToken(s, cache, access); !errors.Is(err, ErrAccessTokenRevoked) {
		t.Fatalf("blacklisted token: err = %v", err)
	}
}

func TestAuthenticateUserAccessTokenFailsOpenWhenRedisDown(t *testing.T) {
	s := newTestJWTService()
	mr := miniredis.RunT(t)
	cache := &CacheService{client: redis.NewClient(&redis.Options{Addr: mr.Addr(), MaxRetries: -1}), ctx: context.Background()}
	mr.Close()

	userID := uuid.New()
	access, _ := s.GenerateTokenWithSession(userID, uuid.New())
	identity, err := AuthenticateUserAccessToken(s, cache, access)
	if err != nil {
		t.Fatalf("redis outage rejected a valid token: %v", err)
	}
	if identity.UserID != userID || identity.RevocationCheckErr == nil {
		t.Fatalf("identity = %+v", identity)
	}
}
