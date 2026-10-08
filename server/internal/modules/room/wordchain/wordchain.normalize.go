package wordchain

import (
	"ola-chat-server/internal/constants"
	"slices"
	"strings"
	"unicode"

	"golang.org/x/text/unicode/norm"
)

var oaToneShift = map[rune]rune{'à': 'ò', 'á': 'ó', 'ả': 'ỏ', 'ã': 'õ', 'ạ': 'ọ'}

var oeToneShift = map[rune]rune{'è': 'ò', 'é': 'ó', 'ẻ': 'ỏ', 'ẽ': 'õ', 'ẹ': 'ọ'}

var uyToneShift = map[rune]rune{'ý': 'ú', 'ỳ': 'ù', 'ỷ': 'ủ', 'ỹ': 'ũ', 'ỵ': 'ụ'}

var yToI = map[rune]rune{'y': 'i', 'ý': 'í', 'ỳ': 'ì', 'ỷ': 'ỉ', 'ỹ': 'ĩ', 'ỵ': 'ị'}

var iToY = map[rune]rune{'i': 'y', 'í': 'ý', 'ì': 'ỳ', 'ỉ': 'ỷ', 'ĩ': 'ỹ', 'ị': 'ỵ'}

const singleYInitials = "hklmst"

var digraphInitials = []string{"ch", "gh", "kh", "nh", "ph", "th", "ngh"}

func normalizeVietnamese(text string) string {
	normalized := strings.Join(strings.Fields(strings.ToLower(norm.NFC.String(text))), " ")
	runes := []rune(normalized)
	runes = shiftTonePair(runes, 'o', 'a', oaToneShift, false)
	runes = shiftTonePair(runes, 'o', 'e', oeToneShift, false)
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

func syllableKey(syllable string) string {
	runes := []rune(normalizeVietnamese(syllable))
	if len(runes) == 2 && strings.ContainsRune(singleYInitials, runes[0]) {
		if vowel, ok := yToI[runes[1]]; ok {
			runes[1] = vowel
		}
	}
	if at := quVowelIndex(runes); at >= 0 {
		if vowel, ok := iToY[runes[at]]; ok {
			runes[at] = vowel
		}
	}
	return string(runes)
}

func wordKey(word string) string {
	parts := splitSyllables(normalizeVietnamese(word))
	for i, part := range parts {
		parts[i] = syllableKey(part)
	}
	return strings.Join(parts, " ")
}

func misspelledY(word string) bool {
	for _, syllable := range splitSyllables(word) {
		runes := []rune(syllable)
		if len(runes) < 3 {
			continue
		}
		if _, ok := yToI[runes[len(runes)-1]]; !ok {
			continue
		}
		if slices.Contains(digraphInitials, string(runes[:len(runes)-1])) {
			return true
		}
	}
	return false
}

func spellingVariants(word string) []string {
	variants := [][]string{splitSyllables(word)}
	for i, syllable := range splitSyllables(word) {
		alternate, ok := quAlternate(syllable)
		if !ok {
			continue
		}
		for _, parts := range variants {
			if len(variants) >= constants.WordChainSpellingVariantsMax {
				break
			}
			swapped := slices.Clone(parts)
			swapped[i] = alternate
			variants = append(variants, swapped)
		}
	}
	out := make([]string, len(variants))
	for i, parts := range variants {
		out[i] = strings.Join(parts, " ")
	}
	return out
}

func quAlternate(syllable string) (string, bool) {
	runes := []rune(syllable)
	at := quVowelIndex(runes)
	if at < 0 {
		return "", false
	}
	if vowel, ok := iToY[runes[at]]; ok {
		runes[at] = vowel
	} else {
		runes[at] = yToI[runes[at]]
	}
	return string(runes), true
}

func quVowelIndex(runes []rune) int {
	if len(runes) < 3 || len(runes) > 4 || runes[0] != 'q' || runes[1] != 'u' {
		return -1
	}
	if len(runes) == 4 && runes[3] != 't' {
		return -1
	}
	if _, ok := iToY[runes[2]]; ok {
		return 2
	}
	if _, ok := yToI[runes[2]]; ok {
		return 2
	}
	return -1
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
