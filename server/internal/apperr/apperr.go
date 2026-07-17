package apperr

import (
	"errors"
	"strings"

	"github.com/jackc/pgx/v5/pgconn"
)

var ErrUserNotFound = errors.New("user not found")

const pgUniqueViolationCode = "23505"

func IsUniqueViolation(err error) bool {
	var pgErr *pgconn.PgError
	if errors.As(err, &pgErr) {
		return pgErr.Code == pgUniqueViolationCode
	}
	return err != nil && strings.Contains(err.Error(), "duplicate key value")
}

func IsDatabaseError(err error) bool {
	if err == nil {
		return false
	}
	var pgErr *pgconn.PgError
	if errors.As(err, &pgErr) {
		return true
	}
	msg := err.Error()
	return strings.Contains(msg, "SQLSTATE") || strings.Contains(msg, "duplicate key value")
}
