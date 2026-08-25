import {
  EMPTY,
  KIND_ADVISOR,
  KIND_CANNON,
  KIND_CHARIOT,
  KIND_ELEPHANT,
  KIND_GENERAL,
  KIND_HORSE,
  KIND_SOLDIER,
  boardX,
  boardY,
  crossedRiver,
  pieceKind,
  pieceSide,
} from './board';
import { inCheck, legalMovesFrom, terminalKind } from './moves';

export type BotDifficulty = 'easy' | 'medium' | 'hard';

export interface BotMove {
  from: number;
  to: number;
}

export const BOT_DIFFICULTY_LABEL: Record<BotDifficulty, string> = {
  easy: 'Dễ',
  medium: 'Vừa',
  hard: 'Khó',
};

const PIECE_VALUE: Record<number, number> = {
  [KIND_GENERAL]: 100_000,
  [KIND_ADVISOR]: 210,
  [KIND_ELEPHANT]: 210,
  [KIND_HORSE]: 420,
  [KIND_CHARIOT]: 900,
  [KIND_CANNON]: 450,
  [KIND_SOLDIER]: 100,
};

const MATE_SCORE = 1_000_000;

export function legalMovesForSide(board: readonly number[], side: number): BotMove[] {
  const moves: BotMove[] = [];
  for (let from = 0; from < board.length; from++) {
    const piece = board[from];
    if (piece === EMPTY || pieceSide(piece) !== side) continue;
    for (const to of legalMovesFrom(board, from)) moves.push({ from, to });
  }
  return moves;
}

function afterMove(board: readonly number[], move: BotMove): number[] {
  const next = [...board];
  next[move.to] = next[move.from];
  next[move.from] = EMPTY;
  return next;
}

function pieceSquareBonus(piece: number, square: number): number {
  const side = pieceSide(piece);
  const kind = pieceKind(piece);
  const x = boardX(square);
  const y = boardY(square);
  if (kind === KIND_SOLDIER) {
    const advance = side === 0 ? y : 9 - y;
    return advance * 8 + (crossedRiver(y, side) ? 36 + (4 - Math.abs(4 - x)) * 4 : 0);
  }
  if (kind === KIND_HORSE || kind === KIND_CANNON) return (4 - Math.abs(4 - x)) * 4;
  if (kind === KIND_CHARIOT) return (4 - Math.abs(4 - x)) * 2;
  return 0;
}

function evaluate(board: readonly number[], perspective: number): number {
  let score = 0;
  for (let square = 0; square < board.length; square++) {
    const piece = board[square];
    if (piece === EMPTY) continue;
    const value = PIECE_VALUE[pieceKind(piece)] + pieceSquareBonus(piece, square);
    score += pieceSide(piece) === perspective ? value : -value;
  }
  if (inCheck(board, 1 - perspective)) score += 28;
  if (inCheck(board, perspective)) score -= 28;
  return score;
}

function movePriority(board: readonly number[], move: BotMove): number {
  const captured = board[move.to];
  const mover = board[move.from];
  let score = captured === EMPTY ? 0 : PIECE_VALUE[pieceKind(captured)] * 10 - PIECE_VALUE[pieceKind(mover)];
  const next = afterMove(board, move);
  if (inCheck(next, 1 - pieceSide(mover))) score += 180;
  return score;
}

function orderedMoves(board: readonly number[], side: number): BotMove[] {
  return legalMovesForSide(board, side).sort((a, b) => movePriority(board, b) - movePriority(board, a));
}

interface SearchContext {
  perspective: number;
  deadline: number;
  nodes: number;
}

function search(
  board: readonly number[],
  side: number,
  depth: number,
  alpha: number,
  beta: number,
  ply: number,
  context: SearchContext,
): number {
  context.nodes++;
  if ((context.nodes & 127) === 0 && Date.now() >= context.deadline) return evaluate(board, context.perspective);
  const terminal = terminalKind(board, side);
  if (terminal !== 'none') return side === context.perspective ? -MATE_SCORE + ply : MATE_SCORE - ply;
  if (depth === 0) return evaluate(board, context.perspective);

  const maximizing = side === context.perspective;
  let best = maximizing ? -Infinity : Infinity;
  for (const move of orderedMoves(board, side)) {
    const score = search(afterMove(board, move), 1 - side, depth - 1, alpha, beta, ply + 1, context);
    if (maximizing) {
      best = Math.max(best, score);
      alpha = Math.max(alpha, best);
    } else {
      best = Math.min(best, score);
      beta = Math.min(beta, best);
    }
    if (beta <= alpha || Date.now() >= context.deadline) break;
  }
  return best;
}

export function chooseBotMove(
  board: readonly number[],
  side: number,
  difficulty: BotDifficulty,
  random: () => number = Math.random,
): BotMove | null {
  const moves = orderedMoves(board, side);
  if (moves.length === 0) return null;
  if (difficulty === 'easy') return moves[Math.min(moves.length - 1, Math.floor(random() * moves.length))];

  const depth = difficulty === 'hard' ? 3 : 2;
  const budgetMs = difficulty === 'hard' ? 650 : 220;
  const context: SearchContext = { perspective: side, deadline: Date.now() + budgetMs, nodes: 0 };
  const scored = moves.map((move) => ({
    move,
    score: search(afterMove(board, move), 1 - side, depth - 1, -Infinity, Infinity, 1, context),
  }));
  scored.sort((a, b) => b.score - a.score || movePriority(board, b.move) - movePriority(board, a.move));

  if (difficulty === 'medium') {
    const candidates = scored.filter((item) => item.score >= scored[0].score - 45).slice(0, 3);
    return candidates[Math.min(candidates.length - 1, Math.floor(random() * candidates.length))].move;
  }
  return scored[0].move;
}
