import { describe, expect, it } from 'vitest';
import { applyMove, newGame } from './engine';
import { buildPlan } from './rules-hint';
import type { GameState } from './types';

function owning(houses: [number, number]): GameState {
  const s = newGame(3, 2);
  return {
    ...s,
    phase: 'manage',
    turn: 0,
    players: s.players.map((p, seat) => (seat === 0 ? { ...p, cash: 5000 } : p)),
    tiles: s.tiles.map((t, idx) => (idx === 30 ? { owner: 0, houses: houses[0] } : idx === 31 ? { owner: 0, houses: houses[1] } : t)),
  };
}

describe('buildPlan', () => {
  it('builds the group evenly up to the chosen level', () => {
    const plan = buildPlan(owning([0, 0]), 0, 30, 2);
    expect(plan).toEqual({ tiles: [30, 31, 30], cost: 600 });
  });

  it('raises the lower tile first when the target tile is ahead', () => {
    expect(buildPlan(owning([1, 0]), 0, 30, 2)?.tiles).toEqual([31, 30]);
  });

  it('returns null without the whole group or past the top level', () => {
    const s = owning([0, 0]);
    expect(buildPlan({ ...s, tiles: s.tiles.map((t, idx) => (idx === 31 ? { owner: -1, houses: 0 } : t)) }, 0, 30, 1)).toBeNull();
    expect(buildPlan(owning([3, 3]), 0, 30, 4)).toBeNull();
  });

  it('every planned move is legal in the engine', () => {
    let s = owning([0, 1]);
    const plan = buildPlan(s, 0, 31, 3);
    expect(plan).not.toBeNull();
    for (const tile of plan?.tiles ?? []) s = applyMove(s, 0, { type: 'BUILD', tile });
    expect(s.tiles[31].houses).toBe(3);
    expect(s.tiles[30].houses).toBeGreaterThanOrEqual(2);
    expect(s.players[0].cash).toBe(5000 - (plan?.cost ?? 0));
  });
});
