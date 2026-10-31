import { describe, expect, it } from 'vitest';
import { detectCombo } from './combos';
import { enumeratePlays, hintPlays } from './hints';

const card = (rank: number, suit: number): number => rank * 4 + suit;

describe('enumeratePlays', () => {
  it('uses the higher suit to top a straight of the same rank', () => {
    const prev = detectCombo([card(2, 0), card(3, 1), card(4, 2)])!;
    const hand = [card(2, 1), card(3, 2), card(4, 0), card(4, 3)];
    expect(enumeratePlays(hand, prev)).toContainEqual([card(2, 1), card(3, 2), card(4, 3)]);
  });

  it('finds double runs with any top pair', () => {
    const hand = [card(5, 0), card(5, 1), card(6, 0), card(6, 1), card(7, 2), card(7, 3)];
    expect(enumeratePlays(hand, null)).toContainEqual(hand);
  });
});

describe('hintPlays', () => {
  it('suggests the cheapest beat first and chops last', () => {
    const prev = detectCombo([card(12, 1)])!;
    const hand = [card(12, 3), card(4, 0), card(4, 1), card(4, 2), card(4, 3)];
    const hints = hintPlays(hand, prev);
    expect(hints[0]).toEqual([card(12, 3)]);
    expect(hints[hints.length - 1]).toEqual([card(4, 0), card(4, 1), card(4, 2), card(4, 3)]);
  });

  it('offers one suggestion per shape', () => {
    const prev = detectCombo([card(5, 0), card(5, 1)])!;
    const hand = [card(6, 0), card(6, 1), card(6, 3)];
    expect(hintPlays(hand, prev)).toEqual([[card(6, 0), card(6, 1)]]);
  });

  it('suggests only the longest run from each starting rank when leading', () => {
    const hand = [card(0, 0), card(1, 1), card(2, 2), card(3, 3), card(4, 0)];
    const straights = hintPlays(hand, null).filter((play) => play.length >= 3);
    expect(straights).toEqual([hand, [card(1, 1), card(2, 2), card(3, 3), card(4, 0)], [card(2, 2), card(3, 3), card(4, 0)]]);
  });

  it('only suggests plays with the three of spades on the opening turn', () => {
    const hand = [card(0, 0), card(0, 2), card(1, 1), card(2, 3), card(9, 0)];
    const hints = hintPlays(hand, null, true);
    expect(hints.length).toBeGreaterThan(0);
    expect(hints.every((play) => play.includes(card(0, 0)))).toBe(true);
    expect(hints[0]).toEqual([card(0, 0), card(1, 1), card(2, 3)]);
  });

  it('returns nothing when the hand cannot beat the table', () => {
    const prev = detectCombo([card(11, 2), card(11, 3)])!;
    expect(hintPlays([card(3, 0), card(9, 2), card(9, 3)], prev)).toEqual([]);
  });
});
