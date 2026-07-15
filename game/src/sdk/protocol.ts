export const C2S = {
  QueueJoin: 'QUEUE_JOIN',
  QueueLeave: 'QUEUE_LEAVE',
  Move: 'MOVE',
  Forfeit: 'FORFEIT',
} as const;

export const S2C = {
  QueueWaiting: 'QUEUE_WAITING',
  MatchFound: 'MATCH_FOUND',
  State: 'STATE',
  MatchOver: 'MATCH_OVER',
  Error: 'ERROR',
} as const;

export interface Envelope {
  type: string;
  data?: unknown;
}

export interface PlayerInfo {
  id: string;
  name: string;
}

export interface MatchFoundData<TState = unknown> {
  matchId: string;
  gameId: string;
  players: PlayerInfo[];
  you: number;
  state: TState;
  turn: number;
  deadline: number;
  resumed?: boolean;
}

export interface StateData<TState = unknown, TMove = unknown> {
  matchId: string;
  state: TState;
  turn: number;
  deadline: number;
  lastMove?: TMove;
  lastBy: number;
}

export interface MatchOverData<TState = unknown> {
  matchId: string;
  winnerId?: string;
  reason: 'win' | 'forfeit' | 'timeout';
  state: TState;
}

export interface ErrorData {
  code: string;
  message: string;
}
