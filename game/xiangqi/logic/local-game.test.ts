import { describe, expect, it } from 'vitest';
import { SIDE_BLACK, SIDE_RED, boardIdx, parseBoardRows } from './board';
import { applyLocalMove, createLocalGame } from './local-game';

describe('local Xiangqi game', () => {
  it('applies a legal move without mutating the previous state', () => {
    const state = createLocalGame();
    const before = [...state.board];
    const result = applyLocalMove(state, SIDE_RED, boardIdx(1, 2), boardIdx(4, 2));

    expect(state.board).toEqual(before);
    expect(result.state.moveCount).toBe(1);
    expect(result.state.lastFrom).toBe(boardIdx(1, 2));
    expect(result.state.lastTo).toBe(boardIdx(4, 2));
    expect(result.state.result).toBeNull();
  });

  it('recognizes a discovered cannon check reached from the starting board', () => {
    const moves = [
      [boardIdx(1, 2), boardIdx(4, 2)],
      [boardIdx(0, 6), boardIdx(0, 5)],
      [boardIdx(4, 3), boardIdx(4, 4)],
      [boardIdx(2, 6), boardIdx(2, 5)],
      [boardIdx(4, 4), boardIdx(4, 5)],
      [boardIdx(6, 6), boardIdx(6, 5)],
      [boardIdx(4, 5), boardIdx(4, 6)],
    ] as const;
    let state = createLocalGame();
    let checked = false;
    for (const [from, to] of moves) {
      const applied = applyLocalMove(state, state.moveCount % 2, from, to);
      state = applied.state;
      checked = applied.checked;
    }
    expect(checked).toBe(true);
    expect(state.check).toBe(true);
    expect(state.result).toBeNull();
  });

  it('rejects an out-of-turn or illegal move', () => {
    const state = createLocalGame();
    expect(() => applyLocalMove(state, SIDE_BLACK, boardIdx(0, 9), boardIdx(0, 8))).toThrow('Chưa đến lượt');
    expect(() => applyLocalMove(state, SIDE_RED, boardIdx(4, 0), boardIdx(4, 2))).toThrow('Nước đi không hợp lệ');
  });

  it('adjudicates checkmate like the server', () => {
    const board = parseBoardRows([
      '....K....',
      '.r.......',
      '..h......',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.....k...',
    ]);
    const state = createLocalGame(board, SIDE_BLACK);
    const result = applyLocalMove(state, SIDE_BLACK, boardIdx(1, 1), boardIdx(4, 1));
    expect(result.state.result).toEqual({ winner: SIDE_BLACK, reason: 'checkmate' });
  });

  it('terminates defensively if a legacy edge state captures a general', () => {
    const board = parseBoardRows([
      '...K.....',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '....R....',
      '....k....',
    ]);
    const state = createLocalGame(board, SIDE_RED);
    const result = applyLocalMove(state, SIDE_RED, boardIdx(4, 8), boardIdx(4, 9));
    expect(result.state.result).toEqual({ winner: SIDE_RED, reason: 'checkmate' });
  });

  it('draws on the third repeated position', () => {
    const board = parseBoardRows([
      '...K....R',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.........',
      '.....k..r',
    ]);
    let state = createLocalGame(board);
    const cycle = [
      [boardIdx(8, 0), boardIdx(8, 1)],
      [boardIdx(8, 9), boardIdx(8, 8)],
      [boardIdx(8, 1), boardIdx(8, 0)],
      [boardIdx(8, 8), boardIdx(8, 9)],
    ] as const;
    for (let round = 0; round < 2; round++) {
      for (const [from, to] of cycle) {
        const side = state.moveCount % 2;
        state = applyLocalMove(state, side, from, to).state;
      }
    }
    expect(state.result).toEqual({ winner: null, reason: 'repetition' });
  });
});
