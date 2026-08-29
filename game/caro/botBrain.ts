import { SIZE, checkWin, scorePlacement, type BotLevel, type CaroMove } from './types';

export const PLAYER_MARK = 1;
export const BOT_MARK = 2;

interface ScoredMove extends CaroMove {
  attack: number;
  defend: number;
}

const WIN_SCORE = 1_000_000;
const OPEN_FOUR_SCORE = 120_000;
const EXPERT_BREADTH = 14;
const EXPERT_REPLY_BREADTH = 10;
const FORCED_WIN_SCORE = WIN_SCORE * 10;
const BOT_WINS_NEXT_SCORE = WIN_SCORE * 5;
const UNSTOPPABLE_LOSS_SCORE = -WIN_SCORE * 2;

export function pickBotMove(board: number[], level: BotLevel): CaroMove | null {
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

  if (level === 'expert') {
    const winNow = scored.find((s) => s.attack >= WIN_SCORE);
    if (winNow) return winNow;
    const blockWin = scored.find((s) => s.defend >= WIN_SCORE);
    if (blockWin) return blockWin;
    const makeOpenFour = bestBy(scored, (s) => (s.attack >= OPEN_FOUR_SCORE ? s.attack : -1));
    if (makeOpenFour) return makeOpenFour;
    const blockOpenFour = bestBy(scored, (s) => (s.defend >= OPEN_FOUR_SCORE ? s.defend : -1));
    if (blockOpenFour) return blockOpenFour;
    return pickExpertMove(board, scored);
  }

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

function pickExpertMove(board: number[], scored: ScoredMove[]): CaroMove | null {
  const top = [...scored]
    .sort((a, b) => b.attack + b.defend - (a.attack + a.defend))
    .slice(0, EXPERT_BREADTH);
  let best: ScoredMove | null = null;
  let bestValue = -Infinity;
  for (const move of top) {
    const index = move.y * SIZE + move.x;
    board[index] = BOT_MARK;
    const value = worstCaseAfterBotMove(board) + (move.attack + move.defend) * 0.001;
    board[index] = 0;
    if (value > bestValue) {
      bestValue = value;
      best = move;
    }
  }
  return best ?? bestBy(scored, (s) => s.attack + s.defend);
}

function worstCaseAfterBotMove(board: number[]): number {
  if (countWinningCells(board, BOT_MARK) >= 2) return FORCED_WIN_SCORE;
  let worst = Infinity;
  for (const index of topReplyCells(board)) {
    const x = index % SIZE;
    const y = Math.floor(index / SIZE);
    board[index] = PLAYER_MARK;
    const value = checkWin(board, x, y, PLAYER_MARK)
      ? -FORCED_WIN_SCORE
      : evaluateBotTurn(board);
    board[index] = 0;
    if (value < worst) worst = value;
    if (worst <= -FORCED_WIN_SCORE) break;
  }
  return worst === Infinity ? 0 : worst;
}

function topReplyCells(board: number[]): number[] {
  return candidateCells(board)
    .map((index) => {
      const x = index % SIZE;
      const y = Math.floor(index / SIZE);
      const value = Math.max(
        scorePlacement(board, x, y, PLAYER_MARK),
        scorePlacement(board, x, y, BOT_MARK),
      );
      return { index, value };
    })
    .sort((a, b) => b.value - a.value)
    .slice(0, EXPERT_REPLY_BREADTH)
    .map((cell) => cell.index);
}

function countWinningCells(board: number[], mark: number): number {
  let count = 0;
  for (const index of candidateCells(board)) {
    const x = index % SIZE;
    const y = Math.floor(index / SIZE);
    if (scorePlacement(board, x, y, mark) >= WIN_SCORE) count++;
  }
  return count;
}

function evaluateBotTurn(board: number[]): number {
  let bestBot = 0;
  let bestPlayer = 0;
  let playerWinCells = 0;
  for (const index of candidateCells(board)) {
    const x = index % SIZE;
    const y = Math.floor(index / SIZE);
    const bot = scorePlacement(board, x, y, BOT_MARK);
    if (bot >= WIN_SCORE) return BOT_WINS_NEXT_SCORE;
    const player = scorePlacement(board, x, y, PLAYER_MARK);
    if (player >= WIN_SCORE) playerWinCells++;
    if (bot > bestBot) bestBot = bot;
    if (player > bestPlayer) bestPlayer = player;
  }
  if (playerWinCells >= 2) return UNSTOPPABLE_LOSS_SCORE;
  return bestBot - bestPlayer * 1.15;
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
