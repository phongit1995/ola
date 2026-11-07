package tycoon

import (
	"encoding/json"
	"errors"
	"time"

	"ola-chat-server/internal/game/logic"
)

var now = time.Now

type Logic struct{}

func init() {
	logic.Register(Logic{})
}

func (Logic) ID() string { return GameID }

func (Logic) StateVersion() int { return StateVersion }

func (Logic) Init(seed int64) any { return startState(seed, MinPlayers) }

func (Logic) InitPlayers(seed int64, playerCount int) any { return startState(seed, playerCount) }

func startState(seed int64, playerCount int) *State {
	s := newState(seed, playerCount)
	s.StartedAt = now().UnixMilli()
	return s
}

func (Logic) MinPlayers() int { return MinPlayers }

func (Logic) MaxPlayers() int { return MaxPlayers }

func (Logic) TurnSeconds() int { return TurnSeconds }

func (Logic) DecodeState(data json.RawMessage) (any, error) {
	return decodeState(data)
}

func (Logic) ValidateMove(state any, playerIdx int, move json.RawMessage) error {
	_, err := apply(state, playerIdx, move)
	return err
}

func (Logic) Apply(state any, playerIdx int, move json.RawMessage) (any, error) {
	next, err := apply(state, playerIdx, move)
	if err != nil {
		return state, err
	}
	return next, nil
}

func apply(state any, playerIdx int, raw json.RawMessage) (*State, error) {
	s, ok := state.(*State)
	if !ok {
		return nil, errors.New("invalid state")
	}
	mv, err := parseMove(raw)
	if err != nil {
		return nil, err
	}
	next, err := applyMove(s, playerIdx, mv)
	if err != nil {
		return nil, err
	}
	if !next.Finished && isNewTurn(s, next) && timeUp(next) {
		next.finish(EndTime)
	}
	return next, nil
}

func timeUp(s *State) bool {
	return s.StartedAt > 0 && now().UnixMilli()-s.StartedAt >= TimeLimit.Milliseconds()
}

func (Logic) Result(state any) (bool, int) {
	s, ok := state.(*State)
	if !ok || !s.isOver() {
		return false, -1
	}
	ranked := s.rankings()
	if len(ranked) == 0 {
		return true, -1
	}
	return true, ranked[0]
}

func (Logic) NextTurn(state any, currentIdx int) int {
	s, ok := state.(*State)
	if !ok {
		return -1
	}
	return s.Turn
}

func (Logic) MoveOnTimeout(state any, playerIdx int) (json.RawMessage, bool) {
	s, ok := state.(*State)
	if !ok {
		return nil, false
	}
	mv, ok := moveOnTimeout(s, playerIdx)
	if !ok {
		return nil, false
	}
	raw, err := json.Marshal(mv)
	if err != nil {
		return nil, false
	}
	return raw, true
}

func (Logic) OnPlayerQuit(state any, playerIdx int) {
	s, ok := state.(*State)
	if !ok {
		return
	}
	s.Steps = []Step{}
	quitPlayer(s, playerIdx)
}

func (Logic) OnEveryoneLeft(state any) {
	s, ok := state.(*State)
	if !ok || s.Finished {
		return
	}
	s.Steps = []Step{}
	s.finish(EndTime)
}

func (Logic) Rankings(state any) []int {
	s, ok := state.(*State)
	if !ok {
		return nil
	}
	return s.rankings()
}

func (Logic) MoveCount(state any) int {
	s, ok := state.(*State)
	if !ok {
		return 0
	}
	return s.MoveCount
}

func (Logic) TurnStartDelay(state any, previousPlayerIdx, nextPlayerIdx int) time.Duration {
	s, ok := state.(*State)
	if !ok {
		return 0
	}
	if previousPlayerIdx < 0 {
		return firstTurnDelay
	}
	delay := stepsDelay(s.Steps)
	if previousPlayerIdx != nextPlayerIdx {
		delay += turnAnnounceDelay
	}
	return min(delay, maxStartDelay)
}

func stepsDelay(steps []Step) time.Duration {
	var delay time.Duration
	for _, step := range steps {
		switch step.Kind {
		case StepRoll:
			delay += rollDelay
		case StepMove:
			if step.From == nil || step.To == nil {
				continue
			}
			hops := (*step.To - *step.From + BoardSize) % BoardSize
			fast := max(hops-hopFastAfter, 0)
			delay += time.Duration(hops-fast)*hopDelay + time.Duration(fast)*hopFastDelay
		case StepTeleport:
			delay += teleportDelay
		case StepLand:
			delay += landDelay
		case StepPay:
			delay += payDelay
		case StepCard:
			delay += cardDelay
		case StepJailIn:
			delay += jailInDelay
		case StepJailOut:
			delay += jailOutDelay
		case StepBuild, StepSell:
			delay += buildDelay
		case StepDebt:
			delay += debtDelay
		case StepBankrupt:
			delay += bankruptDelay
		case StepRound:
			delay += roundDelay
		}
	}
	return delay
}
