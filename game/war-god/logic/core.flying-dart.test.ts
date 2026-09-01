import { describe, expect, it } from 'vitest';
import {
  applyGravity,
  computeExplosions,
  expandDartTriggeredSpecials,
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
    expect(findFlyingDartCreation(board, [51], [49, 50, 51, 52, 53])).toEqual({
      index: 51,
      type: 'flyingDartHorizontal',
    });
  });

  it('creates a vertical dart from five Water tiles', () => {
    const board = stripedBoard();
    [12, 20, 28, 36, 44].forEach((index) => {
      board[index] = 'water';
    });
    expect(findFlyingDartCreation(board, [28], [12, 20, 28, 36, 44])).toEqual({
      index: 28,
      type: 'flyingDartVertical',
    });
  });

  it.each([
    {
      name: 'L shape',
      cells: [11, 19, 27, 28, 29],
      pivot: 27,
    },
    {
      name: 'T shape',
      cells: [11, 19, 26, 27, 28],
      pivot: 27,
    },
  ])('$name creates a cross dart at the intersection', ({ cells, pivot }) => {
    const board: Board = [
      ['sword', 'sword', 'peach', 'peach', 'heart', 'heart', 'sword', 'sword'],
      ['water', 'water', 'shield', 'shield', 'lightning', 'lightning', 'water', 'water'],
      ['peach', 'peach', 'heart', 'heart', 'sword', 'sword', 'peach', 'peach'],
      ['shield', 'shield', 'lightning', 'lightning', 'water', 'water', 'shield', 'shield'],
      ['heart', 'heart', 'sword', 'sword', 'peach', 'peach', 'heart', 'heart'],
      ['lightning', 'lightning', 'water', 'water', 'shield', 'shield', 'lightning', 'lightning'],
      ['sword', 'sword', 'peach', 'peach', 'heart', 'heart', 'sword', 'sword'],
      ['water', 'water', 'shield', 'shield', 'lightning', 'lightning', 'water', 'water'],
    ].flat() as Board;
    board[29] = 'lightning';
    cells.forEach((index) => {
      board[index] = 'water';
    });
    const match = findMatches(board);
    expect(match).not.toBeNull();
    expect([...match!.cells].sort((a, b) => a - b)).toEqual(cells);
    expect(match!.maxRun).toBe(3);
    expect(findFlyingDartCreation(board, [cells[0]!], match!.cells)).toEqual({
      index: pivot,
      type: 'flyingDartCross',
    });
  });

  it('prefers the L/T component touched by the swap over a larger unrelated shape', () => {
    const board: Board = Array.from({ length: 64 }, () => 'shield');
    const smallL = [9, 17, 25, 26, 27];
    const largerL = [36, 37, 38, 45, 53, 61];
    const matched = [...smallL, ...largerL];
    matched.forEach((index) => {
      board[index] = 'water';
    });
    expect(findFlyingDartCreation(board, [27], matched)).toEqual({
      index: 25,
      type: 'flyingDartCross',
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

  it('clears both the row and column for a cross dart', () => {
    const board = wildcardBoard();
    board[26] = 'sword';
    board[27] = 'flyingDartCross';
    board[28] = 'sword';
    const match = findMatches(board);
    expect(match).not.toBeNull();
    expect([...match!.cells].sort((a, b) => a - b)).toEqual([26, 27, 28]);
    const plan = computeExplosions(board, match!.cells, () => 0);
    expect(plan.dartActivations).toEqual([{ source: 27, axis: 'cross' }]);
    expect(plan.lightningArcs.length).toBeGreaterThan(0);
    const removed = new Set([...match!.cells, ...plan.exploded]);
    for (let column = 0; column < 8; column++) {
      expect(removed.has(3 * 8 + column)).toBe(true);
    }
    for (let row = 0; row < 8; row++) {
      expect(removed.has(row * 8 + 3)).toBe(true);
    }
    expect(plan.exploded).not.toContain(27);
  });

  it('activates Fire Swords on both cross axes during an ultimate sweep', () => {
    const board = stripedBoard();
    board[27] = 'flyingDartCross';
    board[11] = 'fireSword';
    board[29] = 'fireSword';
    const affected = new Set([27]);
    const result = expandDartTriggeredSpecials(board, affected);
    expect(result.dartActivations).toEqual([{ source: 27, axis: 'cross' }]);
    expect(result.fireSwordActivations).toEqual([11, 29]);
    expect(affected.has(3)).toBe(true);
    expect(affected.has(31)).toBe(true);
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
