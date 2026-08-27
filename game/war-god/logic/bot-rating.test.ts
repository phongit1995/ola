import { describe, expect, it } from 'vitest';
import {
  calculateBotStarRating,
  formatBotStarRating,
  isBotStarRating,
  starFillAt,
  type BotRatingInput,
} from './bot-rating';

describe('bot result rating', () => {
  const rate = (overrides: Partial<BotRatingInput> = {}) =>
    calculateBotStarRating({
      won: true,
      forfeit: false,
      playerHp: 100,
      playerArmor: 0,
      botHp: 0,
      botArmor: 0,
      turns: 12,
      ...overrides,
    });

  it('rates a typical win with roughly half HP as 2.5 stars', () => {
    expect(rate({ playerHp: 96, playerArmor: 4 })).toBe(2.5);
  });

  it.each([
    [6, 99, 2.5],
    [6, 100, 3],
    [7, 133, 2.5],
    [7, 134, 3],
    [8, 166, 2.5],
    [8, 167, 3],
    [9, 199, 2.5],
    [9, 200, 3],
    [10, 33, 2],
    [10, 34, 2.5],
    [11, 66, 2],
    [11, 67, 2.5],
    [12, 99, 2],
    [12, 100, 2.5],
  ] as const)('rates a turn %i win with %i effective HP as %s stars', (turns, hp, expected) => {
    expect(rate({ turns, playerHp: hp })).toBe(expected);
  });

  it.each([
    [200, 0],
    [167, 0],
    [166, 0.5],
    [101, 0.5],
    [100, 1],
    [34, 1],
    [33, 1.5],
    [0, 1.5],
  ] as const)('rates a loss against %i effective bot HP as %s stars', (botHp, expected) => {
    expect(rate({ won: false, playerHp: 0, botHp })).toBe(expected);
  });

  it('counts armor as remaining effective health', () => {
    expect(rate({ won: false, playerHp: 0, botHp: 140, botArmor: 0 })).toBe(0.5);
    expect(rate({ won: false, playerHp: 0, botHp: 140, botArmor: 30 })).toBe(0);
  });

  it('clamps turn zero like the first turn and gives no rating for a forfeit', () => {
    expect(rate({ turns: 0, playerHp: 100 })).toBe(rate({ turns: 1, playerHp: 100 }));
    expect(rate({ forfeit: true, playerHp: 200, turns: 1 })).toBe(0);
  });

  it('validates half-star steps and formats the Vietnamese decimal', () => {
    expect(isBotStarRating(2.5)).toBe(true);
    expect(isBotStarRating(2.25)).toBe(false);
    expect(formatBotStarRating(2.5)).toBe('2,5');
    expect([0, 1, 2].map((index) => starFillAt(0.5, index as 0 | 1 | 2))).toEqual([
      0.5,
      0,
      0,
    ]);
    expect([0, 1, 2].map((index) => starFillAt(1.5, index as 0 | 1 | 2))).toEqual([
      1,
      0.5,
      0,
    ]);
    expect([0, 1, 2].map((index) => starFillAt(2.5, index as 0 | 1 | 2))).toEqual([
      1,
      1,
      0.5,
    ]);
  });
});
