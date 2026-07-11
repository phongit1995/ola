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
export const HIT_HOLD_TICKS = 14;
export const MISS_HOLD_TICKS = 10;

export const EGG_COST = 10;
export const EGG_START_KEN = 200;
export const BIG_WIN_KEN = 120;

function expandFrames(keys: string[], holds: number[]): string[] {
  const seq: string[] = [];
  keys.forEach((key, i) => {
    const count = holds[i] ?? 1;
    for (let j = 0; j < count; j += 1) seq.push(key);
  });
  return seq;
}

export const SMASH_LOOP_FRAMES = expandFrames(
  ['Egg_1', 'Egg_2', 'Egg_3', 'Egg_4', 'Egg_5'],
  [2, 1, 1, 1, 2]
);

export interface SmashTail {
  frames: string[];
  revealAt: number;
}

const TAIL_HOLDS = [1, 1, 2, 4];

function buildTail(keys: string[], holdTicks: number, lastFrame: string): SmashTail {
  const core = expandFrames(keys, TAIL_HOLDS);
  return {
    frames: [...core, ...Array<string>(holdTicks).fill(lastFrame)],
    revealAt: core.length - 1,
  };
}

export const SMASH_TAIL_HIT = buildTail(['Egg_6', 'Egg_7', 'Egg_8', 'Egg_9'], HIT_HOLD_TICKS, 'Egg_9');
export const SMASH_TAIL_MISS = buildTail(
  ['Egg_6', 'Egg_7_Miss', 'Egg_8_Miss', 'Egg_9_Miss'],
  MISS_HOLD_TICKS,
  'Egg_9_Miss'
);
