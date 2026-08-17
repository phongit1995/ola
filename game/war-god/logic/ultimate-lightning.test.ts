import { describe, expect, it } from 'vitest';
import { GRID, randomFourTwoByTwoBlocks } from './core';

describe('randomFourTwoByTwoBlocks', () => {
  it.each([0, 0.17, 0.5, 0.83, 0.999999])(
    'selects four non-overlapping in-bounds 2x2 blocks for random=%s',
    (random) => {
      const blocks = randomFourTwoByTwoBlocks(() => random);
      expect(blocks).toHaveLength(4);
      const allCells = blocks.flat();
      expect(new Set(allCells).size).toBe(16);
      for (const cells of blocks) {
        expect(cells).toHaveLength(4);
        expect(cells[1] - cells[0]).toBe(1);
        expect(cells[2] - cells[0]).toBe(GRID);
        expect(cells[3] - cells[0]).toBe(GRID + 1);
        expect(cells[0] % GRID).toBeLessThan(GRID - 1);
        expect(cells[3]).toBeLessThan(GRID * GRID);
      }
    },
  );

  it('spreads a zero-valued random stream across the first board row', () => {
    expect(randomFourTwoByTwoBlocks(() => 0)).toEqual([
      [0, 1, 8, 9],
      [2, 3, 10, 11],
      [4, 5, 12, 13],
      [6, 7, 14, 15],
    ]);
  });
});
