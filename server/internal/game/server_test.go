package game

import "testing"

func TestSocketPlayerCarriesVipType(t *testing.T) {
	vipType := "vip-42"
	data := &SocketData{
		UserID:  "user-id",
		GameID:  "caro",
		Name:    "player",
		VipType: &vipType,
		Level:   7,
	}

	player := socketPlayer(data)
	if player.ID != data.UserID || player.Name != data.Name {
		t.Fatalf("unexpected socket player: %+v", player)
	}
	if player.VipType == nil || *player.VipType != vipType {
		t.Fatalf("socket player lost VIP type: %+v", player)
	}
	if player.Level != data.Level {
		t.Fatalf("socket player lost level: %+v", player)
	}
}
