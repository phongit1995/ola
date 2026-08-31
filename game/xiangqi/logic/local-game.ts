import { HALFMOVE_DRAW_PLIES, REPETITION_LIMIT, START_BOARD } from './constants.gen';
import { EMPTY, KIND_GENERAL, SIDE_RED, pieceFor, pieceSide, positionKey } from './board';
import { inCheck, legalMovesFrom, terminalKind } from './moves';

export type LocalResultReason = 'checkmate' | 'stalemate' | 'perpetual' | 'repetition' | 'halfmove';

export interface LocalGameResult {
  winner: number | null;
  reason: LocalResultReason;
}

export interface LocalGameState {
  board: number[];
  moveCount: number;
  halfmoveClock: number;
  history: string[];
  historyChecks: boolean[];
  lastFrom: number;
  lastTo: number;
  check: boolean;
  result: LocalGameResult | null;
}

export interface LocalMoveResult {
  state: LocalGameState;
  captured: number;
  checked: boolean;
}

export function createLocalGame(board: readonly number[] = START_BOARD, sideToMove = SIDE_RED): LocalGameState {
  const nextBoard = [...board];
  const checked = inCheck(nextBoard, sideToMove);
  return {
    board: nextBoard,
    moveCount: sideToMove,
    halfmoveClock: 0,
    history: [positionKey(nextBoard, sideToMove)],
    historyChecks: [checked],
    lastFrom: -1,
    lastTo: -1,
    check: checked,
    result: null,
  };
}

function countKey(history: readonly string[], key: string): number {
  let count = 0;
  for (const item of history) {
    if (item === key) count++;
  }
  return count;
}

// Mirrors server/internal/game/games/xiangqi/move.go so local practice follows
// the same Vietnamese Xiangqi repetition/perpetual-check adjudication as PvP.
function perpetualChecker(
  history: readonly string[],
  checks: readonly boolean[],
  key: string,
  moveCount: number,
): number | null {
  const first = history.indexOf(key);
  if (first < 0) return null;
  const allCheck = [true, true];
  const seen = [false, false];
  for (let index = first + 1; index < history.length; index++) {
    const entrySide = ((moveCount - (history.length - 1 - index)) % 2 + 2) % 2;
    const mover = 1 - entrySide;
    seen[mover] = true;
    if (!checks[index]) allCheck[mover] = false;
  }
  for (let side = 0; side < 2; side++) {
    if (seen[side] && allCheck[side] && !(seen[1 - side] && allCheck[1 - side])) return side;
  }
  return null;
}

export function applyLocalMove(state: LocalGameState, side: number, from: number, to: number): LocalMoveResult {
  if (state.result) throw new Error('Ván cờ đã kết thúc');
  if (side !== state.moveCount % 2) throw new Error('Chưa đến lượt');
  const piece = state.board[from];
  if (piece === EMPTY || pieceSide(piece) !== side || !legalMovesFrom(state.board, from).includes(to)) {
    throw new Error('Nước đi không hợp lệ');
  }

  const board = [...state.board];
  const captured = board[to];
  board[to] = board[from];
  board[from] = EMPTY;
  const moveCount = state.moveCount + 1;
  const nextSide = 1 - side;
  const checked = inCheck(board, nextSide);
  const halfmoveClock = captured === EMPTY ? state.halfmoveClock + 1 : 0;
  const history = captured === EMPTY ? [...state.history] : [];
  const historyChecks = captured === EMPTY ? [...state.historyChecks] : [];
  const key = positionKey(board, nextSide);
  history.push(key);
  historyChecks.push(checked);

  let result: LocalGameResult | null = null;
  if (captured === pieceFor(nextSide, KIND_GENERAL)) {
    // Legal play should stop at mate first, but legacy/restored edge states
    // must not continue after an explicit general capture.
    result = { winner: side, reason: 'checkmate' };
  } else {
    const terminal = terminalKind(board, nextSide);
    if (terminal !== 'none') {
      result = { winner: side, reason: terminal };
    }
  }
  if (!result && countKey(history, key) >= REPETITION_LIMIT) {
    const perpetualSide = perpetualChecker(history, historyChecks, key, moveCount);
    result = perpetualSide == null
      ? { winner: null, reason: 'repetition' }
      : { winner: 1 - perpetualSide, reason: 'perpetual' };
  } else if (!result && halfmoveClock >= HALFMOVE_DRAW_PLIES) {
    result = { winner: null, reason: 'halfmove' };
  }

  return {
    captured,
    checked,
    state: {
      board,
      moveCount,
      halfmoveClock,
      history,
      historyChecks,
      lastFrom: from,
      lastTo: to,
      check: checked,
      result,
    },
  };
}
