import { describe, expect, it } from 'vitest';
import { START_BOARD } from './constants.gen';
import { EMPTY, SIDE_BLACK, SIDE_RED, parseBoardRows } from './board';
import { chooseBotMove, legalMovesForSide, type BotDifficulty } from './bot';
import { terminalKind } from './moves';

function play(board: readonly number[], from: number, to: number): number[] {
  const next = [...board];
  next[to] = next[from];
  next[from] = EMPTY;
  return next;
}

describe('Xiangqi bot', () => {
  for (const difficulty of ['easy', 'medium', 'hard'] as BotDifficulty[]) {
    it(`${difficulty} always returns a legal opening move`, () => {
      const legal = legalMovesForSide(START_BOARD, SIDE_RED);
      const move = chooseBotMove(START_BOARD, SIDE_RED, difficulty, () => 0);
      expect(move).not.toBeNull();
      expect(legal).toContainEqual(move);
    });
  }

  it('takes a forced mate in one on hard difficulty', () => {
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
    const move = chooseBotMove(board, SIDE_BLACK, 'hard', () => 0);
    expect(move).not.toBeNull();
    expect(terminalKind(play(board, move!.from, move!.to), SIDE_RED)).toBe('checkmate');
  });
});
