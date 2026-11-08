package utils

import (
	"fmt"
	"net/http"
	"slices"
	"strings"

	"github.com/google/uuid"
	"gorm.io/gorm"
	"gorm.io/gorm/clause"
)

const orderedListLockPrefix = "ordered_list:"

var ErrListOrderStale = NewHTTPError(http.StatusConflict, "list has changed")

type ReorderRequest struct {
	IDs []uuid.UUID `json:"ids" binding:"required,min=1"`
}

type OrderedList struct {
	Model    interface{}
	Table    string
	Column   string
	OrderSQL string
}

func SameIDs(current, wanted []uuid.UUID) bool {
	if len(current) != len(wanted) {
		return false
	}
	remaining := make(map[uuid.UUID]struct{}, len(current))
	for _, id := range current {
		remaining[id] = struct{}{}
	}
	for _, id := range wanted {
		if _, found := remaining[id]; !found {
			return false
		}
		delete(remaining, id)
	}
	return len(remaining) == 0
}

func insertAtPosition(others, placed []uuid.UUID, position int) ([]uuid.UUID, int) {
	index := len(others)
	if position > 0 && position <= len(others) {
		index = position - 1
	}
	return slices.Insert(slices.Clone(others), index, placed...), index + 1
}

func (l OrderedList) lockIDs(tx *gorm.DB) ([]uuid.UUID, error) {
	if err := tx.Exec("SELECT pg_advisory_xact_lock(hashtextextended(?::text, 0))", orderedListLockPrefix+l.Table).Error; err != nil {
		return nil, err
	}
	var ids []uuid.UUID
	err := tx.Model(l.Model).Clauses(clause.Locking{Strength: "UPDATE"}).Order(l.OrderSQL).Pluck("id", &ids).Error
	return ids, err
}

func (l OrderedList) assign(tx *gorm.DB, ids []uuid.UUID) error {
	if len(ids) == 0 {
		return nil
	}
	rows := make([]string, len(ids))
	args := make([]interface{}, 0, len(ids)*2)
	for index, id := range ids {
		rows[index] = "(?::uuid, ?::int)"
		args = append(args, id, index+1)
	}
	query := fmt.Sprintf(
		`UPDATE "%[1]s" AS t SET "%[2]s" = v.position FROM (VALUES %[3]s) AS v(id, position) WHERE t.id = v.id AND t."%[2]s" IS DISTINCT FROM v.position`,
		l.Table, l.Column, strings.Join(rows, ","),
	)
	return tx.Exec(query, args...).Error
}

func (l OrderedList) Reorder(db *gorm.DB, ids []uuid.UUID) error {
	return db.Transaction(func(tx *gorm.DB) error {
		current, err := l.lockIDs(tx)
		if err != nil {
			return err
		}
		if !SameIDs(current, ids) {
			return ErrListOrderStale
		}
		return l.assign(tx, ids)
	})
}

func (l OrderedList) Place(db *gorm.DB, position int, save func(tx *gorm.DB) ([]uuid.UUID, error)) (int, error) {
	first := 0
	err := db.Transaction(func(tx *gorm.DB) error {
		current, err := l.lockIDs(tx)
		if err != nil {
			return err
		}
		placed, err := save(tx)
		if err != nil {
			return err
		}
		others := slices.DeleteFunc(current, func(id uuid.UUID) bool {
			return slices.Contains(placed, id)
		})
		ordered, start := insertAtPosition(others, placed, position)
		first = start
		return l.assign(tx, ordered)
	})
	return first, err
}

func (l OrderedList) PlaceOne(db *gorm.DB, position int, id *uuid.UUID, save func(tx *gorm.DB) error) (int, error) {
	return l.Place(db, position, func(tx *gorm.DB) ([]uuid.UUID, error) {
		if err := save(tx); err != nil {
			return nil, err
		}
		return []uuid.UUID{*id}, nil
	})
}
