import { describe, expect, it } from 'vitest';
import parity from '../../../server/internal/game/games/thirteen/testdata/parity.json';
import { canBeat } from './beats';
import { detectCombo } from './combos';
import { HAND_SIZE } from './constants.gen';

describe('server/client Tien Len parity', () => {
  for (const test of parity.classify) {
    it(`classify [${test.cards.join(',')}]`, () => {
      const combo = detectCombo(test.cards);
      if (!test.valid) {
        expect(combo).toBeNull();
        return;
      }
      expect(combo).not.toBeNull();
      expect(combo!.kind).toBe(test.kind);
      expect(combo!.length).toBe(test.length);
      expect(combo!.key).toBe(test.key);
    });
  }

  for (const test of parity.beats) {
    it(`beats [${test.next.join(',')}] over [${test.prev.join(',')}]`, () => {
      const next = detectCombo(test.next);
      const prev = detectCombo(test.prev);
      expect(next).not.toBeNull();
      expect(prev).not.toBeNull();
      expect(canBeat(next!, prev!)).toBe(test.want);
    });
  }

  for (const deal of parity.deals) {
    it(`deal seed=${deal.seed} players=${deal.players} shape`, () => {
      expect(deal.hands).toHaveLength(deal.players);
      const seen = new Set<number>();
      for (const hand of deal.hands) {
        expect(hand).toHaveLength(HAND_SIZE);
        for (const card of hand) {
          expect(seen.has(card)).toBe(false);
          seen.add(card);
        }
      }
      expect(deal.starter).toBeGreaterThanOrEqual(0);
      expect(deal.starter).toBeLessThan(deal.players);
    });
  }
});
