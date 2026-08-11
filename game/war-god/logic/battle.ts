import {
  computeExplosions,
  findMatches,
  findValidMoves,
  swapCells,
  type Board,
  type TileType,
} from './core';
import {
  ARMOR_DECAY,
  ARMOR_SHIELD,
  DMG_SWORD,
  FIRE_SWORD_DMG,
  FURY_PEACH,
  GREATER_HEART_HEAL,
  HEAL_HEART,
  MAX_ARMOR,
  MAX_FURY,
  MAX_HP,
  MAX_MP,
  MP_WATER,
  REFLECT_DAMAGE,
  REFLECT_THRESHOLD,
  ULT_COST,
} from './constants.gen';

export {
  ARMOR_DECAY,
  FIRE_SWORD_DMG,
  GREATER_HEART_HEAL,
  MAX_ARMOR,
  MAX_FURY,
  MAX_HP,
  MAX_MP,
  REFLECT_DAMAGE,
  REFLECT_THRESHOLD,
  ULT_COST,
} from './constants.gen';

export interface Fighter {
  hp: number;
  mp: number;
  armor: number;
  fury: number;
}

export function createFighter(): Fighter {
  return { hp: MAX_HP, mp: 0, armor: 0, fury: 0 };
}

export interface EffectSummary {
  damage: number;
  heal: number;
  mana: number;
  armor: number;
  armorDamage?: number;
  fury?: number;
  furied?: boolean;
  reflect?: number;
}

export function decayArmor(f: Fighter): void {
  f.armor = Math.max(0, f.armor - ARMOR_DECAY);
}

export function applyTileEffects(
  attacker: Fighter,
  defender: Fighter,
  counts: Record<TileType, number>,
): EffectSummary {
  const summary: EffectSummary = { damage: 0, heal: 0, mana: 0, armor: 0, armorDamage: 0, fury: 0 };
  const defenderArmorBefore = defender.armor;

  let swordDmg = counts.sword * DMG_SWORD;
  let fireDmg = counts.fireSword * FIRE_SWORD_DMG;

  // Nộ chỉ ×2 khi đã đầy TỪ TRƯỚC wave. Đào ăn trong chính wave này chỉ
  // nạp Nộ cho các đòn Kiếm sau, không tự kích hoạt ×2 ngay.
  let furied = false;
  if (attacker.fury >= MAX_FURY && (swordDmg > 0 || fireDmg > 0)) {
    swordDmg *= 2;
    fireDmg *= 2;
    attacker.fury = 0;
    furied = true;
    summary.furied = true;
  }

  if (counts.peach > 0) {
    const gained = Math.min(MAX_FURY - attacker.fury, counts.peach * FURY_PEACH);
    attacker.fury += gained;
    summary.fury = gained;
  }

  if (swordDmg > 0) {
    if (furied) {
      defender.hp = Math.max(0, defender.hp - swordDmg);
      summary.damage += swordDmg;
    } else {
      const absorbed = Math.min(defender.armor, swordDmg);
      defender.armor -= absorbed;
      summary.armorDamage = absorbed;
      const dealt = swordDmg - absorbed;
      defender.hp = Math.max(0, defender.hp - dealt);
      summary.damage += dealt;
    }
  }
  if (fireDmg > 0) {
    defender.hp = Math.max(0, defender.hp - fireDmg);
    summary.damage += fireDmg;
  }

  if (
    defender.hp > 0 &&
    (counts.sword > 0 || counts.fireSword > 0) &&
    defenderArmorBefore >= REFLECT_THRESHOLD
  ) {
    attacker.hp = Math.max(0, attacker.hp - REFLECT_DAMAGE);
    summary.reflect = REFLECT_DAMAGE;
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
  const dmg = Math.floor(attacker.mp / 2);
  attacker.mp = 0;
  defender.hp = Math.max(0, defender.hp - dmg);
  return dmg;
}

export function applyAuthoritativeEffects(
  attacker: Fighter,
  defender: Fighter,
  effects: EffectSummary,
): EffectSummary {
  defender.hp = Math.max(0, defender.hp - effects.damage);
  defender.armor = Math.max(0, defender.armor - (effects.armorDamage ?? 0));
  attacker.hp = Math.max(0, attacker.hp - (effects.reflect ?? 0));
  attacker.hp = Math.min(MAX_HP, attacker.hp + effects.heal);
  attacker.mp = Math.min(MAX_MP, attacker.mp + effects.mana);
  attacker.armor = Math.min(MAX_ARMOR, attacker.armor + effects.armor);
  if (effects.furied) {
    attacker.fury = 0;
  } else {
    attacker.fury = Math.min(MAX_FURY, attacker.fury + (effects.fury ?? 0));
  }
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

  const heartWeight = bot.hp >= MAX_HP ? 0.2 : bot.hp <= 100 ? 6.5 : 1.5;
  const greaterHeartWeight = bot.hp >= MAX_HP ? 0.3 : bot.hp <= 100 ? 9 : 3;
  const shieldWeight = bot.armor >= MAX_ARMOR ? 0.2 : bot.hp <= 120 ? 4.5 : 2.5;
  const waterWeight = bot.mp >= ULT_COST ? 1 : 5;
  const peachWeight = bot.fury >= MAX_FURY ? 0.3 : 3;
  const lightningWeight = 2.5;
  const attackWeight = player.hp <= 50 ? 1.25 : 1;
  const comboBonus = level === 'hard' ? 14 : 8;
  const jitter = level === 'hard' ? 0 : 2;

  let best: [number, number] = moves[0];
  let bestScore = -1;

  for (const move of moves) {
    let previewSeed = (((move[0] + 1) * 1103515245) ^ ((move[1] + 1) * 12345)) >>> 0;
    const previewRandom = (): number => {
      previewSeed = (Math.imul(previewSeed, 1664525) + 1013904223) >>> 0;
      return previewSeed / 0x1_0000_0000;
    };
    swapCells(board, move[0], move[1]);
    const match = findMatches(board);
    let counts: Record<TileType, number> | null = null;
    if (match) {
      counts = { ...match.counts };
      const plan = computeExplosions(board, match.cells, previewRandom);
      for (const idx of plan.exploded) counts[board[idx]]++;
    }
    swapCells(board, move[0], move[1]);
    if (!counts) continue;

    // Nộ chỉ ×2 khi đã đầy từ trước wave; Đào ăn trong wave này chỉ tính điểm
    // nạp Nộ (peachWeight) chứ không nhân đôi sát thương ngay.
    const furyMul = bot.fury >= MAX_FURY ? 2 : 1;
    let score =
      (counts.sword * DMG_SWORD + counts.fireSword * FIRE_SWORD_DMG) * furyMul * attackWeight +
      counts.peach * peachWeight +
      counts.lightning * lightningWeight +
      counts.heart * heartWeight +
      counts.greaterHeart * greaterHeartWeight +
      counts.water * waterWeight +
      counts.shield * shieldWeight;
    if (match) score += comboBonus * match.bonusTurns;
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
  const dmg = Math.floor(bot.mp / 2);
  if (player.hp <= dmg) return true; // đủ kết liễu — luôn chốt hạ
  if (level === 'easy') return player.hp <= dmg + 5 || Math.random() < 0.2;
  if (level === 'hard') {
    // Ult scale theo MP, nên bot KHÓ tích đến đầy để đánh mạnh nhất, chỉ tung
    // sớm khi đã full (không tích thêm được) hoặc đang nguy cấp cần dứt điểm.
    if (bot.mp >= MAX_MP) return true;
    if (bot.hp <= 50 && player.hp <= dmg + 25) return true;
    return false;
  }
  return player.hp <= dmg + 10 || Math.random() < 0.5;
}
