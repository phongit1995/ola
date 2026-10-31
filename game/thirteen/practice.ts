import type {
  ChatMessageData,
  ErrorData,
  GameReactionType,
  GameSession,
  MatchFoundData,
  MatchOverData,
  PlayerInfo,
  ReactionData,
  StateData,
} from '../src/sdk';
import { GAME_ERROR_CODE, GAME_REACTION_TYPE, S2C } from '../src/sdk/protocol';
import { chooseBotMove } from './logic/bot';
import { rankOf } from './logic/cards';
import { GAME_ID, RANK_TWO, TURN_SECONDS } from './logic/constants.gen';
import {
  applyMove,
  checkMove,
  cloneState,
  isOver,
  MoveError,
  newDeal,
  rankings,
  skipTurn,
  turnStartDelayMs,
  viewFor,
  winnerSeat,
  type EngineState,
} from './logic/engine';
import type { ServerMove, ServerState } from './logic/server-types';
import { botName, type BotSetupItem } from './helpers/practice';
import {
  BOT_CHAT_CHANCE,
  BOT_CHAT_LINES,
  BOT_REACTIONS,
  botReplyLines,
  pickLine,
  type BotChatEvent,
} from './helpers/practiceChat';

const TURN_MS = TURN_SECONDS * 1000;
const THINK_MIN_MS = 600;
const THINK_SPREAD_MS = 800;
const BOT_TALK_GAP_MS = 4000;
const GREET_DELAY_MS = 900;
const REPLY_DELAY_MS = 900;
const MAX_CHAT_LENGTH = 120;
const CHAT_GAP_MS = 500;
const REACTION_GAP_MS = 800;
const YOU = 0;

export interface PracticeOptions {
  user: { id: string; username: string; vipType?: string | null };
  bots: readonly BotSetupItem[];
  random?: () => number;
}

type Handler = (data: never) => void;
type ServerEventType = (typeof S2C)[keyof typeof S2C];

export function createPracticeSession({ user, bots, random = Math.random }: PracticeOptions): GameSession<ServerState, ServerMove> {
  const listeners = new Map<ServerEventType, Set<Handler>>();
  const sessionId = globalThis.crypto?.randomUUID?.() ?? `${Date.now().toString(36)}-${random().toString(36).slice(2)}`;
  const players: PlayerInfo[] = [
    { id: user.id, name: user.username, vipType: user.vipType ?? null },
    ...bots.map((bot, i) => ({ id: `bot-${i + 1}`, name: botName(i), vipType: bot.vipType })),
  ];
  const timers = new Set<ReturnType<typeof setTimeout>>();
  let turnTimer: ReturnType<typeof setTimeout> | undefined;
  let state: EngineState | null = null;
  let played: number[] = [];
  let matchId = '';
  let matchCount = 0;
  let lastChatAt = 0;
  let lastReactionAt = 0;
  const lastTalkAt = new Map<number, number>();
  let lastLine = '';

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
    if (turnTimer) clearTimeout(turnTimer);
    turnTimer = undefined;
  };

  const emitError = (code: string, message: string): void => {
    emit(S2C.Error, { code, message } satisfies ErrorData);
  };

  const emitChat = (seat: number, text: string): void => {
    emit(S2C.ChatMessage, { matchId, userId: players[seat].id, name: players[seat].name, text, sentAt: Date.now() } satisfies ChatMessageData);
  };

  const emitReaction = (seat: number, type: GameReactionType): void => {
    emit(S2C.Reaction, { matchId, userId: players[seat].id, type, sentAt: Date.now() } satisfies ReactionData);
  };

  const botTalk = (seat: number, event: BotChatEvent, delayMs: number): void => {
    if (seat === YOU || seat < 0 || random() >= BOT_CHAT_CHANCE[event]) return;
    const now = Date.now();
    if (now - (lastTalkAt.get(seat) ?? 0) < BOT_TALK_GAP_MS) return;
    lastTalkAt.set(seat, now);
    const forMatch = matchId;
    const reactions = BOT_REACTIONS[event];
    const react = reactions != null && random() < 0.5;
    const text = react ? '' : pickLine(BOT_CHAT_LINES[event], random, lastLine);
    if (text) lastLine = text;
    later(delayMs, () => {
      if (matchId !== forMatch) return;
      if (react) emitReaction(seat, reactions[Math.floor(random() * reactions.length)]);
      else emitChat(seat, text);
    });
  };

  const someBot = (except = -1): number => {
    const seats = players.map((_, seat) => seat).filter((seat) => seat !== YOU && seat !== except);
    return seats[Math.floor(random() * seats.length)] ?? -1;
  };

  const reactToSteps = (before: EngineState, after: EngineState): void => {
    for (const step of after.steps) {
      if (step.kind === 'play' && step.chop) {
        botTalk(step.by, 'chop', 500);
        const victim = before.table?.by ?? -1;
        if (victim >= 0) botTalk(victim, 'chopped', 1100);
      } else if (step.kind === 'play' && step.cards?.some((card) => rankOf(card) === RANK_TWO) && step.by === YOU) {
        botTalk(someBot(), 'twoPlayed', 700);
      } else if (step.kind === 'pass') {
        botTalk(step.by, 'pass', 200);
      } else if (step.kind === 'finish' && step.place === 1) {
        if (step.by === YOU) botTalk(someBot(), 'youFirst', 800);
        else botTalk(step.by, 'finishFirst', 600);
      }
    }
  };

  const finish = (): void => {
    if (!state) return;
    clearTimers();
    const order = rankings(state);
    const winner = winnerSeat(state);
    emit(S2C.MatchOver, {
      matchId,
      winnerId: winner >= 0 ? players[winner].id : undefined,
      reason: 'win',
      state: viewFor(state, YOU),
      rankings: order.map((seat, i) => ({ userId: players[seat].id, place: i + 1 })),
    } satisfies MatchOverData<ServerState>);
  };

  const armTurn = (previousSeat: number): number => {
    if (!state) return Date.now();
    const delay = turnStartDelayMs(state.steps, previousSeat);
    const deadline = Date.now() + delay + TURN_MS;
    if (state.turn === YOU) {
      const forMatch = matchId;
      turnTimer = setTimeout(() => {
        turnTimer = undefined;
        if (!state || matchId !== forMatch || state.turn !== YOU) return;
        act(YOU, null);
      }, delay + TURN_MS);
    } else {
      const seat = state.turn;
      later(delay + THINK_MIN_MS + random() * THINK_SPREAD_MS, () => botMove(seat));
    }
    return deadline;
  };

  const act = (seat: number, move: ServerMove | null): void => {
    if (!state) return;
    if (turnTimer) clearTimeout(turnTimer);
    turnTimer = undefined;
    const before = state;
    const next = cloneState(state);
    if (move) applyMove(next, seat, move);
    else skipTurn(next, seat);
    state = next;
    for (const step of next.steps) if (step.kind === 'play') played.push(...(step.cards ?? []));
    reactToSteps(before, next);
    const over = isOver(next);
    const deadline = over ? Date.now() : armTurn(seat);
    emit(S2C.State, {
      matchId,
      state: viewFor(next, YOU),
      turn: over ? -1 : next.turn,
      deadline,
      lastBy: seat,
      ...(move ? { lastMove: move } : { autoMoved: true }),
    } satisfies StateData<ServerState, ServerMove>);
    if (over) finish();
  };

  const botMove = (seat: number): void => {
    if (!state || state.turn !== seat || isOver(state)) return;
    const move = chooseBotMove(
      {
        seat,
        hand: state.hands[seat],
        table: state.table,
        require3s: state.require3s,
        handCounts: state.hands.map((hand) => hand.length),
        played,
      },
      bots[seat - 1]?.level ?? 'normal',
      random,
    );
    try {
      act(seat, move);
    } catch {
      act(seat, null);
    }
  };

  const startDeal = (): void => {
    clearTimers();
    matchCount += 1;
    matchId = `practice-${sessionId}-${matchCount}`;
    played = [];
    lastTalkAt.clear();
    state = newDeal(players.length, random);
    const over = isOver(state);
    const deadline = over ? Date.now() : armTurn(-1);
    emit(S2C.MatchFound, {
      matchId,
      gameId: GAME_ID,
      players,
      you: YOU,
      state: viewFor(state, YOU),
      turn: over ? -1 : state.turn,
      deadline,
      bet: 0,
    } satisfies MatchFoundData<ServerState>);
    if (over) {
      finish();
      return;
    }
    botTalk(someBot(), 'greet', GREET_DELAY_MS);
  };

  return {
    userId: user.id,

    joinQueue: startDeal,
    leaveQueue() {},

    sendMove(requestMatchId, move) {
      if (!state || requestMatchId !== matchId || isOver(state)) {
        emitError(GAME_ERROR_CODE.NoMatch, 'Ván đấu không còn hoạt động');
        return;
      }
      if (state.turn !== YOU) {
        emitError(GAME_ERROR_CODE.NotYourTurn, 'Chưa đến lượt của bạn');
        return;
      }
      try {
        checkMove(state, YOU, move);
      } catch (error) {
        if (error instanceof MoveError) {
          emitError(GAME_ERROR_CODE.InvalidMove, error.message);
          return;
        }
        throw error;
      }
      act(YOU, move);
    },

    sendChat(requestMatchId, text) {
      if (!state || requestMatchId !== matchId) return;
      const characters = Array.from(text.trim());
      if (characters.length === 0) return;
      if (characters.length > MAX_CHAT_LENGTH) {
        emitError(GAME_ERROR_CODE.ChatTooLong, 'Tin nhắn tối đa 120 ký tự');
        return;
      }
      const now = Date.now();
      if (now - lastChatAt < CHAT_GAP_MS) {
        emitError(GAME_ERROR_CODE.ChatRateLimited, 'Bạn gửi tin nhắn quá nhanh');
        return;
      }
      lastChatAt = now;
      const message = characters.join('');
      emitChat(YOU, message);
      const replier = someBot();
      if (replier < 0) return;
      const forMatch = matchId;
      const line = pickLine(botReplyLines(message), random, lastLine);
      lastLine = line;
      later(REPLY_DELAY_MS + random() * 800, () => {
        if (matchId === forMatch) emitChat(replier, line);
      });
    },
    sendRoomChat() {},

    sendReaction(requestMatchId, type) {
      if (!state || requestMatchId !== matchId) return;
      if (!Object.values(GAME_REACTION_TYPE).includes(type)) {
        emitError(GAME_ERROR_CODE.InvalidReaction, 'Cảm xúc không hợp lệ');
        return;
      }
      const now = Date.now();
      if (now - lastReactionAt < REACTION_GAP_MS) {
        emitError(GAME_ERROR_CODE.ReactionRateLimited, 'Bạn thả cảm xúc quá nhanh');
        return;
      }
      lastReactionAt = now;
      emitReaction(YOU, type);
    },

    forfeit() {
      clearTimers();
      state = null;
      matchId = '';
    },

    createRoom() {},
    joinRoom() {},
    leaveRoom() {},
    kickRoomMember() {},
    setRoomReady() {},
    startRoom() {},
    listRooms() {},
    getLeaderboard() {},
    getHistory() {},
    spectateList() {},
    spectateJoin() {},
    spectateLeave() {},

    onUserInfo: () => () => {},
    onQueueWaiting: () => () => {},
    onRoomList: () => () => {},
    onRoomUpsert: () => () => {},
    onRoomRemoved: () => () => {},
    onRoomWaiting: () => () => {},
    onRoomState: () => () => {},
    onRoomSync: () => () => {},
    onRoomClosed: () => () => {},
    onRoomKicked: () => () => {},
    onMatchFound: (handler) => on(S2C.MatchFound, handler as Handler),
    onState: (handler) => on(S2C.State, handler as Handler),
    onChat: (handler) => on(S2C.ChatMessage, handler as Handler),
    onReaction: (handler) => on(S2C.Reaction, handler as Handler),
    onMatchOver: (handler) => on(S2C.MatchOver, handler as Handler),
    onError: (handler) => on(S2C.Error, handler as Handler),
    onOpponentDisconnected: () => () => {},
    onOpponentReconnected: () => () => {},
    onLeaderboard: () => () => {},
    onHistory: () => () => {},
    onSpectateList: () => () => {},
    onSpectateJoined: () => () => {},
    onSpectateLeft: () => () => {},
    onConnectionChange: () => () => {},
    onConnectionError: () => () => {},

    disconnect() {
      clearTimers();
      state = null;
      matchId = '';
      listeners.clear();
    },
  };
}
