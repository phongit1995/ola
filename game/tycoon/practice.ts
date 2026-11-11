import type { ErrorData, GameSession, MatchFoundData, MatchOverData, PlayerInfo, StateData } from '../src/sdk';
import { GAME_ERROR_CODE, S2C } from '../src/sdk/protocol';
import { botMove } from './logic/bot';
import { ERROR_PREFIX, GAME_ID, TIME_LIMIT_MS, TURN_SECONDS } from './logic/constants';
import { applyMove, endByTime, isNewTurn, isOver, moveOnTimeout, newGame, quitPlayer, rankings } from './logic/engine';
import { RuleError, type GameState, type Move, type TycoonView } from './logic/types';
import { viewFor } from './logic/view';
import { botName, type BotSetupItem } from './helpers/bot';

const YOU = 0;
const TURN_MS = TURN_SECONDS * 1000;
export const BOT_DELAY_MS = { card: 950, quick: 150, think: 360 };

export interface PracticeOptions {
  user: { id: string; username: string; vipType?: string | null };
  bots: readonly BotSetupItem[];
  speed: () => number;
  random?: () => number;
}

export interface PracticeSession extends GameSession<TycoonView, Move> {
  readonly practice: true;
  readonly players: readonly PlayerInfo[];
  start(): void;
  idle(): number;
}

type Handler = (data: never) => void;
type ServerEventType = (typeof S2C)[keyof typeof S2C];

function botDelay(state: GameState): number {
  if (state.phase === 'card') return BOT_DELAY_MS.card;
  if (state.phase === 'manage' || state.phase === 'roll') return BOT_DELAY_MS.quick;
  return BOT_DELAY_MS.think;
}

export function createPracticeSession({ user, bots, speed, random = Math.random }: PracticeOptions): PracticeSession {
  const listeners = new Map<ServerEventType, Set<Handler>>();
  const players: PlayerInfo[] = [
    { id: user.id, name: user.username, vipType: user.vipType ?? null },
    ...bots.map((bot, i) => ({ id: `bot-${bot.id}`, name: botName(i), vipType: String(bot.vip) })),
  ];
  const timers = new Set<ReturnType<typeof setTimeout>>();
  let state: GameState | null = null;
  let matchId = '';
  let matchCount = 0;
  let startedAt = 0;
  let newTurnPending = false;

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

  const act = (seat: number, move: Move, autoMoved = false): void => {
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
      const fallback = moveOnTimeout(state, seat);
      if (fallback && fallback.type !== move.type) act(seat, fallback, true);
      return;
    }
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

  const unsupported = (): void => undefined;

  return {
    practice: true,
    players,
    userId: user.id,

    start() {
      clearTimers();
      matchCount += 1;
      matchId = `practice-${matchCount}`;
      startedAt = Date.now();
      newTurnPending = false;
      state = newGame(Math.floor(random() * 2 ** 31) + 1, players.length);
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
        later(botDelay(current) / speed(), () => {
          if (state !== current) return;
          const move = botMove(current, seat) ?? moveOnTimeout(current, seat);
          if (move) act(seat, move);
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
