package services

import (
	"errors"
	"ola-chat-server/internal/config"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

const (
	TokenTypeAdmin  = "admin"
	TokenUseAccess  = "access"
	TokenUseRefresh = "refresh"

	ClaimUserID    = "id"
	ClaimSessionID = "sid"
	ClaimType      = "type"
	ClaimTokenUse  = "token_use"
	ClaimIsAdmin   = "isAdmin"

	defaultAccessTokenExpiry  = 24 * time.Hour
	defaultRefreshTokenExpiry = 30 * 24 * time.Hour
	legacyTokenLifetimeSlack  = time.Minute
)

var ErrWrongTokenUse = errors.New("wrong token type")

type JWTService struct {
	cfg *config.Config
}

type TokenClaims struct {
	Data interface{} `json:"data"`
	jwt.RegisteredClaims
}

func NewJWTService(cfg *config.Config) *JWTService {
	return &JWTService{cfg: cfg}
}

func (s *JWTService) GenerateTokenWithSession(userID, sessionID uuid.UUID) (string, error) {
	return s.GenerateTokenWithClaims(userSessionClaims(userID, sessionID, TokenUseAccess))
}

func userSessionClaims(userID, sessionID uuid.UUID, tokenUse string) map[string]interface{} {
	return map[string]interface{}{
		ClaimUserID:    userID.String(),
		ClaimSessionID: sessionID.String(),
		ClaimTokenUse:  tokenUse,
	}
}

func (s *JWTService) accessExpiry() time.Duration {
	expiry, err := time.ParseDuration(s.cfg.JWTExpiry)
	if err != nil {
		return defaultAccessTokenExpiry
	}
	return expiry
}

func (s *JWTService) refreshExpiry() time.Duration {
	expiry, err := time.ParseDuration(s.cfg.RefreshTokenExpiry)
	if err != nil {
		return defaultRefreshTokenExpiry
	}
	return expiry
}

func (s *JWTService) TokenUse(claims *TokenClaims) string {
	if data, ok := claims.Data.(map[string]interface{}); ok {
		if use, _ := data[ClaimTokenUse].(string); use != "" {
			return use
		}
	}
	if claims.IssuedAt == nil || claims.ExpiresAt == nil {
		return TokenUseAccess
	}
	if claims.ExpiresAt.Sub(claims.IssuedAt.Time) > s.accessExpiry()+legacyTokenLifetimeSlack {
		return TokenUseRefresh
	}
	return TokenUseAccess
}

func (s *JWTService) VerifyAccessToken(tokenString string) (*TokenClaims, error) {
	return s.verifyTokenUse(tokenString, TokenUseAccess)
}

func (s *JWTService) VerifyRefreshToken(tokenString string) (*TokenClaims, error) {
	return s.verifyTokenUse(tokenString, TokenUseRefresh)
}

func (s *JWTService) verifyTokenUse(tokenString, expected string) (*TokenClaims, error) {
	claims, err := s.VerifyToken(tokenString)
	if err != nil {
		return nil, err
	}
	if s.TokenUse(claims) != expected {
		return nil, ErrWrongTokenUse
	}
	return claims, nil
}

func (s *JWTService) GenerateTokenWithClaims(data interface{}) (string, error) {
	return s.sign(data, s.accessExpiry())
}

func (s *JWTService) sign(data interface{}, expiry time.Duration) (string, error) {
	now := time.Now()
	claims := TokenClaims{
		Data: data,
		RegisteredClaims: jwt.RegisteredClaims{
			ID:        uuid.NewString(),
			ExpiresAt: jwt.NewNumericDate(now.Add(expiry)),
			IssuedAt:  jwt.NewNumericDate(now),
			NotBefore: jwt.NewNumericDate(now),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString([]byte(s.cfg.JWTSecret))
}

func (s *JWTService) VerifyToken(tokenString string) (*TokenClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &TokenClaims{}, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, errors.New("unexpected signing method")
		}
		return []byte(s.cfg.JWTSecret), nil
	})

	if err != nil {
		return nil, err
	}

	if claims, ok := token.Claims.(*TokenClaims); ok && token.Valid {
		return claims, nil
	}

	return nil, errors.New("invalid token")
}

func (s *JWTService) GenerateRefreshTokenWithSession(userID, sessionID uuid.UUID) (string, error) {
	return s.GenerateRefreshTokenWithClaims(userSessionClaims(userID, sessionID, TokenUseRefresh))
}

func (s *JWTService) GenerateRefreshTokenWithClaims(data interface{}) (string, error) {
	return s.sign(data, s.refreshExpiry())
}

func UserIDFromClaims(claims *TokenClaims) (uuid.UUID, error) {
	data, ok := claims.Data.(map[string]interface{})
	if !ok {
		return uuid.Nil, errors.New("invalid data format in token")
	}
	userIDStr, ok := data[ClaimUserID].(string)
	if !ok {
		return uuid.Nil, errors.New("id not found in token")
	}
	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		return uuid.Nil, errors.New("invalid user_id format in token")
	}
	return userID, nil
}

func SessionIDFromClaims(claims *TokenClaims) (uuid.UUID, error) {
	data, ok := claims.Data.(map[string]interface{})
	if !ok {
		return uuid.Nil, errors.New("invalid data format in token")
	}
	sidStr, ok := data[ClaimSessionID].(string)
	if !ok || sidStr == "" {
		return uuid.Nil, nil
	}
	sessionID, err := uuid.Parse(sidStr)
	if err != nil {
		return uuid.Nil, errors.New("invalid sid format in token")
	}
	return sessionID, nil
}
