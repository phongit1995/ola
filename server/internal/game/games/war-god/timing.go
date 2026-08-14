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

	fireDelay := time.Duration(0)
	if fireSwords > 0 {
		fireDelay = 930*time.Millisecond + time.Duration(fireSwords-1)*72*time.Millisecond
	}
	specialDelay := fireDelay
	matched := make(map[int]bool, len(step.Cells))
	for _, cell := range step.Cells {
		matched[cell] = true
	}
	directArcs, fireTriggeredArcs := 0, 0
	for _, arc := range step.LightningArcs {
		if matched[arc.Source] {
			directArcs++
		} else {
			fireTriggeredArcs++
		}
	}
	if delay := lightningAnimationDelay(directArcs); delay > specialDelay {
		specialDelay = delay
	}
	if fireTriggeredArcs > 0 {
		delay := fireDelay + lightningAnimationDelay(fireTriggeredArcs)
		if delay > specialDelay {
			specialDelay = delay
		}
	}
	return specialDelay + removeDelay
}

func lightningAnimationDelay(arcs int) time.Duration {
	if arcs <= 0 {
		return 0
	}
	return 400*time.Millisecond + time.Duration(arcs-1)*76*time.Millisecond
}
