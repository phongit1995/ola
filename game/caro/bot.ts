import {
  GAME_ERROR_CODE,
  S2C,
  type ChatMessageData,
  type ErrorData,
  type GameSession,
  type MatchFoundData,
  type MatchOverData,
  type StateData,
} from '../src/sdk';
import {
  SIZE,
  checkWin,
  emptyState,
  scorePlacement,
  type BotLevel,
  type CaroMove,
  type CaroState,
} from './types';

const TURN_MS = (Number(import.meta.env.VITE_GAME_TURN_SECONDS) || 45) * 1000;
const PLAYER_MARK = 1;
const BOT_MARK = 2;
const TURN_ANNOUNCE_MS = 1080;
const MAX_CHAT_LENGTH = 120;

export const BOT_LEVELS: Record<BotLevel, { name: string; thinkMs: number }> = {
  easy: { name: 'Máy · Dễ', thinkMs: 350 },
  normal: { name: 'Máy · Thường', thinkMs: 500 },
  hard: { name: 'Máy · Khó', thinkMs: 650 },
};

const BOT_GREETINGS: Record<BotLevel, string[]> = {
  easy: ['Chào bạn! Mình mới tập chơi thôi 😄', 'Chơi vui nhé, nhẹ tay với mình nha!'],
  normal: ['Chào bạn, bắt đầu nhé!', 'Một ván Caro thật hay nào!'],
  hard: ['Chào đối thủ. Mình sẽ chơi nghiêm túc đấy!', 'Sẵn sàng chưa? Đừng để mình có bốn quân nhé.'],
};

const BOT_REPLIES = [
  'Hay đấy!',
  'Mình đang suy nghĩ đây 🤔',
  'Chúc bạn may mắn!',
  'Nước đi thú vị đó.',
  'Cẩn thận nhé, mình sắp phản công rồi!',
];

const BOT_MOVE_LINES = ['Đến lượt bạn đó!', 'Mình đi xong rồi nhé.', 'Thử chặn nước này xem!'];

type Handler = (data: never) => void;
type ServerEventType = (typeof S2C)[keyof typeof S2C];

export function createBotSession(level: BotLevel): GameSession<CaroState, CaroMove> {
  const listeners = new Map<ServerEventType, Set<Handler>>();
  const sessionId =
    globalThis.crypto?.randomUUID?.() ??
    `${Date.now().toString(36)}-${Math.random().toString(36).slice(2)}`;
  let state = emptyState();
  let matchId = '';
  let matchCount = 0;
  let playing = false;
  let playerTurn = true;
  let turnTimer: number | undefined;
  let botTimer: number | undefined;
  let lastPlayerChatAt = 0;
  const chatTimers = new Set<number>();

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

  const clearTimers = (): void => {
    if (turnTimer) window.clearTimeout(turnTimer);
    if (botTimer) window.clearTimeout(botTimer);
    turnTimer = undefined;
    botTimer = undefined;
    chatTimers.forEach((timer) => window.clearTimeout(timer));
    chatTimers.clear();
  };

  const randomLine = (lines: string[]): string => lines[Math.floor(Math.random() * lines.length)];

  const emitChat = (userId: 'you' | 'bot', name: string, text: string): void => {
    emit(S2C.ChatMessage, {
      matchId,
      userId,
      name,
      text,
      sentAt: Date.now(),
    } satisfies ChatMessageData);
  };

  const scheduleBotChat = (text: string, delayMs: number): void => {
    const scheduledMatchID = matchId;
    const timer = window.setTimeout(() => {
      chatTimers.delete(timer);
      if (!playing || matchId !== scheduledMatchID) return;
      emitChat('bot', BOT_LEVELS[level].name, text);
    }, delayMs);
    chatTimers.add(timer);
  };

  const botReply = (message: string): string => {
    const normalized = message.toLocaleLowerCase('vi-VN');
    if (/\b(chào|hello|hi)\b/u.test(normalized)) return 'Chào bạn! Chúng ta chơi vui nhé 😄';
    if (normalized.includes('khó')) return level === 'hard' ? 'Khó mới vui chứ!' : 'Mình cũng đang cố hết sức đây!';
    if (normalized.includes('hay')) return 'Cảm ơn bạn, nước của bạn cũng hay lắm!';
    return randomLine(BOT_REPLIES);
  };

  const deadline = (): number => Date.now() + TURN_MS;

  const armPlayerTimeout = (): void => {
    if (turnTimer) window.clearTimeout(turnTimer);
    turnTimer = window.setTimeout(() => finish('bot', 'timeout'), TURN_MS);
  };

  const finish = (winner: 'you' | 'bot' | null, reason: MatchOverData['reason']): void => {
    playing = false;
    clearTimers();
    emit(S2C.MatchOver, {
      matchId,
      winnerId: winner ?? '',
      reason,
      state,
    } satisfies MatchOverData<CaroState>);
  };

  const pushState = (turn: number, lastMove: CaroMove, lastBy: number): void => {
    emit(S2C.State, {
      matchId,
      state,
      turn,
      deadline: deadline(),
      lastMove,
      lastBy,
    } satisfies StateData<CaroState, CaroMove>);
  };

  const applyMove = (move: CaroMove, mark: number): void => {
    state.board[move.y * SIZE + move.x] = mark;
    state.moveCount++;
    state.lastX = move.x;
    state.lastY = move.y;
  };

  const botMove = (): void => {
    const move = pickBotMove(state.board, level);
    if (!move) {
      finish(null, 'draw');
      return;
    }
    applyMove(move, BOT_MARK);
    if (checkWin(state.board, move.x, move.y, BOT_MARK)) {
      pushState(-1, move, 1);
      finish('bot', 'win');
      return;
    }
    if (state.moveCount === SIZE * SIZE) {
      pushState(-1, move, 1);
      finish(null, 'draw');
      return;
    }
    playerTurn = true;
    armPlayerTimeout();
    pushState(0, move, 1);
    if (Math.random() < 0.25) scheduleBotChat(randomLine(BOT_MOVE_LINES), 350);
  };

  return {
    userId: 'you',

    joinQueue() {
      clearTimers();
      state = emptyState();
      matchCount++;
      matchId = `local-${sessionId}-${matchCount}`;
      playing = true;
      playerTurn = true;
      lastPlayerChatAt = 0;
      armPlayerTimeout();
      emit(S2C.MatchFound, {
        matchId,
        gameId: 'caro',
        players: [
          { id: 'you', name: 'Bạn' },
          { id: 'bot', name: BOT_LEVELS[level].name },
        ],
        you: 0,
        state,
        turn: 0,
        deadline: deadline(),
      } satisfies MatchFoundData<CaroState>);
      scheduleBotChat(randomLine(BOT_GREETINGS[level]), 650 + Math.floor(Math.random() * 500));
    },

    leaveQueue() {},

    sendMove(_matchId: string, move: CaroMove) {
      if (!playing || !playerTurn) return;
      if (
        move.x < 0 ||
        move.x >= SIZE ||
        move.y < 0 ||
        move.y >= SIZE ||
        state.board[move.y * SIZE + move.x] !== 0
      ) {
        emit(S2C.Error, {
          code: GAME_ERROR_CODE.InvalidMove,
          message: 'Ô không hợp lệ',
        } satisfies ErrorData);
        return;
      }
      playerTurn = false;
      if (turnTimer) window.clearTimeout(turnTimer);
      applyMove(move, PLAYER_MARK);
      if (checkWin(state.board, move.x, move.y, PLAYER_MARK)) {
        pushState(-1, move, 0);
        finish('you', 'win');
        return;
      }
      if (state.moveCount === SIZE * SIZE) {
        pushState(-1, move, 0);
        finish(null, 'draw');
        return;
      }
      pushState(1, move, 0);
      botTimer = window.setTimeout(botMove, TURN_ANNOUNCE_MS + BOT_LEVELS[level].thinkMs);
    },

    sendChat(requestMatchID: string, text: string) {
      if (!playing || requestMatchID !== matchId) return;
      const characters = Array.from(text.trim());
      if (characters.length === 0) return;
      if (characters.length > MAX_CHAT_LENGTH) {
        emit(S2C.Error, {
          code: GAME_ERROR_CODE.ChatTooLong,
          message: 'Tin nhắn tối đa 120 ký tự',
        } satisfies ErrorData);
        return;
      }
      const now = Date.now();
      if (now - lastPlayerChatAt < 500) {
        emit(S2C.Error, {
          code: GAME_ERROR_CODE.ChatRateLimited,
          message: 'Bạn gửi tin nhắn quá nhanh',
        } satisfies ErrorData);
        return;
      }
      lastPlayerChatAt = now;
      const message = characters.join('');
      emitChat('you', 'Bạn', message);
      scheduleBotChat(botReply(message), 700 + Math.floor(Math.random() * 900));
    },
    sendRoomChat() {},

    forfeit(_matchId: string) {
      if (playing) finish('bot', 'forfeit');
    },

    createRoom() {},
    joinRoom() {},
    leaveRoom() {},
    kickRoomMember() {},
    setRoomReady() {},
    startRoom() {},
    listRooms() {},
    getLeaderboard() {},

    onUserInfo: () => () => {},
    onRoomList: () => () => {},
    onRoomUpsert: () => () => {},
    onRoomRemoved: () => () => {},
    onRoomWaiting: () => () => {},
    onRoomState: () => () => {},
    onRoomClosed: () => () => {},
    onRoomKicked: () => () => {},
    onQueueWaiting: (handler) => on(S2C.QueueWaiting, handler as Handler),
    onMatchFound: (handler) => on(S2C.MatchFound, handler as Handler),
    onState: (handler) => on(S2C.State, handler as Handler),
    onChat: (handler) => on(S2C.ChatMessage, handler as Handler),
    onMatchOver: (handler) => on(S2C.MatchOver, handler as Handler),
    onError: (handler) => on(S2C.Error, handler as Handler),
    onOpponentDisconnected: () => () => {},
    onOpponentReconnected: () => () => {},
    onLeaderboard: () => () => {},
    onConnectionChange: (handler) => {
      (handler as (c: boolean) => void)(true);
      return () => {};
    },

    disconnect() {
      clearTimers();
      playing = false;
    },
  };
}

interface ScoredMove extends CaroMove {
  attack: number;
  defend: number;
}

const WIN_SCORE = 1_000_000;
const OPEN_FOUR_SCORE = 120_000;

function pickBotMove(board: number[], level: BotLevel): CaroMove | null {
  const candidates = candidateCells(board);
  if (candidates.length === 0) return null;

  const scored: ScoredMove[] = candidates.map((index) => {
    const x = index % SIZE;
    const y = Math.floor(index / SIZE);
    return {
      x,
      y,
      attack: scorePlacement(board, x, y, BOT_MARK),
      defend: scorePlacement(board, x, y, PLAYER_MARK),
    };
  });

  if (level === 'hard') {
    const winNow = scored.find((s) => s.attack >= WIN_SCORE);
    if (winNow) return winNow;
    const blockWin = scored.find((s) => s.defend >= WIN_SCORE);
    if (blockWin) return blockWin;
    const makeOpenFour = bestBy(scored, (s) => (s.attack >= OPEN_FOUR_SCORE ? s.attack : -1));
    if (makeOpenFour) return makeOpenFour;
    const blockOpenFour = bestBy(scored, (s) => (s.defend >= OPEN_FOUR_SCORE ? s.defend : -1));
    if (blockOpenFour) return blockOpenFour;
    return bestBy(scored, (s) => s.attack + s.defend * 1.05 + Math.random());
  }

  if (level === 'normal') {
    const winNow = scored.find((s) => s.attack >= WIN_SCORE);
    if (winNow) return winNow;
    const blockWin = scored.find((s) => s.defend >= WIN_SCORE);
    if (blockWin) return blockWin;
    return bestBy(scored, (s) => s.attack + s.defend * 0.85 + Math.random() * 1500);
  }

  const blockObvious = scored.find((s) => s.defend >= WIN_SCORE);
  if (blockObvious && Math.random() < 0.5) return blockObvious;
  return bestBy(scored, (s) => s.attack * 0.4 + s.defend * 0.25 + Math.random() * 8000);
}

function bestBy(moves: ScoredMove[], score: (move: ScoredMove) => number): ScoredMove | null {
  let best: ScoredMove | null = null;
  let bestScore = 0;
  for (const move of moves) {
    const value = score(move);
    if (best === null || value > bestScore) {
      if (value < 0) continue;
      best = move;
      bestScore = value;
    }
  }
  return best;
}

function candidateCells(board: number[]): number[] {
  const near = new Set<number>();
  for (let y = 0; y < SIZE; y++) {
    for (let x = 0; x < SIZE; x++) {
      if (board[y * SIZE + x] === 0) continue;
      for (let dy = -2; dy <= 2; dy++) {
        for (let dx = -2; dx <= 2; dx++) {
          const nx = x + dx;
          const ny = y + dy;
          if (nx < 0 || nx >= SIZE || ny < 0 || ny >= SIZE) continue;
          const idx = ny * SIZE + nx;
          if (board[idx] === 0) near.add(idx);
        }
      }
    }
  }
  if (near.size === 0) {
    const center = Math.floor(SIZE / 2);
    return [center * SIZE + center];
  }
  return [...near];
}
