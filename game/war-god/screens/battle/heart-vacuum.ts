import {
  GREATER_HEART_HEAL,
  HEAL_HEART,
  MAX_HP,
} from '../../logic/constants.gen';

/** Luật cân bằng dùng chung cho client UI và phần tính hiệu ứng chưởng Tim. */
export const HEART_VACUUM_RULES = {
  healPerHeart: HEAL_HEART,
  healPerGreaterHeart: GREATER_HEART_HEAL,
} as const;

export function calculateHeartVacuumHeal(
  currentHp: number,
  heartCount: number,
  greaterHeartCount: number,
): number {
  const rawHeal =
    Math.max(0, heartCount) * HEART_VACUUM_RULES.healPerHeart +
    Math.max(0, greaterHeartCount) * HEART_VACUUM_RULES.healPerGreaterHeart;
  return Math.max(0, Math.min(MAX_HP - currentHp, rawHeal));
}
