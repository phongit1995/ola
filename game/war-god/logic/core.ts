import {
  CELLS,
  GRID,
  SPECIAL_FLYING_DART_CHANCE,
  SPECIAL_HEART_CHANCE,
  SPECIAL_SWORD_CHANCE,
  TILE_ORDER,
  type BaseTileType,
  type TileType,
} from './constants.gen';

export {
  CELLS,
  GRID,
  SPECIAL_FLYING_DART_CHANCE,
  SPECIAL_HEART_CHANCE,
  SPECIAL_SWORD_CHANCE,
} from './constants.gen';
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

export type FlyingDartAxis = 'horizontal' | 'vertical';

export interface DartCreation {
  index: number;
  type: 'flyingDartHorizontal' | 'flyingDartVertical';
}

export interface DartActivation {
  source: number;
  axis: FlyingDartAxis;
}

export interface ExplosionPlan {
  exploded: number[];
  lightningArcs: LightningArc[];
  dartActivations: DartActivation[];
  fireSwordActivations: number[];
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

const MAX_FLYING_DARTS_ON_BOARD = 2;

function randTile(random: () => number = Math.random, allowFlyingDart = false): TileType {
  if (allowFlyingDart && random() < SPECIAL_FLYING_DART_CHANCE) {
    return random() < 0.5 ? 'flyingDartHorizontal' : 'flyingDartVertical';
  }
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
  if (type === 'flyingDartHorizontal' || type === 'flyingDartVertical') return 'water';
  return type;
}

export function isFlyingDart(type: TileType): boolean {
  return type === 'flyingDartHorizontal' || type === 'flyingDartVertical';
}

export function flyingDartAxis(type: TileType): FlyingDartAxis {
  return type === 'flyingDartVertical' ? 'vertical' : 'horizontal';
}

/** Expand an affected set with every unique Phi Tiêu line reachable from seed cells. */
export function addFlyingDartActivations(
  board: Board,
  seed: ReadonlySet<number>,
  affected: Set<number>,
): DartActivation[] {
  const activated = new Set<number>();
  const activations: DartActivation[] = [];
  for (;;) {
    const candidates = [...new Set([...seed, ...affected])]
      .filter((index) => isFlyingDart(board[index]) && !activated.has(index))
      .sort((a, b) => a - b);
    if (candidates.length === 0) break;
    for (const source of candidates) {
      if (activated.has(source)) continue;
      activated.add(source);
      const axis = flyingDartAxis(board[source]);
      activations.push({ source, axis });
      const x = source % GRID;
      const y = Math.floor(source / GRID);
      if (axis === 'horizontal') {
        for (let column = 0; column < GRID; column++) affected.add(y * GRID + column);
      } else {
        for (let row = 0; row < GRID; row++) affected.add(row * GRID + x);
      }
    }
  }
  return activations;
}

/** Expand a set of struck cells with dart lines and Fire Swords hit by those lines. */
export function expandDartTriggeredSpecials(
  board: Board,
  affected: Set<number>,
  directFireSwords: ReadonlySet<number> = new Set(),
): { dartActivations: DartActivation[]; fireSwordActivations: number[] } {
  const seed = new Set(affected);
  const dartSwept = new Set<number>();
  const activatedDarts = new Set<number>();
  const activatedFireSwords = new Set<number>();
  const dartActivations: DartActivation[] = [];
  const fireSwordActivations: number[] = [];

  for (;;) {
    let changed = false;
    for (const activation of addFlyingDartActivations(board, seed, affected)) {
      if (activatedDarts.has(activation.source)) continue;
      activatedDarts.add(activation.source);
      dartActivations.push(activation);
      const x = activation.source % GRID;
      const y = Math.floor(activation.source / GRID);
      if (activation.axis === 'horizontal') {
        for (let column = 0; column < GRID; column++) dartSwept.add(y * GRID + column);
      } else {
        for (let row = 0; row < GRID; row++) dartSwept.add(row * GRID + x);
      }
      changed = true;
    }

    const fireCandidates = [...affected]
      .filter(
        (index) =>
          board[index] === 'fireSword' &&
          !directFireSwords.has(index) &&
          dartSwept.has(index) &&
          !activatedFireSwords.has(index),
      )
      .sort((a, b) => a - b);
    for (const source of fireCandidates) {
      activatedFireSwords.add(source);
      fireSwordActivations.push(source);
      const x = source % GRID;
      const y = Math.floor(source / GRID);
      for (let dy = -1; dy <= 1; dy++) {
        for (let dx = -1; dx <= 1; dx++) {
          if (x + dx >= 0 && x + dx < GRID && y + dy >= 0 && y + dy < GRID) {
            affected.add((y + dy) * GRID + x + dx);
          }
        }
      }
      changed = true;
    }

    if (!changed) break;
  }

  return { dartActivations, fireSwordActivations };
}

/** Create one Phi Tiêu from a straight run of at least five plain Water tiles. */
export function findFlyingDartCreation(
  board: Board,
  preferred: readonly number[] = [],
): DartCreation | null {
  const runs: Array<{ cells: number[]; type: DartCreation['type'] }> = [];
  const appendRun = (cells: number[], type: DartCreation['type']): void => {
    if (cells.length >= 5) runs.push({ cells, type });
  };
  for (let y = 0; y < GRID; y++) {
    for (let start = 0; start < GRID; ) {
      if (board[y * GRID + start] !== 'water') {
        start++;
        continue;
      }
      let end = start + 1;
      while (end < GRID && board[y * GRID + end] === 'water') end++;
      appendRun(
        Array.from({ length: end - start }, (_, offset) => y * GRID + start + offset),
        'flyingDartHorizontal',
      );
      start = end;
    }
  }
  for (let x = 0; x < GRID; x++) {
    for (let start = 0; start < GRID; ) {
      if (board[start * GRID + x] !== 'water') {
        start++;
        continue;
      }
      let end = start + 1;
      while (end < GRID && board[end * GRID + x] === 'water') end++;
      appendRun(
        Array.from({ length: end - start }, (_, offset) => (start + offset) * GRID + x),
        'flyingDartVertical',
      );
      start = end;
    }
  }
  if (runs.length === 0) return null;

  for (const index of preferred) {
    if (board[index] !== 'water') continue;
    const run = runs.find(({ cells }) => cells.includes(index));
    if (run) return { index, type: run.type };
  }
  const chosen = runs.reduce((longest, run) =>
    run.cells.length > longest.cells.length ? run : longest,
  );
  const middle = Math.floor((chosen.cells.length - 1) / 2);
  for (let distance = 0; distance < chosen.cells.length; distance++) {
    for (const offset of distance === 0 ? [0] : [distance, -distance]) {
      const index = chosen.cells[middle + offset];
      if (index != null && board[index] === 'water') return { index, type: chosen.type };
    }
  }
  return null;
}

function countBonusMatchGroups(board: Board, matched: ReadonlySet<number>): number {
  const baseTypes = new Set<BaseTileType>();
  matched.forEach((index) => {
    if (!isFlyingDart(board[index])) baseTypes.add(baseTileType(board[index]));
  });
  let bonusTurns = 0;
  for (const type of baseTypes) {
    const visited = new Set<number>();
    const compatible = (index: number): boolean =>
      isFlyingDart(board[index]) || baseTileType(board[index]) === type;
    for (const start of matched) {
      if (visited.has(start) || !compatible(start)) continue;
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
            compatible(neighbor)
          ) {
            visited.add(neighbor);
            queue.push(neighbor);
          }
        }
      }
      if (size >= 4) bonusTurns++;
    }
  }
  return bonusTurns;
}

function scanLineMatches(
  board: Board,
  start: number,
  step: number,
  length: number,
): { runs: number[][]; maxRun: number } {
  const candidates: Array<{ start: number; end: number }> = [];
  let maxRun = 0;
  for (let runStart = 0; runStart <= length - 3; runStart++) {
    let matchType: BaseTileType | null = null;
    let dartCount = 0;
    for (let end = runStart; end < length; end++) {
      const tile = board[start + end * step];
      if (isFlyingDart(tile)) {
        dartCount++;
        if (dartCount > 1) break;
      } else {
        const base = baseTileType(tile);
        if (matchType == null) matchType = base;
        else if (matchType !== base) break;
      }
      const runLength = end - runStart + 1;
      if (runLength >= 3) {
        candidates.push({ start: runStart, end: end + 1 });
        maxRun = Math.max(maxRun, runLength);
      }
    }
  }
  candidates.sort((left, right) => {
    const lengthDiff = right.end - right.start - (left.end - left.start);
    return lengthDiff !== 0 ? lengthDiff : left.start - right.start;
  });
  const occupied = new Set<number>();
  const runs: number[][] = [];
  for (const candidate of candidates) {
    const cells = Array.from(
      { length: candidate.end - candidate.start },
      (_, offset) => start + (candidate.start + offset) * step,
    );
    if (cells.some((index) => occupied.has(index))) continue;
    cells.forEach((index) => occupied.add(index));
    runs.push(cells);
  }
  return { runs, maxRun };
}

export function findMatches(board: Board): MatchResult | null {
  const cells = new Set<number>();
  let maxRun = 0;

  const scanLine = (start: number, step: number, length: number): void => {
    const result = scanLineMatches(board, start, step, length);
    maxRun = Math.max(maxRun, result.maxRun);
    result.runs.forEach((run) => run.forEach((index) => cells.add(index)));
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
    (_, choice) => Math.floor(choice / choicesPerAxis) * GRID + (choice % choicesPerAxis),
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
      twoByTwoCells(topLeft).every((cell) => !occupied.has(cell)),
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
  random: () => number = Math.random,
): ExplosionPlan {
  const set = new Set<number>();
  const add = (x: number, y: number): void => {
    if (x >= 0 && x < GRID && y >= 0 && y < GRID) set.add(y * GRID + x);
  };

  const fireSwordActivations: number[] = [];
  const activatedFireSwords = new Set<number>();
  const dartActivations: DartActivation[] = [];
  const activatedDarts = new Set<number>();
  const dartSwept = new Set<number>();

  // Special tiles form a deterministic chain through Phi Tiêu. A Fire Sword
  // reached by a dart sweep also explodes its 3×3 area; another Fire Sword
  // caught only by that blast remains an ordinary removed tile.
  for (;;) {
    let changed = false;
    const candidates = [...new Set([...matched, ...set])].sort((a, b) => a - b);
    for (const i of candidates) {
      // A Fire Sword keeps its old direct-match behavior. The Phi Tiêu rule
      // additionally allows a dart sweep to activate it; another Fire
      // Sword's 3x3 blast alone must not start a new Fire Sword chain.
      if (
        board[i] !== 'fireSword' ||
        activatedFireSwords.has(i) ||
        (!matched.has(i) && !dartSwept.has(i))
      ) {
        continue;
      }
      activatedFireSwords.add(i);
      fireSwordActivations.push(i);
      const x = i % GRID;
      const y = Math.floor(i / GRID);
      for (let dy = -1; dy <= 1; dy++) {
        for (let dx = -1; dx <= 1; dx++) add(x + dx, y + dy);
      }
      changed = true;
    }

    // addFlyingDartActivations expands all reachable dart lines. Filter the
    // result through a wave-level set so a second loop cannot replay a dart.
    for (const activation of addFlyingDartActivations(board, matched, set)) {
      if (activatedDarts.has(activation.source)) continue;
      activatedDarts.add(activation.source);
      dartActivations.push(activation);
      const x = activation.source % GRID;
      const y = Math.floor(activation.source / GRID);
      if (activation.axis === 'horizontal') {
        for (let column = 0; column < GRID; column++) dartSwept.add(y * GRID + column);
      } else {
        for (let row = 0; row < GRID; row++) dartSwept.add(row * GRID + x);
      }
      changed = true;
    }
    if (!changed) break;
  }

  matched.forEach((i) => set.delete(i));

  // Lôi được match trực tiếp hoặc bị vùng đặc biệt (Kiếm Lửa/Phi Tiêu)
  // chạm đều phát đúng một tia. Chốt sources trước khi thêm target để tia
  // sét không tiếp tục kích hoạt dây chuyền một ô Lôi ngẫu nhiên khác.
  const lightningSources = new Set([...matched, ...set]);
  const removed = new Set([...matched, ...set]);
  const lightningArcs = computeLightningArcs(board, lightningSources, removed, random);
  lightningArcs.forEach((arc) => set.add(arc.target));

  return {
    exploded: [...set].sort((a, b) => a - b),
    lightningArcs,
    dartActivations,
    fireSwordActivations,
  };
}

export function applyGravity(
  board: Board,
  removed: Set<number>,
  random: () => number = Math.random,
): GravityResult {
  const falls: Fall[] = [];
  const spawns: Spawn[] = [];
  let flyingDarts = board.reduce(
    (count, tile, index) => count + (!removed.has(index) && isFlyingDart(tile) ? 1 : 0),
    0,
  );

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
      const type = randTile(random, flyingDarts < MAX_FLYING_DARTS_ON_BOARD);
      if (isFlyingDart(type)) flyingDarts++;
      board[target] = type;
      spawns.push({ index: target, type, fromRow: spawnRow });
      spawnRow--;
    }
  }

  return { falls, spawns };
}
