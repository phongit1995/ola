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

func WeightedPick(weights []float64) int {
	total := 0.0
	for _, w := range weights {
		if w > 0 {
			total += w
		}
	}
	if total <= 0 {
		return -1
	}
	target := CryptoFloat() * total
	acc := 0.0
	last := -1
	for i, w := range weights {
		if w <= 0 {
			continue
		}
		last = i
		acc += w
		if target < acc {
			return i
		}
	}
	return last
}
