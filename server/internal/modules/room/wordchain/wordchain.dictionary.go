package wordchain

import (
	_ "embed"
	"encoding/json"
	"fmt"
	"math/rand/v2"
	"sort"
	"sync"
)

//go:embed assets/wordPairs.json
var embeddedWordPairs []byte

//go:embed assets/customWords.json
var embeddedCustomWords []byte

type Dictionary struct {
	mu    sync.RWMutex
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
	for _, source := range sources {
		d.mergePairs(source)
	}
	d.rebuildList()
	return d
}

func (d *Dictionary) mergePairs(source map[string][]string) {
	keys := make([]string, 0, len(source))
	for k := range source {
		keys = append(keys, k)
	}
	sort.Strings(keys)
	for _, k := range keys {
		nk := normalizeVietnamese(k)
		for _, v := range source[k] {
			nv := normalizeVietnamese(v)
			if !containsString(d.pairs[nk], nv) {
				d.pairs[nk] = append(d.pairs[nk], nv)
			}
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
		for _, second := range d.pairs[first] {
			d.list = append(d.list, first+" "+second)
		}
	}
}

func (d *Dictionary) Size() int {
	d.mu.RLock()
	defer d.mu.RUnlock()
	return len(d.list)
}

func (d *Dictionary) Continuations(start string, used map[string]struct{}) []string {
	d.mu.RLock()
	defer d.mu.RUnlock()
	var playable, repeating, deadEnds []string
	for _, second := range d.pairs[start] {
		word := start + " " + second
		if _, ok := used[word]; ok {
			continue
		}
		switch {
		case len(d.pairs[second]) == 0:
			deadEnds = append(deadEnds, word)
		case second == start:
			repeating = append(repeating, word)
		default:
			playable = append(playable, word)
		}
	}
	return append(append(playable, repeating...), deadEnds...)
}

func (d *Dictionary) uniqueWordLocked(start string) bool {
	possible := d.pairs[start]
	if len(possible) == 0 {
		return true
	}
	for _, word := range possible {
		if word == start {
			continue
		}
		if len(d.pairs[word]) > 0 {
			return false
		}
	}
	return true
}

func (d *Dictionary) NewWord() string {
	d.mu.RLock()
	defer d.mu.RUnlock()
	if len(d.list) == 0 {
		return ""
	}
	word := d.list[d.intN(len(d.list))]
	for attempt := 0; attempt < NewWordMaxAttempts && d.uniqueWordLocked(lastWord(word)); attempt++ {
		word = d.list[d.intN(len(d.list))]
	}
	return word
}

func (d *Dictionary) intN(n int) int {
	d.rngMu.Lock()
	defer d.rngMu.Unlock()
	return d.rng.IntN(n)
}

func containsString(items []string, target string) bool {
	for _, item := range items {
		if item == target {
			return true
		}
	}
	return false
}
