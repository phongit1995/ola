export const EXP_WIN = 50;
export const EXP_DRAW = 25;
export const EXP_LOSS = 15;
export const EXP_MOVE_CAP = 40;
export const MAX_LEVEL = 99;

export function expBaseForLevel(level: number): number {
  if (level <= 1) return 0;
  const capped = Math.min(level, MAX_LEVEL);
  return 50 * capped * (capped - 1);
}

export function expToNext(level: number): number {
  if (level < 1 || level >= MAX_LEVEL) return 0;
  return 100 * level;
}

export function levelFromExp(exp: number): number {
  if (!Number.isFinite(exp) || exp < 0) return 1;
  let level = 1;
  while (level < MAX_LEVEL && exp >= expBaseForLevel(level + 1)) {
    level += 1;
  }
  return level;
}

export interface LevelProgress {
  level: number;
  current: number;
  required: number;
  ratio: number;
}

export function levelProgress(exp: number): LevelProgress {
  const safeExp = Number.isFinite(exp) && exp > 0 ? exp : 0;
  const level = levelFromExp(safeExp);
  const required = expToNext(level);
  if (required <= 0) {
    return { level, current: 0, required: 0, ratio: 1 };
  }
  const current = safeExp - expBaseForLevel(level);
  return { level, current, required, ratio: Math.min(1, current / required) };
}
