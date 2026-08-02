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
export const GREATER_HEART_MIN_TILES = 4;

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

export type SpecialType = 'fireSword' | 'greaterHeart';

export interface SpecialEffect {
  type: SpecialType;
  damage: number;
  heal: number;
}

export interface SpecialProgress {
  sawSword: boolean;
  sawFire: boolean;
  heartTiles: number;
  fireSwordUsed: boolean;
  greaterHeartUsed: boolean;
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

export function createSpecialProgress(): SpecialProgress {
  return {
    sawSword: false,
    sawFire: false,
    heartTiles: 0,
    fireSwordUsed: false,
    greaterHeartUsed: false,
  };
}

export function observeSpecialProgress(
  progress: SpecialProgress,
  counts: Partial<Record<TileType, number>>,
): void {
  progress.sawSword ||= (counts.sword ?? 0) > 0;
  progress.sawFire ||= (counts.fire ?? 0) > 0;
  progress.heartTiles += counts.heart ?? 0;
}

export function applyAvailableSpecials(
  progress: SpecialProgress,
  attacker: Fighter,
  defender: Fighter,
): SpecialEffect[] {
  const effects: SpecialEffect[] = [];
  if (defender.hp <= 0) return effects;
  if (!progress.fireSwordUsed && progress.sawSword && progress.sawFire) {
    progress.fireSwordUsed = true;
    defender.hp = Math.max(0, defender.hp - FIRE_SWORD_DMG);
    effects.push({ type: 'fireSword', damage: FIRE_SWORD_DMG, heal: 0 });
  }
  if (defender.hp <= 0) return effects;
  if (
    !progress.greaterHeartUsed &&
    progress.heartTiles >= GREATER_HEART_MIN_TILES &&
    attacker.hp < MAX_HP
  ) {
    progress.greaterHeartUsed = true;
    const healed = Math.min(GREATER_HEART_HEAL, MAX_HP - attacker.hp);
    attacker.hp += healed;
    effects.push({ type: 'greaterHeart', damage: 0, heal: healed });
  }
  return effects;
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

  const heartWeight = bot.hp <= 50 ? 6.5 : 1.5;
  const waterWeight = bot.mp >= ULT_COST ? 1 : 5;
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
      c.sword * 5 +
      c.fire * 4.5 +
      c.stone * 2 +
      c.heart * heartWeight +
      c.water * waterWeight +
      c.shield * (player.hp > 60 ? 3.5 : 2);
    if (match.maxRun >= 4) score += comboBonus;
    if (c.sword > 0 && c.fire > 0) score += FIRE_SWORD_DMG;
    if (c.heart >= GREATER_HEART_MIN_TILES && bot.hp < MAX_HP) {
      score += Math.min(GREATER_HEART_HEAL, MAX_HP - bot.hp);
    }
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
