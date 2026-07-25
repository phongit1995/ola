package game

import "testing"

func TestSocketPlayerCarriesVipType(t *testing.T) {
	vipType := "vip-42"
	data := &SocketData{
		UserID:  "user-id",
		GameID:  "caro",
		Name:    "player",
		VipType: &vipType,
	}

	player := socketPlayer(data)
	if player.ID != data.UserID || player.Name != data.Name {
		t.Fatalf("unexpected socket player: %+v", player)
	}
	if player.VipType == nil || *player.VipType != vipType {
		t.Fatalf("socket player lost VIP type: %+v", player)
	}
	guest := socketPlayer(&SocketData{UserID: "guest-id", GameID: "caro", Name: "guest", Guest: true})
	if guest.VipType != nil {
		t.Fatalf("guest unexpectedly received VIP type: %+v", guest)
	}
}

func TestGuestIdentityCannotCollideWithRegisteredUUID(t *testing.T) {
	const victimUUID = "11111111-1111-1111-1111-111111111111"
	suffix, userID, ok := guestIdentity("guest:" + victimUUID)
	if !ok || suffix != victimUUID {
		t.Fatalf("guest token was not accepted: suffix=%q ok=%v", suffix, ok)
	}
	if userID == victimUUID || userID != "guest:"+victimUUID {
		t.Fatalf("guest identity %q can collide with registered user %q", userID, victimUUID)
	}
}
