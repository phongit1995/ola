export const BG_W = 640;
export const BG_H = 832;

export interface Nest {
  x: number;
  y: number;
}

export const NESTS: Nest[] = [
  { x: 193, y: 162 },
  { x: 421, y: 162 },
  { x: 86, y: 338 },
  { x: 317, y: 338 },
  { x: 522, y: 338 },
  { x: 186, y: 515 },
  { x: 421, y: 515 },
  { x: 81, y: 688 },
  { x: 322, y: 688 },
  { x: 523, y: 688 },
];

export const REST_SCALE = 0.85;
export const REST_ANCHOR_Y = 1.0;
export const REST_OFFSET_Y = 14;

export const ANIM_SCALE = REST_SCALE;
export const ANIM_ANCHOR_X = 0.51;
export const ANIM_ANCHOR_Y = 0.81;
export const ANIM_OFFSET_Y = -12;

export const TICK_MS = 70;
export const HOLDS = [2, 1, 1, 1, 2, 1, 1, 2, 4];
export const FRAMES_HIT = ['Egg_1', 'Egg_2', 'Egg_3', 'Egg_4', 'Egg_5', 'Egg_6', 'Egg_7', 'Egg_8', 'Egg_9'];
export const FRAMES_MISS = ['Egg_1', 'Egg_2', 'Egg_3', 'Egg_4', 'Egg_5', 'Egg_6', 'Egg_7_Miss', 'Egg_8_Miss', 'Egg_9_Miss'];
export const HIT_LAST_FRAME = 'Egg_9';
export const MISS_LAST_FRAME = 'Egg_9_Miss';

export const HIT_HOLD_TICKS = 14;
export const MISS_HOLD_TICKS = 10;

export const EGG_COST = 10;
export const EGG_TOPUP = 100;
export const EGG_HIT_RATE = 0.6;
export const EGG_START_KEN = 200;
export const BIG_WIN_KEN = 120;

export interface Prize {
  ken: number;
  weight: number;
}

export const PRIZES: Prize[] = [
  { ken: 20, weight: 52 },
  { ken: 50, weight: 30 },
  { ken: 120, weight: 13 },
  { ken: 300, weight: 5 },
];

const DEFAULT_PRIZE: Prize = { ken: 20, weight: 0 };

export function rollPrize(): Prize {
  const total = PRIZES.reduce((sum, p) => sum + p.weight, 0);
  let r = Math.random() * total;
  for (const p of PRIZES) {
    r -= p.weight;
    if (r <= 0) return p;
  }
  return PRIZES[0] ?? DEFAULT_PRIZE;
}

export function expandFrames(keys: string[]): string[] {
  const seq: string[] = [];
  keys.forEach((key, i) => {
    const count = HOLDS[i] ?? 1;
    for (let j = 0; j < count; j += 1) seq.push(key);
  });
  return seq;
}
