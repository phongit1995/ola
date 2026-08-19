import { describe, expect, it } from 'vitest';
import {
  LIGHTNING_GOD_DAMAGE,
  cascadeBonusPercent,
  scaleCascadeValue,
} from './battle';
import {
  GRID,
  computeLightningArcs,
  randomFourTwoByTwoBlocks,
  type Board,
} from './core';

describe('cascade scaling', () => {
  it('adds 10% per automatic cascade and caps at 30%', () => {
    expect([0, 1, 2, 3, 4].map(cascadeBonusPercent)).toEqual([0, 10, 20, 30, 30]);
    expect([0, 1, 2, 3, 4].map((level) => scaleCascadeValue(21, level))).toEqual([
      21, 23, 25, 27, 27,
    ]);
  });

  it('treats invalid cascade levels as the base level', () => {
    expect(scaleCascadeValue(20, -2)).toBe(20);
    expect(scaleCascadeValue(20, Number.NaN)).toBe(20);
  });
});

it('keeps Lightning God direct damage at 20 HP', () => {
  expect(LIGHTNING_GOD_DAMAGE).toBe(20);
});

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

describe('computeLightningArcs', () => {
  it('fires once per destroyed Lightning tile without recursively firing from a target', () => {
    const board = new Array(GRID * GRID).fill('sword') as Board;
    board[0] = 'lightning';
    board[2] = 'lightning';
    board[10] = 'lightning';
    const removed = new Set([0, 1, 10, 11]);

    const arcs = computeLightningArcs(board, [10, 0, 10, 1], removed, () => 0);

    expect(arcs.map((arc) => arc.source)).toEqual([0, 10]);
    expect(arcs[0]?.target).toBe(2);
    expect(new Set(arcs.map((arc) => arc.target)).size).toBe(arcs.length);
    expect(arcs.every((arc) => !removed.has(arc.target))).toBe(true);
    expect(arcs.some((arc) => arc.source === 2)).toBe(false);
  });
});
