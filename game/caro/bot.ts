import type { GameSession, MatchFoundData, MatchOverData, StateData, ErrorData } from '../src/sdk';
import { SIZE, checkWin, emptyState, scorePlacement, type CaroMove, type CaroState } from './types';

const TURN_MS = (Number(import.meta.env.VITE_GAME_TURN_SECONDS) || 45) * 1000;
const PLAYER_MARK = 1;
const BOT_MARK = 2;
const TURN_ANNOUNCE_MS = 1080;

export type BotLevel = 'easy' | 'normal' | 'hard';

export const BOT_LEVELS: Record<BotLevel, { name: string; thinkMs: number }> = {
  easy: { name: 'Máy · Dễ', thinkMs: 350 },
  normal: { name: 'Máy · Thường', thinkMs: 500 },
  hard: { name: 'Máy · Khó', thinkMs: 650 },
};

type Handler = (data: never) => void;

export function createBotSession(level: BotLevel): GameSession<CaroState, CaroMove> {
  const listeners = new Map<string, Set<Handler>>();
  let state = emptyState();
  let matchId = '';
  let matchCount = 0;
  let playing = false;
  let playerTurn = true;
  let turnTimer: number | undefined;
  let botTimer: number | undefined;
  let overTimer: number | undefined;

  const WIN_REVEAL_MS = 1300;

  const on = (type: string, handler: Handler): (() => void) => {
    let set = listeners.get(type);
    if (!set) {
      set = new Set();
      listeners.set(type, set);
    }
    set.add(handler);
    return () => listeners.get(type)?.delete(handler);
  };

  const emit = (type: string, data: unknown): void => {
    listeners.get(type)?.forEach((handler) => (handler as (d: unknown) => void)(data));
  };

  const clearTimers = (): void => {
    if (turnTimer) window.clearTimeout(turnTimer);
    if (botTimer) window.clearTimeout(botTimer);
    if (overTimer) window.clearTimeout(overTimer);
    turnTimer = undefined;
    botTimer = undefined;
    overTimer = undefined;
  };

  const deadline = (): number => Date.now() + TURN_MS;

  const armPlayerTimeout = (): void => {
    if (turnTimer) window.clearTimeout(turnTimer);
    turnTimer = window.setTimeout(() => finish('bot', 'timeout'), TURN_MS);
  };

  const finish = (
    winner: 'you' | 'bot' | null,
    reason: MatchOverData['reason'],
    delayMs = 0,
  ): void => {
    playing = false;
    clearTimers();
    const emitOver = (): void =>
      emit('MATCH_OVER', {
        matchId,
        winnerId: winner ?? '',
        reason,
        state,
      } satisfies MatchOverData<CaroState>);
    if (delayMs > 0) overTimer = window.setTimeout(emitOver, delayMs);
    else emitOver();
  };

  const pushState = (turn: number, lastMove: CaroMove, lastBy: number): void => {
    emit('STATE', {
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
      finish(null, 'win');
      return;
    }
    applyMove(move, BOT_MARK);
    if (checkWin(state.board, move.x, move.y, BOT_MARK)) {
      pushState(-1, move, 1);
      finish('bot', 'win', WIN_REVEAL_MS);
      return;
    }
    if (state.moveCount === SIZE * SIZE) {
      pushState(-1, move, 1);
      finish(null, 'win', WIN_REVEAL_MS);
      return;
    }
    playerTurn = true;
    armPlayerTimeout();
    pushState(0, move, 1);
  };

  return {
    userId: 'you',

    joinQueue() {
      clearTimers();
      state = emptyState();
      matchCount++;
      matchId = `local-${matchCount}`;
      playing = true;
      playerTurn = true;
      armPlayerTimeout();
      emit('MATCH_FOUND', {
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
    },

    leaveQueue() {},

    sendMove(move: CaroMove) {
      if (!playing || !playerTurn) return;
      if (
        move.x < 0 ||
        move.x >= SIZE ||
        move.y < 0 ||
        move.y >= SIZE ||
        state.board[move.y * SIZE + move.x] !== 0
      ) {
        emit('ERROR', { code: 'INVALID_MOVE', message: 'Ô không hợp lệ' } satisfies ErrorData);
        return;
      }
      playerTurn = false;
      if (turnTimer) window.clearTimeout(turnTimer);
      applyMove(move, PLAYER_MARK);
      if (checkWin(state.board, move.x, move.y, PLAYER_MARK)) {
        pushState(-1, move, 0);
        finish('you', 'win', WIN_REVEAL_MS);
        return;
      }
      if (state.moveCount === SIZE * SIZE) {
        pushState(-1, move, 0);
        finish(null, 'win', WIN_REVEAL_MS);
        return;
      }
      pushState(1, move, 0);
      botTimer = window.setTimeout(botMove, TURN_ANNOUNCE_MS + BOT_LEVELS[level].thinkMs);
    },

    forfeit() {
      if (playing) finish('bot', 'forfeit');
    },

    createRoom() {},
    joinRoom() {},
    leaveRoom() {},
    listRooms() {},

    onUserInfo: () => () => {},
    onRoomList: () => () => {},
    onRoomWaiting: () => () => {},
    onQueueWaiting: (handler) => on('QUEUE_WAITING', handler as Handler),
    onMatchFound: (handler) => on('MATCH_FOUND', handler as Handler),
    onState: (handler) => on('STATE', handler as Handler),
    onMatchOver: (handler) => on('MATCH_OVER', handler as Handler),
    onError: (handler) => on('ERROR', handler as Handler),
    onOpponentDisconnected: () => () => {},
    onOpponentReconnected: () => () => {},
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
