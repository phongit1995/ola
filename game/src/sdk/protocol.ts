export const C2S = {
  QueueJoin: 'QUEUE_JOIN',
  QueueLeave: 'QUEUE_LEAVE',
  Move: 'MOVE',
  ChatSend: 'CHAT_SEND',
  ReactionSend: 'REACTION_SEND',
  Forfeit: 'FORFEIT',
  RoomCreate: 'ROOM_CREATE',
  RoomJoin: 'ROOM_JOIN',
  RoomLeave: 'ROOM_LEAVE',
  RoomList: 'ROOM_LIST',
  RoomKick: 'ROOM_KICK',
  RoomReady: 'ROOM_READY',
  RoomStart: 'ROOM_START',
  Leaderboard: 'LEADERBOARD',
  History: 'HISTORY',
  SpectateList: 'SPECTATE_LIST',
  SpectateJoin: 'SPECTATE_JOIN',
  SpectateLeave: 'SPECTATE_LEAVE',
} as const;

export const S2C = {
  UserInfo: 'USER_INFO',
  QueueWaiting: 'QUEUE_WAITING',
  MatchFound: 'MATCH_FOUND',
  State: 'STATE',
  ChatMessage: 'CHAT_MESSAGE',
  Reaction: 'REACTION',
  MatchOver: 'MATCH_OVER',
  Error: 'ERROR',
  RoomList: 'ROOM_LIST',
  RoomUpsert: 'ROOM_UPSERT',
  RoomRemoved: 'ROOM_REMOVED',
  RoomWaiting: 'ROOM_WAITING',
  RoomState: 'ROOM_STATE',
  RoomSync: 'ROOM_SYNC',
  RoomClosed: 'ROOM_CLOSED',
  RoomKicked: 'ROOM_KICKED',
  OpponentDisconnected: 'OPPONENT_DISCONNECTED',
  OpponentReconnected: 'OPPONENT_RECONNECTED',
  Leaderboard: 'LEADERBOARD',
  History: 'HISTORY',
  SpectateList: 'SPECTATE_LIST',
  SpectateJoined: 'SPECTATE_JOINED',
  SpectateLeft: 'SPECTATE_LEFT',
} as const;

export const SPECTATE_LEFT_REASON = {
  Left: 'left',
  MatchOver: 'match_over',
} as const;

export type SpectateLeftReason = (typeof SPECTATE_LEFT_REASON)[keyof typeof SPECTATE_LEFT_REASON];

export const GAME_ERROR_CODE = {
  AlreadyInRoom: 'ALREADY_IN_ROOM',
  BetNotAllowed: 'BET_NOT_ALLOWED',
  WrongPassword: 'WRONG_PASSWORD',
  RoomNotFound: 'ROOM_NOT_FOUND',
  OwnRoom: 'OWN_ROOM',
  RoomBusy: 'ROOM_BUSY',
  RoomCreateFailed: 'ROOM_CREATE_FAILED',
  RoomFull: 'ROOM_FULL',
  RoomJoinFailed: 'ROOM_JOIN_FAILED',
  RoomLeaveFailed: 'ROOM_LEAVE_FAILED',
  RoomListFailed: 'ROOM_LIST_FAILED',
  RoomMemberNotFound: 'ROOM_MEMBER_NOT_FOUND',
  RoomMismatch: 'ROOM_MISMATCH',
  RoomNotReady: 'ROOM_NOT_READY',
  RoomStartFailed: 'ROOM_START_FAILED',
  RoomUpdateFailed: 'ROOM_UPDATE_FAILED',
  NotRoomOwner: 'NOT_ROOM_OWNER',
  InRoom: 'IN_ROOM',
  InvalidBet: 'INVALID_BET',
  InvalidPassword: 'INVALID_PASSWORD',
  InsufficientKen: 'INSUFFICIENT_KEN',
  ChatRateLimited: 'CHAT_RATE_LIMITED',
  ChatTooLong: 'CHAT_TOO_LONG',
  InvalidChat: 'INVALID_CHAT',
  InvalidReaction: 'INVALID_REACTION',
  RoomNotFull: 'ROOM_NOT_FULL',
  NotRoomMember: 'NOT_ROOM_MEMBER',
  InvalidMove: 'INVALID_MOVE',
  MatchMismatch: 'MATCH_MISMATCH',
  MatchStartFailed: 'MATCH_START_FAILED',
  NoMatch: 'NO_MATCH',
  NotYourTurn: 'NOT_YOUR_TURN',
  ReactionRateLimited: 'REACTION_RATE_LIMITED',
  SpectateFailed: 'SPECTATE_FAILED',
  SpectateFull: 'SPECTATE_FULL',
  SpectateNotSupported: 'SPECTATE_NOT_SUPPORTED',
  SpectateOwnMatch: 'SPECTATE_OWN_MATCH',
  MatchNotFound: 'MATCH_NOT_FOUND',
  StateSaveFailed: 'STATE_SAVE_FAILED',
  UnknownGame: 'UNKNOWN_GAME',
  UserInfoFailed: 'USER_INFO_FAILED',
} as const;

export type GameErrorCode = (typeof GAME_ERROR_CODE)[keyof typeof GAME_ERROR_CODE];

export const GAME_REACTION_TYPE = {
  Like: 'LIKE',
  Love: 'LOVE',
  Haha: 'HAHA',
  Wow: 'WOW',
  Sad: 'SAD',
  Angry: 'ANGRY',
} as const;

export type GameReactionType = (typeof GAME_REACTION_TYPE)[keyof typeof GAME_REACTION_TYPE];

export interface Envelope {
  type: string;
  data?: unknown;
}

export interface PlayerInfo {
  id: string;
  name: string;
  vipType?: string | null;
  level?: number;
}

export interface UserInfoData {
  id: string;
  username: string;
  vipType?: string | null;
  vipDays: number;
  ken: number;
  maxBet?: number;
  level?: number;
  exp?: number;
}

export type LeaderboardPeriod = 'day' | 'week';

export interface LeaderboardEntry {
  rank: number;
  userId: string;
  username: string;
  vipType?: string | null;
  ken: number;
  wins?: number;
  losses?: number;
  level?: number;
}

export interface LeaderboardData {
  period: LeaderboardPeriod;
  from: number;
  to: number;
  items: LeaderboardEntry[];
  error?: string;
}

export type MatchHistoryOutcome = 'win' | 'lose' | 'draw';

export interface MatchHistoryEntry {
  id: string;
  playedAt: number;
  opponentId: string;
  opponentName: string;
  opponentVipType?: string | null;
  bet: number;
  outcome: MatchHistoryOutcome;
  kenDelta: number;
}

export interface MatchHistoryData {
  items: MatchHistoryEntry[];
  error?: string;
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
  bet?: number;
  roomOwnerId?: string;
}

export interface SpectateListEntry {
  matchId: string;
  roomId?: string;
  players: PlayerInfo[];
  bet?: number;
  startedAt: number;
  spectators: number;
}

export interface SpectateListData {
  matches: SpectateListEntry[];
}

export interface SpectateJoinedData<TState = unknown> {
  matchId: string;
  gameId: string;
  players: PlayerInfo[];
  state: TState;
  turn: number;
  deadline: number;
  bet?: number;
  roomOwnerId?: string;
  spectators: number;
}

export interface SpectateLeftData {
  matchId: string;
  reason: SpectateLeftReason;
}

export interface StateData<TState = unknown, TMove = unknown> {
  matchId: string;
  state: TState;
  turn: number;
  deadline: number;
  lastMove?: TMove;
  lastBy: number;
}

export interface ChatMessageData {
  matchId?: string;
  roomId?: string;
  userId: string;
  name: string;
  text: string;
  sentAt: number;
}

export interface ReactionData {
  matchId: string;
  userId: string;
  type: GameReactionType;
  sentAt: number;
}

export interface RankingEntry {
  userId: string;
  place: number;
}

export interface ExpGainEntry {
  userId: string;
  exp: number;
}

export interface MatchOverData<TState = unknown> {
  matchId: string;
  winnerId?: string;
  reason: 'win' | 'forfeit' | 'timeout' | 'disconnect' | 'draw';
  state: TState;
  bet?: number;
  payout?: number;
  kenDelta?: number;
  rankings?: RankingEntry[];
  expGains?: ExpGainEntry[];
}

export interface ErrorData {
  code: string;
  message: string;
}

export interface RoomInfo {
  id: string;
  owner: string;
  ownerVipType?: string | null;
  bet: number;
  locked: boolean;
  players: number;
  maxPlayers?: number;
  full?: boolean;
  status?: 'waiting' | 'playing';
  matchId?: string;
}

export interface RoomListData {
  rooms: RoomInfo[];
}

export interface RoomUpsertData {
  room: RoomInfo;
}

export interface RoomRemovedData {
  roomId: string;
}

export interface RoomWaitingData {
  roomId: string;
  bet: number;
  locked: boolean;
  maxPlayers?: number;
}

export interface RoomMember {
  id: string;
  name: string;
  owner: boolean;
  ready: boolean;
  vipType?: string | null;
  level?: number;
}

export interface RoomStateData {
  roomId: string;
  ownerId: string;
  youId: string;
  bet: number;
  locked: boolean;
  maxPlayers?: number;
  members: RoomMember[];
  /** Match whose completed board this waiting-room snapshot follows. */
  afterMatchId?: string;
}

export interface RoomSyncData {
  roomId?: string;
}

export interface RoomClosedData {
  roomId: string;
  reason: 'owner_left' | 'owner_disconnected' | 'owner_busy' | 'guest_left' | 'member_left' | 'left' | string;
}

export interface RoomKickedData {
  roomId: string;
  byUserId: string;
}

export interface OpponentDisconnectedData {
  graceDeadline: number;
  turnRemainingMs?: number;
  userId?: string;
}

export interface OpponentReconnectedData {
  userId?: string;
  /** Authoritative turn/deadline after a paused clock has been re-armed. */
  turn?: number;
  deadline?: number;
}
