// Command tycoongen exports the server-authoritative Tycoon parity fixtures.
package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"

	"ola-chat-server/internal/game/games/tycoon"
)

func main() {
	parityPath := flag.String("parity", "", "output path for the JSON parity fixture")
	stressPath := flag.String("stress", "", "output path for a large fixture with the state after every turn")
	games := flag.Int("games", 200, "number of games in the stress fixture")
	flag.Parse()
	if *parityPath == "" && *stressPath == "" {
		fmt.Fprintln(os.Stderr, "-parity or -stress is required")
		os.Exit(2)
	}
	if *parityPath != "" {
		if err := writeFixture(*parityPath, tycoon.ExportParityFixture()); err != nil {
			fmt.Fprintln(os.Stderr, err)
			os.Exit(1)
		}
	}
	if *stressPath != "" {
		if err := writeFixture(*stressPath, tycoon.ExportStressFixture(*games)); err != nil {
			fmt.Fprintln(os.Stderr, err)
			os.Exit(1)
		}
	}
}

func writeFixture(path string, fixture tycoon.ParityFixture) error {
	data, err := tycoon.EncodeParityFixture(fixture)
	if err != nil {
		return fmt.Errorf("encode %s: %w", path, err)
	}
	if err := os.MkdirAll(filepath.Dir(path), 0o755); err != nil {
		return fmt.Errorf("create output directory: %w", err)
	}
	if err := os.WriteFile(path, data, 0o644); err != nil {
		return fmt.Errorf("write %s: %w", path, err)
	}
	return nil
}
