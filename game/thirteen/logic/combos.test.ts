import { describe, expect, it } from 'vitest';
import { canBeat, isChop } from './beats';
import { detectCombo } from './combos';
import { enumeratePlays, hasAnyBeat } from './hints';

const card = (rank: number, suit: number): number => rank * 4 + suit;

describe('detectCombo', () => {
  it('detects basic sets', () => {
    expect(detectCombo([card(5, 2)])?.kind).toBe('single');
    expect(detectCombo([card(7, 0), card(7, 3)])?.kind).toBe('pair');
    expect(detectCombo([card(2, 0), card(2, 1), card(2, 2)])?.kind).toBe('triple');
    expect(detectCombo([card(9, 0), card(9, 1), card(9, 2), card(9, 3)])?.kind).toBe('quad');
  });

  it('detects straights without twos', () => {
    expect(detectCombo([card(0, 0), card(1, 2), card(2, 3)])?.kind).toBe('straight');
    expect(detectCombo([card(10, 0), card(11, 1), card(12, 1)])).toBeNull();
  });

  it('detects double runs', () => {
    const run = [card(3, 0), card(3, 1), card(4, 0), card(4, 2), card(5, 1), card(5, 3)];
    expect(detectCombo(run)).toMatchObject({ kind: 'doubleRun', length: 3 });
  });

  it('rejects junk and duplicates', () => {
    expect(detectCombo([])).toBeNull();
    expect(detectCombo([card(1, 0), card(5, 1)])).toBeNull();
    expect(detectCombo([card(5, 1), card(5, 1)])).toBeNull();
  });
});

describe('canBeat + chops', () => {
  const single2 = detectCombo([card(12, 0)])!;
  const pair2 = detectCombo([card(12, 2), card(12, 3)])!;
  const quad5 = detectCombo([card(5, 0), card(5, 1), card(5, 2), card(5, 3)])!;
  const run3 = detectCombo([card(3, 0), card(3, 1), card(4, 0), card(4, 1), card(5, 0), card(5, 1)])!;
  const run4 = detectCombo([
    card(3, 0), card(3, 1), card(4, 0), card(4, 1), card(5, 0), card(5, 1), card(6, 0), card(6, 1),
  ])!;

  it('applies the chop table', () => {
    expect(canBeat(quad5, single2)).toBe(true);
    expect(canBeat(run3, single2)).toBe(true);
    expect(canBeat(run3, pair2)).toBe(false);
    expect(canBeat(quad5, pair2)).toBe(true);
    expect(canBeat(run4, pair2)).toBe(true);
    expect(canBeat(run4, quad5)).toBe(true);
    expect(canBeat(quad5, run4)).toBe(false);
    expect(canBeat(quad5, run3)).toBe(true);
    expect(isChop(quad5, single2)).toBe(true);
    expect(isChop(quad5, detectCombo([card(5, 0)])!)).toBe(false);
  });

  it('leads freely on an empty table', () => {
    expect(canBeat(single2, null)).toBe(true);
  });
});

describe('hints', () => {
  it('finds beats and reports dead hands', () => {
    const hand = [card(3, 0), card(9, 2), card(9, 3)];
    const prevPair = detectCombo([card(8, 0), card(8, 1)])!;
    expect(hasAnyBeat(hand, prevPair)).toBe(true);
    const prevPairAces = detectCombo([card(11, 2), card(11, 3)])!;
    expect(hasAnyBeat(hand, prevPairAces)).toBe(false);
    expect(enumeratePlays(hand, null).length).toBeGreaterThan(0);
  });
});
