package progression

const (
	ExpWin     = 50
	ExpDraw    = 25
	ExpLoss    = 15
	ExpMoveCap = 40
	MaxLevel   = 99
	ReasonVoid = "void"
)

func ExpBaseForLevel(level int) int64 {
	if level <= 1 {
		return 0
	}
	if level > MaxLevel {
		level = MaxLevel
	}
	return int64(50 * level * (level - 1))
}

func ExpToNext(level int) int64 {
	if level < 1 || level >= MaxLevel {
		return 0
	}
	return int64(100 * level)
}

func LevelFromExp(exp int64) int {
	if exp < 0 {
		return 1
	}
	level := 1
	for level < MaxLevel && exp >= ExpBaseForLevel(level+1) {
		level++
	}
	return level
}

func MoveBonus(moveCount int) int {
	if moveCount < 0 {
		return 0
	}
	if moveCount > ExpMoveCap {
		moveCount = ExpMoveCap
	}
	return moveCount / 2
}

func MatchExp(winnerID, reason, playerID string, moveCount int) int {
	if reason == ReasonVoid {
		return 0
	}
	base := ExpLoss
	if winnerID == "" {
		base = ExpDraw
	} else if playerID == winnerID {
		base = ExpWin
	}
	return base + MoveBonus(moveCount)
}
