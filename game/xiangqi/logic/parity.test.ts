import { describe, expect, it } from 'vitest';
import parity from '../../../server/internal/game/games/xiangqi/testdata/parity.json';
import { positionKey } from './board';
import { generalsFacing, inCheck, legalMovesFrom, terminalKind } from './moves';
import { BOARD_CELLS, REPETITION_LIMIT, START_BOARD, TURN_SECONDS } from './constants.gen';

describe('xiangqi parity fixture', () => {
  it('has the expected shape', () => {
    expect(parity.version).toBe(1);
    expect(parity.legalMoves.length).toBeGreaterThan(10);
    expect(TURN_SECONDS).toBe(60);
    expect(REPETITION_LIMIT).toBe(3);
    expect(START_BOARD.length).toBe(BOARD_CELLS);
  });

  for (const [index, test] of parity.legalMoves.entries()) {
    it(`legalMoves case ${index} from ${test.from}`, () => {
      expect(legalMovesFrom(test.board, test.from)).toEqual(test.want);
    });
  }

  for (const [index, test] of parity.inCheck.entries()) {
    it(`inCheck case ${index}`, () => {
      expect(inCheck(test.board, test.side)).toBe(test.want);
    });
  }

  for (const [index, test] of parity.facing.entries()) {
    it(`facing case ${index}`, () => {
      expect(generalsFacing(test.board)).toBe(test.want);
    });
  }

  for (const [index, test] of parity.terminal.entries()) {
    it(`terminal case ${index}`, () => {
      expect(terminalKind(test.board, test.side)).toBe(test.want);
    });
  }

  for (const [index, test] of parity.positionKeys.entries()) {
    it(`position key case ${index}`, () => {
      expect(positionKey(test.board, test.side)).toBe(test.key);
    });
  }
});
