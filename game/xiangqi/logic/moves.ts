import {
  EMPTY,
  KIND_ADVISOR,
  KIND_CANNON,
  KIND_CHARIOT,
  KIND_ELEPHANT,
  KIND_GENERAL,
  KIND_HORSE,
  KIND_SOLDIER,
  SIDE_BLACK,
  SIDE_RED,
  boardIdx,
  boardX,
  boardY,
  crossedRiver,
  forwardDir,
  inPalace,
  onBoard,
  pieceFor,
  pieceKind,
  pieceSide,
} from './board';

const ORTHO_DIRS = [
  [1, 0],
  [-1, 0],
  [0, 1],
  [0, -1],
] as const;

const DIAG_DIRS = [
  [1, 1],
  [1, -1],
  [-1, 1],
  [-1, -1],
] as const;

const HORSE_JUMPS = [
  [1, 2, 0, 1],
  [-1, 2, 0, 1],
  [1, -2, 0, -1],
  [-1, -2, 0, -1],
  [2, 1, 1, 0],
  [2, -1, 1, 0],
  [-2, 1, -1, 0],
  [-2, -1, -1, 0],
] as const;

export function pseudoMoves(board: readonly number[], from: number): number[] {
  const piece = board[from];
  if (piece === EMPTY) return [];
  const side = pieceSide(piece);
  const x = boardX(from);
  const y = boardY(from);
  const out: number[] = [];
  const add = (tx: number, ty: number) => {
    if (!onBoard(tx, ty)) return;
    const target = board[boardIdx(tx, ty)];
    if (target !== EMPTY && pieceSide(target) === side) return;
    out.push(boardIdx(tx, ty));
  };
  switch (pieceKind(piece)) {
    case KIND_GENERAL:
      for (const [dx, dy] of ORTHO_DIRS) {
        if (inPalace(x + dx, y + dy, side)) add(x + dx, y + dy);
      }
      break;
    case KIND_ADVISOR:
      for (const [dx, dy] of DIAG_DIRS) {
        if (inPalace(x + dx, y + dy, side)) add(x + dx, y + dy);
      }
      break;
    case KIND_ELEPHANT:
      for (const [dx, dy] of DIAG_DIRS) {
        const tx = x + 2 * dx;
        const ty = y + 2 * dy;
        if (!onBoard(tx, ty) || crossedRiver(ty, side)) continue;
        if (board[boardIdx(x + dx, y + dy)] !== EMPTY) continue;
        add(tx, ty);
      }
      break;
    case KIND_HORSE:
      for (const [dx, dy, lx, ly] of HORSE_JUMPS) {
        if (!onBoard(x + lx, y + ly) || board[boardIdx(x + lx, y + ly)] !== EMPTY) continue;
        add(x + dx, y + dy);
      }
      break;
    case KIND_CHARIOT:
      for (const [dx, dy] of ORTHO_DIRS) {
        let tx = x + dx;
        let ty = y + dy;
        while (onBoard(tx, ty)) {
          const target = board[boardIdx(tx, ty)];
          if (target !== EMPTY) {
            if (pieceSide(target) !== side) out.push(boardIdx(tx, ty));
            break;
          }
          out.push(boardIdx(tx, ty));
          tx += dx;
          ty += dy;
        }
      }
      break;
    case KIND_CANNON:
      for (const [dx, dy] of ORTHO_DIRS) {
        let tx = x + dx;
        let ty = y + dy;
        let jumped = false;
        while (onBoard(tx, ty)) {
          const target = board[boardIdx(tx, ty)];
          if (!jumped) {
            if (target === EMPTY) out.push(boardIdx(tx, ty));
            else jumped = true;
          } else if (target !== EMPTY) {
            if (pieceSide(target) !== side) out.push(boardIdx(tx, ty));
            break;
          }
          tx += dx;
          ty += dy;
        }
      }
      break;
    case KIND_SOLDIER:
      add(x, y + forwardDir(side));
      if (crossedRiver(y, side)) {
        add(x - 1, y);
        add(x + 1, y);
      }
      break;
  }
  return out;
}

export function findGeneral(board: readonly number[], side: number): number {
  const target = pieceFor(side, KIND_GENERAL);
  for (let idx = 0; idx < board.length; idx++) {
    if (board[idx] === target) return idx;
  }
  return -1;
}

function generalAttacked(board: readonly number[], sq: number, bySide: number): boolean {
  const x = boardX(sq);
  const y = boardY(sq);
  for (const [dx, dy] of ORTHO_DIRS) {
    let tx = x + dx;
    let ty = y + dy;
    let steps = 1;
    let jumped = false;
    while (onBoard(tx, ty)) {
      const target = board[boardIdx(tx, ty)];
      if (target !== EMPTY) {
        if (!jumped) {
          if (pieceSide(target) === bySide) {
            const kind = pieceKind(target);
            if (kind === KIND_CHARIOT) return true;
            if (kind === KIND_GENERAL && steps === 1 && inPalace(x, y, bySide)) return true;
          }
          jumped = true;
        } else {
          if (pieceSide(target) === bySide && pieceKind(target) === KIND_CANNON) return true;
          break;
        }
      }
      tx += dx;
      ty += dy;
      steps++;
    }
  }
  for (const [dx, dy, lx, ly] of HORSE_JUMPS) {
    const hx = x - dx;
    const hy = y - dy;
    if (!onBoard(hx, hy) || !onBoard(hx + lx, hy + ly)) continue;
    if (board[boardIdx(hx + lx, hy + ly)] !== EMPTY) continue;
    if (board[boardIdx(hx, hy)] === pieceFor(bySide, KIND_HORSE)) return true;
  }
  const sy = y - forwardDir(bySide);
  if (onBoard(x, sy) && board[boardIdx(x, sy)] === pieceFor(bySide, KIND_SOLDIER)) return true;
  if (crossedRiver(y, bySide)) {
    for (const dx of [-1, 1]) {
      if (onBoard(x + dx, y) && board[boardIdx(x + dx, y)] === pieceFor(bySide, KIND_SOLDIER)) return true;
    }
  }
  return false;
}

export function inCheck(board: readonly number[], side: number): boolean {
  const general = findGeneral(board, side);
  if (general < 0) return false;
  return generalAttacked(board, general, 1 - side);
}

export function generalsFacing(board: readonly number[]): boolean {
  const red = findGeneral(board, SIDE_RED);
  const black = findGeneral(board, SIDE_BLACK);
  if (red < 0 || black < 0) return false;
  if (boardX(red) !== boardX(black)) return false;
  const x = boardX(red);
  for (let y = boardY(red) + 1; y < boardY(black); y++) {
    if (board[boardIdx(x, y)] !== EMPTY) return false;
  }
  return true;
}

function moveLeavesIllegal(board: number[], from: number, to: number, side: number): boolean {
  const captured = board[to];
  board[to] = board[from];
  board[from] = EMPTY;
  const bad = inCheck(board, side) || generalsFacing(board);
  board[from] = board[to];
  board[to] = captured;
  return bad;
}

export function legalMovesFrom(board: readonly number[], from: number): number[] {
  const piece = board[from];
  if (piece === EMPTY) return [];
  const side = pieceSide(piece);
  const scratch = board.slice();
  const out: number[] = [];
  for (const to of pseudoMoves(scratch, from)) {
    if (!moveLeavesIllegal(scratch, from, to, side)) out.push(to);
  }
  out.sort((a, b) => a - b);
  return out;
}

export function hasLegalMove(board: readonly number[], side: number): boolean {
  const scratch = board.slice();
  for (let from = 0; from < scratch.length; from++) {
    const piece = scratch[from];
    if (piece === EMPTY || pieceSide(piece) !== side) continue;
    for (const to of pseudoMoves(scratch, from)) {
      if (!moveLeavesIllegal(scratch, from, to, side)) return true;
    }
  }
  return false;
}

export function terminalKind(board: readonly number[], side: number): 'none' | 'checkmate' | 'stalemate' {
  if (hasLegalMove(board, side)) return 'none';
  return inCheck(board, side) ? 'checkmate' : 'stalemate';
}
