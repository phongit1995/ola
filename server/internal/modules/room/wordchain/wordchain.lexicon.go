package wordchain

import (
	"bytes"
	"cmp"
	_ "embed"
	"encoding/json"
	"fmt"
	"slices"
	"strings"
	"unicode"
	"unicode/utf8"

	"github.com/andybalholm/brotli"
	"golang.org/x/text/unicode/norm"
)

//go:embed assets/viDictionary.json.br
var embeddedViDictionary []byte

var lexiconQuiSpellings = [][2]string{
	{"qui", "quy"}, {"quì", "quỳ"}, {"quí", "quý"}, {"quỉ", "quỷ"}, {"quĩ", "quỹ"}, {"quị", "quỵ"},
}

var lexiconToneSpellings = [][2]string{
	{"ùy", "uỳ"}, {"úy", "uý"}, {"ủy", "uỷ"}, {"ũy", "uỹ"}, {"ụy", "uỵ"},
	{"òa", "oà"}, {"óa", "oá"}, {"ỏa", "oả"}, {"õa", "oã"}, {"ọa", "oạ"},
	{"òe", "oè"}, {"óe", "oé"}, {"ỏe", "oẻ"}, {"õe", "oẽ"}, {"ọe", "oẹ"},
}

const (
	lexiconTonedOAndU   = "ùúủũụòóỏõọ"
	lexiconYBoundaryPun = ".,!?"
)

type lexiconEntry struct {
	Word         string            `json:"word"`
	Meanings     []DictMeaning     `json:"meanings"`
	Translations []DictTranslation `json:"translations"`
	Relations    []DictRelation    `json:"relations"`
}

type Lexicon struct {
	entries map[string]*lexiconEntry
	words   []string
}

func NewLexicon() (*Lexicon, error) {
	var entries []lexiconEntry
	if err := json.NewDecoder(brotli.NewReader(bytes.NewReader(embeddedViDictionary))).Decode(&entries); err != nil {
		return nil, fmt.Errorf("failed to parse word chain lexicon: %w", err)
	}
	return newLexicon(entries), nil
}

func newLexicon(entries []lexiconEntry) *Lexicon {
	l := &Lexicon{entries: make(map[string]*lexiconEntry, len(entries)), words: make([]string, 0, len(entries))}
	for i := range entries {
		entry := &entries[i]
		if _, dup := l.entries[entry.Word]; dup {
			continue
		}
		l.entries[entry.Word] = entry
		l.words = append(l.words, entry.Word)
	}
	slices.Sort(l.words)
	return l
}

func (l *Lexicon) Lookup(word string) *DictLookup {
	normalized := lexiconNormalize(word)
	entry, ok := l.entries[normalized]
	if !ok {
		entry, ok = l.entries[word]
	}
	if !ok {
		return &DictLookup{Exists: false, Word: normalized}
	}
	return &DictLookup{
		Exists: true,
		Word:   entry.Word,
		Results: []DictResult{{
			LangCode:     WordChainLookupLangVietnamese,
			LangName:     WordChainLookupLangVietnameseName,
			Meanings:     orEmpty(entry.Meanings),
			Translations: orEmpty(entry.Translations),
			Relations:    orEmpty(entry.Relations),
		}},
	}
}

func (l *Lexicon) Suggest(prefix string, limit int) []string {
	normalized := lexiconNormalize(prefix)
	if normalized == "" || limit <= 0 {
		return []string{}
	}
	start, _ := slices.BinarySearch(l.words, normalized)
	var matches []string
	for i := start; i < len(l.words) && strings.HasPrefix(l.words[i], normalized); i++ {
		matches = append(matches, l.words[i])
	}
	slices.SortStableFunc(matches, func(a, b string) int {
		return cmp.Compare(utf8.RuneCountInString(a), utf8.RuneCountInString(b))
	})
	if len(matches) > limit {
		matches = matches[:limit]
	}
	return matches
}

func orEmpty[T any](items []T) []T {
	if items == nil {
		return []T{}
	}
	return items
}

func lexiconNormalize(text string) string {
	result := lexiconFinalYToI(strings.ToLower(norm.NFC.String(text)))
	if strings.Contains(result, "qui") {
		for _, pair := range lexiconQuiSpellings {
			result = strings.ReplaceAll(result, pair[0], pair[1])
		}
	}
	if strings.ContainsAny(result, lexiconTonedOAndU) {
		for _, pair := range lexiconToneSpellings {
			result = strings.ReplaceAll(result, pair[0], pair[1])
		}
	}
	return result
}

func lexiconFinalYToI(text string) string {
	runes := []rune(text)
	for i := 1; i < len(runes); i++ {
		vowel, ok := yToI[runes[i]]
		if !ok || !strings.ContainsRune(singleYInitials, runes[i-1]) {
			continue
		}
		if i >= 2 && runes[i-2] == 'u' {
			continue
		}
		if i+1 < len(runes) && !unicode.IsSpace(runes[i+1]) && !strings.ContainsRune(lexiconYBoundaryPun, runes[i+1]) {
			continue
		}
		runes[i] = vowel
	}
	return string(runes)
}
