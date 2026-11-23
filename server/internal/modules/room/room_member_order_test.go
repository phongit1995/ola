package room

import (
	"reflect"
	"testing"
)

func TestRoomMemberNameRank(t *testing.T) {
	cases := map[string]int{"ab": 2, "abc": 3, "abcd": 4, "abcde": 5, "abcdef": 6, "a": 6, "john_doe_99": 6}
	for name, want := range cases {
		if got := roomMemberNameRank(name); got != want {
			t.Errorf("roomMemberNameRank(%q) = %d, want %d", name, got, want)
		}
	}
}

func TestOrderRoomMembersPutsVipThenShortNamesFirst(t *testing.T) {
	joined := []struct {
		username string
		vip      bool
	}{
		{"normal_one", false},
		{"five5", true},
		{"tri", false},
		{"normal_vip", true},
		{"ab", true},
		{"vip", true},
		{"cd", false},
		{"one", true},
	}
	ranked := make([]rankedRoomMember, 0, len(joined))
	for _, entry := range joined {
		ranked = append(ranked, rankedRoomMember{
			member:   RoomMemberResponse{Username: entry.username},
			vip:      entry.vip,
			nameRank: roomMemberNameRank(entry.username),
		})
	}

	got := make([]string, 0, len(joined))
	for _, member := range orderRoomMembers(ranked) {
		got = append(got, member.Username)
	}
	want := []string{"ab", "vip", "one", "five5", "normal_vip", "cd", "tri", "normal_one"}
	if !reflect.DeepEqual(got, want) {
		t.Fatalf("order = %v, want %v", got, want)
	}
}
