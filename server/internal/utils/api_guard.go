package utils

import (
	"crypto/hmac"
	"crypto/sha512"
	"encoding/hex"
	"strconv"
	"strings"
	"time"
)

func apiGuardSignHex(secret, value string) string {
	mac := hmac.New(sha512.New, []byte(secret))
	mac.Write([]byte(value))
	return hex.EncodeToString(mac.Sum(nil))
}

func apiGuardSafeEqualHex(a, b string) bool {
	ab, err := hex.DecodeString(a)
	if err != nil {
		return false
	}
	bb, err := hex.DecodeString(b)
	if err != nil {
		return false
	}
	return hmac.Equal(ab, bb)
}

func apiGuardCanonical(timestamp, nonce, method, path string) string {
	return strings.Join([]string{
		timestamp,
		nonce,
		strings.ToUpper(method),
		path,
	}, "\n")
}

func APIGuardVerify(secret, timestamp, nonce, signature, method, path string, maxSkew time.Duration) bool {
	if timestamp == "" || nonce == "" || signature == "" {
		return false
	}

	ms, err := strconv.ParseInt(timestamp, 10, 64)
	if err != nil {
		return false
	}
	skew := time.Since(time.UnixMilli(ms))
	if skew > maxSkew || skew < -maxSkew {
		return false
	}

	return apiGuardSafeEqualHex(apiGuardSignHex(secret, apiGuardCanonical(timestamp, nonce, method, path)), signature)
}
