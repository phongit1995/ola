export const GRID = 8;
export const CELLS = GRID * GRID;

export type BaseTileType = 'sword' | 'peach' | 'heart' | 'water' | 'shield' | 'lightning';
export type TileType = BaseTileType | 'fireSword' | 'greaterHeart';

export const TILE_TYPES: BaseTileType[] = ['sword', 'peach', 'heart', 'water', 'shield', 'lightning'];
// Divisor riêng cho từng ô gốc để cả hai ô đặc biệt ra ~1/60 (khớp server):
//   Kiếm Lửa ≈ 22% / 13 ≈ 1/59 ; Đại Trái Tim ≈ 16% / 10 ≈ 1/62
export const SPECIAL_SWORD_CHANCE = 1 / 13;
export const SPECIAL_HEART_CHANCE = 1 / 10;

export type Board = TileType[];

export interface MatchResult {
  cells: Set<number>;
  counts: Record<TileType, number>;
  maxRun: number;
  bonusTurns: number;
}

export interface Fall {
  from: number;
  to: number;
}

export interface Spawn {
  index: number;
  type: TileType;
  fromRow: number;
}

export interface GravityResult {
  falls: Fall[];
  spawns: Spawn[];
}

function randBase(): BaseTileType {
  const r = Math.random() * 100;
  if (r < 22) return 'sword';
  if (r < 38) return 'peach';
  if (r < 54) return 'heart';
  if (r < 69) return 'water';
  if (r < 84) return 'shield';
  return 'lightning';
}

function randTile(): TileType {
  const base = randBase();
  if (base === 'sword' && Math.random() < SPECIAL_SWORD_CHANCE) return 'fireSword';
  if (base === 'heart' && Math.random() < SPECIAL_HEART_CHANCE) return 'greaterHeart';
  return base;
}

export function emptyCounts(): Record<TileType, number> {
  return {
    sword: 0,
    peach: 0,
    heart: 0,
    water: 0,
    shield: 0,
    lightning: 0,
    fireSword: 0,
    greaterHeart: 0,
  };
}

export function createBoard(): Board {
  const board: Board = new Array(CELLS);
  for (let i = 0; i < CELLS; i++) {
    let type = randTile();
    while (createsMatchAt(board, i, type)) {
      type = randTile();
    }
    board[i] = type;
  }
  if (findValidMoves(board).length === 0) return createBoard();
  return board;
}

function createsMatchAt(board: Board, i: number, type: TileType): boolean {
  const x = i % GRID;
  const y = Math.floor(i / GRID);
  const matchType = baseTileType(type);
  if (
    x >= 2 &&
    baseTileType(board[i - 1]) === matchType &&
    baseTileType(board[i - 2]) === matchType
  ) {
    return true;
  }
  if (
    y >= 2 &&
    baseTileType(board[i - GRID]) === matchType &&
    baseTileType(board[i - GRID * 2]) === matchType
  ) {
    return true;
  }
  return false;
}

export function baseTileType(type: TileType): BaseTileType {
  if (type === 'fireSword') return 'sword';
  if (type === 'greaterHeart') return 'heart';
  return type;
}

export function findMatches(board: Board): MatchResult | null {
  const cells = new Set<number>();
  let maxRun = 0;
  let bonusTurns = 0;

  const scanLine = (start: number, step: number, length: number): void => {
    let runStart = 0;
    for (let k = 1; k <= length; k++) {
      const same =
        k < length &&
        baseTileType(board[start + k * step]) === baseTileType(board[start + runStart * step]);
      if (!same) {
        const runLen = k - runStart;
        if (runLen >= 3) {
          maxRun = Math.max(maxRun, runLen);
          if (runLen >= 4) bonusTurns++;
          for (let r = runStart; r < k; r++) cells.add(start + r * step);
        }
        runStart = k;
      }
    }
  };

  for (let y = 0; y < GRID; y++) scanLine(y * GRID, 1, GRID);
  for (let x = 0; x < GRID; x++) scanLine(x, GRID, GRID);

  if (cells.size === 0) return null;

  const counts = emptyCounts();
  cells.forEach((i) => {
    counts[board[i]]++;
  });
  // Preserve the existing rule for T/L/cross or separate triples: if no
  // straight run earned a turn, clearing 5+ matched cells still earns one.
  if (bonusTurns === 0 && cells.size >= 5) bonusTurns = 1;
  return { cells, counts, maxRun, bonusTurns };
}

export function areAdjacent(a: number, b: number): boolean {
  const ax = a % GRID;
  const ay = Math.floor(a / GRID);
  const bx = b % GRID;
  const by = Math.floor(b / GRID);
  return Math.abs(ax - bx) + Math.abs(ay - by) === 1;
}

export function swapCells(board: Board, a: number, b: number): void {
  const tmp = board[a];
  board[a] = board[b];
  board[b] = tmp;
}

export function findValidMoves(board: Board): Array<[number, number]> {
  const moves: Array<[number, number]> = [];
  const test = (a: number, b: number): void => {
    swapCells(board, a, b);
    if (findMatches(board)) moves.push([a, b]);
    swapCells(board, a, b);
  };
  for (let y = 0; y < GRID; y++) {
    for (let x = 0; x < GRID; x++) {
      const i = y * GRID + x;
      if (x < GRID - 1) test(i, i + 1);
      if (y < GRID - 1) test(i, i + GRID);
    }
  }
  return moves;
}

export function computeExplosions(board: Board, matched: Set<number>): number[] {
  const set = new Set<number>();
  const add = (x: number, y: number): void => {
    if (x >= 0 && x < GRID && y >= 0 && y < GRID) set.add(y * GRID + x);
  };
  matched.forEach((i) => {
    const x = i % GRID;
    const y = Math.floor(i / GRID);
    const t = board[i];
    if (t === 'lightning') {
      add(x, y - 1);
      add(x, y + 1);
      add(x - 1, y);
      add(x + 1, y);
    } else if (t === 'fireSword') {
      for (let dy = -1; dy <= 1; dy++) {
        for (let dx = -1; dx <= 1; dx++) add(x + dx, y + dy);
      }
    }
  });
  const out: number[] = [];
  set.forEach((i) => {
    if (!matched.has(i)) out.push(i);
  });
  out.sort((a, b) => a - b);
  return out;
}

export function applyGravity(board: Board, removed: Set<number>): GravityResult {
  const falls: Fall[] = [];
  const spawns: Spawn[] = [];

  for (let x = 0; x < GRID; x++) {
    let write = GRID - 1;
    for (let y = GRID - 1; y >= 0; y--) {
      const i = y * GRID + x;
      if (removed.has(i)) continue;
      const target = write * GRID + x;
      if (target !== i) {
        board[target] = board[i];
        falls.push({ from: i, to: target });
      }
      write--;
    }
    let spawnRow = -1;
    for (let y = write; y >= 0; y--) {
      const target = y * GRID + x;
      const type = randTile();
      board[target] = type;
      spawns.push({ index: target, type, fromRow: spawnRow });
      spawnRow--;
    }
  }

  return { falls, spawns };
}
