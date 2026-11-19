package megaphone

import (
	"testing"
	"time"

	"ola-chat-server/internal/models"
)

func TestTicketExpiresAt(t *testing.T) {
	now := time.Date(2026, 11, 20, 10, 0, 0, 0, time.UTC)
	if got := TicketExpiresAt(now, 0); got != nil {
		t.Fatalf("0 days should mean no expiry, got %v", got)
	}
	if got := TicketExpiresAt(now, -3); got != nil {
		t.Fatalf("negative days should mean no expiry, got %v", got)
	}
	got := TicketExpiresAt(now, 7)
	if got == nil || !got.Equal(now.Add(7*24*time.Hour)) {
		t.Fatalf("7 days: got %v", got)
	}
}

func TestTicketStatus(t *testing.T) {
	now := time.Date(2026, 11, 20, 10, 0, 0, 0, time.UTC)
	past := now.Add(-time.Minute)
	future := now.Add(time.Hour)
	cases := []struct {
		name   string
		ticket models.UserMegaphoneTicket
		want   string
	}{
		{"no expiry", models.UserMegaphoneTicket{}, models.MegaphoneTicketStatusUsable},
		{"future expiry", models.UserMegaphoneTicket{ExpiresAt: &future}, models.MegaphoneTicketStatusUsable},
		{"expired", models.UserMegaphoneTicket{ExpiresAt: &past}, models.MegaphoneTicketStatusExpired},
		{"expires exactly now", models.UserMegaphoneTicket{ExpiresAt: &now}, models.MegaphoneTicketStatusExpired},
		{"used beats expired", models.UserMegaphoneTicket{ExpiresAt: &past, UsedAt: &past}, models.MegaphoneTicketStatusUsed},
		{"revoked", models.UserMegaphoneTicket{RevokedAt: &past}, models.MegaphoneTicketStatusRevoked},
		{"revoked beats expired", models.UserMegaphoneTicket{ExpiresAt: &past, RevokedAt: &past}, models.MegaphoneTicketStatusRevoked},
	}
	for _, c := range cases {
		if got := c.ticket.Status(now); got != c.want {
			t.Errorf("%s: got %s, want %s", c.name, got, c.want)
		}
	}
}
