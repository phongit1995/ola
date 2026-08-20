package thirteen

const (
	DeckSize = 52
	HandSize = 13

	RankThree = 0
	RankTwo   = 12

	SuitSpade   = 0
	SuitClub    = 1
	SuitDiamond = 2
	SuitHeart   = 3

	ThreeOfSpades = 0
)

func rankOf(card int) int { return card / 4 }

func suitOf(card int) int { return card % 4 }

func validCard(card int) bool { return card >= 0 && card < DeckSize }
