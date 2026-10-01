package wordchain

import (
	"strings"
	"unicode"

	"golang.org/x/text/unicode/norm"
)

var oaToneShift = map[rune]rune{'à': 'ò', 'á': 'ó', 'ả': 'ỏ', 'ã': 'õ', 'ạ': 'ọ'}

var uyToneShift = map[rune]rune{'ý': 'ú', 'ỳ': 'ù', 'ỷ': 'ủ', 'ỹ': 'ũ', 'ỵ': 'ụ'}

func normalizeVietnamese(text string) string {
	normalized := strings.Join(strings.Fields(strings.ToLower(norm.NFC.String(text))), " ")
	runes := []rune(normalized)
	runes = shiftTonePair(runes, 'o', 'a', oaToneShift, false)
	runes = shiftTonePair(runes, 'u', 'y', uyToneShift, true)
	return string(runes)
}

func shiftTonePair(runes []rune, lead, tail rune, shifts map[rune]rune, skipAfterQ bool) []rune {
	out := make([]rune, len(runes))
	copy(out, runes)
	for i := 0; i+1 < len(out); i++ {
		if out[i] != lead {
			continue
		}
		toned, ok := shifts[out[i+1]]
		if !ok || !isWordBoundary(out, i+2) {
			continue
		}
		if skipAfterQ && i > 0 && out[i-1] == 'q' {
			continue
		}
		out[i] = toned
		out[i+1] = tail
		i++
	}
	return out
}

func isWordBoundary(runes []rune, index int) bool {
	return index >= len(runes) || !unicode.IsLetter(runes[index])
}

func splitSyllables(word string) []string {
	return strings.Split(word, " ")
}

func firstWord(word string) string {
	return splitSyllables(word)[0]
}

func lastWord(word string) string {
	parts := splitSyllables(word)
	return parts[len(parts)-1]
}
