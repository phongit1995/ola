export interface ProgressionConfig {
  maxLevel: number;
  baseXP: number;
  linearXP: number;
  quadraticAfterLevel: number;
  quadraticXP: number;
}

export interface Progression {
  level: number;
  /** XP earned inside the current level, capped at `need` on the last level. */
  current: number;
  /** XP the current level spans. */
  need: number;
  /** Total XP required to reach the current level from level 1. */
  floor: number;
}
