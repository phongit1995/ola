package tycoon

import "time"

const (
	GameID             = "tycoon"
	StateVersion       = 1
	TurnSeconds        = 30
	MinPlayers         = 2
	MaxPlayers         = 4
	BoardSize          = 32
	SideTiles          = BoardSize / 4
	StartCash          = 1500
	GoSalary           = 160
	JailFine           = 50
	JailTile           = 8
	MaxHouses          = 3
	MaxRounds          = 30
	TimeLimit          = 25 * time.Minute
	TakeoverMultiplier = 2
	WinGroups          = 3
	MaxDoubles         = 3
	JailMaxTurns       = 3
	BirthdayGift       = 10
	FestivalMultiplier = 2
	TaxRate            = 0.1
	ErrorPrefix        = "tycoon:"
)

var StationRent = [...]int{0, 25, 50, 100, 200}

const (
	PhaseRoll     = "roll"
	PhaseJail     = "jail"
	PhaseDecide   = "decide"
	PhaseTakeover = "takeover"
	PhaseFestival = "festival"
	PhaseTravel   = "travel"
	PhaseCard     = "card"
	PhaseManage   = "manage"
	PhaseDebt     = "debt"
)

var Phases = []string{PhaseRoll, PhaseJail, PhaseDecide, PhaseTakeover, PhaseFestival, PhaseTravel, PhaseCard, PhaseManage, PhaseDebt}

const (
	MoveRoll            = "ROLL"
	MoveJailPay         = "JAIL_PAY"
	MoveJailCard        = "JAIL_CARD"
	MoveJailRoll        = "JAIL_ROLL"
	MoveBuy             = "BUY"
	MoveDecline         = "DECLINE"
	MoveCardAck         = "CARD_ACK"
	MoveBuild           = "BUILD"
	MoveSellHouse       = "SELL_HOUSE"
	MovePayDebt         = "PAY_DEBT"
	MoveSettleDebt      = "SETTLE_DEBT"
	MoveDeclareBankrupt = "DECLARE_BANKRUPT"
	MoveTakeover        = "TAKEOVER"
	MoveFestival        = "FESTIVAL"
	MoveTravel          = "TRAVEL"
	MoveEndTurn         = "END_TURN"
)

var MoveTypes = []string{
	MoveRoll, MoveJailPay, MoveJailCard, MoveJailRoll, MoveBuy, MoveDecline, MoveCardAck, MoveBuild,
	MoveSellHouse, MovePayDebt, MoveSettleDebt, MoveDeclareBankrupt, MoveTakeover, MoveFestival, MoveTravel, MoveEndTurn,
}

const (
	StepRoll     = "roll"
	StepMove     = "move"
	StepTeleport = "teleport"
	StepLand     = "land"
	StepPay      = "pay"
	StepBuy      = "buy"
	StepCard     = "card"
	StepJailIn   = "jail-in"
	StepJailOut  = "jail-out"
	StepBuild    = "build"
	StepSell     = "sell"
	StepDebt     = "debt"
	StepBankrupt = "bankrupt"
	StepTakeover = "takeover"
	StepFestival = "festival"
	StepTravel   = "travel"
	StepRound    = "round"
	StepFinish   = "finish"
)

var StepKinds = []string{
	StepRoll, StepMove, StepTeleport, StepLand, StepPay, StepBuy, StepCard, StepJailIn, StepJailOut,
	StepBuild, StepSell, StepDebt, StepBankrupt, StepTakeover, StepFestival, StepTravel, StepRound, StepFinish,
}

const (
	KindGo       = "go"
	KindStreet   = "street"
	KindStation  = "station"
	KindChance   = "chance"
	KindChest    = "chest"
	KindTax      = "tax"
	KindJail     = "jail"
	KindFestival = "festival"
	KindTravel   = "travel"
)

const (
	GroupBrown   = "brown"
	GroupSky     = "sky"
	GroupPink    = "pink"
	GroupOrange  = "orange"
	GroupRed     = "red"
	GroupYellow  = "yellow"
	GroupGreen   = "green"
	GroupBlue    = "blue"
	GroupStation = "station"
)

const (
	PayRent     = "rent"
	PayTax      = "tax"
	PayCard     = "card"
	PayFine     = "fine"
	PayRepair   = "repair"
	PayBirthday = "birthday"
	PayBuy      = "buy"
	PayBuild    = "build"
	PaySell     = "sell"
	PaySalary   = "salary"
	PayTakeover = "takeover"
)

const (
	EndLast     = "last"
	EndRounds   = "rounds"
	EndTime     = "time"
	EndGroups   = "groups"
	EndLine     = "line"
	EndAirports = "airports"
)

var EndReasons = []string{EndLast, EndRounds, EndTime, EndGroups, EndLine, EndAirports}

const (
	ExitBankrupt = "bankrupt"
	ExitForfeit  = "forfeit"
)

const (
	DeckChance = "chance"
	DeckChest  = "chest"
)

const (
	EffectMoveTo        = "moveTo"
	EffectMoveToNearest = "moveToNearest"
	EffectCash          = "cash"
	EffectJailCard      = "jailCard"
	EffectGoToJail      = "goToJail"
	EffectRepair        = "repair"
	EffectCollectEach   = "collectEach"
)

const (
	HowDice3  = "dice3"
	HowCard   = "card"
	HowPay    = "pay"
	HowDouble = "double"
	HowForced = "forced"
)

const debtAfterMove = "move"

const (
	ErrFinished      = "finished"
	ErrNotActive     = "not_active"
	ErrNotYourTurn   = "not_your_turn"
	ErrWrongPhase    = "wrong_phase"
	ErrInvalidTile   = "invalid_tile"
	ErrInvalidMove   = "invalid_move"
	ErrUnknownMove   = "unknown_move"
	ErrNoCash        = "no_cash"
	ErrNoJailCard    = "no_jail_card"
	ErrNotStreet     = "not_street"
	ErrNotOwner      = "not_owner"
	ErrNotHere       = "not_here"
	ErrJustBought    = "just_bought"
	ErrMaxHouses     = "max_houses"
	ErrNoHouses      = "no_houses"
	ErrNotTakeover   = "not_takeover"
	ErrTakeoverHotel = "takeover_hotel"
)

const (
	firstTurnDelay    = 1500 * time.Millisecond
	turnAnnounceDelay = 1200 * time.Millisecond
	maxStartDelay     = 8 * time.Second
	rollDelay         = 940 * time.Millisecond
	hopDelay          = 140 * time.Millisecond
	hopFastDelay      = 110 * time.Millisecond
	hopFastAfter      = 9
	teleportDelay     = 420 * time.Millisecond
	landDelay         = 220 * time.Millisecond
	payDelay          = 520 * time.Millisecond
	cardDelay         = 420 * time.Millisecond
	jailInDelay       = 700 * time.Millisecond
	jailOutDelay      = 200 * time.Millisecond
	buildDelay        = 260 * time.Millisecond
	debtDelay         = 300 * time.Millisecond
	bankruptDelay     = 900 * time.Millisecond
	roundDelay        = 240 * time.Millisecond
)
