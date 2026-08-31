import { describe, expect, it } from 'vitest';
import {
  applyGravity,
  computeExplosions,
  findFlyingDartCreation,
  findMatches,
  type Board,
} from './core';

function stripedBoard(): Board {
  return Array.from({ length: 64 }, (_, index) => {
    const row = Math.floor(index / 8);
    const column = index % 8;
    return row % 2 === 0
      ? column % 2 === 0
        ? 'sword'
        : 'peach'
      : column % 2 === 0
      ? 'heart'
      : 'water';
  });
}

function wildcardBoard(): Board {
  const bases: Board = ['sword', 'peach', 'heart', 'water', 'shield', 'lightning'];
  return Array.from({ length: 64 }, (_, index) => {
    const row = Math.floor(index / 8);
    const column = index % 8;
    return bases[(column + row * 2) % bases.length];
  });
}

describe('Flying Dart', () => {
  it('creates a horizontal dart from five Water tiles', () => {
    const board = stripedBoard();
    [49, 50, 51, 52, 53].forEach((index) => {
      board[index] = 'water';
    });
    [41, 45, 57, 61].forEach((index) => {
      board[index] = 'shield';
    });
    expect(findFlyingDartCreation(board, [51])).toEqual({
      index: 51,
      type: 'flyingDartHorizontal',
    });
  });

  it('creates a vertical dart from five Water tiles', () => {
    const board = stripedBoard();
    [12, 20, 28, 36, 44].forEach((index) => {
      board[index] = 'water';
    });
    expect(findFlyingDartCreation(board, [28])).toEqual({
      index: 28,
      type: 'flyingDartVertical',
    });
  });

  it('clears its full line and chains another dart once', () => {
    const board = stripedBoard();
    board[26] = 'flyingDartHorizontal';
    board[29] = 'flyingDartVertical';
    const plan = computeExplosions(board, new Set([26]));
    expect(plan.dartActivations).toEqual([
      { source: 26, axis: 'horizontal' },
      { source: 29, axis: 'vertical' },
    ]);
    expect(plan.exploded).toEqual([5, 13, 21, 24, 25, 27, 28, 29, 30, 31, 37, 45, 53, 61]);
  });

  it('acts as a wildcard for swords and clears its horizontal row', () => {
    const board = wildcardBoard();
    board[50] = 'sword';
    board[51] = 'sword';
    board[52] = 'flyingDartHorizontal';
    board[53] = 'shield';

    const match = findMatches(board);
    expect(match).not.toBeNull();
    expect([...match!.cells].sort((a, b) => a - b)).toEqual([50, 51, 52]);
    expect(match!.counts.sword).toBe(2);
    expect(match!.counts.flyingDartHorizontal).toBe(1);
    expect(match!.maxRun).toBe(3);

    const plan = computeExplosions(board, match!.cells, () => 0);
    expect(plan.dartActivations).toEqual([{ source: 52, axis: 'horizontal' }]);
    expect(plan.exploded).toEqual([48, 49, 53, 54, 55]);
  });

  it('acts as a wildcard for hearts and clears its vertical column', () => {
    const board = wildcardBoard();
    board[18] = 'heart';
    board[26] = 'heart';
    board[34] = 'flyingDartVertical';

    const match = findMatches(board);
    expect(match).not.toBeNull();
    expect([...match!.cells].sort((a, b) => a - b)).toEqual([18, 26, 34]);
    expect(match!.counts.heart).toBe(2);
    expect(match!.counts.flyingDartVertical).toBe(1);
    expect(match!.maxRun).toBe(3);

    const plan = computeExplosions(board, match!.cells, () => 0);
    expect(plan.dartActivations).toEqual([{ source: 34, axis: 'vertical' }]);
    expect(plan.exploded).toEqual([2, 10, 42, 50, 58]);
  });

  it('triggers Fire Sword and Lightning caught by its sweep', () => {
    const board = wildcardBoard();
    board[50] = 'sword';
    board[51] = 'sword';
    board[52] = 'flyingDartHorizontal';
    board[53] = 'shield';
    board[54] = 'fireSword';
    board[55] = 'lightning';

    const match = findMatches(board);
    expect(match).not.toBeNull();
    const plan = computeExplosions(board, match!.cells, () => 0);

    expect(plan.dartActivations).toEqual([{ source: 52, axis: 'horizontal' }]);
    expect(plan.fireSwordActivations).toEqual([54]);
    expect(plan.lightningArcs.map((arc) => arc.source)).toEqual([47, 55]);
    expect(plan.exploded).toEqual(
      expect.arrayContaining([0, 45, 46, 47, 48, 49, 53, 54, 55, 60, 61, 62, 63]),
    );
  });

  it('does not chain a Fire Sword caught by another Fire Sword blast', () => {
    const board = stripedBoard();
    board[27] = 'fireSword';
    board[28] = 'fireSword';

    const plan = computeExplosions(board, new Set([27]), () => 0);

    expect(plan.fireSwordActivations).toEqual([27]);
    expect(plan.exploded).toEqual([18, 19, 20, 26, 28, 34, 35, 36]);
  });

  it.each([3, 4, 5])('accepts a wildcard in a %i-tile run', (length) => {
    const board = wildcardBoard();
    const start = 56;
    for (let offset = 0; offset < length; offset++) board[start + offset] = 'shield';
    board[start + length - 1] = 'flyingDartHorizontal';

    const match = findMatches(board);
    expect(match).not.toBeNull();
    expect([...match!.cells].sort((a, b) => a - b)).toEqual(
      Array.from({ length }, (_, offset) => start + offset),
    );
    expect(match!.maxRun).toBe(length);
  });

  it('rejects mixed bases and more than one dart in the same run', () => {
    const mixed = wildcardBoard();
    mixed[56] = 'sword';
    mixed[57] = 'flyingDartHorizontal';
    mixed[58] = 'heart';
    expect(findMatches(mixed)).toBeNull();

    const multipleDarts = wildcardBoard();
    multipleDarts[56] = 'sword';
    multipleDarts[57] = 'flyingDartHorizontal';
    multipleDarts[58] = 'flyingDartVertical';
    expect(findMatches(multipleDarts)).toBeNull();
  });

  it('counts a dart that falls into a new vertical run on the next cascade', () => {
    const board = wildcardBoard();
    board[18] = 'flyingDartVertical';

    // Before gravity: Heart - Shield - Dart - Heart, so there is no run.
    expect(findMatches(board)).toBeNull();

    applyGravity(board, new Set([10]), () => 0.8);

    // Removing the Shield makes the Dart fall between the two Hearts.
    expect(board[10]).toBe('heart');
    expect(board[18]).toBe('flyingDartVertical');
    expect(board[26]).toBe('heart');
    const match = findMatches(board);
    expect(match).not.toBeNull();
    expect([...match!.cells]).toEqual(expect.arrayContaining([10, 18, 26]));

    const plan = computeExplosions(board, match!.cells, () => 0);
    expect(plan.dartActivations).toEqual([{ source: 18, axis: 'vertical' }]);
  });
});
