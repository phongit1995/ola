import { expect, it } from 'vitest';
import {
  applyTileEffects,
  botChooseMove,
  botShouldUlt,
  castUltimate,
  createFighter,
  decayArmor,
  type BotLevel,
  type Fighter,
} from './battle';
import {
  applyGravity,
  computeExplosions,
  createBoard,
  findMatches,
  findValidMoves,
  swapCells,
  type Board,
} from './core';

function lcg(seed: number): () => number {
  let value = seed >>> 0;
  return () => {
    value = (Math.imul(value, 1664525) + 1013904223) >>> 0;
    return value / 0x1_0000_0000;
  };
}

function resolve(board: Board, attacker: Fighter, defender: Fighter, random: () => number): number {
  let bonus = 0;
  for (let wave = 0; wave < 32; wave++) {
    const match = findMatches(board);
    if (!match) break;
    bonus += match.bonusTurns;
    const plan = computeExplosions(board, match.cells, random);
    for (const index of plan.exploded) match.counts[board[index]]++;
    const removed = new Set(match.cells);
    for (const index of plan.exploded) removed.add(index);
    applyTileEffects(attacker, defender, match.counts);
    applyGravity(board, removed, random);
    if (attacker.hp <= 0 || defender.hp <= 0) break;
  }
  return bonus;
}

function play(seed: number, first: BotLevel, second: BotLevel): 0 | 1 | null {
  const random = lcg(seed);
  let board = createBoard(random);
  const fighters = [createFighter(), createFighter()];
  const levels = [first, second];
  const extra = [0, 0];
  let side = 0;
  for (let action = 0; action < 300; action++) {
    const attacker = fighters[side];
    const defender = fighters[1 - side];
    if (extra[side] > 0) extra[side]--;
    decayArmor(attacker);
    if (botShouldUlt(attacker, defender, levels[side])) {
      castUltimate(attacker, defender);
    } else {
      const move = botChooseMove(board, attacker, defender, levels[side]);
      if (!move) {
        board = createBoard(random);
        action--;
        continue;
      }
      swapCells(board, move[0], move[1]);
      extra[side] += resolve(board, attacker, defender, random);
      if (findValidMoves(board).length === 0) board = createBoard(random);
    }
    if (defender.hp <= 0) return side as 0 | 1;
    if (attacker.hp <= 0) return (1 - side) as 0 | 1;
    if (extra[side] === 0) side = 1 - side;
  }
  return null;
}

it('keeps expert measurably stronger than hard across seeded matches', () => {
  let expertWins = 0;
  let hardWins = 0;
  let draws = 0;
  for (let seed = 1; seed <= 8; seed++) {
    const expertFirst = seed % 2 === 0;
    const winner = play(seed, expertFirst ? 'expert' : 'hard', expertFirst ? 'hard' : 'expert');
    if (winner == null) draws++;
    else if ((winner === 0) === expertFirst) expertWins++;
    else hardWins++;
  }
  expect(draws).toBe(0);
  expect(expertWins).toBeGreaterThan(hardWins);
  expect(expertWins).toBeGreaterThanOrEqual(5);
});
