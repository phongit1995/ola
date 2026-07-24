export const C2S = {
  QueueJoin: 'QUEUE_JOIN',
  QueueLeave: 'QUEUE_LEAVE',
  Move: 'MOVE',
  ChatSend: 'CHAT_SEND',
  Forfeit: 'FORFEIT',
  RoomCreate: 'ROOM_CREATE',
  RoomJoin: 'ROOM_JOIN',
  RoomLeave: 'ROOM_LEAVE',
  RoomList: 'ROOM_LIST',
  RoomKick: 'ROOM_KICK',
  RoomReady: 'ROOM_READY',
  RoomStart: 'ROOM_START',
} as const;

export const S2C = {
  UserInfo: 'USER_INFO',
  QueueWaiting: 'QUEUE_WAITING',
  MatchFound: 'MATCH_FOUND',
  State: 'STATE',
  ChatMessage: 'CHAT_MESSAGE',
  MatchOver: 'MATCH_OVER',
  Error: 'ERROR',
  RoomList: 'ROOM_LIST',
  RoomUpsert: 'ROOM_UPSERT',
  RoomRemoved: 'ROOM_REMOVED',
  RoomWaiting: 'ROOM_WAITING',
  RoomState: 'ROOM_STATE',
  RoomClosed: 'ROOM_CLOSED',
  RoomKicked: 'ROOM_KICKED',
  OpponentDisconnected: 'OPPONENT_DISCONNECTED',
  OpponentReconnected: 'OPPONENT_RECONNECTED',
} as const;

export interface Envelope {
  type: string;
  data?: unknown;
}

export interface PlayerInfo {
  id: string;
  name: string;
}

export interface UserInfoData {
  username: string;
  vipType?: string | null;
  vipDays: number;
  ken: number;
  guest?: boolean;
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
  matchId: string;
  userId: string;
  name: string;
  text: string;
  sentAt: number;
}

export interface MatchOverData<TState = unknown> {
  matchId: string;
  winnerId?: string;
  reason: 'win' | 'forfeit' | 'timeout' | 'disconnect' | 'draw';
  state: TState;
  bet?: number;
}

export interface ErrorData {
  code: string;
  message: string;
}

export interface RoomInfo {
  id: string;
  owner: string;
  bet: number;
  locked: boolean;
  players: number;
  full?: boolean;
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
}

export interface RoomMember {
  id: string;
  name: string;
  owner: boolean;
  ready: boolean;
}

export interface RoomStateData {
  roomId: string;
  ownerId: string;
  youId: string;
  bet: number;
  locked: boolean;
  members: RoomMember[];
}

export interface RoomClosedData {
  roomId: string;
  reason: 'owner_left' | 'owner_disconnected' | 'owner_busy' | 'member_left' | 'left' | string;
}

export interface RoomKickedData {
  roomId: string;
  byUserId: string;
}

export interface OpponentDisconnectedData {
  graceDeadline: number;
}
