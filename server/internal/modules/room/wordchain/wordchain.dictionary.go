package wordchain

import (
	_ "embed"
	"encoding/json"
	"fmt"
	"math/rand/v2"
	"ola-chat-server/internal/constants"
	"sort"
	"sync"
)

//go:embed assets/wordPairs.json
var embeddedWordPairs []byte

//go:embed assets/customWords.json
var embeddedCustomWords []byte

type Dictionary struct {
	pairs map[string][]string
	list  []string
	rngMu sync.Mutex
	rng   *rand.Rand
}

func NewDictionary() (*Dictionary, error) {
	sources := make([]map[string][]string, 0, 2)
	for _, raw := range [][]byte{embeddedWordPairs, embeddedCustomWords} {
		var source map[string][]string
		if err := json.Unmarshal(raw, &source); err != nil {
			return nil, fmt.Errorf("failed to parse word chain dictionary: %w", err)
		}
		sources = append(sources, source)
	}
	return newDictionaryFromSources(rand.New(rand.NewPCG(rand.Uint64(), rand.Uint64())), sources...), nil
}

func newDictionaryFromSources(rng *rand.Rand, sources ...map[string][]string) *Dictionary {
	d := &Dictionary{pairs: map[string][]string{}, rng: rng}
	seen := map[string]struct{}{}
	for _, source := range sources {
		d.mergePairs(source, seen)
	}
	d.rebuildList()
	return d
}

func (d *Dictionary) mergePairs(source map[string][]string, seen map[string]struct{}) {
	keys := make([]string, 0, len(source))
	for k := range source {
		keys = append(keys, k)
	}
	sort.Strings(keys)
	for _, k := range keys {
		first := normalizeVietnamese(k)
		key := syllableKey(first)
		for _, v := range source[k] {
			word := first + " " + normalizeVietnamese(v)
			if _, ok := seen[word]; ok {
				continue
			}
			seen[word] = struct{}{}
			d.pairs[key] = append(d.pairs[key], word)
		}
	}
}

func (d *Dictionary) rebuildList() {
	keys := make([]string, 0, len(d.pairs))
	for k := range d.pairs {
		keys = append(keys, k)
	}
	sort.Strings(keys)
	d.list = d.list[:0]
	for _, first := range keys {
		d.list = append(d.list, d.pairs[first]...)
	}
}

func (d *Dictionary) Continuations(start string, used map[string]struct{}) []string {
	var playable, repeating, deadEnds []string
	key := syllableKey(start)
	for _, word := range d.pairs[key] {
		if _, ok := used[wordKey(word)]; ok {
			continue
		}
		next := syllableKey(lastWord(word))
		switch {
		case len(d.pairs[next]) == 0:
			deadEnds = append(deadEnds, word)
		case next == key:
			repeating = append(repeating, word)
		default:
			playable = append(playable, word)
		}
	}
	return append(append(playable, repeating...), deadEnds...)
}

func (d *Dictionary) uniqueWord(start string) bool {
	key := syllableKey(start)
	for _, word := range d.pairs[key] {
		next := syllableKey(lastWord(word))
		if next != key && len(d.pairs[next]) > 0 {
			return false
		}
	}
	return true
}

func (d *Dictionary) NewWord() string {
	if len(d.list) == 0 {
		return ""
	}
	word := d.list[d.intN(len(d.list))]
	for attempt := 0; attempt < constants.WordChainNewWordMaxAttempts && d.uniqueWord(lastWord(word)); attempt++ {
		word = d.list[d.intN(len(d.list))]
	}
	return word
}

func (d *Dictionary) intN(n int) int {
	d.rngMu.Lock()
	defer d.rngMu.Unlock()
	return d.rng.IntN(n)
}
