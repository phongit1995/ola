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

func TestMatchAnimationDelayWaitsForFireTriggeredLightning(t *testing.T) {
	directArcs := make([]LightningArc, 8)
	triggeredArcs := make([]LightningArc, 8)
	for i := range directArcs {
		directArcs[i] = LightningArc{Source: i, Target: 32 + i}
		triggeredArcs[i] = LightningArc{Source: 16 + i, Target: 32 + i}
	}
	direct := Step{
		Kind:          stepMatch,
		Cells:         []int{0, 1, 2, 3, 4, 5, 6, 7},
		Counts:        map[string]int{tileNames[tileFireSword]: 1},
		LightningArcs: directArcs,
	}
	triggered := direct
	triggered.LightningArcs = triggeredArcs
	mixed := direct
	mixed.LightningArcs = append(append([]LightningArc(nil), directArcs...), triggeredArcs...)

	if diff := matchAnimationDelay(triggered) - matchAnimationDelay(direct); diff != 930*time.Millisecond {
		t.Fatalf("fire-triggered lightning must wait for fire FX: delay difference=%v", diff)
	}
	if got, want := matchAnimationDelay(mixed), matchAnimationDelay(triggered); got != want {
		t.Fatalf("direct and fire-triggered arc groups run in parallel: mixed=%v want=%v", got, want)
	}
}
