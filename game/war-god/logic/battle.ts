import {
  applyGravity,
  computeExplosions,
  findMatches,
  findFlyingDartCreation,
  findValidMoves,
  swapCells,
  type Board,
  type TileType,
} from './core';
import type { UltimateSkillId } from './server-types';
import {
  ARMOR_SHIELD,
  CASCADE_BONUS_PERCENT_PER_LEVEL,
  DMG_SWORD,
  FIRE_SWORD_DMG,
  FURY_DAMAGE_MULTIPLIER,
  FURY_PEACH,
  GREATER_HEART_HEAL,
  HEAL_HEART,
  MAX_ARMOR,
  MAX_CASCADE_LEVEL,
  MAX_EXTRA_TURNS,
  MAX_FURY,
  MAX_HP,
  MAX_MP,
  MP_WATER,
  ULT_COST,
} from './constants.gen';

export {
  CASCADE_BONUS_PERCENT_PER_LEVEL,
  FIRE_SWORD_DMG,
  FURY_DAMAGE_MULTIPLIER,
  GREATER_HEART_HEAL,
  MAX_ARMOR,
  MAX_CASCADE_LEVEL,
  MAX_EXTRA_TURNS,
  MAX_FURY,
  MAX_HP,
  MAX_MP,
  ULT_COST,
} from './constants.gen';

export { LIGHTNING_GOD_DAMAGE } from './constants.gen';

export interface Fighter {
  hp: number;
  mp: number;
  armor: number;
  fury: number;
}

export function cascadeBonusPercent(cascadeLevel: number): number {
  const safeLevel = Number.isFinite(cascadeLevel) ? Math.max(0, Math.floor(cascadeLevel)) : 0;
  return Math.min(MAX_CASCADE_LEVEL, safeLevel) * CASCADE_BONUS_PERCENT_PER_LEVEL;
}

export function scaleCascadeValue(value: number, cascadeLevel: number): number {
  return Math.round((value * (100 + cascadeBonusPercent(cascadeLevel))) / 100);
}

function scaleFuryDamage(value: number): number {
  return Math.round(value * FURY_DAMAGE_MULTIPLIER);
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
}

export interface DamageResult {
  damage: number;
  armorDamage: number;
}

export interface ExtraTurnGrant {
  granted: number;
  remaining: number;
}

export function grantExtraTurns(current: number, earned: number): ExtraTurnGrant {
  const safeCurrent = Math.min(MAX_EXTRA_TURNS, Math.max(0, Math.floor(current)));
  const safeEarned = Math.max(0, Math.floor(earned));
  const remaining = Math.min(MAX_EXTRA_TURNS, safeCurrent + safeEarned);
  return { granted: remaining - safeCurrent, remaining };
}

export function applyDamageThroughArmor(defender: Fighter, incoming: number): DamageResult {
  const armorDamage = Math.min(defender.armor, incoming);
  defender.armor -= armorDamage;
  const damage = incoming - armorDamage;
  defender.hp = Math.max(0, defender.hp - damage);
  return { damage, armorDamage };
}

export function applyTileEffects(
  attacker: Fighter,
  defender: Fighter,
  counts: Record<TileType, number>,
  cascadeLevel = 0,
  furyChain?: { active: boolean },
): EffectSummary {
  const summary: EffectSummary = {
    damage: 0,
    heal: 0,
    mana: 0,
    armor: 0,
    armorDamage: 0,
    fury: 0,
  };

  let swordDmg = counts.sword * DMG_SWORD;
  let fireDmg = counts.fireSword * FIRE_SWORD_DMG;

  // Nộ kích hoạt khi đã đầy trước một wave có Kiếm, rồi giữ hệ số sát thương
  // chuỗi sập hiện tại. Đào ăn trong wave chỉ nạp Nộ cho các wave sau.
  const hasSwordDamage = swordDmg > 0 || fireDmg > 0;
  let furied = furyChain?.active === true && hasSwordDamage;
  if (!furyChain?.active && attacker.fury >= MAX_FURY && hasSwordDamage) {
    swordDmg = scaleFuryDamage(swordDmg);
    fireDmg = scaleFuryDamage(fireDmg);
    attacker.fury = 0;
    furied = true;
    summary.furied = true;
    if (furyChain) furyChain.active = true;
  } else if (furied) {
    swordDmg = scaleFuryDamage(swordDmg);
    fireDmg = scaleFuryDamage(fireDmg);
  }

  swordDmg = scaleCascadeValue(swordDmg, cascadeLevel);
  fireDmg = scaleCascadeValue(fireDmg, cascadeLevel);

  if (counts.peach > 0) {
    const gained = Math.min(
      MAX_FURY - attacker.fury,
      scaleCascadeValue(counts.peach * FURY_PEACH, cascadeLevel),
    );
    attacker.fury += gained;
    summary.fury = gained;
  }

  const incomingDamage = swordDmg + fireDmg;
  if (incomingDamage > 0) {
    const result = applyDamageThroughArmor(defender, incomingDamage);
    summary.damage = result.damage;
    summary.armorDamage = result.armorDamage;
  }

  const healing = scaleCascadeValue(
    counts.heart * HEAL_HEART + counts.greaterHeart * GREATER_HEART_HEAL,
    cascadeLevel,
  );
  if (healing > 0) {
    const healed = Math.min(MAX_HP - attacker.hp, healing);
    attacker.hp += healed;
    summary.heal = healed;
  }

  // A dart is a wildcard for matching, but it is not a Water resource.
  // Its own effect is the line clear determined by its axis.
  const waterCount = counts.water;
  if (waterCount > 0) {
    const gained = Math.min(
      MAX_MP - attacker.mp,
      scaleCascadeValue(waterCount * MP_WATER, cascadeLevel),
    );
    attacker.mp += gained;
    summary.mana = gained;
  }

  if (counts.shield > 0) {
    const added = Math.min(
      MAX_ARMOR - attacker.armor,
      scaleCascadeValue(counts.shield * ARMOR_SHIELD, cascadeLevel),
    );
    attacker.armor += added;
    summary.armor = added;
  }

  return summary;
}

export function castUltimate(attacker: Fighter, defender: Fighter): DamageResult {
  const dmg = Math.floor(attacker.mp / 2);
  attacker.mp = 0;
  return applyDamageThroughArmor(defender, dmg);
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
  if (effects.furied) attacker.fury = 0;
  attacker.fury = Math.min(MAX_FURY, attacker.fury + (effects.fury ?? 0));
  return effects;
}

export type BotLevel = 'easy' | 'normal' | 'hard' | 'expert';

export const LEVEL_LABELS: Record<BotLevel, string> = {
  easy: 'DỄ',
  normal: 'VỪA',
  hard: 'KHÓ',
  expert: 'SIÊU KHÓ',
};

export const BOT_LEVEL_TITLES: Record<BotLevel, string> = {
  easy: 'Dễ',
  normal: 'Vừa',
  hard: 'Khó',
  expert: 'Siêu khó',
};

type BotMove = [number, number];

interface MovePreview {
  counts: Record<TileType, number>;
  bonusTurns: number;
  dartCreations: number;
}

interface SimulatedMove {
  board: Board;
  bot: Fighter;
  player: Fighter;
  damage: number;
  heal: number;
  mana: number;
  armor: number;
  armorDamage: number;
  fury: number;
  bonusTurns: number;
  dartCreations: number;
}

// A created Phi Tiêu remains on the board and can clear an entire line on a
// later turn, so the non-expert scorers need to account for it as persistent
// board value instead of valuing only the immediate Water mana.
const FLYING_DART_CREATION_SCORE = 220;

const EXPERT_CANDIDATE_LIMIT = 12;
const EXPERT_ROLLOUTS = 6;
const EXPERT_CASCADE_LIMIT = 16;

// Seed chỉ lấy từ trạng thái bàn nhìn thấy được. Bot mô phỏng nhiều khả năng
// sinh ngọc nhưng không đọc trước luồng Math.random thật của trận đấu.
function moveSeed(board: Board, move: BotMove, sample = 0): number {
  let seed = (0x811c9dc5 ^ ((move[0] + 1) * 0x45d9f3b) ^ ((move[1] + 1) * 0x27d4eb2d)) >>> 0;
  for (let i = 0; i < board.length; i++) {
    const tile = board[i];
    seed ^= tile.charCodeAt(0) + tile.length * 31 + i;
    seed = Math.imul(seed, 0x01000193) >>> 0;
  }
  return (seed ^ Math.imul(sample + 1, 0x9e3779b1)) >>> 0;
}

function seededRandom(seed: number): () => number {
  let state = seed || 0x6d2b79f5;
  return () => {
    state = (Math.imul(state, 1664525) + 1013904223) >>> 0;
    return state / 0x1_0000_0000;
  };
}

function previewMove(board: Board, move: BotMove, random: () => number): MovePreview | null {
  swapCells(board, move[0], move[1]);
  const match = findMatches(board);
  if (!match) {
    swapCells(board, move[0], move[1]);
    return null;
  }
  const counts = { ...match.counts };
  const plan = computeExplosions(board, match.cells, random);
  for (const index of plan.exploded) counts[board[index]]++;
  const dartCreations = findFlyingDartCreation(board, [move[1], move[0]]) ? 1 : 0;
  swapCells(board, move[0], move[1]);
  return {
    counts,
    bonusTurns: grantExtraTurns(0, match.bonusTurns).remaining,
    dartCreations,
  };
}

function scoreResolvedState(
  beforeBot: Fighter,
  beforePlayer: Fighter,
  result: Omit<SimulatedMove, 'board'>,
): number {
  if (result.player.hp <= 0 && result.bot.hp > 0) return 1_000_000 + result.bot.hp * 100;
  if (result.bot.hp <= 0) return -1_000_000;

  const damage = beforePlayer.hp - result.player.hp;
  const lowHealthFactor = beforeBot.hp <= 60 ? 2.2 : beforeBot.hp <= 110 ? 1.45 : 1;
  let score =
    damage * 12 +
    result.armorDamage * 4 +
    result.heal * 6 * lowHealthFactor +
    result.mana * 3.2 +
    result.armor * 4.5 * lowHealthFactor +
    result.fury * 2.8 +
    result.bonusTurns * 280;

  score += result.dartCreations * FLYING_DART_CREATION_SCORE;

  if (result.bot.mp >= ULT_COST && beforeBot.mp < ULT_COST) score += 180;
  if (result.bot.fury >= MAX_FURY && beforeBot.fury < MAX_FURY) score += 140;
  if (result.player.hp <= 50) score += (50 - result.player.hp) * 3;
  return score;
}

function scoreImmediateMove(
  board: Board,
  attacker: Fighter,
  defender: Fighter,
  move: BotMove,
  random: () => number,
): number {
  const preview = previewMove(board, move, random);
  if (!preview) return Number.NEGATIVE_INFINITY;
  const nextAttacker = { ...attacker };
  const nextDefender = { ...defender };
  const effects = applyTileEffects(nextAttacker, nextDefender, preview.counts);
  return scoreResolvedState(attacker, defender, {
    bot: nextAttacker,
    player: nextDefender,
    damage: effects.damage,
    heal: effects.heal,
    mana: effects.mana,
    armor: effects.armor,
    armorDamage: effects.armorDamage ?? 0,
    fury: effects.fury ?? 0,
    bonusTurns: preview.bonusTurns,
    dartCreations: preview.dartCreations,
  });
}

function simulateExpertMove(
  board: Board,
  bot: Fighter,
  player: Fighter,
  move: BotMove,
  random: () => number,
): SimulatedMove {
  const nextBoard = [...board];
  const nextBot = { ...bot };
  const nextPlayer = { ...player };
  const total = {
    damage: 0,
    heal: 0,
    mana: 0,
    armor: 0,
    armorDamage: 0,
    fury: 0,
    bonusTurns: 0,
    dartCreations: 0,
  };

  swapCells(nextBoard, move[0], move[1]);
  const furyChain = { active: false };
  let preferredDartCells: readonly number[] = [move[1], move[0]];
  for (let cascade = 0; cascade < EXPERT_CASCADE_LIMIT; cascade++) {
    const match = findMatches(nextBoard);
    if (!match) break;
    total.bonusTurns = grantExtraTurns(total.bonusTurns, match.bonusTurns).remaining;
    const creation = findFlyingDartCreation(nextBoard, preferredDartCells);
    const plan = computeExplosions(nextBoard, match.cells, random);
    for (const index of plan.exploded) match.counts[nextBoard[index]]++;
    const removed = new Set(match.cells);
    for (const index of plan.exploded) removed.add(index);
    if (creation) {
      total.dartCreations++;
      removed.delete(creation.index);
      nextBoard[creation.index] = creation.type;
    }
    const effects = applyTileEffects(nextBot, nextPlayer, match.counts, cascade, furyChain);
    total.damage += effects.damage;
    total.heal += effects.heal;
    total.mana += effects.mana;
    total.armor += effects.armor;
    total.armorDamage += effects.armorDamage ?? 0;
    total.fury += effects.fury ?? 0;
    applyGravity(nextBoard, removed, random);
    preferredDartCells = [];
    if (nextBot.hp <= 0 || nextPlayer.hp <= 0) break;
  }

  return { board: nextBoard, bot: nextBot, player: nextPlayer, ...total };
}

function bestImmediateReplyScore(
  board: Board,
  player: Fighter,
  bot: Fighter,
  seed: number,
): number {
  const replies = findValidMoves(board);
  let best = 0;
  for (const reply of replies) {
    const score = scoreImmediateMove(
      board,
      player,
      bot,
      reply,
      seededRandom(seed ^ moveSeed(board, reply)),
    );
    if (score > best) best = score;
  }
  return best;
}

function chooseExpertMove(board: Board, bot: Fighter, player: Fighter, moves: BotMove[]): BotMove {
  const candidates = moves
    .map((move) => ({
      move,
      score: scoreImmediateMove(board, bot, player, move, seededRandom(moveSeed(board, move))),
    }))
    .sort((a, b) => b.score - a.score)
    .slice(0, EXPERT_CANDIDATE_LIMIT);

  let best = candidates[0].move;
  let bestScore = Number.NEGATIVE_INFINITY;
  for (const candidate of candidates) {
    let score = 0;
    for (let sample = 0; sample < EXPERT_ROLLOUTS; sample++) {
      const seed = moveSeed(board, candidate.move, sample);
      const outcome = simulateExpertMove(board, bot, player, candidate.move, seededRandom(seed));
      let rolloutScore = scoreResolvedState(bot, player, outcome);
      if (outcome.player.hp > 0 && outcome.bot.hp > 0) {
        const replyWeight = outcome.bonusTurns > 0 ? 0.2 : 0.55;
        rolloutScore -=
          bestImmediateReplyScore(outcome.board, outcome.player, outcome.bot, seed ^ 0xa5a5a5a5) *
          replyWeight;
      }
      score += rolloutScore;
    }
    score /= EXPERT_ROLLOUTS;
    if (score > bestScore) {
      bestScore = score;
      best = candidate.move;
    }
  }
  return best;
}

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

  if (level === 'expert') return chooseExpertMove(board, bot, player, moves);

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
    const preview = previewMove(board, move, previewRandom);
    if (!preview) continue;
    const { counts } = preview;

    // Nộ chỉ tăng sát thương khi đã đầy từ trước wave; Đào ăn trong wave này
    // chỉ tính điểm nạp Nộ (peachWeight), không tăng sát thương ngay.
    const furyMul = bot.fury >= MAX_FURY ? FURY_DAMAGE_MULTIPLIER : 1;
    let score =
      (counts.sword * DMG_SWORD + counts.fireSword * FIRE_SWORD_DMG) * furyMul * attackWeight +
      counts.peach * peachWeight +
      counts.lightning * lightningWeight +
      counts.heart * heartWeight +
      counts.greaterHeart * greaterHeartWeight +
      counts.water * waterWeight +
      counts.shield * shieldWeight;
    score += preview.dartCreations * FLYING_DART_CREATION_SCORE;
    score += comboBonus * preview.bonusTurns;
    score += Math.random() * jitter;

    if (score > bestScore) {
      bestScore = score;
      best = move;
    }
  }

  return best;
}

// ULT_COST bằng MAX_MP nên tới đây MP luôn đầy — tích thêm là lãng phí ô Nước,
// vì vậy KHÓ/SIÊU KHÓ tung ngay; mức thấp hơn chần chừ ngẫu nhiên cho giống người.
export function botShouldUlt(bot: Fighter, player: Fighter, level: BotLevel): boolean {
  if (bot.mp < ULT_COST) return false;
  const dmg = Math.max(0, Math.floor(bot.mp / 2) - player.armor);
  if (player.hp <= dmg) return true; // đủ kết liễu — luôn chốt hạ
  if (level === 'easy') return player.hp <= dmg + 5 || Math.random() < 0.2;
  if (level === 'normal') return player.hp <= dmg + 10 || Math.random() < 0.5;
  return true;
}

// Vạn Kiếm ăn chắc 50 nên là đòn kết liễu/dứt điểm; Lôi Thần đổi damage cứng
// lấy 16 ô hiệu ứng + chuỗi sập nên là đòn lấy giá trị khi trận còn dài.
export function botChooseUltimateSkill(
  bot: Fighter,
  player: Fighter,
  level: BotLevel,
  board?: Board,
): UltimateSkillId {
  const dmg = Math.max(0, Math.floor(bot.mp / 2) - player.armor);
  if (player.hp <= dmg + 10) return 'myriad-swords';

  // Thánh Tâm is only useful when the current board has hearts to absorb.
  // Keep the board optional for callers that only need the legacy two-skill
  // policy, while the live bot passes its authoritative board here.
  if (board != null && bot.hp < MAX_HP) {
    let normalHearts = 0;
    let greaterHearts = 0;
    for (const tile of board) {
      if (tile === 'heart') normalHearts++;
      else if (tile === 'greaterHeart') greaterHearts++;
    }
    const availableHeal = Math.min(
      MAX_HP - bot.hp,
      normalHearts * HEAL_HEART + greaterHearts * GREATER_HEART_HEAL,
    );
    const hpThreshold = level === 'expert' ? 125 : level === 'hard' ? 115 : level === 'normal' ? 105 : 95;
    const minimumHeal = level === 'easy' ? 25 : 15;
    if (bot.hp <= hpThreshold && availableHeal >= minimumHeal) return 'heart-vacuum';
  }

  if (level === 'easy') return Math.random() < 0.5 ? 'lightning-god' : 'myriad-swords';
  if (level === 'normal') return Math.random() < 0.35 ? 'myriad-swords' : 'lightning-god';
  return player.hp <= 60 ? 'myriad-swords' : 'lightning-god';
}
