package utils

import (
	"github.com/gocql/gocql"
	"github.com/google/uuid"
)

func ToGocqlUUID(googleUUID uuid.UUID) (gocql.UUID, error) {
	return gocql.ParseUUID(googleUUID.String())
}

func ToGoogleUUID(gocqlUUID gocql.UUID) (uuid.UUID, error) {
	return uuid.Parse(gocqlUUID.String())
}
