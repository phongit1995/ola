import { describe, expect, it } from 'vitest';
import parity from '../../../server/internal/game/games/war-god/testdata/parity.json';
import { applyTileEffects } from './battle';
import { TILE_ORDER, type TileType } from './constants.gen';
import { computeExplosions, emptyCounts, findMatches } from './core';
import { decodeBoard, decodeTile } from './server-types';

describe('server/client War God parity', () => {
  it('uses the server tile wire order and rejects malformed tile codes', () => {
    expect(TILE_ORDER).toEqual(parity.tileOrder);
    TILE_ORDER.forEach((tile, index) => expect(decodeTile(index)).toBe(tile));
    for (const invalid of [-1, TILE_ORDER.length, 1.5, Number.NaN]) {
      expect(() => decodeTile(invalid)).toThrow(RangeError);
    }
  });

  for (const test of parity.findMatches) {
    it(`findMatches: ${test.name}`, () => {
      const result = findMatches(decodeBoard(test.board));
      expect(result).not.toBeNull();
      expect([...result!.cells].sort((a, b) => a - b)).toEqual(test.cells);
      expect(nonZeroCounts(result!.counts)).toEqual(test.counts);
      expect(result!.maxRun).toBe(test.maxRun);
      expect(result!.bonusTurns).toBe(test.bonusTurns);
    });
  }

  for (const test of parity.tileEffects) {
    it(`applyTileEffects: ${test.name}`, () => {
      const attacker = { ...test.attacker };
      const defender = { ...test.defender };
      const effects = applyTileEffects(
        attacker,
        defender,
        Object.assign(emptyCounts(), test.counts),
      );
      expect(attacker).toEqual(test.wantAttacker);
      expect(defender).toEqual(test.wantDefender);
      expect(effects).toEqual(test.wantEffects);
    });
  }

  for (const test of parity.explosionPlans) {
    it(`computeExplosions: ${test.name}`, () => {
      let randomIndex = 0;
      const randomValues = test.random ?? [];
      const result = computeExplosions(
        decodeBoard(test.board),
        new Set(test.matched),
        () => randomValues[randomIndex++] ?? 0,
      );
      expect(result.exploded).toEqual(test.exploded);
      expect(result.lightningArcs).toEqual(test.lightningArcs);
      expect(result.dartActivations).toEqual(test.dartActivations);
      expect(result.fireSwordActivations).toEqual(test.fireSwordActivations);
    });
  }
});

function nonZeroCounts(counts: Record<TileType, number>): Partial<Record<TileType, number>> {
  return Object.fromEntries(
    TILE_ORDER.flatMap((tile) => (counts[tile] === 0 ? [] : [[tile, counts[tile]]])),
  );
}
