import { describe, expect, it } from 'vitest';
import { applyMove, newGame } from './engine';
import { buildPlan, sellPlan } from './rules-hint';
import type { GameState } from './types';

function owning(houses: [number, number], pos = 30): GameState {
  const s = newGame(3, 2);
  return {
    ...s,
    phase: 'manage',
    turn: 0,
    players: s.players.map((p, seat) => (seat === 0 ? { ...p, cash: 5000, pos } : p)),
    tiles: s.tiles.map((t, idx) => (idx === 30 ? { owner: 0, houses: houses[0] } : idx === 31 ? { owner: 0, houses: houses[1] } : t)),
  };
}

describe('buildPlan', () => {
  it('builds only the tile you stand on, straight to the chosen level', () => {
    expect(buildPlan(owning([0, 0]), 0, 30, 2)).toEqual({ tiles: [30, 30], cost: 150 + 200 });
  });

  it('returns null away from the tile or past the top level', () => {
    expect(buildPlan(owning([0, 0]), 0, 31, 1)).toBeNull();
    expect(buildPlan(owning([3, 3]), 0, 30, 4)).toBeNull();
  });

  it('every planned move is legal in the engine', () => {
    let s = owning([0, 1], 31);
    const plan = buildPlan(s, 0, 31, 3);
    expect(plan).not.toBeNull();
    for (const tile of plan?.tiles ?? []) s = applyMove(s, 0, { type: 'BUILD', tile });
    expect(s.tiles[31].houses).toBe(3);
    expect(s.tiles[30].houses).toBe(0);
    expect(s.players[0].cash).toBe(5000 - (plan?.cost ?? 0));
  });
});

describe('sellPlan', () => {
  it('sells only the chosen tile down to the chosen level', () => {
    expect(sellPlan(owning([3, 3]), 0, 30, 1)).toEqual({ tiles: [30, 30], cost: 125 + 100 });
  });

  it('returns null when nothing to sell', () => {
    expect(sellPlan(owning([0, 0]), 0, 30, 0)).toBeNull();
  });

  it('every planned sale is legal in the engine', () => {
    let s = owning([3, 2]);
    const plan = sellPlan(s, 0, 31, 0);
    for (const tile of plan?.tiles ?? []) s = applyMove(s, 0, { type: 'SELL_HOUSE', tile });
    expect(s.tiles[31].houses).toBe(0);
    expect(s.tiles[30].houses).toBe(3);
    expect(s.players[0].cash).toBe(5000 + (plan?.cost ?? 0));
  });
});
