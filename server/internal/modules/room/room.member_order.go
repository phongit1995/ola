package room

import (
	"sort"
	"unicode/utf8"
)

type rankedRoomMember struct {
	member   RoomMemberResponse
	vip      bool
	nameRank int
}

func roomMemberNameRank(username string) int {
	length := utf8.RuneCountInString(username)
	if length >= RoomMemberShortNameMinLen && length <= RoomMemberShortNameMaxLen {
		return length
	}
	return RoomMemberShortNameMaxLen + 1
}

func orderRoomMembers(ranked []rankedRoomMember) []RoomMemberResponse {
	sort.SliceStable(ranked, func(i, j int) bool {
		if ranked[i].vip != ranked[j].vip {
			return ranked[i].vip
		}
		return ranked[i].nameRank < ranked[j].nameRank
	})
	members := make([]RoomMemberResponse, len(ranked))
	for i, entry := range ranked {
		members[i] = entry.member
	}
	return members
}
