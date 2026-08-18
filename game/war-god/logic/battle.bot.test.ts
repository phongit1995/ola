import { describe, expect, it } from 'vitest';
import {
  BOT_LEVEL_TITLES,
  LEVEL_LABELS,
  botChooseMove,
  botShouldUlt,
  createFighter,
} from './battle';
import { createBoard, findMatches, findValidMoves, swapCells, type Board } from './core';

function lcg(seed: number): () => number {
  let state = seed >>> 0;
  return () => {
    state = (Math.imul(state, 1664525) + 1013904223) >>> 0;
    return state / 0x1_0000_0000;
  };
}

function isImmediateAttack(board: Board, move: [number, number]): boolean {
  const next = [...board];
  swapCells(next, move[0], move[1]);
  const match = findMatches(next);
  return match != null && match.counts.sword + match.counts.fireSword > 0;
}

describe('War God expert bot', () => {
  it('exposes the SIÊU KHÓ difficulty label', () => {
    expect(LEVEL_LABELS.expert).toBe('SIÊU KHÓ');
    expect(BOT_LEVEL_TITLES).toEqual({
      easy: 'Dễ',
      normal: 'Vừa',
      hard: 'Khó',
      expert: 'Siêu khó',
    });
  });

  it('chooses a deterministic valid move without mutating combat state', () => {
    const board = createBoard(lcg(20260818));
    const before = [...board];
    const bot = { ...createFighter(), hp: 84, mp: 63, armor: 12, fury: 70 };
    const player = { ...createFighter(), hp: 112, armor: 18 };
    const beforeBot = { ...bot };
    const beforePlayer = { ...player };

    const first = botChooseMove(board, bot, player, 'expert');
    const second = botChooseMove(board, bot, player, 'expert');

    expect(first).not.toBeNull();
    expect(second).toEqual(first);
    expect(findValidMoves(board)).toContainEqual(first);
    expect(board).toEqual(before);
    expect(bot).toEqual(beforeBot);
    expect(player).toEqual(beforePlayer);
  });

  it('takes an immediate finishing attack when one is available', () => {
    let scenario: Board | null = null;
    for (let seed = 1; seed <= 80; seed++) {
      const board = createBoard(lcg(seed));
      const moves = findValidMoves(board);
      if (
        moves.some((move) => isImmediateAttack(board, move)) &&
        moves.some((move) => !isImmediateAttack(board, move))
      ) {
        scenario = board;
        break;
      }
    }
    expect(scenario).not.toBeNull();

    const move = botChooseMove(scenario!, createFighter(), { ...createFighter(), hp: 1 }, 'expert');
    expect(move).not.toBeNull();
    expect(isImmediateAttack(scenario!, move!)).toBe(true);
  });

  it('only casts the ultimate when mana is ready and always closes a lethal line', () => {
    const bot = createFighter();
    const player = createFighter();
    bot.mp = 99;
    expect(botShouldUlt(bot, player, 'expert')).toBe(false);
    bot.mp = 100;
    expect(botShouldUlt(bot, player, 'expert')).toBe(true);
    player.hp = 40;
    expect(botShouldUlt(bot, player, 'expert')).toBe(true);
  });
});
