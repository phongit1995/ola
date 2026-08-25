import { expect, it } from 'vitest';
import {
  LIGHTNING_GOD_DAMAGE,
  applyDamageThroughArmor,
  applyTileEffects,
  botChooseMove,
  botChooseUltimateSkill,
  botShouldUlt,
  castUltimate,
  createFighter,
  grantExtraTurns,
  type BotLevel,
  type Fighter,
} from './battle';
import {
  applyGravity,
  computeLightningArcs,
  computeExplosions,
  createBoard,
  emptyCounts,
  findMatches,
  findValidMoves,
  randomFourTwoByTwoBlocks,
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

function resolve(
  board: Board,
  attacker: Fighter,
  defender: Fighter,
  random: () => number,
  startingCascadeLevel = 0,
  furyChain: { active: boolean } = { active: false },
): number {
  let bonus = 0;
  let cascadeLevel = startingCascadeLevel;
  for (let wave = 0; wave < 32; wave++) {
    const match = findMatches(board);
    if (!match) break;
    bonus += match.bonusTurns;
    const plan = computeExplosions(board, match.cells, random);
    for (const index of plan.exploded) match.counts[board[index]]++;
    const removed = new Set(match.cells);
    for (const index of plan.exploded) removed.add(index);
    applyTileEffects(attacker, defender, match.counts, cascadeLevel, furyChain);
    applyGravity(board, removed, random);
    cascadeLevel++;
    if (attacker.hp <= 0 || defender.hp <= 0) break;
  }
  return bonus;
}

function castLightningGod(
  board: Board,
  attacker: Fighter,
  defender: Fighter,
  random: () => number,
): number {
  attacker.mp = 0;
  applyDamageThroughArmor(defender, LIGHTNING_GOD_DAMAGE);
  const cells = randomFourTwoByTwoBlocks(random).flat();
  const removed = new Set(cells);
  const lightningArcs = computeLightningArcs(board, cells, removed, random);
  for (const arc of lightningArcs) removed.add(arc.target);
  const counts = emptyCounts();
  for (const index of removed) counts[board[index]]++;
  const furyChain = { active: false };
  applyTileEffects(attacker, defender, counts, 0, furyChain);
  applyGravity(board, removed, random);
  if (attacker.hp <= 0 || defender.hp <= 0) return 0;
  return resolve(board, attacker, defender, random, 1, furyChain);
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
    if (botShouldUlt(attacker, defender, levels[side])) {
      const skill = botChooseUltimateSkill(attacker, defender, levels[side]);
      if (skill === 'lightning-god') {
        extra[side] = grantExtraTurns(
          extra[side],
          castLightningGod(board, attacker, defender, random),
        ).remaining;
      } else {
        castUltimate(attacker, defender);
      }
    } else {
      const move = botChooseMove(board, attacker, defender, levels[side]);
      if (!move) {
        board = createBoard(random);
        action--;
        continue;
      }
      swapCells(board, move[0], move[1]);
      extra[side] = grantExtraTurns(
        extra[side],
        resolve(board, attacker, defender, random),
      ).remaining;
    }
    if (attacker.hp > 0 && defender.hp > 0 && findValidMoves(board).length === 0) {
      board = createBoard(random);
    }
    if (defender.hp <= 0) return side as 0 | 1;
    if (attacker.hp <= 0) return (1 - side) as 0 | 1;
    if (extra[side] === 0) side = 1 - side;
  }
  return null;
}

it('keeps expert measurably stronger than hard across seeded matches with skill selection', () => {
  let expertWins = 0;
  let hardWins = 0;
  let draws = 0;
  for (let seed = 1; seed <= 16; seed++) {
    const expertFirst = seed % 2 === 0;
    const winner = play(seed, expertFirst ? 'expert' : 'hard', expertFirst ? 'hard' : 'expert');
    if (winner == null) draws++;
    else if ((winner === 0) === expertFirst) expertWins++;
    else hardWins++;
  }
  expect(draws).toBe(0);
  expect(expertWins).toBeGreaterThan(hardWins);
  expect(expertWins).toBeGreaterThanOrEqual(9);
}, 20_000);
