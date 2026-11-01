package tycoon

import (
	"errors"
	"math"
	"slices"
	"sort"
)

type RuleError struct {
	Code string
}

func (e *RuleError) Error() string { return ErrorPrefix + e.Code }

func ruleError(code string) error { return &RuleError{Code: code} }

func RuleCode(err error) string {
	var re *RuleError
	if errors.As(err, &re) {
		return re.Code
	}
	return ""
}

func (s *State) isActive(seat int) bool {
	return seat >= 0 && seat < len(s.Players) && !s.Players[seat].Bankrupt && !s.Players[seat].Quit
}

func (s *State) activeSeats() []int {
	seats := make([]int, 0, len(s.Players))
	for i := range s.Players {
		if s.isActive(i) {
			seats = append(seats, i)
		}
	}
	return seats
}

func (s *State) nextActive(from int) int {
	n := len(s.Players)
	for i := 1; i <= n; i++ {
		j := (from + i) % n
		if s.isActive(j) {
			return j
		}
	}
	return -1
}

func (s *State) push(step Step) {
	s.Steps = append(s.Steps, step)
}

func (s *State) ownsGroup(seat int, group string) bool {
	tiles := tilesOfGroup(group)
	if len(tiles) == 0 {
		return false
	}
	for _, idx := range tiles {
		if s.Tiles[idx].Owner != seat {
			return false
		}
	}
	return true
}

func (s *State) ownedCount(seat int, group string) int {
	count := 0
	for _, idx := range tilesOfGroup(group) {
		if s.Tiles[idx].Owner == seat {
			count++
		}
	}
	return count
}

func (s *State) houseValue(seat int) int {
	sum := 0
	for idx, t := range s.Tiles {
		if t.Owner == seat && t.Houses > 0 {
			sum += t.Houses * Board[idx].HouseCost
		}
	}
	return sum
}

func (s *State) Worth(seat int) int {
	if seat < 0 || seat >= len(s.Players) || s.Players[seat].Bankrupt {
		return 0
	}
	sum := s.Players[seat].Cash
	for idx, t := range s.Tiles {
		if t.Owner == seat {
			sum += Board[idx].Price + t.Houses*Board[idx].HouseCost
		}
	}
	return sum
}

func (s *State) liquidationValue(seat int) int {
	return s.houseValue(seat) / 2
}

func (s *State) computeRent(idx, owner int) int {
	tile := Board[idx]
	switch tile.Kind {
	case KindStreet:
		houses := s.Tiles[idx].Houses
		rent := tile.Rent[houses]
		base := rent
		if houses == 0 && tile.Group != "" && s.ownsGroup(owner, tile.Group) {
			base = rent * 2
		}
		if s.Festival == idx {
			return base * FestivalMultiplier
		}
		return base
	case KindStation:
		return StationRent[s.ownedCount(owner, GroupStation)]
	default:
		return 0
	}
}

func (s *State) canBuildError(seat, idx int) string {
	tile := Board[idx]
	t := s.Tiles[idx]
	if tile.Kind != KindStreet || tile.Group == "" {
		return ErrNotStreet
	}
	if t.Owner != seat {
		return ErrNotOwner
	}
	if !s.ownsGroup(seat, tile.Group) {
		return ErrNotGroupOwner
	}
	if t.Houses >= MaxHouses {
		return ErrMaxHouses
	}
	if s.Players[seat].Cash < tile.HouseCost {
		return ErrNoCash
	}
	for _, g := range tilesOfGroup(tile.Group) {
		if t.Houses > s.Tiles[g].Houses {
			return ErrBuildUneven
		}
	}
	return ""
}

func (s *State) canSellError(seat, idx int) string {
	tile := Board[idx]
	t := s.Tiles[idx]
	if tile.Kind != KindStreet || tile.Group == "" {
		return ErrNotStreet
	}
	if t.Owner != seat {
		return ErrNotOwner
	}
	if t.Houses <= 0 {
		return ErrNoHouses
	}
	for _, g := range tilesOfGroup(tile.Group) {
		if s.Tiles[g].Owner == seat && t.Houses < s.Tiles[g].Houses {
			return ErrSellUneven
		}
	}
	return ""
}

func (s *State) taxAmount(seat int) int {
	return int(math.Floor(float64(s.Worth(seat))*TaxRate + 0.5))
}

func (s *State) festivalPick(seat int) int {
	best := -1
	for idx, t := range s.Tiles {
		if t.Owner != seat || Board[idx].Kind != KindStreet {
			continue
		}
		if best < 0 || s.computeRent(idx, seat) > s.computeRent(best, seat) {
			best = idx
		}
	}
	return best
}

func (s *State) takeoverPrice(idx int) int {
	return TakeoverMultiplier * (Board[idx].Price + s.Tiles[idx].Houses*Board[idx].HouseCost)
}

func (s *State) canTakeoverError(seat, idx int) string {
	t := s.Tiles[idx]
	if Board[idx].Kind != KindStreet {
		return ErrNotStreet
	}
	if t.Owner < 0 || t.Owner == seat || !s.isActive(t.Owner) {
		return ErrNotTakeover
	}
	if t.Houses >= MaxHouses {
		return ErrTakeoverHotel
	}
	if s.Players[seat].Cash < s.takeoverPrice(idx) {
		return ErrNoCash
	}
	return ""
}

func (s *State) instantWin(seat int) string {
	groups := 0
	for _, g := range streetGroups {
		if s.ownsGroup(seat, g) {
			groups++
		}
	}
	if groups >= WinGroups {
		return EndGroups
	}
	for _, tiles := range sideStreets {
		if len(tiles) == 0 {
			continue
		}
		all := true
		for _, idx := range tiles {
			if s.Tiles[idx].Owner != seat {
				all = false
				break
			}
		}
		if all {
			return EndLine
		}
	}
	if s.ownsGroup(seat, GroupStation) {
		return EndAirports
	}
	return ""
}

func (s *State) checkInstantWin(seat int) bool {
	if s.Finished || !s.isActive(seat) {
		return false
	}
	reason := s.instantWin(seat)
	if reason == "" {
		return false
	}
	s.Winner = seat
	s.finish(reason)
	return true
}

func (s *State) rollDice() (int, int) {
	a := s.rngInt(6) + 1
	b := s.rngInt(6) + 1
	s.Dice = [2]int{a, b}
	return a, b
}

func (s *State) paySalary(seat int) {
	s.Players[seat].Cash += GoSalary
	s.push(Step{Kind: StepPay, By: -1, Target: intp(seat), Amount: intp(GoSalary), Reason: PaySalary})
}

func (s *State) leaveJail(seat int, how string) {
	p := &s.Players[seat]
	p.InJail = false
	p.JailTurns = 0
	s.push(Step{Kind: StepJailOut, By: seat, How: how})
}

func (s *State) sendToJail(seat int, how string) {
	p := &s.Players[seat]
	from := p.Pos
	p.Pos = JailTile
	p.InJail = true
	p.JailTurns = 0
	p.Doubles = 0
	p.Travel = false
	s.push(Step{Kind: StepTeleport, By: seat, From: intp(from), To: intp(JailTile)})
	s.push(Step{Kind: StepJailIn, By: seat, How: how})
}

func (s *State) pay(from, to, amount int, reason, after string) bool {
	if amount <= 0 {
		return true
	}
	p := &s.Players[from]
	if p.Cash >= amount {
		p.Cash -= amount
		if to >= 0 && s.isActive(to) {
			s.Players[to].Cash += amount
		}
		s.push(Step{Kind: StepPay, By: from, Target: intp(to), Amount: intp(amount), Reason: reason})
		return true
	}
	if p.Cash+s.liquidationValue(from) < amount {
		s.bankrupt(from, to)
		return false
	}
	s.enterDebt(Debt{Creditor: to, Amount: amount, By: from, ReturnTo: s.Turn, After: after, Reason: reason})
	return false
}

func (s *State) enterDebt(d Debt) {
	if s.Phase == PhaseDebt && s.Debt != nil {
		d.ReturnTo = s.Debt.ReturnTo
		s.PendingDebts = append(s.PendingDebts, d)
		return
	}
	s.Debt = &d
	s.Phase = PhaseDebt
	s.Turn = d.By
	s.push(Step{Kind: StepDebt, By: d.By, Creditor: intp(d.Creditor), Amount: intp(d.Amount), Reason: d.Reason})
}

func (s *State) resolveDebt() {
	d := *s.Debt
	s.Debt = nil
	for len(s.PendingDebts) > 0 {
		next := s.PendingDebts[0]
		s.PendingDebts = s.PendingDebts[1:]
		if !s.isActive(next.By) {
			continue
		}
		s.Debt = &next
		s.Phase = PhaseDebt
		s.Turn = next.By
		s.push(Step{Kind: StepDebt, By: next.By, Creditor: intp(next.Creditor), Amount: intp(next.Amount), Reason: next.Reason})
		return
	}
	s.PendingDebts = []Debt{}
	if !s.isActive(d.ReturnTo) {
		s.Turn = d.ReturnTo
		s.advanceTurn()
		return
	}
	s.Turn = d.ReturnTo
	s.Phase = PhaseManage
}

func (s *State) settleDebt(seat int) {
	d := *s.Debt
	s.Players[seat].Cash -= d.Amount
	if d.Creditor >= 0 && s.isActive(d.Creditor) {
		s.Players[d.Creditor].Cash += d.Amount
	}
	s.push(Step{Kind: StepPay, By: seat, Target: intp(d.Creditor), Amount: intp(d.Amount), Reason: d.Reason})
	s.resolveDebt()
	if d.After == debtAfterMove && s.Turn == seat && s.Phase == PhaseManage {
		s.leaveJail(seat, HowForced)
		s.movePlayer(seat, s.Dice[0]+s.Dice[1])
	}
}

func (s *State) autoSellForDebt(seat int) {
	amount := s.Debt.Amount
	for s.Players[seat].Cash < amount {
		best := -1
		for idx, t := range s.Tiles {
			if t.Owner != seat || t.Houses == 0 || s.canSellError(seat, idx) != "" {
				continue
			}
			if best < 0 || t.Houses > s.Tiles[best].Houses || (t.Houses == s.Tiles[best].Houses && Board[idx].HouseCost > Board[best].HouseCost) {
				best = idx
			}
		}
		if best < 0 {
			return
		}
		s.sellHouse(seat, best)
	}
}

func (s *State) build(seat, idx int) {
	cost := Board[idx].HouseCost
	s.Players[seat].Cash -= cost
	s.Tiles[idx].Houses++
	s.push(Step{Kind: StepPay, By: seat, Target: intp(-1), Amount: intp(cost), Reason: PayBuild, Tile: intp(idx)})
	s.push(Step{Kind: StepBuild, By: seat, Tile: intp(idx), Houses: intp(s.Tiles[idx].Houses)})
}

func (s *State) sellHouse(seat, idx int) {
	refund := Board[idx].HouseCost / 2
	s.Players[seat].Cash += refund
	s.Tiles[idx].Houses--
	s.push(Step{Kind: StepSell, By: seat, Tile: intp(idx), Houses: intp(s.Tiles[idx].Houses)})
	s.push(Step{Kind: StepPay, By: -1, Target: intp(seat), Amount: intp(refund), Reason: PaySell, Tile: intp(idx)})
}

func (s *State) pile(deck string) *[]int {
	if deck == DeckChance {
		return &s.ChanceDeck
	}
	return &s.ChestDeck
}

func (s *State) drawCard(seat int, deck string) {
	pile := s.pile(deck)
	if len(*pile) == 0 {
		return
	}
	id := (*pile)[0]
	*pile = append((*pile)[1:], id)
	card := deckCards(deck)[id]
	s.Card = &CardRef{Deck: deck, ID: card.ID}
	s.Phase = PhaseCard
	s.push(Step{Kind: StepCard, By: seat, Deck: deck, Card: card.ID})
}

func cardByRef(ref CardRef) (Card, bool) {
	idx := cardIndex(ref)
	if idx < 0 {
		return Card{}, false
	}
	return deckCards(ref.Deck)[idx], true
}

func (s *State) removeFromDeck(deck, cardID string) {
	cards := deckCards(deck)
	pile := s.pile(deck)
	at := slices.IndexFunc(*pile, func(id int) bool { return cards[id].ID == cardID })
	if at >= 0 {
		*pile = slices.Delete(*pile, at, at+1)
	}
}

func (s *State) returnToDeck(ref CardRef) {
	pile := s.pile(ref.Deck)
	id := cardIndex(ref)
	if id >= 0 && !slices.Contains(*pile, id) {
		*pile = append(*pile, id)
	}
}

func nearestTile(from int, kind string) int {
	for step := 1; step <= BoardSize; step++ {
		idx := (from + step) % BoardSize
		if Board[idx].Kind == kind {
			return idx
		}
	}
	return from
}

func (s *State) applyCard(seat int, card Card) {
	p := &s.Players[seat]
	switch card.Effect {
	case EffectMoveTo:
		s.teleport(seat, card.Tile, true, 1)
	case EffectMoveToNearest:
		s.teleport(seat, nearestTile(p.Pos, card.Kind), true, card.Amount)
	case EffectCash:
		if card.Amount >= 0 {
			p.Cash += card.Amount
			s.push(Step{Kind: StepPay, By: -1, Target: intp(seat), Amount: intp(card.Amount), Reason: PayCard})
		} else {
			s.pay(seat, -1, -card.Amount, PayCard, "")
		}
	case EffectJailCard:
		p.JailCards = append(p.JailCards, CardRef{Deck: card.Deck, ID: card.ID})
		s.removeFromDeck(card.Deck, card.ID)
	case EffectGoToJail:
		s.sendToJail(seat, HowCard)
	case EffectRepair:
		levels := 0
		for _, t := range s.Tiles {
			if t.Owner == seat {
				levels += t.Houses
			}
		}
		s.pay(seat, -1, levels*card.Amount, PayRepair, "")
	case EffectCollectEach:
		for _, other := range s.activeSeats() {
			if other != seat {
				s.pay(other, seat, card.Amount, PayBirthday, "")
			}
		}
	}
}

func (s *State) land(seat, rentMul int) {
	p := &s.Players[seat]
	tile := Board[p.Pos]
	s.push(Step{Kind: StepLand, By: seat, Tile: intp(p.Pos)})
	s.Phase = PhaseManage
	switch tile.Kind {
	case KindStreet, KindStation:
		owner := s.Tiles[p.Pos].Owner
		if owner < 0 {
			s.Phase = PhaseDecide
			return
		}
		if owner == seat || !s.isActive(owner) {
			return
		}
		rent := s.computeRent(p.Pos, owner)
		if tile.Kind == KindStation && rentMul > 1 {
			rent *= rentMul
		}
		if s.pay(seat, owner, rent, PayRent, "") && s.canTakeoverError(seat, p.Pos) == "" {
			s.Phase = PhaseTakeover
		}
	case KindTax:
		s.pay(seat, -1, s.taxAmount(seat), PayTax, "")
	case KindChance:
		s.drawCard(seat, DeckChance)
	case KindChest:
		s.drawCard(seat, DeckChest)
	case KindFestival:
		if s.festivalPick(seat) >= 0 {
			s.Phase = PhaseFestival
		}
	case KindTravel:
		p.Travel = true
		p.Doubles = 0
		s.push(Step{Kind: StepTravel, By: seat, Tile: intp(p.Pos)})
	}
}

func (s *State) movePlayer(seat, steps int) {
	p := &s.Players[seat]
	from := p.Pos
	to := (from + steps) % BoardSize
	passedGo := to < from
	p.Pos = to
	s.push(Step{Kind: StepMove, By: seat, From: intp(from), To: intp(to), PassedGo: boolp(passedGo)})
	if passedGo {
		s.paySalary(seat)
	}
	s.land(seat, 1)
}

func (s *State) teleport(seat, to int, passGo bool, rentMul int) {
	p := &s.Players[seat]
	from := p.Pos
	passed := passGo && to < from
	p.Pos = to
	s.push(Step{Kind: StepTeleport, By: seat, From: intp(from), To: intp(to), PassedGo: boolp(passed)})
	if passed {
		s.paySalary(seat)
	}
	s.land(seat, rentMul)
}

func (s *State) rollAndMove(seat int) {
	a, b := s.rollDice()
	double := a == b
	s.push(Step{Kind: StepRoll, By: seat, Dice: []int{a, b}, Double: boolp(double)})
	p := &s.Players[seat]
	if double {
		p.Doubles++
		if p.Doubles >= MaxDoubles {
			p.Doubles = 0
			s.sendToJail(seat, HowDice3)
			s.Phase = PhaseManage
			return
		}
	} else {
		p.Doubles = 0
	}
	s.movePlayer(seat, a+b)
}

func (s *State) jailRoll(seat int) {
	a, b := s.rollDice()
	double := a == b
	s.push(Step{Kind: StepRoll, By: seat, Dice: []int{a, b}, Double: boolp(double)})
	p := &s.Players[seat]
	p.Doubles = 0
	if double {
		s.leaveJail(seat, HowDouble)
		s.movePlayer(seat, a+b)
		return
	}
	p.JailTurns++
	if p.JailTurns < JailMaxTurns {
		s.Phase = PhaseManage
		return
	}
	if s.pay(seat, -1, JailFine, PayFine, debtAfterMove) {
		s.leaveJail(seat, HowForced)
		s.movePlayer(seat, a+b)
	}
}

func (s *State) bankrupt(seat, creditor int) {
	p := &s.Players[seat]
	tiles := []int{}
	for idx := range s.Tiles {
		t := &s.Tiles[idx]
		if t.Owner != seat {
			continue
		}
		if t.Houses > 0 {
			p.Cash += t.Houses * Board[idx].HouseCost / 2
			t.Houses = 0
		}
		tiles = append(tiles, idx)
	}
	toCreditor := creditor >= 0 && creditor != seat && s.isActive(creditor)
	newOwner := -1
	if toCreditor {
		newOwner = creditor
	}
	for _, idx := range tiles {
		s.Tiles[idx].Owner = newOwner
	}
	if !toCreditor && slices.Contains(tiles, s.Festival) {
		s.Festival = -1
	}
	if toCreditor {
		s.Players[creditor].Cash += p.Cash
	}
	for _, card := range p.JailCards {
		s.returnToDeck(card)
	}
	p.JailCards = []CardRef{}
	p.Cash = 0
	p.Bankrupt = true
	p.InJail = false
	p.Doubles = 0
	s.BankruptOrder = append(s.BankruptOrder, seat)
	s.push(Step{Kind: StepBankrupt, By: seat, Creditor: intp(newOwner), Tiles: tiles})
	pending := []Debt{}
	for _, d := range s.PendingDebts {
		if d.By != seat {
			pending = append(pending, d)
		}
	}
	s.PendingDebts = pending
	s.Card = nil
	if len(s.activeSeats()) <= 1 {
		s.finish(EndLast)
		return
	}
	if toCreditor && s.checkInstantWin(creditor) {
		return
	}
	if s.Phase == PhaseDebt && s.Debt != nil && s.Debt.By == seat {
		s.resolveDebt()
		return
	}
	if s.Turn == seat {
		s.advanceTurn()
	}
}

func (s *State) advanceTurn() {
	from := s.Turn
	next := s.nextActive(from)
	if next < 0 {
		s.finish(EndLast)
		return
	}
	s.Card = nil
	if next <= from {
		s.Round++
		s.push(Step{Kind: StepRound, By: -1, Round: intp(s.Round)})
		if s.Round > MaxRounds {
			s.finish(EndRounds)
			return
		}
	}
	s.Turn = next
	p := &s.Players[next]
	p.Doubles = 0
	switch {
	case p.InJail:
		s.Phase = PhaseJail
	case p.Travel:
		s.Phase = PhaseTravel
	default:
		s.Phase = PhaseRoll
	}
}

func (s *State) finish(reason string) {
	if s.Finished {
		return
	}
	s.Finished = true
	s.EndReason = &reason
	ranked := s.rankings()
	worth := make([]int, len(ranked))
	for i, seat := range ranked {
		worth[i] = s.Worth(seat)
	}
	s.push(Step{Kind: StepFinish, By: -1, Rankings: ranked, Worth: worth, End: reason})
}

func (s *State) rankings() []int {
	active := s.activeSeats()
	sort.SliceStable(active, func(i, j int) bool {
		a, b := active[i], active[j]
		if (a == s.Winner) != (b == s.Winner) {
			return a == s.Winner
		}
		if wa, wb := s.Worth(a), s.Worth(b); wa != wb {
			return wa > wb
		}
		return a < b
	})
	ranked := append([]int{}, active...)
	for i := len(s.BankruptOrder) - 1; i >= 0; i-- {
		ranked = append(ranked, s.BankruptOrder[i])
	}
	return ranked
}

func (s *State) isOver() bool {
	return s.Finished || len(s.activeSeats()) <= 1
}

func isNewTurn(prev, next *State) bool {
	return next.Turn != prev.Turn && (next.Phase == PhaseRoll || next.Phase == PhaseJail || next.Phase == PhaseTravel)
}

func applyMove(input *State, seat int, mv Move) (*State, error) {
	s := cloneState(input)
	if s.Finished {
		return nil, ruleError(ErrFinished)
	}
	if !s.isActive(seat) {
		return nil, ruleError(ErrNotActive)
	}
	if s.Turn != seat {
		return nil, ruleError(ErrNotYourTurn)
	}
	p := &s.Players[seat]
	needPhase := func(phases ...string) error {
		if !slices.Contains(phases, s.Phase) {
			return ruleError(ErrWrongPhase)
		}
		return nil
	}
	needTile := func() (int, error) {
		if mv.Tile == nil || *mv.Tile < 0 || *mv.Tile >= BoardSize {
			return 0, ruleError(ErrInvalidTile)
		}
		return *mv.Tile, nil
	}
	switch mv.Type {
	case MoveRoll:
		if err := needPhase(PhaseRoll, PhaseTravel); err != nil {
			return nil, err
		}
		p.Travel = false
		s.rollAndMove(seat)
	case MoveJailRoll:
		if err := needPhase(PhaseJail); err != nil {
			return nil, err
		}
		s.jailRoll(seat)
	case MoveJailPay:
		if err := needPhase(PhaseJail); err != nil {
			return nil, err
		}
		if p.Cash < JailFine {
			return nil, ruleError(ErrNoCash)
		}
		p.Cash -= JailFine
		s.push(Step{Kind: StepPay, By: seat, Target: intp(-1), Amount: intp(JailFine), Reason: PayFine})
		s.leaveJail(seat, HowPay)
		s.Phase = PhaseRoll
	case MoveJailCard:
		if err := needPhase(PhaseJail); err != nil {
			return nil, err
		}
		if len(p.JailCards) == 0 {
			return nil, ruleError(ErrNoJailCard)
		}
		card := p.JailCards[0]
		p.JailCards = append([]CardRef{}, p.JailCards[1:]...)
		s.returnToDeck(card)
		s.leaveJail(seat, HowCard)
		s.Phase = PhaseRoll
	case MoveBuy:
		if err := needPhase(PhaseDecide); err != nil {
			return nil, err
		}
		price := Board[p.Pos].Price
		if p.Cash < price {
			return nil, ruleError(ErrNoCash)
		}
		p.Cash -= price
		s.Tiles[p.Pos].Owner = seat
		s.push(Step{Kind: StepPay, By: seat, Target: intp(-1), Amount: intp(price), Reason: PayBuy, Tile: intp(p.Pos)})
		s.push(Step{Kind: StepBuy, By: seat, Tile: intp(p.Pos)})
		s.Phase = PhaseManage
		s.checkInstantWin(seat)
	case MoveTakeover:
		if err := needPhase(PhaseTakeover); err != nil {
			return nil, err
		}
		idx := p.Pos
		if code := s.canTakeoverError(seat, idx); code != "" {
			return nil, ruleError(code)
		}
		owner := s.Tiles[idx].Owner
		price := s.takeoverPrice(idx)
		p.Cash -= price
		s.Players[owner].Cash += price
		s.Tiles[idx].Owner = seat
		s.push(Step{Kind: StepPay, By: seat, Target: intp(owner), Amount: intp(price), Reason: PayTakeover, Tile: intp(idx)})
		s.push(Step{Kind: StepTakeover, By: seat, Tile: intp(idx), Target: intp(owner), Houses: intp(s.Tiles[idx].Houses)})
		s.Phase = PhaseManage
		s.checkInstantWin(seat)
	case MoveFestival:
		if err := needPhase(PhaseFestival); err != nil {
			return nil, err
		}
		idx, err := needTile()
		if err != nil {
			return nil, err
		}
		if Board[idx].Kind != KindStreet {
			return nil, ruleError(ErrNotStreet)
		}
		if s.Tiles[idx].Owner != seat {
			return nil, ruleError(ErrNotOwner)
		}
		s.Festival = idx
		s.push(Step{Kind: StepFestival, By: seat, Tile: intp(idx)})
		s.Phase = PhaseManage
	case MoveTravel:
		if err := needPhase(PhaseTravel); err != nil {
			return nil, err
		}
		idx, err := needTile()
		if err != nil {
			return nil, err
		}
		if idx == p.Pos {
			return nil, ruleError(ErrInvalidTile)
		}
		p.Travel = false
		s.teleport(seat, idx, true, 1)
	case MoveDecline:
		if err := needPhase(PhaseDecide, PhaseTakeover, PhaseFestival); err != nil {
			return nil, err
		}
		s.Phase = PhaseManage
	case MoveCardAck:
		if err := needPhase(PhaseCard); err != nil {
			return nil, err
		}
		if s.Card == nil {
			return nil, ruleError(ErrWrongPhase)
		}
		ref := *s.Card
		s.Card = nil
		s.Phase = PhaseManage
		if card, ok := cardByRef(ref); ok {
			s.applyCard(seat, card)
		}
	case MoveBuild:
		if err := needPhase(PhaseManage); err != nil {
			return nil, err
		}
		idx, err := needTile()
		if err != nil {
			return nil, err
		}
		if code := s.canBuildError(seat, idx); code != "" {
			return nil, ruleError(code)
		}
		s.build(seat, idx)
	case MoveSellHouse:
		if err := needPhase(PhaseManage, PhaseDebt); err != nil {
			return nil, err
		}
		idx, err := needTile()
		if err != nil {
			return nil, err
		}
		if code := s.canSellError(seat, idx); code != "" {
			return nil, ruleError(code)
		}
		s.sellHouse(seat, idx)
	case MovePayDebt:
		if err := needPhase(PhaseDebt); err != nil {
			return nil, err
		}
		if s.Debt == nil {
			return nil, ruleError(ErrWrongPhase)
		}
		if p.Cash < s.Debt.Amount {
			return nil, ruleError(ErrNoCash)
		}
		s.settleDebt(seat)
	case MoveSettleDebt:
		if err := needPhase(PhaseDebt); err != nil {
			return nil, err
		}
		if s.Debt == nil {
			return nil, ruleError(ErrWrongPhase)
		}
		s.autoSellForDebt(seat)
		if p.Cash >= s.Debt.Amount {
			s.settleDebt(seat)
		} else {
			s.bankrupt(seat, s.Debt.Creditor)
		}
	case MoveDeclareBankrupt:
		if err := needPhase(PhaseDebt); err != nil {
			return nil, err
		}
		if s.Debt == nil {
			return nil, ruleError(ErrWrongPhase)
		}
		s.bankrupt(seat, s.Debt.Creditor)
	case MoveEndTurn:
		if err := needPhase(PhaseManage); err != nil {
			return nil, err
		}
		if p.Doubles > 0 && !p.InJail {
			s.Phase = PhaseRoll
		} else {
			p.Doubles = 0
			s.advanceTurn()
		}
	default:
		return nil, ruleError(ErrUnknownMove)
	}
	s.MoveCount++
	return s, nil
}

func moveOnTimeout(s *State, seat int) (Move, bool) {
	if s.Finished || !s.isActive(seat) || s.Turn != seat {
		return Move{}, false
	}
	switch s.Phase {
	case PhaseRoll, PhaseTravel:
		return Move{Type: MoveRoll}, true
	case PhaseJail:
		return Move{Type: MoveJailRoll}, true
	case PhaseFestival:
		return Move{Type: MoveFestival, Tile: intp(s.festivalPick(seat))}, true
	case PhaseDecide, PhaseTakeover:
		return Move{Type: MoveDecline}, true
	case PhaseCard:
		return Move{Type: MoveCardAck}, true
	case PhaseManage:
		return Move{Type: MoveEndTurn}, true
	case PhaseDebt:
		return Move{Type: MoveSettleDebt}, true
	}
	return Move{}, false
}

func quitPlayer(s *State, seat int) {
	if s.Finished || !s.isActive(seat) {
		return
	}
	s.Players[seat].Quit = true
	s.bankrupt(seat, -1)
}
