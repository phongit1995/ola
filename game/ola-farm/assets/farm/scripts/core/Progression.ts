import { DEFAULT_PROGRESSION } from './constants/ProgressionDefaults';
import type { Progression } from './types/ProgressionTypes';

/** Keep the first ten level thresholds; later levels take progressively more production. */
export const xpToNext = (level: number, config = DEFAULT_PROGRESSION): number =>
  config.baseXP +
  config.linearXP * (Math.max(1, level) - 1) +
  config.quadraticXP * Math.max(0, level - config.quadraticAfterLevel) ** 2;

export function progression(xp: number, config = DEFAULT_PROGRESSION): Progression {
  let level = 1,
    floor = 0,
    current = Number.isFinite(xp) ? Math.max(0, Math.floor(xp)) : 0;
  while (level < config.maxLevel && current >= xpToNext(level, config)) {
    const need = xpToNext(level, config);
    current -= need;
    floor += need;
    level++;
  }
  const need = xpToNext(level, config);
  return { level, current: Math.min(current, need), need, floor };
}
