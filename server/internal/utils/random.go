package utils

import (
	"crypto/rand"
	"encoding/binary"
)

func CryptoFloat() float64 {
	var b [8]byte
	if _, err := rand.Read(b[:]); err != nil {
		return 0
	}
	v := binary.BigEndian.Uint64(b[:]) >> 11
	return float64(v) / float64(1<<53)
}
