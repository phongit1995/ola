package seed

import (
	"database/sql"
	"fmt"
	"log"
	"time"
)

type vipDemo struct {
	username string
	icons    []int16
	locked   map[int16]bool
	active   int16
	days     int
}

var vipDemos = []vipDemo{
	{"test1", []int16{4, 7, 40, 116}, map[int16]bool{116: true}, 4, 30},
	{"test2", []int16{51, 95, 100}, nil, 51, 60},
	{"test3", []int16{1, 2, 3}, nil, 0, 7},
	{"test4", []int16{86, 87, 88, 89, 90}, map[int16]bool{86: true}, 87, 90},
	{"test5", []int16{120}, nil, 120, 15},
}

func SeedVipStore(db *sql.DB) error {
	log.Printf("🌱 Seeding VIP store for %d demo users...\n", len(vipDemos))

	seeded := 0
	for _, d := range vipDemos {
		var userID string
		err := db.QueryRow(
			`SELECT id FROM users WHERE username = $1 AND deleted_at IS NULL LIMIT 1`,
			d.username,
		).Scan(&userID)
		if err == sql.ErrNoRows {
			log.Printf("   ⏭️  %s not found, skipping", d.username)
			continue
		}
		if err != nil {
			return fmt.Errorf("failed to lookup %s: %w", d.username, err)
		}

		tx, err := db.Begin()
		if err != nil {
			return fmt.Errorf("failed to start transaction: %w", err)
		}

		if _, err := tx.Exec(`DELETE FROM user_vip_icons WHERE user_id = $1`, userID); err != nil {
			tx.Rollback()
			return fmt.Errorf("failed to clear vip icons for %s: %w", d.username, err)
		}

		for _, typeID := range d.icons {
			if _, err := tx.Exec(
				`INSERT INTO user_vip_icons (user_id, vip_icon_id, is_locked, source, acquired_at)
				 VALUES ($1, $2, $3, 'admin', NOW())`,
				userID, typeID, d.locked[typeID],
			); err != nil {
				tx.Rollback()
				return fmt.Errorf("failed to insert vip icon %d for %s: %w", typeID, d.username, err)
			}
		}

		var vipUsed interface{}
		if d.active > 0 {
			vipUsed = fmt.Sprintf("%d", d.active)
		}
		endTime := time.Now().AddDate(0, 0, d.days)
		if _, err := tx.Exec(
			`UPDATE users SET vip_used = $1, vip_end_time = $2, vip_store_privacy = 0 WHERE id = $3`,
			vipUsed, endTime, userID,
		); err != nil {
			tx.Rollback()
			return fmt.Errorf("failed to update vip state for %s: %w", d.username, err)
		}

		if err := tx.Commit(); err != nil {
			return fmt.Errorf("failed to commit vip seed for %s: %w", d.username, err)
		}
		seeded++
	}

	log.Printf("✅ Seeded VIP store for %d users", seeded)
	return nil
}
