import { io, type Socket } from 'socket.io-client';
import {
  bridge,
  GameAuthenticationExpiredError,
  GameAuthenticationRequiredError,
} from './bridge';
import {
  C2S,
  S2C,
  type ChatMessageData,
  type Envelope,
  type ErrorData,
  type LeaderboardData,
  type LeaderboardPeriod,
  type MatchHistoryData,
  type MatchFoundData,
  type MatchOverData,
  type OpponentDisconnectedData,
  type OpponentReconnectedData,
  type GameReactionType,
  type ReactionData,
  type RoomListData,
  type RoomRemovedData,
  type RoomUpsertData,
  type RoomClosedData,
  type RoomKickedData,
  type RoomStateData,
  type RoomSyncData,
  type RoomWaitingData,
  type StateData,
  type UserInfoData,
} from './protocol';

export type GameStatus = 'connecting' | 'idle' | 'queueing' | 'playing' | 'over';

export interface GameSession<TState = unknown, TMove = unknown> {
  readonly userId: string;
  joinQueue(): void;
  leaveQueue(): void;
  sendMove(matchId: string, move: TMove): void;
  sendChat(matchId: string, text: string): void;
  sendRoomChat(roomId: string, text: string): void;
  sendReaction(matchId: string, type: GameReactionType): void;
  forfeit(matchId: string, leaveAfter?: boolean): void;
  createRoom(bet: number, password?: string, maxPlayers?: number): void;
  joinRoom(roomId: string, password?: string): void;
  leaveRoom(roomId?: string): void;
  kickRoomMember(roomId: string, userId: string): void;
  setRoomReady(roomId: string, ready: boolean): void;
  startRoom(roomId: string): void;
  listRooms(): void;
  getLeaderboard(period: LeaderboardPeriod): void;
  getHistory(): void;
  onUserInfo(handler: (data: UserInfoData) => void): () => void;
  onQueueWaiting(handler: () => void): () => void;
  onRoomList(handler: (data: RoomListData) => void): () => void;
  onRoomUpsert(handler: (data: RoomUpsertData) => void): () => void;
  onRoomRemoved(handler: (data: RoomRemovedData) => void): () => void;
  onRoomWaiting(handler: (data: RoomWaitingData) => void): () => void;
  onRoomState(handler: (data: RoomStateData) => void): () => void;
  onRoomSync(handler: (data: RoomSyncData) => void): () => void;
  onRoomClosed(handler: (data: RoomClosedData) => void): () => void;
  onRoomKicked(handler: (data: RoomKickedData) => void): () => void;
  onMatchFound(handler: (data: MatchFoundData<TState>) => void): () => void;
  onState(handler: (data: StateData<TState, TMove>) => void): () => void;
  onChat(handler: (data: ChatMessageData) => void): () => void;
  onReaction(handler: (data: ReactionData) => void): () => void;
  onMatchOver(handler: (data: MatchOverData<TState>) => void): () => void;
  onError(handler: (data: ErrorData) => void): () => void;
  onOpponentDisconnected(handler: (data: OpponentDisconnectedData) => void): () => void;
  onOpponentReconnected(handler: (data?: OpponentReconnectedData) => void): () => void;
  onLeaderboard(handler: (data: LeaderboardData) => void): () => void;
  onHistory(handler: (data: MatchHistoryData) => void): () => void;
  onConnectionChange(handler: (connected: boolean) => void): () => void;
  onConnectionError(handler: (error: Error) => void): () => void;
  disconnect(): void;
}

type Handler = (data: never) => void;

function normalizeConnectionError(error: Error): Error {
  const code = (error as Error & { data?: { code?: unknown } }).data?.code;
  if (code === 'AUTH_EXPIRED') return new GameAuthenticationExpiredError();
  if (code === 'AUTH_REQUIRED') return new GameAuthenticationRequiredError();
  const message = error.message.trim().toLowerCase();
  if (message === 'unauthorized') return new GameAuthenticationExpiredError();
  if (message === 'access_token is required') return new GameAuthenticationRequiredError();
  return error;
}

export async function joinGame<TState = unknown, TMove = unknown>(gameId: string): Promise<GameSession<TState, TMove>> {
  const token = await bridge.requestToken();
  const name = new URLSearchParams(location.search).get('name') ?? undefined;

  const socket: Socket = io('/', {
    auth: { token, gameId, ...(name && { name }) },
    transports: ['websocket', 'polling'],
  });

  const listeners = new Map<string, Set<Handler>>();

  const on = (type: string, handler: Handler): (() => void) => {
    let set = listeners.get(type);
    if (!set) {
      set = new Set();
      listeners.set(type, set);
    }
    set.add(handler);
    return () => listeners.get(type)?.delete(handler);
  };

  const emitLocal = (type: string, data: unknown): void => {
    listeners.get(type)?.forEach((handler) => (handler as (d: unknown) => void)(data));
  };

  socket.on('message', (envelope: Envelope) => {
    if (envelope?.type) emitLocal(envelope.type, envelope.data);
  });
  socket.on('connect', () => emitLocal('connection', true));
  socket.on('disconnect', () => emitLocal('connection', false));
  socket.on('connect_error', (error) => {
    emitLocal('connection', false);
    emitLocal('connection_error', normalizeConnectionError(error));
  });

  const send = (type: string, data?: unknown): void => {
    socket.emit('message', { type, data } satisfies Envelope);
  };

  return {
    userId: 'me',
    joinQueue: () => send(C2S.QueueJoin),
    leaveQueue: () => send(C2S.QueueLeave),
    sendMove: (matchId, move) => send(C2S.Move, { matchId, move }),
    sendChat: (matchId, text) => send(C2S.ChatSend, { matchId, text }),
    sendRoomChat: (roomId, text) => send(C2S.ChatSend, { roomId, text }),
    sendReaction: (matchId, type) => send(C2S.ReactionSend, { matchId, type }),
    forfeit: (matchId, leaveAfter = false) => send(C2S.Forfeit, { matchId, leaveAfter }),
    createRoom: (bet, password, maxPlayers) => send(C2S.RoomCreate, { bet, password, ...(maxPlayers ? { maxPlayers } : {}) }),
    joinRoom: (roomId, password) => send(C2S.RoomJoin, { roomId, password }),
    leaveRoom: (roomId) => send(C2S.RoomLeave, roomId ? { roomId } : undefined),
    kickRoomMember: (roomId, userId) => send(C2S.RoomKick, { roomId, userId }),
    setRoomReady: (roomId, ready) => send(C2S.RoomReady, { roomId, ready }),
    startRoom: (roomId) => send(C2S.RoomStart, { roomId }),
    listRooms: () => send(C2S.RoomList),
    getLeaderboard: (period) => send(C2S.Leaderboard, { period }),
    getHistory: () => send(C2S.History),
    onUserInfo: (handler) => on(S2C.UserInfo, handler as Handler),
    onQueueWaiting: (handler) => on(S2C.QueueWaiting, handler as Handler),
    onRoomList: (handler) => on(S2C.RoomList, handler as Handler),
    onRoomUpsert: (handler) => on(S2C.RoomUpsert, handler as Handler),
    onRoomRemoved: (handler) => on(S2C.RoomRemoved, handler as Handler),
    onRoomWaiting: (handler) => on(S2C.RoomWaiting, handler as Handler),
    onRoomState: (handler) => on(S2C.RoomState, handler as Handler),
    onRoomSync: (handler) => on(S2C.RoomSync, handler as Handler),
    onRoomClosed: (handler) => on(S2C.RoomClosed, handler as Handler),
    onRoomKicked: (handler) => on(S2C.RoomKicked, handler as Handler),
    onMatchFound: (handler) => on(S2C.MatchFound, handler as Handler),
    onState: (handler) => on(S2C.State, handler as Handler),
    onChat: (handler) => on(S2C.ChatMessage, handler as Handler),
    onReaction: (handler) => on(S2C.Reaction, handler as Handler),
    onMatchOver: (handler) => on(S2C.MatchOver, handler as Handler),
    onError: (handler) => on(S2C.Error, handler as Handler),
    onOpponentDisconnected: (handler) => on(S2C.OpponentDisconnected, handler as Handler),
    onOpponentReconnected: (handler) => on(S2C.OpponentReconnected, handler as Handler),
    onLeaderboard: (handler) => on(S2C.Leaderboard, handler as Handler),
    onHistory: (handler) => on(S2C.History, handler as Handler),
    onConnectionChange: (handler) => on('connection', handler as Handler),
    onConnectionError: (handler) => on('connection_error', handler as Handler),
    disconnect: () => socket.disconnect(),
  };
}
