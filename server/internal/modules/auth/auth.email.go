package auth

import (
	"errors"
	"fmt"
	"regexp"
	"strings"
)

const (
	emailDomainGmail    = "gmail.com"
	emailSubaddressMark = "+"
)

var (
	errEmailFormatNotAllowed = errors.New("email address format not allowed")
	gmailLocalPattern        = regexp.MustCompile(`^[a-z0-9](?:\.?[a-z0-9])*$`)
)

// Gmail, iCloud and Yahoo usernames never contain "+", so "user+tag@" is always a subaddress of another inbox.
func isAllowedEmailLocal(email string) bool {
	at := strings.LastIndex(email, "@")
	if at <= 0 {
		return false
	}
	local, domain := email[:at], email[at+1:]
	if strings.Contains(local, emailSubaddressMark) {
		return false
	}
	return domain != emailDomainGmail || gmailLocalPattern.MatchString(local)
}

// Gmail ignores dots and everything after "+", so "a.b+x@gmail.com" lands in the same inbox as "ab@gmail.com".
// The key also folds addresses saved before isAllowedEmailLocal existed.
func emailInboxKeySQL(value string) string {
	local := fmt.Sprintf("split_part(split_part(lower(%[1]s), '@', 1), '%[2]s', 1)", value, emailSubaddressMark)
	domain := fmt.Sprintf("split_part(lower(%s), '@', 2)", value)
	return fmt.Sprintf("(CASE WHEN %[2]s = '%[3]s' THEN replace(%[1]s, '.', '') ELSE %[1]s END || '@' || %[2]s)",
		local, domain, emailDomainGmail)
}
