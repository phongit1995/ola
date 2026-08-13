package wargod

import "time"

const initialBoardAnimationDelay = 1100 * time.Millisecond

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
			delay += 450 * time.Millisecond
		case stepUlt:
			delay += 2100 * time.Millisecond
		}
	}
	return delay
}

func matchAnimationDelay(step Step) time.Duration {
	fireSwords := step.Counts[tileNames[tileFireSword]]
	swords := step.Counts[tileNames[tileSword]] + fireSwords

	removeDelay := 200 * time.Millisecond
	if swords > 0 {
		removeDelay = 590*time.Millisecond + time.Duration(swords-1)*110*time.Millisecond
	}

	specialDelay := time.Duration(0)
	if fireSwords > 0 {
		specialDelay = 930*time.Millisecond + time.Duration(fireSwords-1)*72*time.Millisecond
	}
	if arcs := len(step.LightningArcs); arcs > 0 {
		lightningDelay := 400*time.Millisecond + time.Duration(arcs-1)*76*time.Millisecond
		if lightningDelay > specialDelay {
			specialDelay = lightningDelay
		}
	}
	return specialDelay + removeDelay
}
