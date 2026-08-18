export type BattleMode = 'bot' | 'pvp';

export interface BattleActionLayout {
  restartVisible: boolean;
  restartX: number;
  forfeitX: number;
  exitX: number;
}

export interface BattleActionAvailability {
  restartEnabled: boolean;
  forfeitEnabled: boolean;
  exitEnabled: boolean;
}

export function battleActionLayout(mode: BattleMode): BattleActionLayout {
  return mode === 'bot'
    ? { restartVisible: true, restartX: 0, forfeitX: 152, exitX: 304 }
    : { restartVisible: false, restartX: 0, forfeitX: 76, exitX: 228 };
}

export function battleActionAvailability(
  mode: BattleMode,
  busy: boolean,
  over: boolean,
): BattleActionAvailability {
  return {
    restartEnabled: mode === 'bot' && !busy,
    // PvP animations must not trap a player in a match. The server accepts
    // FORFEIT independently of whose turn it is.
    forfeitEnabled: !over && (mode === 'pvp' || !busy),
    exitEnabled: mode === 'pvp' || !busy,
  };
}
