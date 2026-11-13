package services

import (
	"errors"
	"fmt"

	"ola-chat-server/internal/constants"

	"github.com/google/uuid"
)

var (
	ErrAccessTokenInvalid   = errors.New("invalid or expired token")
	ErrAccessTokenRevoked   = errors.New("token has been revoked")
	ErrAccessTokenPayload   = errors.New("invalid token payload")
	ErrAccessTokenAdmin     = errors.New("invalid token")
	ErrAccessTokenNoUserID  = errors.New("id missing from token")
	ErrAccessTokenUserID    = errors.New("invalid id in token")
	ErrAccessSessionRevoked = errors.New("session revoked")
)

type AccessIdentity struct {
	UserID             uuid.UUID
	SessionID          uuid.UUID
	Claims             *TokenClaims
	RevocationCheckErr error
}

func AuthenticateUserAccessToken(jwtService *JWTService, cache *CacheService, token string) (*AccessIdentity, error) {
	claims, err := jwtService.VerifyAccessToken(token)
	if err != nil {
		return nil, ErrAccessTokenInvalid
	}

	var revocationErr error
	if claims.ID != "" {
		revoked, err := keyExists(cache, fmt.Sprintf(constants.CacheKeyTokenBlacklist, claims.ID))
		if err != nil {
			revocationErr = err
		}
		if revoked {
			return nil, ErrAccessTokenRevoked
		}
	}

	data, ok := claims.Data.(map[string]interface{})
	if !ok {
		return nil, ErrAccessTokenPayload
	}
	if isAdmin, _ := data[ClaimIsAdmin].(bool); isAdmin {
		return nil, ErrAccessTokenAdmin
	}
	if tokenType, _ := data[ClaimType].(string); tokenType == TokenTypeAdmin {
		return nil, ErrAccessTokenAdmin
	}

	userIDStr, ok := data[ClaimUserID].(string)
	if !ok {
		return nil, ErrAccessTokenNoUserID
	}
	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		return nil, ErrAccessTokenUserID
	}

	identity := &AccessIdentity{UserID: userID, Claims: claims}
	if sidStr, _ := data[ClaimSessionID].(string); sidStr != "" {
		if sessionID, err := uuid.Parse(sidStr); err == nil {
			revoked, err := keyExists(cache, fmt.Sprintf(constants.CacheKeySessionRevoked, sessionID.String()))
			if err != nil && revocationErr == nil {
				revocationErr = err
			}
			if revoked {
				return nil, ErrAccessSessionRevoked
			}
			identity.SessionID = sessionID
		}
	}
	identity.RevocationCheckErr = revocationErr
	return identity, nil
}

func keyExists(cache *CacheService, key string) (bool, error) {
	if cache == nil {
		return false, nil
	}
	return cache.Exists(key)
}
