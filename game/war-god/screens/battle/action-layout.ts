export type BattleMode = 'bot' | 'pvp';

export interface BattleActionLayout {
  restartVisible: boolean;
  restartX: number;
  forfeitX: number;
  exitX: number;
}

export function battleActionLayout(mode: BattleMode): BattleActionLayout {
  return mode === 'bot'
    ? { restartVisible: true, restartX: 0, forfeitX: 152, exitX: 304 }
    : { restartVisible: false, restartX: 0, forfeitX: 76, exitX: 228 };
}
