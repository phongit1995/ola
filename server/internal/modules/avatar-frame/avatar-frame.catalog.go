package avatarframe

import (
	_ "embed"
	"encoding/json"
	"sync"
)

//go:embed assets/avatarFrames.json
var catalogJSON []byte

var catalogIDs = sync.OnceValue(func() map[string]bool {
	var entries []struct {
		ID string `json:"id"`
	}
	if err := json.Unmarshal(catalogJSON, &entries); err != nil {
		panic("avatar frame catalog: " + err.Error())
	}
	ids := make(map[string]bool, len(entries))
	for _, e := range entries {
		ids[e.ID] = true
	}
	return ids
})

func IsCatalogFrameID(id string) bool {
	return IsValidFrameID(id) && catalogIDs()[id]
}
