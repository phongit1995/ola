package wargod

import "time"

const initialBoardAnimationDelay = 1800 * time.Millisecond
const shuffleAnimationDelay = 1450 * time.Millisecond

// TurnStartDelay reserves enough authoritative time for the active client to
// finish replaying the previous move before its normal turn clock is consumed.
func (Logic) TurnStartDelay(state any, previousPlayerIdx, nextPlayerIdx int) time.Duration {
	current, ok := state.(*State)
	if !ok {
		return 0
	}
	if previousPlayerIdx < 0 {
		return initialBoardAnimationDelay
	}

	delay := 250 * time.Millisecond
	for _, step := range current.Steps {
		switch step.Kind {
		case stepSwap:
			// The opponent sees a short selection cue before the swap itself.
			if previousPlayerIdx == nextPlayerIdx {
				delay += 200 * time.Millisecond
			} else {
				delay += 850 * time.Millisecond
			}
		case stepMatch:
			delay += matchAnimationDelay(step)
		case stepGravity:
			delay += 350 * time.Millisecond
		case stepShuffle:
			delay += shuffleAnimationDelay
		case stepUlt:
			if step.Skill == skillHeartVacuum {
				delay += heartVacuumAnimationDelay(len(step.Cells))
			} else {
				delay += 2100 * time.Millisecond
			}
			if len(step.DartActivations) > 0 {
				delay += flyingDartAnimationDelay(len(step.DartActivations))
			}
			if len(step.FireSwordActivations) > 0 {
				delay += fireSwordAnimationDelay(len(step.FireSwordActivations))
			}
			if len(step.LightningArcs) > 0 {
				delay += lightningAnimationDelay(len(step.LightningArcs))
			}
		}
	}
	return delay
}

func heartVacuumAnimationDelay(hearts int) time.Duration {
	if hearts < 1 {
		hearts = 1
	}
	// Reveal (~440ms), staggered heart flights (46ms each), core flight and
	// impact (~1.2s), plus a safety margin for slower devices.
	return 2900*time.Millisecond + time.Duration(hearts-1)*46*time.Millisecond
}

func matchAnimationDelay(step Step) time.Duration {
	fireSwords := step.Counts[tileNames[tileFireSword]]
	swords := step.Counts[tileNames[tileSword]] + fireSwords

	removeDelay := 200 * time.Millisecond
	if swords > 0 {
		removeDelay = 590*time.Millisecond + time.Duration(swords-1)*110*time.Millisecond
	}

	matched := make(map[int]bool, len(step.Cells))
	for _, cell := range step.Cells {
		matched[cell] = true
	}
	directFireSwords, triggeredFireSwords := 0, 0
	if len(step.FireSwordActivations) == 0 {
		// Older steps did not record activation provenance; all Fire Swords
		// represented by Counts were direct matches in that wire format.
		directFireSwords = fireSwords
	} else {
		for _, source := range step.FireSwordActivations {
			if matched[source] {
				directFireSwords++
			} else {
				triggeredFireSwords++
			}
		}
	}
	directDarts, triggeredDarts := 0, 0
	for _, activation := range step.DartActivations {
		if matched[activation.Source] {
			directDarts++
		} else {
			triggeredDarts++
		}
	}
	directFireDelay := fireSwordAnimationDelay(directFireSwords)
	directDartDelay := flyingDartAnimationDelay(directDarts)
	triggeredDartDelay := flyingDartAnimationDelay(triggeredDarts)
	triggeredFireDelay := fireSwordAnimationDelay(triggeredFireSwords)
	// Direct Fire Sword and Phi Tiêu FX start together. A special reached by
	// another special waits for that preceding FX, matching explodeFx on the
	// client. These maxima model the parallel branches without undercounting
	// the sequential fire -> dart -> fire/lightning chains.
	dartDelay := directDartDelay
	if candidate := directFireDelay + triggeredDartDelay; candidate > dartDelay {
		dartDelay = candidate
	}
	fireDelay := directFireDelay
	if candidate := dartDelay + triggeredFireDelay; candidate > fireDelay {
		fireDelay = candidate
	}
	specialDelay := fireDelay
	directArcs, triggeredArcs := 0, 0
	for _, arc := range step.LightningArcs {
		if matched[arc.Source] {
			directArcs++
		} else {
			triggeredArcs++
		}
	}
	if delay := lightningAnimationDelay(directArcs); delay > specialDelay {
		specialDelay = delay
	}
	if dartDelay > specialDelay {
		specialDelay = dartDelay
	}
	if triggeredArcs > 0 {
		// A non-matched Lightning source may be reached by either a Dart line
		// or a Fire Sword blast. The client waits for both branches before
		// showing its bolt, so include the longer prerequisite chain.
		triggeredLightningBase := fireDelay
		if dartDelay > triggeredLightningBase {
			triggeredLightningBase = dartDelay
		}
		delay := triggeredLightningBase + lightningAnimationDelay(triggeredArcs)
		if delay > specialDelay {
			specialDelay = delay
		}
	}
	creationDelay := time.Duration(0)
	if len(step.DartCreations) > 0 {
		creationDelay = 540 * time.Millisecond
	}
	return specialDelay + removeDelay + creationDelay
}

func flyingDartAnimationDelay(darts int) time.Duration {
	if darts <= 0 {
		return 0
	}
	// charge (260ms) + sweep (about 432ms), with a 70ms gap between
	// sequential darts. Keep a small frame/network safety margin so the next
	// player's clock never starts while the replay is still on screen.
	return 720*time.Millisecond + time.Duration(darts-1)*760*time.Millisecond
}

func fireSwordAnimationDelay(swords int) time.Duration {
	if swords <= 0 {
		return 0
	}
	return 930*time.Millisecond + time.Duration(swords-1)*72*time.Millisecond
}

func lightningAnimationDelay(arcs int) time.Duration {
	if arcs <= 0 {
		return 0
	}
	return 400*time.Millisecond + time.Duration(arcs-1)*76*time.Millisecond
}
