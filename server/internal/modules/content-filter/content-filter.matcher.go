package contentfilter

import (
	"strings"
	"unicode"
	"unicode/utf8"

	"golang.org/x/text/unicode/norm"
)

type phrase struct {
	word   string
	tokens []string
	joined string
}

func NormalizeContent(text string) string {
	var b strings.Builder
	for _, r := range norm.NFC.String(text) {
		if unicode.IsControl(r) && !unicode.IsSpace(r) {
			continue
		}
		b.WriteRune(r)
	}
	return strings.Join(strings.Fields(b.String()), " ")
}

func ContainsLink(text string) bool {
	return linkPattern.MatchString(norm.NFC.String(text))
}

func foldTokens(text string) []string {
	var b strings.Builder
	for _, r := range norm.NFD.String(strings.ToLower(text)) {
		if unicode.Is(unicode.Mn, r) {
			continue
		}
		if r == 'đ' {
			r = 'd'
		}
		if unicode.IsLetter(r) || unicode.IsDigit(r) {
			b.WriteRune(r)
			continue
		}
		b.WriteRune(' ')
	}
	return strings.Fields(b.String())
}

func mergeSingleLetters(tokens []string) []string {
	out := make([]string, 0, len(tokens))
	var run strings.Builder
	runLen := 0
	flush := func() {
		if runLen > 0 {
			out = append(out, run.String())
		}
		run.Reset()
		runLen = 0
	}
	for _, token := range tokens {
		if utf8.RuneCountInString(token) == 1 {
			run.WriteString(token)
			runLen++
			continue
		}
		flush()
		out = append(out, token)
	}
	flush()
	return out
}

func wholeWords(tokens, merged []string) map[string]bool {
	words := make(map[string]bool, len(tokens)*2)
	for _, token := range tokens {
		words[token] = true
	}
	for _, token := range merged {
		words[token] = true
	}
	for start := range tokens {
		var joined strings.Builder
		for end := start; end < len(tokens) && end-start < joinWindowMax; end++ {
			if utf8.RuneCountInString(tokens[end]) > joinPartMaxRunes {
				break
			}
			joined.WriteString(tokens[end])
			if end > start {
				words[joined.String()] = true
			}
		}
	}
	return words
}

func containsSequence(tokens, sequence []string) bool {
	if len(sequence) == 0 || len(sequence) > len(tokens) {
		return false
	}
	for i := 0; i+len(sequence) <= len(tokens); i++ {
		matched := true
		for j, word := range sequence {
			if tokens[i+j] != word {
				matched = false
				break
			}
		}
		if matched {
			return true
		}
	}
	return false
}

func compilePhrases(bannedWords []string) []phrase {
	phrases := make([]phrase, 0, len(bannedWords))
	for _, word := range bannedWords {
		tokens := foldTokens(word)
		if len(tokens) == 0 {
			continue
		}
		phrases = append(phrases, phrase{word: word, tokens: tokens, joined: strings.Join(tokens, "")})
	}
	return phrases
}

func matchPhrases(text string, phrases []phrase) (string, bool) {
	tokens := foldTokens(text)
	if len(tokens) == 0 {
		return "", false
	}
	merged := mergeSingleLetters(tokens)
	words := wholeWords(tokens, merged)
	for _, p := range phrases {
		if containsSequence(tokens, p.tokens) || containsSequence(merged, p.tokens) || words[p.joined] {
			return p.word, true
		}
	}
	return "", false
}

func MatchBannedWord(text string, bannedWords []string) (string, bool) {
	return matchPhrases(text, compilePhrases(bannedWords))
}
