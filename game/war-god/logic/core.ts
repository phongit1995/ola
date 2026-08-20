import {
  CELLS,
  GRID,
  SPECIAL_HEART_CHANCE,
  SPECIAL_SWORD_CHANCE,
  TILE_ORDER,
  type BaseTileType,
  type TileType,
} from './constants.gen';

export { CELLS, GRID, SPECIAL_HEART_CHANCE, SPECIAL_SWORD_CHANCE } from './constants.gen';
export type { BaseTileType, TileType } from './constants.gen';

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

export interface LightningArc {
  source: number;
  target: number;
}

export interface ExplosionPlan {
  exploded: number[];
  lightningArcs: LightningArc[];
}

function randBase(random: () => number = Math.random): BaseTileType {
  const r = random() * 100;
  if (r < 22) return 'sword';
  if (r < 38) return 'peach';
  if (r < 54) return 'heart';
  if (r < 69) return 'water';
  if (r < 84) return 'shield';
  return 'lightning';
}

function randTile(random: () => number = Math.random): TileType {
  const base = randBase(random);
  if (base === 'sword' && random() < SPECIAL_SWORD_CHANCE) return 'fireSword';
  if (base === 'heart' && random() < SPECIAL_HEART_CHANCE) return 'greaterHeart';
  return base;
}

export function emptyCounts(): Record<TileType, number> {
  return Object.fromEntries(TILE_ORDER.map((tile) => [tile, 0])) as Record<TileType, number>;
}

export function createBoard(random: () => number = Math.random): Board {
  const board: Board = new Array(CELLS);
  for (let i = 0; i < CELLS; i++) {
    let type = randTile(random);
    while (createsMatchAt(board, i, type)) {
      type = randTile(random);
    }
    board[i] = type;
  }
  if (findValidMoves(board).length === 0) return createBoard(random);
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

function countBonusMatchGroups(board: Board, matched: ReadonlySet<number>): number {
  const visited = new Set<number>();
  let bonusTurns = 0;
  for (const start of matched) {
    if (visited.has(start)) continue;
    const type = baseTileType(board[start]);
    const queue = [start];
    visited.add(start);
    let size = 0;
    while (queue.length > 0) {
      const index = queue.pop()!;
      size++;
      const x = index % GRID;
      const y = Math.floor(index / GRID);
      const neighbors = [
        x > 0 ? index - 1 : -1,
        x < GRID - 1 ? index + 1 : -1,
        y > 0 ? index - GRID : -1,
        y < GRID - 1 ? index + GRID : -1,
      ];
      for (const neighbor of neighbors) {
        if (
          neighbor >= 0 &&
          matched.has(neighbor) &&
          !visited.has(neighbor) &&
          baseTileType(board[neighbor]) === type
        ) {
          visited.add(neighbor);
          queue.push(neighbor);
        }
      }
    }
    if (size >= 4) bonusTurns++;
  }
  return bonusTurns;
}

export function findMatches(board: Board): MatchResult | null {
  const cells = new Set<number>();
  let maxRun = 0;

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
  const bonusTurns = countBonusMatchGroups(board, cells);
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

/** Give every destroyed Lightning source one unique target outside the removal set. */
export function computeLightningArcs(
  board: Board,
  sources: Iterable<number>,
  removed: ReadonlySet<number>,
  random: () => number = Math.random,
): LightningArc[] {
  const lightningSources = [...new Set(sources)]
    .filter((index) => board[index] === 'lightning')
    .sort((a, b) => a - b);
  const unavailable = new Set(removed);
  lightningSources.forEach((index) => unavailable.add(index));
  const pool = Array.from({ length: CELLS }, (_, index) => index).filter(
    (index) => !unavailable.has(index),
  );
  const arcs: LightningArc[] = [];

  const targetCount = Math.min(lightningSources.length, pool.length);
  for (let order = 0; order < targetCount; order++) {
    const rawPick = Math.floor(random() * pool.length);
    const pick = Math.max(0, Math.min(pool.length - 1, rawPick));
    const target = pool[pick];
    pool[pick] = pool[pool.length - 1];
    pool.pop();
    arcs.push({ source: lightningSources[order], target });
  }
  return arcs;
}

function twoByTwoCells(topLeft: number): number[] {
  return [topLeft, topLeft + 1, topLeft + GRID, topLeft + GRID + 1];
}

/** Pick four non-overlapping 2x2 strike zones for Lôi Thần Giáng Thế. */
export function randomFourTwoByTwoBlocks(random: () => number = Math.random): number[][] {
  const choicesPerAxis = GRID - 1;
  let candidates = Array.from(
    { length: choicesPerAxis * choicesPerAxis },
    (_, choice) => Math.floor(choice / choicesPerAxis) * GRID + (choice % choicesPerAxis)
  );
  const blocks: number[][] = [];
  const occupied = new Set<number>();

  while (blocks.length < 4 && candidates.length > 0) {
    const rawPick = Math.floor(random() * candidates.length);
    const pick = Math.max(0, Math.min(candidates.length - 1, rawPick));
    const cells = twoByTwoCells(candidates[pick]);
    blocks.push(cells);
    cells.forEach((cell) => occupied.add(cell));
    candidates = candidates.filter((topLeft) =>
      twoByTwoCells(topLeft).every((cell) => !occupied.has(cell))
    );
  }

  return blocks;
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

export function computeExplosions(
  board: Board,
  matched: Set<number>,
  random: () => number = Math.random
): ExplosionPlan {
  const set = new Set<number>();
  const add = (x: number, y: number): void => {
    if (x >= 0 && x < GRID && y >= 0 && y < GRID) set.add(y * GRID + x);
  };

  // Kiếm Lửa vẫn nổ khối 3×3 như cũ. Tính vùng này trước để các mục tiêu
  // ngẫu nhiên của Lôi luôn là những ô bị ăn thêm thật sự.
  matched.forEach((i) => {
    const x = i % GRID;
    const y = Math.floor(i / GRID);
    const t = board[i];
    if (t === 'fireSword') {
      for (let dy = -1; dy <= 1; dy++) {
        for (let dx = -1; dx <= 1; dx++) add(x + dx, y + dy);
      }
    }
  });

  matched.forEach((i) => set.delete(i));

  // Lôi được match trực tiếp hoặc bị Kiếm Lửa chạm trong vùng nổ ban đầu
  // đều phát đúng một tia. Chốt sources trước khi thêm target để tia sét
  // không tiếp tục kích hoạt dây chuyền một ô Lôi ngẫu nhiên khác.
  const lightningSources = new Set([...matched, ...set]);
  const removed = new Set([...matched, ...set]);
  const lightningArcs = computeLightningArcs(board, lightningSources, removed, random);
  lightningArcs.forEach((arc) => set.add(arc.target));

  return {
    exploded: [...set].sort((a, b) => a - b),
    lightningArcs,
  };
}

export function applyGravity(
  board: Board,
  removed: Set<number>,
  random: () => number = Math.random
): GravityResult {
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
      const type = randTile(random);
      board[target] = type;
      spawns.push({ index: target, type, fromRow: spawnRow });
      spawnRow--;
    }
  }

  return { falls, spawns };
}
