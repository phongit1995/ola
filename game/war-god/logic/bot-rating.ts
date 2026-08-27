import { MAX_HP } from './constants.gen';

export type BotStarRating = 0 | 0.5 | 1 | 1.5 | 2 | 2.5 | 3;
export type StarFill = 0 | 0.5 | 1;

export interface BotRatingInput {
  won: boolean;
  forfeit: boolean;
  playerHp: number;
  playerArmor: number;
  botHp: number;
  botArmor: number;
  turns: number;
}

function clamp01(value: number): number {
  return Math.max(0, Math.min(1, value));
}

function roundToHalf(value: number): BotStarRating {
  return (Math.max(0, Math.min(3, Math.round(value * 2) / 2))) as BotStarRating;
}

/**
 * Thắng luôn đạt ít nhất 2 sao, rồi cộng điểm sinh tồn (HP + giáp) và tốc độ.
 * Khi thua, rating phản ánh lượng sinh lực hiệu dụng đã lấy được của Máy, tối đa 1,5 sao.
 */
export function calculateBotStarRating(input: BotRatingInput): BotStarRating {
  if (input.forfeit) return 0;

  const playerSurvival = clamp01((input.playerHp + input.playerArmor) / MAX_HP);
  const botRemaining = clamp01((input.botHp + input.botArmor) / MAX_HP);
  const completedTurns = Math.max(1, Math.floor(input.turns));
  const speed = clamp01((12 - completedTurns) / 6);
  const rawRating = input.won
    ? 2 + 0.5 * playerSurvival + 0.5 * speed
    : 1.5 * (1 - botRemaining);

  return roundToHalf(rawRating);
}

export function isBotStarRating(value: number): value is BotStarRating {
  return value >= 0 && value <= 3 && Number.isInteger(value * 2);
}

export function formatBotStarRating(rating: BotStarRating): string {
  return rating.toLocaleString('vi-VN', {
    minimumFractionDigits: Number.isInteger(rating) ? 0 : 1,
    maximumFractionDigits: 1,
  });
}

export function starFillAt(rating: BotStarRating, index: 0 | 1 | 2): StarFill {
  const remaining = rating - index;
  if (remaining >= 1) return 1;
  if (remaining >= 0.5) return 0.5;
  return 0;
}
