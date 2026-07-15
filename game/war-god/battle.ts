import {
  findMatches,
  findValidMoves,
  swapCells,
  type Board,
  type TileType,
} from './core';

export const MAX_HP = 100;
export const MAX_MP = 100;
export const MAX_ARMOR = 30;
export const ULT_COST = 50;
export const ULT_DMG = 25;

export interface Fighter {
  hp: number;
  mp: number;
  armor: number;
}

export function createFighter(): Fighter {
  return { hp: MAX_HP, mp: 0, armor: 0 };
}

export interface EffectSummary {
  damage: number;
  heal: number;
  mana: number;
  armor: number;
}

const DMG_SWORD = 5;
const DMG_FIRE = 4;
const DMG_STONE = 3;
const HEAL_HEART = 4;
const MP_WATER = 7;
const ARMOR_SHIELD = 4;

export function applyTileEffects(
  attacker: Fighter,
  defender: Fighter,
  counts: Record<TileType, number>,
): EffectSummary {
  const summary: EffectSummary = { damage: 0, heal: 0, mana: 0, armor: 0 };

  const physical = counts.sword * DMG_SWORD + counts.stone * DMG_STONE;
  if (physical > 0) {
    const absorbed = Math.min(defender.armor, physical);
    defender.armor -= absorbed;
    const dealt = physical - absorbed;
    defender.hp = Math.max(0, defender.hp - dealt);
    summary.damage += dealt;
  }

  const magic = counts.fire * DMG_FIRE;
  if (magic > 0) {
    defender.hp = Math.max(0, defender.hp - magic);
    summary.damage += magic;
  }

  if (counts.heart > 0) {
    const healed = Math.min(MAX_HP - attacker.hp, counts.heart * HEAL_HEART);
    attacker.hp += healed;
    summary.heal = healed;
  }

  if (counts.water > 0) {
    const gained = Math.min(MAX_MP - attacker.mp, counts.water * MP_WATER);
    attacker.mp += gained;
    summary.mana = gained;
  }

  if (counts.shield > 0) {
    const added = Math.min(MAX_ARMOR - attacker.armor, counts.shield * ARMOR_SHIELD);
    attacker.armor += added;
    summary.armor = added;
  }

  return summary;
}

export function castUltimate(attacker: Fighter, defender: Fighter): number {
  attacker.mp -= ULT_COST;
  defender.hp = Math.max(0, defender.hp - ULT_DMG);
  return ULT_DMG;
}

export function botChooseMove(
  board: Board,
  bot: Fighter,
  player: Fighter,
): [number, number] | null {
  const moves = findValidMoves(board);
  if (moves.length === 0) return null;

  const heartWeight = bot.hp <= 50 ? 6.5 : 1.5;
  const waterWeight = bot.mp >= ULT_COST ? 1 : 5;

  let best: [number, number] = moves[0];
  let bestScore = -1;

  for (const move of moves) {
    swapCells(board, move[0], move[1]);
    const match = findMatches(board);
    swapCells(board, move[0], move[1]);
    if (!match) continue;

    const c = match.counts;
    let score =
      c.sword * 5 +
      c.fire * 4.5 +
      c.stone * 2 +
      c.heart * heartWeight +
      c.water * waterWeight +
      c.shield * (player.hp > 60 ? 3.5 : 2);
    if (match.maxRun >= 4) score += 8;
    score += Math.random() * 2;

    if (score > bestScore) {
      bestScore = score;
      best = move;
    }
  }

  return best;
}
