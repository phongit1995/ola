package wargod

import (
	"testing"
	"time"
)

func TestTurnStartDelayCoversInitialBoardAnimation(t *testing.T) {
	delay := (Logic{}).TurnStartDelay(&State{}, -1, 0)
	if delay != initialBoardAnimationDelay {
		t.Fatalf("initial delay = %v, want %v", delay, initialBoardAnimationDelay)
	}
}

func TestTurnStartDelayAccountsForOpponentCueAndSpecialEffects(t *testing.T) {
	plain := &State{Steps: []Step{
		{Kind: stepSwap},
		{Kind: stepMatch, Counts: map[string]int{tileNames[tileSword]: 3}},
		{Kind: stepGravity},
	}}
	keptTurn := (Logic{}).TurnStartDelay(plain, 0, 0)
	opponentTurn := (Logic{}).TurnStartDelay(plain, 0, 1)
	if opponentTurn-keptTurn != 650*time.Millisecond {
		t.Fatalf("opponent cue difference = %v, want 650ms", opponentTurn-keptTurn)
	}

	special := &State{Steps: []Step{
		{Kind: stepSwap},
		{
			Kind:          stepMatch,
			Counts:        map[string]int{tileNames[tileSword]: 2, tileNames[tileFireSword]: 2},
			LightningArcs: []LightningArc{{Source: 1, Target: 2}, {Source: 3, Target: 4}},
		},
		{Kind: stepGravity},
	}}
	if got := (Logic{}).TurnStartDelay(special, 0, 1); got <= opponentTurn {
		t.Fatalf("special delay = %v, want greater than plain delay %v", got, opponentTurn)
	}
}
