package tycoon

type Tile struct {
	Idx       int    `json:"idx"`
	Name      string `json:"name"`
	Kind      string `json:"kind"`
	Group     string `json:"group,omitempty"`
	Price     int    `json:"price,omitempty"`
	Rent      []int  `json:"rent,omitempty"`
	HouseCost int    `json:"houseCost,omitempty"`
}

type Card struct {
	ID     string `json:"id"`
	Deck   string `json:"deck"`
	Text   string `json:"text"`
	Effect string `json:"effect"`
	Tile   int    `json:"tile,omitempty"`
	Kind   string `json:"kind,omitempty"`
	Amount int    `json:"amount,omitempty"`
}

var Board = []Tile{
	{Idx: 0, Name: "Xuất phát", Kind: KindGo},
	{Idx: 1, Name: "Thanh Hóa", Kind: KindStreet, Group: GroupBrown, Price: 60, Rent: []int{6, 40, 145, 320}, HouseCost: 50},
	{Idx: 2, Name: "Khí vận", Kind: KindChest},
	{Idx: 3, Name: "Vinh", Kind: KindStreet, Group: GroupBrown, Price: 80, Rent: []int{8, 45, 160, 340}, HouseCost: 50},
	{Idx: 4, Name: "Cơ hội", Kind: KindChance},
	{Idx: 5, Name: "Buôn Ma Thuột", Kind: KindStreet, Group: GroupSky, Price: 100, Rent: []int{10, 50, 180, 380}, HouseCost: 50},
	{Idx: 6, Name: "Sân bay", Kind: KindStation, Group: GroupStation, Price: 200},
	{Idx: 7, Name: "Đà Lạt", Kind: KindStreet, Group: GroupSky, Price: 120, Rent: []int{12, 60, 200, 400}, HouseCost: 50},
	{Idx: 8, Name: "Nhà tù", Kind: KindJail},
	{Idx: 9, Name: "Cần Thơ", Kind: KindStreet, Group: GroupPink, Price: 140, Rent: []int{14, 85, 310, 660}, HouseCost: 100},
	{Idx: 10, Name: "Sân bay", Kind: KindStation, Group: GroupStation, Price: 200},
	{Idx: 11, Name: "Phú Quốc", Kind: KindStreet, Group: GroupPink, Price: 160, Rent: []int{16, 90, 320, 690}, HouseCost: 100},
	{Idx: 12, Name: "Thuế thu nhập", Kind: KindTax},
	{Idx: 13, Name: "Quy Nhơn", Kind: KindStreet, Group: GroupOrange, Price: 180, Rent: []int{18, 100, 340, 720}, HouseCost: 100},
	{Idx: 14, Name: "Khí vận", Kind: KindChest},
	{Idx: 15, Name: "Nha Trang", Kind: KindStreet, Group: GroupOrange, Price: 200, Rent: []int{20, 105, 360, 750}, HouseCost: 100},
	{Idx: 16, Name: "Lễ hội", Kind: KindFestival},
	{Idx: 17, Name: "Hội An", Kind: KindStreet, Group: GroupRed, Price: 220, Rent: []int{22, 130, 470, 1000}, HouseCost: 150},
	{Idx: 18, Name: "Cơ hội", Kind: KindChance},
	{Idx: 19, Name: "Huế", Kind: KindStreet, Group: GroupRed, Price: 240, Rent: []int{24, 135, 490, 1040}, HouseCost: 150},
	{Idx: 20, Name: "Cơ hội", Kind: KindChance},
	{Idx: 21, Name: "Hạ Long", Kind: KindStreet, Group: GroupYellow, Price: 260, Rent: []int{26, 145, 500, 1060}, HouseCost: 150},
	{Idx: 22, Name: "Sân bay", Kind: KindStation, Group: GroupStation, Price: 200},
	{Idx: 23, Name: "Hải Phòng", Kind: KindStreet, Group: GroupYellow, Price: 280, Rent: []int{28, 150, 520, 1100}, HouseCost: 150},
	{Idx: 24, Name: "Du lịch", Kind: KindTravel},
	{Idx: 25, Name: "Vũng Tàu", Kind: KindStreet, Group: GroupGreen, Price: 300, Rent: []int{30, 175, 630, 1350}, HouseCost: 200},
	{Idx: 26, Name: "Sân bay", Kind: KindStation, Group: GroupStation, Price: 200},
	{Idx: 27, Name: "Đà Nẵng", Kind: KindStreet, Group: GroupGreen, Price: 320, Rent: []int{32, 180, 650, 1380}, HouseCost: 200},
	{Idx: 28, Name: "Khí vận", Kind: KindChest},
	{Idx: 29, Name: "Cơ hội", Kind: KindChance},
	{Idx: 30, Name: "Hà Nội", Kind: KindStreet, Group: GroupBlue, Price: 350, Rent: []int{35, 190, 680, 1420}, HouseCost: 200},
	{Idx: 31, Name: "TP. Hồ Chí Minh", Kind: KindStreet, Group: GroupBlue, Price: 400, Rent: []int{40, 210, 720, 1500}, HouseCost: 200},
}

var Cards = []Card{
	{ID: "ch01", Deck: DeckChance, Text: "Tiến đến Xuất phát. Nhận 160 tr.", Effect: EffectMoveTo, Tile: 0},
	{ID: "ch02", Deck: DeckChance, Text: "Đi đến TP. Hồ Chí Minh. Qua Xuất phát nhận 160 tr.", Effect: EffectMoveTo, Tile: 31},
	{ID: "ch03", Deck: DeckChance, Text: "Đi đến Huế. Qua Xuất phát nhận 160 tr.", Effect: EffectMoveTo, Tile: 19},
	{ID: "ch04", Deck: DeckChance, Text: "Đi đến Cần Thơ. Qua Xuất phát nhận 160 tr.", Effect: EffectMoveTo, Tile: 9},
	{ID: "ch05", Deck: DeckChance, Text: "Đi đến sân bay gần nhất. Nếu có chủ, trả gấp đôi tiền thuê.", Effect: EffectMoveToNearest, Kind: KindStation, Amount: 2},
	{ID: "ch06", Deck: DeckChance, Text: "Đi dự Lễ hội. Qua Xuất phát nhận 160 tr.", Effect: EffectMoveTo, Tile: 16},
	{ID: "ch07", Deck: DeckChance, Text: "Ngân hàng trả cổ tức 50 tr.", Effect: EffectCash, Amount: 50},
	{ID: "ch08", Deck: DeckChance, Text: "Thẻ ra tù miễn phí. Giữ đến khi dùng.", Effect: EffectJailCard},
	{ID: "ch09", Deck: DeckChance, Text: "Vào tù. Đi thẳng, không qua Xuất phát.", Effect: EffectGoToJail},
	{ID: "ch10", Deck: DeckChance, Text: "Bảo trì nhà cửa: 25 tr cho mỗi cấp nhà bạn đang có.", Effect: EffectRepair, Amount: 25},
	{ID: "ch11", Deck: DeckChance, Text: "Phạt vượt tốc độ 15 tr.", Effect: EffectCash, Amount: -15},
	{ID: "ch12", Deck: DeckChance, Text: "Bạn trúng giải xổ số 150 tr.", Effect: EffectCash, Amount: 150},
	{ID: "cm01", Deck: DeckChest, Text: "Tiến đến Xuất phát. Nhận 160 tr.", Effect: EffectMoveTo, Tile: 0},
	{ID: "cm02", Deck: DeckChest, Text: "Ngân hàng tính nhầm, bạn nhận 200 tr.", Effect: EffectCash, Amount: 200},
	{ID: "cm03", Deck: DeckChest, Text: "Viện phí 100 tr.", Effect: EffectCash, Amount: -100},
	{ID: "cm04", Deck: DeckChest, Text: "Hoàn thuế 20 tr.", Effect: EffectCash, Amount: 20},
	{ID: "cm05", Deck: DeckChest, Text: "Thẻ ra tù miễn phí. Giữ đến khi dùng.", Effect: EffectJailCard},
	{ID: "cm06", Deck: DeckChest, Text: "Vào tù. Đi thẳng, không qua Xuất phát.", Effect: EffectGoToJail},
	{ID: "cm07", Deck: DeckChest, Text: "Sinh nhật bạn! Mỗi người chơi mừng 10 tr.", Effect: EffectCollectEach, Amount: BirthdayGift},
	{ID: "cm08", Deck: DeckChest, Text: "Hoàn tiền bảo hiểm 100 tr.", Effect: EffectCash, Amount: 100},
	{ID: "cm09", Deck: DeckChest, Text: "Học phí 50 tr.", Effect: EffectCash, Amount: -50},
	{ID: "cm10", Deck: DeckChest, Text: "Nhận thừa kế 100 tr.", Effect: EffectCash, Amount: 100},
	{ID: "cm11", Deck: DeckChest, Text: "Bán hàng được 50 tr.", Effect: EffectCash, Amount: 50},
	{ID: "cm12", Deck: DeckChest, Text: "Sửa đường: 40 tr cho mỗi cấp nhà bạn đang có.", Effect: EffectRepair, Amount: 40},
}

var (
	chanceCards  = cardsOf(DeckChance)
	chestCards   = cardsOf(DeckChest)
	groupTiles   = buildGroupTiles()
	streetGroups = buildStreetGroups()
	sideStreets  = buildSideStreets()
)

func cardsOf(deck string) []Card {
	out := make([]Card, 0, len(Cards))
	for _, card := range Cards {
		if card.Deck == deck {
			out = append(out, card)
		}
	}
	return out
}

func deckCards(deck string) []Card {
	if deck == DeckChance {
		return chanceCards
	}
	return chestCards
}

func buildGroupTiles() map[string][]int {
	groups := map[string][]int{}
	for _, tile := range Board {
		if tile.Group != "" {
			groups[tile.Group] = append(groups[tile.Group], tile.Idx)
		}
	}
	return groups
}

func buildStreetGroups() []string {
	seen := map[string]bool{}
	var groups []string
	for _, tile := range Board {
		if tile.Kind == KindStreet && !seen[tile.Group] {
			seen[tile.Group] = true
			groups = append(groups, tile.Group)
		}
	}
	return groups
}

func buildSideStreets() [4][]int {
	var sides [4][]int
	for _, tile := range Board {
		if tile.Kind == KindStreet {
			side := tile.Idx / SideTiles
			sides[side] = append(sides[side], tile.Idx)
		}
	}
	return sides
}

func tilesOfGroup(group string) []int {
	return groupTiles[group]
}
