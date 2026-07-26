import type {
  GameReactionType,
  LeaderboardEntry,
  LeaderboardPeriod,
  MatchHistoryEntry,
  RoomInfo,
  RoomStateData,
  UserInfoData,
} from '../../src/sdk';
import type { BotLevel, WinLine } from '../types';

export type OverlayAction = 'again' | 'cancel' | 'lobby';
export type OverlayKind = 'win' | 'lose' | 'draw';
export type PlayerMark = 'x' | 'o';
export type LobbyPhase = 'loading' | 'connecting' | 'error' | 'ready';
export type BoardMode = 'idle' | 'pregame' | 'playing';
export type MatchOutcome = 'win' | 'lose' | 'draw';
export type RoomActionPending =
  | 'creating'
  | 'joining'
  | 'ready'
  | 'starting'
  | 'leaving'
  | 'kicking'
  | null;

export interface OverlayState {
  title: string;
  sub: string;
  kind?: OverlayKind;
  actions: OverlayAction[];
}

export interface MatchResultState {
  matchId: string;
  outcome: MatchOutcome;
  kenDelta: number | null;
  winnerPayout: number | null;
  revealDelayMs: number;
}

export interface PlayerDisplay {
  name: string;
  vip: string;
  mark: PlayerMark;
  active: boolean;
  owner: boolean;
}

export interface ChatMsg {
  id: number;
  who: string;
  text: string;
}

export interface TurnAnnouncement {
  id: number;
  text: string;
  mine: boolean;
}

export interface ReactionNotice {
  id: number;
  type: GameReactionType;
  mine: boolean;
}

export type HistoryEntry = MatchHistoryEntry;

export interface CaroState {
  lobbyVisible: boolean;
  lobbyPhase: LobbyPhase;
  lobbyError: string | null;
  lobbyAnimKey: number;
  userInfo: UserInfoData | null;
  ken: number;
  bet: number;

  rankedVisible: boolean;
  leaderboardVisible: boolean;
  leaderboards: Record<LeaderboardPeriod, LeaderboardEntry[] | null>;
  leaderboardLoading: Record<LeaderboardPeriod, boolean>;
  leaderboardErrors: Record<LeaderboardPeriod, string | null>;
  historyVisible: boolean;
  history: HistoryEntry[];
  historyLoading: boolean;
  historyError: string | null;
  rooms: RoomInfo[];
  roomWaiting: RoomStateData | null;
  boardMode: BoardMode;
  roomActionPending: RoomActionPending;
  oppAway: number | null;

  board: number[];
  lastIdx: number;
  status: string;
  myTurn: boolean;
  movePending: boolean;
  showTimer: boolean;
  timerText: string;
  timerUrgent: boolean;
  turnArrowSrc: string | null;
  me: PlayerDisplay;
  op: PlayerDisplay;
  overlay: OverlayState | null;
  replayVisible: boolean;
  forfeitDisabled: boolean;

  result: MatchResultState | null;
  toast: string | null;
  notice: string | null;
  matchSeq: number;
  betDeductionVisible: boolean;
  turnAnnounce: TurnAnnouncement | null;
  winLine: WinLine | null;
  messages: ChatMsg[];
  reactionNotice: ReactionNotice | null;
}

export interface CaroActions {
  init(ready: boolean): void;
  dispose(): void;
  playBot(level: BotLevel): void;
  playRanked(): void;
  refreshRooms(): void;
  createRoom(bet: number, password?: string): void;
  joinRoom(roomId: string, password?: string): void;
  cancelRoom(): void;
  toggleRoomReady(): void;
  startRoom(): void;
  kickRoomGuest(): void;
  showLeaderboard(): void;
  hideLeaderboard(): void;
  loadLeaderboard(period: LeaderboardPeriod): void;
  showHistory(): void;
  hideHistory(): void;
  loadHistory(): void;
  retry(): void;
  exitApp(): void;
  placeMove(x: number, y: number): void;
  again(): void;
  replay(): void;
  cancelSearch(): void;
  toLobby(): void;
  forfeit(): void;
  exitMatch(): void;
  closeResult(): void;
  showToast(message: string): void;
  dismissNotice(): void;
  sendChat(text: string): void;
  sendReaction(type: GameReactionType): void;
}

export type CaroStore = CaroState & CaroActions;
