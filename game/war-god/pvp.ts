import type {
  ChatMessageData,
  ErrorData,
  GameSession,
  MatchFoundData,
  MatchOverData,
  OpponentDisconnectedData,
  PlayerInfo,
  StateData,
} from '../src/sdk';
import type { ServerMove, ServerState, UltimateSkillId } from './logic/server-types';

export type PvpGameSession = GameSession<ServerState, ServerMove>;

export interface PvpHandlers {
  onMatchFound(data: MatchFoundData<ServerState>): void;
  onState(data: StateData<ServerState, ServerMove>): void;
  onMatchOver(data: MatchOverData<ServerState>): void;
  onChat(data: ChatMessageData): void;
  onOpponentDisconnected(data: OpponentDisconnectedData): void;
  onOpponentReconnected(): void;
  onError(data: ErrorData): void;
  onConnectionChange(connected: boolean): void;
}

let session: PvpGameSession | null = null;
let handlers: Partial<PvpHandlers> = {};
let matchId = '';
let myIdx = 0;
let matchPlayers: PlayerInfo[] = [];
let matchBet = 0;
let matchDeadline = 0;

export const pvp = {
  ready(): boolean {
    return session != null;
  },

  init(next: PvpGameSession): void {
    if (session === next) return;
    session = next;
    next.onMatchFound((data) => {
      matchId = data.matchId;
      myIdx = data.you;
      matchPlayers = data.players;
      matchBet = data.bet ?? 0;
      matchDeadline = data.deadline;
      handlers.onMatchFound?.(data);
    });
    next.onState((data) => {
      if (data.matchId !== matchId) return;
      matchDeadline = data.deadline;
      handlers.onState?.(data);
    });
    next.onMatchOver((data) => {
      handlers.onMatchOver?.(data);
      if (data.matchId === matchId) matchId = '';
    });
    next.onChat((data) => {
      if (data.matchId && data.matchId === matchId) handlers.onChat?.(data);
    });
    next.onOpponentDisconnected((data) => handlers.onOpponentDisconnected?.(data));
    next.onOpponentReconnected(() => handlers.onOpponentReconnected?.());
    next.onError((data) => handlers.onError?.(data));
    next.onConnectionChange((connected) => handlers.onConnectionChange?.(connected));
  },

  on(next: Partial<PvpHandlers>): void {
    handlers = { ...handlers, ...next };
  },

  forfeit(): void {
    if (matchId) session?.forfeit(matchId);
  },

  leaveMatch(): void {
    if (matchId) session?.forfeit(matchId, true);
    matchId = '';
  },

  sendSwap(a: number, b: number): void {
    if (matchId) session?.sendMove(matchId, { type: 'swap', a, b });
  },

  sendUlt(skill: UltimateSkillId): void {
    if (matchId) session?.sendMove(matchId, { type: 'ult', skill });
  },

  sendChatText(text: string): void {
    if (matchId) session?.sendChat(matchId, text);
  },

  matchId(): string {
    return matchId;
  },

  myIdx(): number {
    return myIdx;
  },

  players(): PlayerInfo[] {
    return matchPlayers;
  },

  bet(): number {
    return matchBet;
  },

  deadline(): number {
    return matchDeadline;
  },
};
