package contentfilter

import "regexp"

const (
	ReasonLink       = "link"
	ReasonBannedWord = "banned_word"

	joinPartMaxRunes = 3
	joinWindowMax    = 3
)

var linkPattern = regexp.MustCompile(`(?i)(https?://|www\.|[a-z0-9-]+\.(com|net|org|vn|info|xyz|io|link|top|site|online|club|biz|app|shop|store|live|fun|vip|pro|asia)\b|[a-z0-9-]+\.(me|co|ly|gl|gg|cc|tv|to|us|uk|ru|cn)/)`)
