export const SIZE = 20;
export const WIN_LEN = 5;

export type BotLevel = 'easy' | 'normal' | 'hard';

export interface CaroState {
  board: number[];
  moveCount: number;
  lastX: number;
  lastY: number;
}

export interface CaroMove {
  x: number;
  y: number;
}

const DIRECTIONS: ReadonlyArray<readonly [number, number]> = [
  [1, 0],
  [0, 1],
  [1, 1],
  [1, -1],
];

export function emptyState(): CaroState {
  return { board: new Array(SIZE * SIZE).fill(0), moveCount: 0, lastX: -1, lastY: -1 };
}

export function checkWin(board: number[], x: number, y: number, mark: number): boolean {
  for (const [dx, dy] of DIRECTIONS) {
    let count = 1;
    for (const sign of [1, -1]) {
      let cx = x + dx * sign;
      let cy = y + dy * sign;
      while (cx >= 0 && cx < SIZE && cy >= 0 && cy < SIZE && board[cy * SIZE + cx] === mark) {
        count++;
        cx += dx * sign;
        cy += dy * sign;
      }
    }
    if (count >= WIN_LEN) return true;
  }
  return false;
}

export interface WinLine {
  x1: number;
  y1: number;
  x2: number;
  y2: number;
}

export function findWinLine(board: number[], x: number, y: number, mark: number): WinLine | null {
  for (const [dx, dy] of DIRECTIONS) {
    let sx = x;
    let sy = y;
    let cx = x - dx;
    let cy = y - dy;
    while (cx >= 0 && cx < SIZE && cy >= 0 && cy < SIZE && board[cy * SIZE + cx] === mark) {
      sx = cx;
      sy = cy;
      cx -= dx;
      cy -= dy;
    }
    let ex = x;
    let ey = y;
    cx = x + dx;
    cy = y + dy;
    while (cx >= 0 && cx < SIZE && cy >= 0 && cy < SIZE && board[cy * SIZE + cx] === mark) {
      ex = cx;
      ey = cy;
      cx += dx;
      cy += dy;
    }
    const count = Math.max(Math.abs(ex - sx), Math.abs(ey - sy)) + 1;
    if (count >= WIN_LEN) return { x1: sx, y1: sy, x2: ex, y2: ey };
  }
  return null;
}

export function lineMetrics(
  board: number[],
  x: number,
  y: number,
  dx: number,
  dy: number,
  mark: number,
): { count: number; openEnds: number } {
  let count = 1;
  let openEnds = 0;
  for (const sign of [1, -1]) {
    let cx = x + dx * sign;
    let cy = y + dy * sign;
    while (cx >= 0 && cx < SIZE && cy >= 0 && cy < SIZE && board[cy * SIZE + cx] === mark) {
      count++;
      cx += dx * sign;
      cy += dy * sign;
    }
    if (cx >= 0 && cx < SIZE && cy >= 0 && cy < SIZE && board[cy * SIZE + cx] === 0) {
      openEnds++;
    }
  }
  return { count, openEnds };
}

export function scorePlacement(board: number[], x: number, y: number, mark: number): number {
  let total = 0;
  for (const [dx, dy] of DIRECTIONS) {
    const { count, openEnds } = lineMetrics(board, x, y, dx, dy, mark);
    total += lineScore(count, openEnds);
  }
  return total;
}

function lineScore(count: number, openEnds: number): number {
  if (count >= WIN_LEN) return 1_000_000;
  if (count === 4) return openEnds === 2 ? 120_000 : 12_000;
  if (count === 3) return openEnds === 2 ? 6_000 : 600;
  if (count === 2) return openEnds === 2 ? 120 : 15;
  return openEnds > 0 ? 2 : 0;
}
