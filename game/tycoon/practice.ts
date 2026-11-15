import type { ErrorData, GameSession, MatchFoundData, MatchOverData, PlayerInfo, StateData } from '../src/sdk';
import { GAME_ERROR_CODE, S2C } from '../src/sdk/protocol';
import { botMove, botRng } from './logic/bot';
import { ERROR_PREFIX, GAME_ID, TIME_LIMIT_MS, TURN_SECONDS } from './logic/constants';
import { applyMove, endByTime, isNewTurn, isOver, moveOnTimeout, newGame, quitPlayer, rankings } from './logic/engine';
import { RuleError, type BotLevel, type GameState, type Move, type TycoonView } from './logic/types';
import type { BotReply, BotRequest } from './logic/bot.worker';
import { viewFor } from './logic/view';
import { botName, type BotSetupItem } from './helpers/bot';

const YOU = 0;
const TURN_MS = TURN_SECONDS * 1000;
const BOT_REPLY_TIMEOUT_MS = 8000;
let practiceMatchSeq = 0;
export const BOT_DELAY_MS = { roll: 750, manage: 650, think: 950, card: 1300 };

export interface BotWorkerLike {
  postMessage(request: BotRequest): void;
  terminate(): void;
  onmessage: ((event: MessageEvent<BotReply>) => void) | null;
  onerror: ((event: ErrorEvent) => void) | null;
}

export interface PracticeOptions {
  user: { id: string; username: string; vipType?: string | null };
  bots: readonly BotSetupItem[];
  speed: () => number;
  random?: () => number;
  createBotWorker?: () => BotWorkerLike | null;
}

export interface PracticeSession extends GameSession<TycoonView, Move> {
  readonly practice: true;
  readonly players: readonly PlayerInfo[];
  start(): void;
  idle(): number;
}

type Handler = (data: never) => void;
type ServerEventType = (typeof S2C)[keyof typeof S2C];

interface BotRequestState {
  id: number;
  current: GameState;
  seat: number;
  level: BotLevel;
  count: number;
  reply: { move: Move | null } | null;
  due: boolean;
}

function defaultBotWorker(): BotWorkerLike | null {
  if (typeof Worker === 'undefined') return null;
  try {
    return new Worker(new URL('./logic/bot.worker.ts', import.meta.url), { type: 'module' });
  } catch {
    return null;
  }
}

function botDelay(state: GameState): number {
  if (state.phase === 'card') return BOT_DELAY_MS.card;
  if (state.phase === 'roll') return BOT_DELAY_MS.roll;
  if (state.phase === 'manage') return BOT_DELAY_MS.manage;
  return BOT_DELAY_MS.think;
}

export function createPracticeSession({
  user,
  bots,
  speed,
  random = Math.random,
  createBotWorker = defaultBotWorker,
}: PracticeOptions): PracticeSession {
  const listeners = new Map<ServerEventType, Set<Handler>>();
  const players: PlayerInfo[] = [
    { id: user.id, name: user.username, vipType: user.vipType ?? null },
    ...bots.map((bot, i) => ({ id: `bot-${bot.id}`, name: botName(i), vipType: String(bot.vip) })),
  ];
  const timers = new Set<ReturnType<typeof setTimeout>>();
  let state: GameState | null = null;
  let seed = 0;
  let botMoves: number[] = [];
  let matchId = '';
  let startedAt = 0;
  let newTurnPending = false;
  let worker: BotWorkerLike | null = null;
  let workerFailed = false;
  let requestSeq = 0;
  let pending: BotRequestState | null = null;

  const on = (type: ServerEventType, handler: Handler): (() => void) => {
    let set = listeners.get(type);
    if (!set) {
      set = new Set();
      listeners.set(type, set);
    }
    set.add(handler);
    return () => listeners.get(type)?.delete(handler);
  };

  const emit = (type: ServerEventType, data: unknown): void => {
    listeners.get(type)?.forEach((handler) => (handler as (d: unknown) => void)(data));
  };

  const later = (ms: number, fn: () => void): void => {
    const timer = setTimeout(() => {
      timers.delete(timer);
      fn();
    }, ms);
    timers.add(timer);
  };

  const clearTimers = (): void => {
    timers.forEach((timer) => clearTimeout(timer));
    timers.clear();
  };

  const view = (s: GameState): TycoonView => ({ ...viewFor(s, YOU), startedAt });

  const finish = (s: GameState): void => {
    clearTimers();
    const order = rankings(s);
    emit(S2C.MatchOver, {
      matchId,
      winnerId: order[0] != null ? players[order[0]].id : undefined,
      reason: s.players[YOU].quit ? 'forfeit' : 'win',
      state: view(s),
      rankings: order.map((seat, i) => ({ userId: players[seat].id, place: i + 1 })),
    } satisfies MatchOverData<TycoonView>);
  };

  const act = (seat: number, move: Move, autoMoved = false, retry = true): void => {
    if (!state || state.finished) return;
    let next: GameState;
    try {
      next = applyMove(state, seat, move);
    } catch (error) {
      if (seat === YOU) {
        const code = error instanceof RuleError ? error.code : 'invalid_move';
        emit(S2C.Error, { code: GAME_ERROR_CODE.InvalidMove, message: `${ERROR_PREFIX}${code}` } satisfies ErrorData);
        return;
      }
      const fallback = retry ? moveOnTimeout(state, seat) : null;
      if (fallback) act(seat, fallback, true, false);
      else commit(seat, move, quitPlayer(state, seat), true);
      return;
    }
    commit(seat, move, next, autoMoved);
  };

  const commit = (seat: number, move: Move, next: GameState, autoMoved: boolean): void => {
    if (!state) return;
    clearTimers();
    newTurnPending = isNewTurn(state, next);
    state = next;
    emit(S2C.State, {
      matchId,
      state: view(next),
      turn: next.turn,
      deadline: 0,
      lastMove: move,
      lastBy: seat,
      ...(autoMoved ? { autoMoved: true } : {}),
    } satisfies StateData<TycoonView, Move>);
    if (isOver(next)) finish(next);
  };

  const syncBotMove = (current: GameState, seat: number, level: BotLevel, count: number): Move | null => {
    try {
      return botMove(current, seat, level, botRng(seed, seat, count));
    } catch {
      return null;
    }
  };

  const playBot = (current: GameState, seat: number, move: Move | null): void => {
    botMoves[seat]++;
    const chosen = move ?? moveOnTimeout(current, seat);
    if (chosen) act(seat, chosen);
  };

  const tryApply = (request: BotRequestState): void => {
    if (pending !== request || !request.reply || !request.due) return;
    pending = null;
    if (state !== request.current) return;
    playBot(request.current, request.seat, request.reply.move);
  };

  const stopWorker = (): void => {
    if (!worker) return;
    worker.onmessage = null;
    worker.onerror = null;
    worker.terminate();
    worker = null;
  };

  const dropPending = (): void => {
    if (pending && !pending.reply) stopWorker();
    pending = null;
  };

  const failWorker = (): void => {
    stopWorker();
    workerFailed = true;
    const request = pending;
    if (!request || request.reply) return;
    if (state !== request.current) {
      pending = null;
      return;
    }
    request.reply = { move: syncBotMove(request.current, request.seat, request.level, request.count) };
    tryApply(request);
  };

  const botWorker = (): BotWorkerLike | null => {
    if (worker || workerFailed) return worker;
    try {
      worker = createBotWorker();
    } catch {
      worker = null;
    }
    if (!worker) {
      workerFailed = true;
      return null;
    }
    worker.onmessage = (event) => {
      const request = pending;
      if (!request || request.reply || event.data.id !== request.id) return;
      request.reply = { move: event.data.move };
      tryApply(request);
    };
    worker.onerror = () => failWorker();
    return worker;
  };

  const askBot = (current: GameState, seat: number, level: BotLevel, delay: number): boolean => {
    const target = botWorker();
    if (!target) return false;
    const request: BotRequestState = { id: ++requestSeq, current, seat, level, count: botMoves[seat], reply: null, due: false };
    pending = request;
    try {
      target.postMessage({ id: request.id, state: current, seat, level, seed, count: request.count });
    } catch {
      pending = null;
      stopWorker();
      workerFailed = true;
      return false;
    }
    later(delay, () => {
      if (pending !== request) return;
      request.due = true;
      tryApply(request);
    });
    later(delay + BOT_REPLY_TIMEOUT_MS, () => {
      if (pending === request && !request.reply) failWorker();
    });
    return true;
  };

  const unsupported = (): void => undefined;

  return {
    practice: true,
    players,
    userId: user.id,

    start() {
      clearTimers();
      dropPending();
      practiceMatchSeq += 1;
      matchId = `practice-${practiceMatchSeq}`;
      startedAt = Date.now();
      newTurnPending = false;
      seed = Math.floor(random() * 2 ** 31) + 1;
      botMoves = players.map(() => 0);
      state = newGame(seed, players.length);
      emit(S2C.MatchFound, {
        matchId,
        gameId: GAME_ID,
        players,
        you: YOU,
        state: view(state),
        turn: state.turn,
        deadline: 0,
      } satisfies MatchFoundData<TycoonView>);
    },

    idle() {
      clearTimers();
      dropPending();
      if (!state || state.finished) return 0;
      if (newTurnPending && Date.now() - startedAt >= TIME_LIMIT_MS) {
        newTurnPending = false;
        state = endByTime(state);
        finish(state);
        return 0;
      }
      newTurnPending = false;
      const current = state;
      const seat = current.turn;
      if (seat !== YOU) {
        const level = bots[seat - 1]?.level ?? 'normal';
        const delay = botDelay(current) / speed();
        if (level === 'hard' && askBot(current, seat, level, delay)) return 0;
        later(delay, () => {
          if (state !== current) return;
          playBot(current, seat, syncBotMove(current, seat, level, botMoves[seat]));
        });
        return 0;
      }
      later(TURN_MS, () => {
        if (state !== current) return;
        const move = moveOnTimeout(current, YOU);
        if (move) act(YOU, move, true);
      });
      return Date.now() + TURN_MS;
    },

    sendMove(id, move) {
      if (id !== matchId || !state) return;
      if (state.turn !== YOU) {
        emit(S2C.Error, { code: GAME_ERROR_CODE.NotYourTurn, message: '' } satisfies ErrorData);
        return;
      }
      act(YOU, move);
    },

    forfeit(id) {
      if (id !== matchId || !state || state.finished) return;
      const next = quitPlayer(state, YOU);
      next.finished = true;
      state = next;
      finish(next);
    },

    disconnect() {
      clearTimers();
      pending = null;
      stopWorker();
      listeners.clear();
      state = null;
    },

    joinQueue: unsupported,
    leaveQueue: unsupported,
    sendChat: unsupported,
    sendRoomChat: unsupported,
    sendReaction: unsupported,
    createRoom: unsupported,
    joinRoom: unsupported,
    leaveRoom: unsupported,
    kickRoomMember: unsupported,
    setRoomReady: unsupported,
    startRoom: unsupported,
    listRooms: unsupported,
    getLeaderboard: unsupported,
    getHistory: unsupported,
    spectateList: unsupported,
    spectateJoin: unsupported,
    spectateLeave: unsupported,
    roomWatch: unsupported,
    roomUnwatch: unsupported,

    onUserInfo: (handler) => on(S2C.UserInfo, handler),
    onQueueWaiting: (handler) => on(S2C.QueueWaiting, handler),
    onRoomList: (handler) => on(S2C.RoomList, handler),
    onRoomUpsert: (handler) => on(S2C.RoomUpsert, handler),
    onRoomRemoved: (handler) => on(S2C.RoomRemoved, handler),
    onRoomWaiting: (handler) => on(S2C.RoomWaiting, handler),
    onRoomState: (handler) => on(S2C.RoomState, handler),
    onRoomSync: (handler) => on(S2C.RoomSync, handler),
    onRoomClosed: (handler) => on(S2C.RoomClosed, handler),
    onRoomKicked: (handler) => on(S2C.RoomKicked, handler),
    onMatchFound: (handler) => on(S2C.MatchFound, handler),
    onState: (handler) => on(S2C.State, handler),
    onChat: (handler) => on(S2C.ChatMessage, handler),
    onReaction: (handler) => on(S2C.Reaction, handler),
    onMatchOver: (handler) => on(S2C.MatchOver, handler),
    onError: (handler) => on(S2C.Error, handler),
    onOpponentDisconnected: (handler) => on(S2C.OpponentDisconnected, handler),
    onOpponentReconnected: (handler) => on(S2C.OpponentReconnected, handler),
    onLeaderboard: (handler) => on(S2C.Leaderboard, handler),
    onHistory: (handler) => on(S2C.History, handler),
    onSpectateList: (handler) => on(S2C.SpectateList, handler),
    onSpectateJoined: (handler) => on(S2C.SpectateJoined, handler),
    onSpectateLeft: (handler) => on(S2C.SpectateLeft, handler),
    onSpectators: (handler) => on(S2C.Spectators, handler),
    onConnectionChange: () => () => undefined,
    onConnectionError: () => () => undefined,
  };
}
