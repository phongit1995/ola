package avatarframe

import (
	"bytes"
	"os"
	"testing"
)

const sharedCatalogPath = "../../../../packages/shared/src/lib/avatarFrames.json"

func TestCatalogMatchesShared(t *testing.T) {
	shared, err := os.ReadFile(sharedCatalogPath)
	if err != nil {
		t.Skipf("shared catalog not found: %v", err)
	}
	if !bytes.Equal(shared, catalogJSON) {
		t.Fatalf("server/internal/modules/avatar-frame/assets/avatarFrames.json differs from packages/shared/src/lib/avatarFrames.json, copy the shared file over it")
	}
}

func TestIsCatalogFrameID(t *testing.T) {
	if !IsCatalogFrameID("001") || !IsCatalogFrameID("759") {
		t.Fatal("first and last catalog frames must be valid")
	}
	if IsCatalogFrameID("024") || IsCatalogFrameID("999") || IsCatalogFrameID("abc") || IsCatalogFrameID("") {
		t.Fatal("unknown frame ids must be rejected")
	}
}
