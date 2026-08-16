import { describe, expect, it } from 'vitest';
import { GRID, randomTwoByTwoCells } from './core';

describe('randomTwoByTwoCells', () => {
  it.each([
    [0, [0, 1, 8, 9]],
    [0.5, [27, 28, 35, 36]],
    [0.999999, [54, 55, 62, 63]],
  ])('selects an in-bounds 2x2 block for random=%s', (random, expected) => {
    expect(randomTwoByTwoCells(() => random)).toEqual(expected);
  });

  it('always returns four distinct cells forming a square', () => {
    for (let sample = 0; sample < 49; sample += 1) {
      const cells = randomTwoByTwoCells(() => (sample + 0.1) / 49);
      expect(new Set(cells).size).toBe(4);
      expect(cells[1] - cells[0]).toBe(1);
      expect(cells[2] - cells[0]).toBe(GRID);
      expect(cells[3] - cells[0]).toBe(GRID + 1);
      expect(cells[0] % GRID).toBeLessThan(GRID - 1);
    }
  });
});
