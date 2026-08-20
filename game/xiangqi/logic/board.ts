import { BOARD_ALPHABET, BOARD_CELLS, BOARD_HEIGHT, BOARD_WIDTH } from './constants.gen';

export const SIDE_RED = 0;
export const SIDE_BLACK = 1;

export const EMPTY = 0;

export const KIND_GENERAL = 1;
export const KIND_ADVISOR = 2;
export const KIND_ELEPHANT = 3;
export const KIND_HORSE = 4;
export const KIND_CHARIOT = 5;
export const KIND_CANNON = 6;
export const KIND_SOLDIER = 7;

export function pieceSide(piece: number): number {
  return Math.floor((piece - 1) / 7);
}

export function pieceKind(piece: number): number {
  return ((piece - 1) % 7) + 1;
}

export function pieceFor(side: number, kind: number): number {
  return side * 7 + kind;
}

export function boardX(idx: number): number {
  return idx % BOARD_WIDTH;
}

export function boardY(idx: number): number {
  return Math.floor(idx / BOARD_WIDTH);
}

export function boardIdx(x: number, y: number): number {
  return y * BOARD_WIDTH + x;
}

export function onBoard(x: number, y: number): boolean {
  return x >= 0 && x < BOARD_WIDTH && y >= 0 && y < BOARD_HEIGHT;
}

export function flipIndex(idx: number): number {
  return BOARD_CELLS - 1 - idx;
}

export function inPalace(x: number, y: number, side: number): boolean {
  if (x < 3 || x > 5) return false;
  if (side === SIDE_RED) return y >= 0 && y <= 2;
  return y >= 7 && y <= 9;
}

export function crossedRiver(y: number, side: number): boolean {
  if (side === SIDE_RED) return y >= 5;
  return y <= 4;
}

export function forwardDir(side: number): number {
  return side === SIDE_RED ? 1 : -1;
}

export function positionKey(board: readonly number[], side: number): string {
  let key = '';
  for (let i = 0; i < BOARD_CELLS; i++) key += BOARD_ALPHABET[board[i]];
  return key + (side === SIDE_RED ? 'r' : 'b');
}

export function parseBoardRows(rows: readonly string[]): number[] {
  if (rows.length !== BOARD_HEIGHT) throw new RangeError('invalid board rows');
  const board = new Array<number>(BOARD_CELLS).fill(EMPTY);
  for (let y = 0; y < BOARD_HEIGHT; y++) {
    const row = rows[y];
    if (row.length !== BOARD_WIDTH) throw new RangeError('invalid board row length');
    for (let x = 0; x < BOARD_WIDTH; x++) {
      const code = BOARD_ALPHABET.indexOf(row[x]);
      if (code < 0) throw new RangeError('invalid board character');
      board[boardIdx(x, y)] = code;
    }
  }
  return board;
}
