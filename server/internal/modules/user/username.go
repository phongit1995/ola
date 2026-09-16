package user

import "regexp"

var usernameRegex = regexp.MustCompile(`^[a-z][a-z0-9]*$`)

const UsernameFormatMessage = "username may only contain lowercase letters and numbers, and must start with a letter"

func IsValidUsernameFormat(username string) bool {
	return usernameRegex.MatchString(username)
}
