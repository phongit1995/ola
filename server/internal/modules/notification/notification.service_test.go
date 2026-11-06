package notification

import (
	"encoding/json"
	"testing"

	"ola-chat-server/internal/models"

	"github.com/google/uuid"
)

func notificationWith(ntype, preview string) *models.AppNotification {
	return &models.AppNotification{
		BaseModel: models.BaseModel{ID: uuid.New()},
		Type:      ntype,
		Preview:   preview,
	}
}

func TestToAppNotificationResponseTransfer(t *testing.T) {
	cases := []struct {
		name     string
		ntype    string
		transfer models.AppNotificationTransfer
		preview  string
	}{
		{"ken amount", models.AppNotificationKenReceived, models.AppNotificationTransfer{Amount: 1250000}, "Đã chuyển cho bạn 1,250,000 Ken"},
		{"vip days", models.AppNotificationVipReceived, models.AppNotificationTransfer{Days: 30}, "Đã tặng bạn 30 ngày VIP"},
		{"vip icon", models.AppNotificationVipReceived, models.AppNotificationTransfer{VipTypeID: 4}, "Đã tặng bạn VIP"},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			resp := toAppNotificationResponse(notificationWith(tc.ntype, tc.transfer.Preview()))
			if resp.Preview != tc.preview {
				t.Fatalf("preview = %q, want %q", resp.Preview, tc.preview)
			}
			if resp.Transfer == nil || *resp.Transfer != tc.transfer {
				t.Fatalf("transfer = %+v, want %+v", resp.Transfer, tc.transfer)
			}
		})
	}
}

func TestToAppNotificationResponseKeepsOtherPreviews(t *testing.T) {
	raw := `{"amount":1000}`
	resp := toAppNotificationResponse(notificationWith(models.AppNotificationContentViolation, raw))
	if resp.Preview != raw || resp.Transfer != nil {
		t.Fatalf("other types must stay untouched: %+v", resp)
	}

	body, err := json.Marshal(toAppNotificationResponse(notificationWith(models.AppNotificationFriendRequest, "")))
	if err != nil {
		t.Fatal(err)
	}
	var decoded map[string]interface{}
	if err := json.Unmarshal(body, &decoded); err != nil {
		t.Fatal(err)
	}
	if _, ok := decoded["transfer"]; ok {
		t.Fatalf("transfer must be omitted: %s", body)
	}
}
