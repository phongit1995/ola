package room

import "testing"

func TestReportedObjectKeysMatchWhateverTheBucketIsCalled(t *testing.T) {
	keys := reportedObjectKeys([]string{
		"https://cdn.example.com/chat-uploads/rooms/2026-09-01/a.jpg",
		"http://localhost:9000/rooms/rooms/2026-09-02/b.webp?x=1",
		"https://old-domain.example.com/prefix/chat-uploads/rooms/2026-09-03/c.png",
		"::not a url",
	})
	for _, key := range []string{"rooms/2026-09-01/a.jpg", "rooms/2026-09-02/b.webp", "rooms/2026-09-03/c.png"} {
		if _, ok := keys[key]; !ok {
			t.Errorf("%s should be protected", key)
		}
	}
	if _, ok := keys["rooms/2026-09-01/other.jpg"]; ok {
		t.Error("an unreported image must not be protected")
	}
}

func TestIsRoomImageObject(t *testing.T) {
	images := []string{"rooms/d/a.jpg", "rooms/d/a.JPEG", "rooms/d/a.png", "rooms/d/a.gif", "rooms/d/a.webp"}
	for _, name := range images {
		if !isRoomImageObject(name) {
			t.Errorf("%s should count as an image", name)
		}
	}
	others := []string{"rooms/d/a.m4a", "rooms/d/a.webm", "rooms/d/a.mp3", "rooms/d/a"}
	for _, name := range others {
		if isRoomImageObject(name) {
			t.Errorf("%s should not count as an image", name)
		}
	}
}
