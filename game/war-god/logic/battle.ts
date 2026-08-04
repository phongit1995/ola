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
export const FIRE_SWORD_DMG = 8;
export const GREATER_HEART_HEAL = 8;

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
  armorDamage?: number;
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
  const summary: EffectSummary = { damage: 0, heal: 0, mana: 0, armor: 0, armorDamage: 0 };

  const physical = counts.sword * DMG_SWORD + counts.stone * DMG_STONE;
  if (physical > 0) {
    const absorbed = Math.min(defender.armor, physical);
    defender.armor -= absorbed;
    summary.armorDamage = absorbed;
    const dealt = physical - absorbed;
    defender.hp = Math.max(0, defender.hp - dealt);
    summary.damage += dealt;
  }

  const magic = counts.fire * DMG_FIRE + counts.fireSword * FIRE_SWORD_DMG;
  if (magic > 0) {
    defender.hp = Math.max(0, defender.hp - magic);
    summary.damage += magic;
  }

  const healing = counts.heart * HEAL_HEART + counts.greaterHeart * GREATER_HEART_HEAL;
  if (healing > 0) {
    const healed = Math.min(MAX_HP - attacker.hp, healing);
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

export function applyAuthoritativeEffects(
  attacker: Fighter,
  defender: Fighter,
  effects: EffectSummary,
): EffectSummary {
  defender.hp = Math.max(0, defender.hp - effects.damage);
  defender.armor = Math.max(0, defender.armor - (effects.armorDamage ?? 0));
  attacker.hp = Math.min(MAX_HP, attacker.hp + effects.heal);
  attacker.mp = Math.min(MAX_MP, attacker.mp + effects.mana);
  attacker.armor = Math.min(MAX_ARMOR, attacker.armor + effects.armor);
  return effects;
}

export type BotLevel = 'easy' | 'normal' | 'hard';

export const LEVEL_LABELS: Record<BotLevel, string> = {
  easy: 'DỄ',
  normal: 'VỪA',
  hard: 'KHÓ',
};

export function botChooseMove(
  board: Board,
  bot: Fighter,
  player: Fighter,
  level: BotLevel = 'normal',
): [number, number] | null {
  const moves = findValidMoves(board);
  if (moves.length === 0) return null;

  if (level === 'easy') {
    return moves[Math.floor(Math.random() * moves.length)];
  }

  const heartWeight = bot.hp >= MAX_HP ? 0.2 : bot.hp <= 50 ? 6.5 : 1.5;
  const greaterHeartWeight = bot.hp >= MAX_HP ? 0.3 : bot.hp <= 50 ? 9 : 3;
  const shieldWeight = bot.armor >= MAX_ARMOR ? 0.2 : bot.hp <= 60 ? 4.5 : 2.5;
  const waterWeight = bot.mp >= ULT_COST ? 1 : 5;
  const attackWeight = player.hp <= 25 ? 1.25 : 1;
  const comboBonus = level === 'hard' ? 14 : 8;
  const jitter = level === 'hard' ? 0 : 2;

  let best: [number, number] = moves[0];
  let bestScore = -1;

  for (const move of moves) {
    swapCells(board, move[0], move[1]);
    const match = findMatches(board);
    swapCells(board, move[0], move[1]);
    if (!match) continue;

    const c = match.counts;
    let score =
      (c.sword * 5 +
        c.fire * 4.5 +
        c.fireSword * FIRE_SWORD_DMG +
        c.stone * 2) *
        attackWeight +
      c.heart * heartWeight +
      c.greaterHeart * greaterHeartWeight +
      c.water * waterWeight +
      c.shield * shieldWeight;
    if (match.maxRun >= 4) score += comboBonus;
    score += Math.random() * jitter;

    if (score > bestScore) {
      bestScore = score;
      best = move;
    }
  }

  return best;
}

export function botShouldUlt(bot: Fighter, player: Fighter, level: BotLevel): boolean {
  if (bot.mp < ULT_COST) return false;
  if (level === 'easy') return player.hp <= ULT_DMG + 5 || Math.random() < 0.2;
  if (level === 'hard') return true;
  return player.hp <= ULT_DMG + 10 || Math.random() < 0.5;
}
