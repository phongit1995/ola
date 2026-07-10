package utils

import "strings"

var likeEscaper = strings.NewReplacer("\\", "\\\\", "%", "\\%", "_", "\\_")

func LikeContains(q string) string {
	return "%" + likeEscaper.Replace(q) + "%"
}
