package seed

import (
	"database/sql"
	"fmt"
	"log"
	"time"
)

type roomSeed struct {
	Name        string
	Description string
	Slug        string
	MaxMembers  int
}

var rooms = []roomSeed{
	{"General Chat", "Phòng chat chung cho mọi người", "general", 0},
	{"Technology", "Thảo luận về công nghệ, lập trình, AI", "technology", 200},
	{"Gaming", "Nơi game thủ giao lưu và tìm đồng đội", "gaming", 200},
	{"Music Lovers", "Chia sẻ những bản nhạc bạn yêu thích", "music", 150},
	{"Movies & TV", "Bàn luận phim ảnh và series mới nhất", "movies", 150},
	{"Sports Zone", "Cập nhật và bình luận thể thao", "sports", 150},
	{"Travel & Adventure", "Kể về những chuyến đi đáng nhớ", "travel", 100},
	{"Food & Cooking", "Công thức nấu ăn và review quán xá", "food", 100},
	{"Books & Reading", "Cộng đồng yêu sách và đọc", "books", 100},
	{"Random Talk", "Tám chuyện không giới hạn chủ đề", "random", 0},
}

func SeedRooms(db *sql.DB) error {
	log.Printf("🌱 Seeding %d rooms...\n", len(rooms))

	var adminID string
	err := db.QueryRow(
		`SELECT id FROM admin_users WHERE LOWER(username) = 'admin' AND deleted_at IS NULL LIMIT 1`,
	).Scan(&adminID)
	if err == sql.ErrNoRows {
		return fmt.Errorf("admin user not found, run migrations first")
	}
	if err != nil {
		return fmt.Errorf("failed to lookup admin user: %w", err)
	}

	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("failed to start transaction: %w", err)
	}

	successCount := 0
	skipCount := 0

	for _, r := range rooms {
		imageURL := fmt.Sprintf("https://picsum.photos/seed/%s/400/300", r.Slug)
		query := `
			INSERT INTO rooms (name, description, image_url, max_members, enabled, created_by, created_at, updated_at)
			SELECT $1::varchar, $2::text, $3::varchar, $4::int, TRUE, $5::uuid, $6::timestamp, $6::timestamp
			WHERE NOT EXISTS (
				SELECT 1 FROM rooms WHERE name = $1::varchar AND deleted_at IS NULL
			)
		`
		result, err := tx.Exec(query, r.Name, r.Description, imageURL, r.MaxMembers, adminID, time.Now())
		if err != nil {
			tx.Rollback()
			return fmt.Errorf("failed to insert room %q: %w", r.Name, err)
		}
		if rows, _ := result.RowsAffected(); rows > 0 {
			successCount++
		} else {
			skipCount++
		}
	}

	if err := tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %w", err)
	}

	log.Printf("✅ Created: %d rooms", successCount)
	if skipCount > 0 {
		log.Printf("⏭️  Skipped: %d rooms (already exist)", skipCount)
	}

	return nil
}
