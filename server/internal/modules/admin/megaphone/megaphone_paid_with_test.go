package adminmegaphone

import (
	"testing"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func TestPaidWithOf(t *testing.T) {
	ticketID := uuid.New()
	cases := []struct {
		name string
		item models.Megaphone
		want string
	}{
		{"paid ken", models.Megaphone{KenPrice: 5000}, PaidWithKen},
		{"ticket", models.Megaphone{TicketID: &ticketID}, PaidWithTicket},
		{"free price", models.Megaphone{}, PaidWithFree},
		{"gift megaphone", models.Megaphone{Type: models.MegaphoneTypeGift}, PaidWithFree},
	}
	for _, c := range cases {
		if got := paidWithOf(&c.item); got != c.want {
			t.Errorf("%s: got %s, want %s", c.name, got, c.want)
		}
	}
}
