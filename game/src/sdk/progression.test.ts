import { describe, expect, it } from 'vitest';

import {
  MAX_LEVEL,
  expBaseForLevel,
  expToNext,
  levelFromExp,
  levelProgress,
} from './progression';

// Parity fixture mirrored from server/internal/game/progression (Go is the source of truth).
const GO_PARITY: Array<[level: number, base: number]> = [
  [1, 0],
  [2, 100],
  [3, 300],
  [5, 1000],
  [10, 4500],
  [20, 19000],
  [99, 485100],
];

describe('progression parity with Go', () => {
  it('matches the Go exp curve', () => {
    for (const [level, base] of GO_PARITY) {
      expect(expBaseForLevel(level)).toBe(base);
    }
    expect(expBaseForLevel(150)).toBe(485100);
  });

  it('derives the same levels from exp', () => {
    expect(levelFromExp(-10)).toBe(1);
    expect(levelFromExp(0)).toBe(1);
    expect(levelFromExp(99)).toBe(1);
    expect(levelFromExp(100)).toBe(2);
    expect(levelFromExp(4499)).toBe(9);
    expect(levelFromExp(4500)).toBe(10);
    expect(levelFromExp(10_000_000)).toBe(MAX_LEVEL);
  });

  it('round-trips every level boundary', () => {
    for (let level = 1; level < MAX_LEVEL; level += 1) {
      const base = expBaseForLevel(level);
      expect(levelFromExp(base)).toBe(level);
      expect(levelFromExp(base + expToNext(level))).toBe(level + 1);
    }
  });
});

describe('levelProgress', () => {
  it('reports progress within a level', () => {
    expect(levelProgress(0)).toEqual({ level: 1, current: 0, required: 100, ratio: 0 });
    expect(levelProgress(150)).toEqual({ level: 2, current: 50, required: 200, ratio: 0.25 });
  });

  it('saturates at the level cap', () => {
    const capped = levelProgress(expBaseForLevel(MAX_LEVEL) + 123);
    expect(capped.level).toBe(MAX_LEVEL);
    expect(capped.required).toBe(0);
    expect(capped.ratio).toBe(1);
  });
});
