import { describe, expect, it } from 'vitest';
import { tilesOfGroup } from './board';
import { instantWin, newGame } from './engine';
import { winningTiles, winThreats } from './rules-hint';
import type { GameState } from './types';

function withOwners(owners: Record<number, number>, houses: Record<number, number> = {}): GameState {
  const s = newGame(5, 3);
  return { ...s, tiles: s.tiles.map((t, idx) => (idx in owners ? { owner: owners[idx], houses: houses[idx] ?? 0 } : t)) };
}

describe('winThreats', () => {
  it('flags the last city of a board side', () => {
    const threats = winThreats(withOwners({ 1: 0, 3: 0, 5: 0 }).tiles, newGame(5, 3).players);
    expect(threats).toContainEqual({ seat: 0, kind: 'line', tile: 7 });
  });

  it('flags the fourth airport only when it can still be bought', () => {
    const [a, b, c, d] = tilesOfGroup('station');
    const players = newGame(5, 3).players;
    expect(winThreats(withOwners({ [a]: 1, [b]: 1, [c]: 1 }).tiles, players)).toContainEqual({ seat: 1, kind: 'airports', tile: d });
    expect(winThreats(withOwners({ [a]: 1, [b]: 1, [c]: 1, [d]: 2 }).tiles, players).some((t) => t.kind === 'airports')).toBe(false);
  });

  it('ignores a missing city that is a rival hotel', () => {
    const threats = winThreats(withOwners({ 1: 0, 3: 0, 5: 0, 7: 1 }, { 7: 3 }).tiles, newGame(5, 3).players);
    expect(threats.some((t) => t.seat === 0 && t.kind === 'line')).toBe(false);
  });

  it('flags groups only after two full groups', () => {
    const owners = { 1: 2, 3: 2, 5: 2, 7: 2, 9: 2 };
    const threats = winThreats(withOwners(owners).tiles, newGame(5, 3).players).filter((t) => t.kind === 'groups');
    expect(threats.map((t) => t.tile)).toContain(11);
  });

  it('owning the flagged tile is an instant win', () => {
    const s = withOwners({ 1: 0, 3: 0, 5: 0 });
    const threat = winThreats(s.tiles, s.players).find((t) => t.kind === 'line');
    expect(threat).toBeDefined();
    const won = { ...s, tiles: s.tiles.map((t, idx) => (idx === threat?.tile ? { owner: 0, houses: 0 } : t)) };
    expect(instantWin(won, 0)).toBe('line');
    expect(winningTiles(won, 0, 'line')).toEqual([1, 3, 5, 7]);
  });
});
