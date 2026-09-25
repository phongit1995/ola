import type { ProgressionConfig } from '../types/ProgressionTypes';

/**
 * Player level derived from lifetime XP. Nothing is stored: `FarmState.xp` already accumulates from planting,
 * harvesting, producing, selling and collecting, so every existing save shows a level immediately.
 */
export const MAX_LEVEL = 99;

/** Compatibility defaults for older profiles; the current farm supplies economy.json. */
export const DEFAULT_PROGRESSION: ProgressionConfig = {
  maxLevel: MAX_LEVEL,
  baseXP: 80,
  linearXP: 50,
  quadraticAfterLevel: 10,
  quadraticXP: 400,
};
