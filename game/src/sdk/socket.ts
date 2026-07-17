import { io, type Socket } from 'socket.io-client';
import { bridge } from './bridge';
import {
  C2S,
  S2C,
  type Envelope,
  type ErrorData,
  type MatchFoundData,
  type MatchOverData,
  type StateData,
  type UserInfoData,
} from './protocol';

export type GameStatus = 'connecting' | 'idle' | 'queueing' | 'playing' | 'over';

export interface GameSession<TState = unknown, TMove = unknown> {
  readonly userId: string;
  joinQueue(): void;
  leaveQueue(): void;
  sendMove(move: TMove): void;
  forfeit(): void;
  onUserInfo(handler: (data: UserInfoData) => void): () => void;
  onQueueWaiting(handler: () => void): () => void;
  onMatchFound(handler: (data: MatchFoundData<TState>) => void): () => void;
  onState(handler: (data: StateData<TState, TMove>) => void): () => void;
  onMatchOver(handler: (data: MatchOverData<TState>) => void): () => void;
  onError(handler: (data: ErrorData) => void): () => void;
  onConnectionChange(handler: (connected: boolean) => void): () => void;
  disconnect(): void;
}

type Handler = (data: never) => void;

export async function joinGame<TState = unknown, TMove = unknown>(
  gameId: string,
): Promise<GameSession<TState, TMove>> {
  const token = await bridge.requestToken();
  const name = new URLSearchParams(location.search).get('name') ?? undefined;
  const userId = token.startsWith('guest:') ? token.slice(6) : 'me';

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
  socket.on('connect_error', () => emitLocal('connection', false));

  const send = (type: string, data?: unknown): void => {
    socket.emit('message', { type, data } satisfies Envelope);
  };

  return {
    userId,
    joinQueue: () => send(C2S.QueueJoin),
    leaveQueue: () => send(C2S.QueueLeave),
    sendMove: (move) => send(C2S.Move, move),
    forfeit: () => send(C2S.Forfeit),
    onUserInfo: (handler) => on(S2C.UserInfo, handler as Handler),
    onQueueWaiting: (handler) => on(S2C.QueueWaiting, handler as Handler),
    onMatchFound: (handler) => on(S2C.MatchFound, handler as Handler),
    onState: (handler) => on(S2C.State, handler as Handler),
    onMatchOver: (handler) => on(S2C.MatchOver, handler as Handler),
    onError: (handler) => on(S2C.Error, handler as Handler),
    onConnectionChange: (handler) => on('connection', handler as Handler),
    disconnect: () => socket.disconnect(),
  };
}
