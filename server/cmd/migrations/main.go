package main

import (
	"log"
	"os"
	"time"
)

func main() {
	time.Local = time.UTC

	cfg := LoadConfig()

	if cfg.MigrationAction == "seed" {
		log.Println("🌱 Starting Database Seeder...")
		if err := RunSeed(cfg); err != nil {
			log.Printf("❌ Seed failed: %v\n", err)
			os.Exit(1)
		}
		log.Println("🎉 Seed completed successfully!")
		return
	}

	log.Println("🚀 Starting Migration Service...")

	if cfg.MigrateDB == "" {
		cfg.MigrateDB = "all"
	}

	log.Printf("📋 Migration Config:")
	log.Printf("   Action: %s", cfg.MigrationAction)
	log.Printf("   Target: %s", cfg.MigrateDB)
	log.Printf("   Steps: %d", cfg.MigrationSteps)
	log.Println()

	var hasError bool

	switch cfg.MigrateDB {
	case "postgres":
		if err := RunPostgresMigration(cfg); err != nil {
			log.Printf("❌ PostgreSQL migration failed: %v\n", err)
			hasError = true
		}

	case "scylla":
		if err := RunScyllaMigration(cfg); err != nil {
			log.Printf("❌ ScyllaDB migration failed: %v\n", err)
			hasError = true
		}

	case "all":
		if err := RunPostgresMigration(cfg); err != nil {
			log.Printf("❌ PostgreSQL migration failed: %v\n", err)
			hasError = true
		}

		if err := RunScyllaMigration(cfg); err != nil {
			log.Printf("❌ ScyllaDB migration failed: %v\n", err)
			hasError = true
		}

	default:
		log.Printf("❌ Unknown database target: %s (use: postgres, scylla, or all)\n", cfg.MigrateDB)
		log.Printf("⚠️  Defaulting to 'all' - running all migrations\n")
		cfg.MigrateDB = "all"

		if err := RunPostgresMigration(cfg); err != nil {
			log.Printf("❌ PostgreSQL migration failed: %v\n", err)
			hasError = true
		}

		if err := RunScyllaMigration(cfg); err != nil {
			log.Printf("❌ ScyllaDB migration failed: %v\n", err)
			hasError = true
		}
	}

	if hasError {
		log.Println("❌ Migration completed with errors")
		os.Exit(1)
	}

	log.Println("🎉 All migrations completed successfully!")
}
