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

	plainUltimate := &State{Steps: []Step{{Kind: stepUlt}}}
	lightningUltimate := &State{Steps: []Step{{
		Kind: stepUlt,
		LightningArcs: []LightningArc{
			{Source: 1, Target: 8},
			{Source: 2, Target: 9},
			{Source: 3, Target: 10},
		},
	}}}
	wantArcDelay := lightningAnimationDelay(len(lightningUltimate.Steps[0].LightningArcs))
	gotArcDelay := (Logic{}).TurnStartDelay(lightningUltimate, 0, 1) -
		(Logic{}).TurnStartDelay(plainUltimate, 0, 1)
	if gotArcDelay != wantArcDelay {
		t.Fatalf("ultimate secondary arc delay = %v, want %v", gotArcDelay, wantArcDelay)
	}
}

func TestTurnStartDelayCoversBoardShufflePresentation(t *testing.T) {
	state := &State{Steps: []Step{{Kind: stepShuffle}}}
	want := 250*time.Millisecond + shuffleAnimationDelay
	if got := (Logic{}).TurnStartDelay(state, 0, 1); got != want {
		t.Fatalf("shuffle delay = %v, want %v", got, want)
	}
}

func TestTurnStartDelayCoversHeartVacuumAndCollapse(t *testing.T) {
	state := &State{Steps: []Step{
		{Kind: stepUlt, Skill: skillHeartVacuum, Cells: []int{0, 1, 2, 3, 4, 5}},
		{Kind: stepGravity},
		{Kind: stepMatch, Counts: map[string]int{tileNames[tileSword]: 3}, CascadeLevel: 1},
	}}
	wantMinimum := 250*time.Millisecond + heartVacuumAnimationDelay(6) + 350*time.Millisecond + matchAnimationDelay(state.Steps[2])
	if got := (Logic{}).TurnStartDelay(state, 0, 1); got < wantMinimum {
		t.Fatalf("heart vacuum replay delay = %v, want >= %v", got, wantMinimum)
	}
}

func TestHeartVacuumDelayDoesNotUndercountEmptyBoardReplay(t *testing.T) {
	if got := heartVacuumAnimationDelay(0); got < 2900*time.Millisecond {
		t.Fatalf("empty heart vacuum replay delay = %v, want >= 2.9s", got)
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

func TestMatchAnimationDelayWaitsForDartTriggeredLightning(t *testing.T) {
	base := Step{
		Kind:   stepMatch,
		Cells:  []int{0, 1, 2},
		Counts: map[string]int{tileNames[tileWater]: 3},
	}
	triggered := base
	triggered.DartActivations = []DartActivation{{Source: 8, Axis: dartAxisHorizontal}}
	triggered.LightningArcs = []LightningArc{{Source: 8, Target: 16}}

	// The bolt source is reached only by the Dart sweep, so it must start
	// after the full Dart FX rather than in parallel with it.
	wantMinimum := flyingDartAnimationDelay(1) + lightningAnimationDelay(1)
	if got := matchAnimationDelay(triggered) - matchAnimationDelay(base); got < wantMinimum {
		t.Fatalf("dart-triggered lightning is undercounted: delay difference=%v want >=%v", got, wantMinimum)
	}
}

func TestMatchAnimationDelayCoversSequentialDartsAndCreationFx(t *testing.T) {
	base := Step{
		Kind:   stepMatch,
		Cells:  []int{0, 1, 2},
		Counts: map[string]int{tileNames[tileWater]: 3},
	}
	oneDart := base
	oneDart.DartActivations = []DartActivation{{Source: 0, Axis: dartAxisHorizontal}}
	twoDarts := base
	twoDarts.DartActivations = []DartActivation{
		{Source: 0, Axis: dartAxisHorizontal},
		{Source: 1, Axis: dartAxisVertical},
	}
	if got := matchAnimationDelay(oneDart); got < 692*time.Millisecond+200*time.Millisecond {
		t.Fatalf("one dart replay is undercounted: %v", got)
	}
	if got := matchAnimationDelay(twoDarts); got < 1454*time.Millisecond+200*time.Millisecond {
		t.Fatalf("two sequential dart replay is undercounted: %v", got)
	}
	created := base
	created.DartCreations = []DartCreation{{Index: 1, Type: tileFlyingDartHorizontal}}
	if diff := matchAnimationDelay(created) - matchAnimationDelay(base); diff < 520*time.Millisecond {
		t.Fatalf("dart creation FX is undercounted: %v", diff)
	}
}
