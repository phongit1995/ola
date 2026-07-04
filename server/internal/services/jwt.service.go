package services

import (
	"errors"
	"ola-chat-server/internal/config"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

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
	return s.GenerateTokenWithClaims(map[string]interface{}{
		"id":  userID.String(),
		"sid": sessionID.String(),
	})
}

func (s *JWTService) GenerateTokenWithClaims(data interface{}) (string, error) {
	expiry, err := time.ParseDuration(s.cfg.JWTExpiry)
	if err != nil {
		expiry = 24 * time.Hour
	}

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

func (s *JWTService) GetDataFromToken(tokenString string) (interface{}, error) {
	claims, err := s.VerifyToken(tokenString)
	if err != nil {
		return nil, err
	}

	return claims.Data, nil
}

func (s *JWTService) GenerateRefreshTokenWithSession(userID, sessionID uuid.UUID) (string, error) {
	return s.GenerateRefreshTokenWithClaims(map[string]interface{}{
		"id":  userID.String(),
		"sid": sessionID.String(),
	})
}

func (s *JWTService) GenerateRefreshTokenWithClaims(data interface{}) (string, error) {
	expiry, err := time.ParseDuration(s.cfg.RefreshTokenExpiry)
	if err != nil {
		expiry = 30 * 24 * time.Hour
	}

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

func (s *JWTService) GetUserIDFromToken(tokenString string) (uuid.UUID, error) {
	data, err := s.GetDataFromToken(tokenString)
	if err != nil {
		return uuid.Nil, err
	}

	dataMap, ok := data.(map[string]interface{})
	if !ok {
		return uuid.Nil, errors.New("invalid data format in token")
	}

	userIDStr, ok := dataMap["id"].(string)
	if !ok {
		return uuid.Nil, errors.New("id not found in token")
	}

	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		return uuid.Nil, errors.New("invalid user_id format in token")
	}

	return userID, nil
}

func (s *JWTService) GetSessionIDFromToken(tokenString string) (uuid.UUID, error) {
	data, err := s.GetDataFromToken(tokenString)
	if err != nil {
		return uuid.Nil, err
	}

	dataMap, ok := data.(map[string]interface{})
	if !ok {
		return uuid.Nil, errors.New("invalid data format in token")
	}

	sidStr, ok := dataMap["sid"].(string)
	if !ok || sidStr == "" {
		return uuid.Nil, nil
	}

	sessionID, err := uuid.Parse(sidStr)
	if err != nil {
		return uuid.Nil, errors.New("invalid sid format in token")
	}

	return sessionID, nil
}
