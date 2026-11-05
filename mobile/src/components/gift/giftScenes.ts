import type { GiftAnimationKey } from '@ola/shared/types';
import { GIFT_ANIMATION_DURATION_MS } from '@ola/shared/constants';
import { EASE, type Keyframe, type KeyframeAnimation } from './giftKeyframes';

export type GiftEffect =
  | 'rays'
  | 'sparks'
  | 'ring'
  | 'glow'
  | 'confetti'
  | 'hearts'
  | 'stars'
  | 'bubbles'
  | 'firework'
  | 'petals'
  | 'rainbow';

export interface Viewport {
  vw: number;
  vh: number;
}

const D = GIFT_ANIMATION_DURATION_MS;

function full(frames: Keyframe[], easing: KeyframeAnimation['easing']): KeyframeAnimation {
  return { frames, duration: D, easing };
}

export const GIFT_SCENE_EFFECTS: Record<GiftAnimationKey, GiftEffect[]> = {
  fly: ['rays', 'sparks'],
  drop: ['ring', 'confetti'],
  spin: ['rays', 'ring'],
  zoom: ['glow', 'sparks'],
  float: ['glow', 'hearts'],
  swing: ['glow', 'confetti'],
  pop: ['firework', 'stars'],
  flip: ['rainbow', 'sparks'],
  heartbeat: ['ring', 'hearts'],
  jelly: ['bubbles', 'stars'],
  tornado: ['rays', 'petals'],
  slide: ['firework', 'confetti'],
};

export function giftMotion(key: GiftAnimationKey, { vw, vh }: Viewport): KeyframeAnimation {
  switch (key) {
    case 'fly':
      return full(
        [
          { at: 0, opacity: 0, transform: { translateY: 45 * vh, scale: 0.3, rotate: -12 } },
          { at: 0.22, opacity: 1, transform: { scale: 1.18, rotate: 4 } },
          { at: 0.32, transform: { scale: 0.96 } },
          { at: 0.4, opacity: 1, transform: {} },
          { at: 0.78, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateY: -18 * vh, scale: 0.7 } },
        ],
        EASE.snappy
      );
    case 'drop':
      return full(
        [
          { at: 0, opacity: 0, transform: { translateY: -60 * vh, scale: 0.85 } },
          { at: 0.18, opacity: 1, transform: { scaleX: 1.08, scaleY: 0.9 } },
          { at: 0.26, transform: { translateY: -36, scaleX: 0.96, scaleY: 1.04 } },
          { at: 0.34, transform: { scaleX: 1.03, scaleY: 0.97 } },
          { at: 0.4, opacity: 1, transform: {} },
          { at: 0.78, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateY: 8 * vh, scale: 0.8 } },
        ],
        EASE.bouncy
      );
    case 'spin':
      return full(
        [
          { at: 0, opacity: 0, transform: { scale: 0, rotate: -540 } },
          { at: 0.3, opacity: 1, transform: { scale: 1.15, rotate: 12 } },
          { at: 0.4, opacity: 1, transform: {} },
          { at: 0.78, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { scale: 1.45 } },
        ],
        EASE.snappy
      );
    case 'zoom':
      return full(
        [
          { at: 0, opacity: 0, transform: { scale: 3 } },
          { at: 0.25, opacity: 1, transform: { scale: 0.92 } },
          { at: 0.34, transform: { scale: 1.05 } },
          { at: 0.42, opacity: 1, transform: {} },
          { at: 0.78, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateY: -14 * vh, scale: 0.6 } },
        ],
        EASE.snappy
      );
    case 'float':
      return full(
        [
          { at: 0, opacity: 0, transform: { translateY: 30 * vh, scale: 0.6 } },
          { at: 0.28, opacity: 1, transform: {} },
          { at: 0.42, transform: { translateY: -14, scale: 1.02 } },
          { at: 0.56, transform: { translateY: 6 } },
          { at: 0.7, transform: { translateY: -8, scale: 1.01 } },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateY: -32 * vh, scale: 0.85 } },
        ],
        EASE.inOut
      );
    case 'swing':
      return full(
        [
          { at: 0, opacity: 0, transform: { translateX: -70 * vw, rotate: -35 } },
          { at: 0.24, opacity: 1, transform: { rotate: 16 } },
          { at: 0.34, transform: { rotate: -10 } },
          { at: 0.44, transform: { rotate: 6 } },
          { at: 0.54, transform: { rotate: -3 } },
          { at: 0.62, opacity: 1, transform: {} },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateX: 60 * vw, rotate: 25 } },
        ],
        EASE.out
      );
    case 'pop':
      return full(
        [
          { at: 0, opacity: 0, transform: { scale: 0 } },
          { at: 0.18, opacity: 1, transform: { scale: 1.3 } },
          { at: 0.28, transform: { scale: 0.88 } },
          { at: 0.36, transform: { scale: 1.06 } },
          { at: 0.44, opacity: 1, transform: {} },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateY: -20 * vh, scale: 0.7 } },
        ],
        EASE.snappy
      );
    case 'flip':
      return full(
        [
          { at: 0, opacity: 0, transform: { rotateY: -720, scale: 0.3 } },
          { at: 0.32, opacity: 1, transform: { rotateY: 15, scale: 1.08 } },
          { at: 0.42, opacity: 1, transform: {} },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { rotateY: 180, scale: 0.6 } },
        ],
        EASE.snappy
      );
    case 'heartbeat':
      return full(
        [
          { at: 0, opacity: 0, transform: { scale: 0.4 } },
          { at: 0.15, opacity: 1, transform: {} },
          { at: 0.24, transform: { scale: 1.14 } },
          { at: 0.32, transform: {} },
          { at: 0.4, transform: { scale: 1.14 } },
          { at: 0.48, transform: {} },
          { at: 0.62, transform: { scale: 1.1 } },
          { at: 0.7, opacity: 1, transform: {} },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { scale: 1.3 } },
        ],
        EASE.inOut
      );
    case 'jelly':
      return full(
        [
          { at: 0, opacity: 0, transform: { translateY: 20 * vh, scale: 0.5 } },
          { at: 0.2, opacity: 1, transform: { scaleX: 1.25, scaleY: 0.75 } },
          { at: 0.3, transform: { scaleX: 0.8, scaleY: 1.2 } },
          { at: 0.4, transform: { scaleX: 1.12, scaleY: 0.88 } },
          { at: 0.5, transform: { scaleX: 0.95, scaleY: 1.05 } },
          { at: 0.58, opacity: 1, transform: {} },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateY: -10 * vh, scale: 0.6 } },
        ],
        EASE.out
      );
    case 'tornado':
      return full(
        [
          { at: 0, opacity: 0, transform: { orbit: -720, translateX: 170, rotate: 720, scale: 0.2 } },
          { at: 0.3, opacity: 1, transform: { scale: 1.1 } },
          { at: 0.4, opacity: 1, transform: {} },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { orbit: 360, scale: 0.5 } },
        ],
        EASE.snappy
      );
    case 'slide':
      return full(
        [
          { at: 0, opacity: 0, transform: { translateX: 80 * vw, skewX: -20 } },
          { at: 0.22, opacity: 1, transform: { translateX: -24, skewX: 10 } },
          { at: 0.32, transform: { translateX: 10, skewX: -4 } },
          { at: 0.4, opacity: 1, transform: {} },
          { at: 0.8, opacity: 1, transform: {} },
          { at: 1, opacity: 0, transform: { translateX: -80 * vw, skewX: 20 } },
        ],
        EASE.snappy
      );
  }
}

export const RAYS_ANIMATION = full(
  [
    { at: 0, opacity: 0, transform: { scale: 0.4 } },
    { at: 0.25, opacity: 0.9, transform: { scale: 1, rotate: 90 } },
    { at: 0.75, opacity: 0.9, transform: { scale: 1, rotate: 90 } },
    { at: 1, opacity: 0, transform: { scale: 1.2, rotate: 140 } },
  ],
  EASE.linear
);

export const GLOW_ANIMATION = full(
  [
    { at: 0, opacity: 0, transform: { scale: 0.4 } },
    { at: 0.28, opacity: 1, transform: {} },
    { at: 0.46, transform: { scale: 1.1 } },
    { at: 0.62, transform: { scale: 0.98 } },
    { at: 0.78, opacity: 1, transform: { scale: 1.05 } },
    { at: 1, opacity: 0, transform: { scale: 1.3 } },
  ],
  EASE.inOut
);

export const FLASH_ANIMATION = full(
  [
    { at: 0, opacity: 0, transform: { scale: 0.3 } },
    { at: 0.18, opacity: 0, transform: { scale: 0.3 } },
    { at: 0.26, opacity: 0.9, transform: {} },
    { at: 0.46, opacity: 0, transform: { scale: 1.6 } },
    { at: 1, opacity: 0, transform: { scale: 1.6 } },
  ],
  EASE.out
);

export const RAINBOW_ANIMATION = full(
  [
    { at: 0, opacity: 0, transform: { scale: 0.5 } },
    { at: 0.3, opacity: 0.9, transform: { rotate: 120 } },
    { at: 0.78, opacity: 0.9, transform: { scale: 1.05, rotate: 360 } },
    { at: 1, opacity: 0, transform: { scale: 1.25, rotate: 450 } },
  ],
  EASE.linear
);

export const RING_DELAYS = [450, 750];

export function ringAnimation(delay: number): KeyframeAnimation {
  return {
    frames: [
      { at: 0, opacity: 0, transform: { scale: 0.2 } },
      { at: 0.2, opacity: 0.95 },
      { at: 1, opacity: 0, transform: { scale: 1.8 } },
    ],
    duration: 1200,
    easing: EASE.out,
    delay,
  };
}

export const SPARKS = [
  { x: -170, y: -120, delay: 350 },
  { x: 160, y: -150, delay: 450 },
  { x: -190, y: 40, delay: 500 },
  { x: 180, y: 70, delay: 400 },
  { x: -80, y: -190, delay: 600 },
  { x: 100, y: 170, delay: 550 },
  { x: -130, y: 150, delay: 650 },
  { x: 30, y: -200, delay: 500 },
  { x: 200, y: -30, delay: 700 },
  { x: -200, y: -40, delay: 750 },
];

export function sparkAnimation(spark: (typeof SPARKS)[number]): KeyframeAnimation {
  return {
    frames: [
      { at: 0, opacity: 0, transform: { scale: 0.2 } },
      { at: 0.3, opacity: 1 },
      { at: 1, opacity: 0, transform: { translateX: spark.x, translateY: spark.y } },
    ],
    duration: 1400,
    easing: EASE.out,
    delay: spark.delay,
  };
}

export const CONFETTI = [
  { x: -160, drift: 30, delay: 300, color: '#ff4081', spin: 540 },
  { x: -110, drift: -20, delay: 500, color: '#ffd600', spin: -720 },
  { x: -60, drift: 40, delay: 350, color: '#40c4ff', spin: 600 },
  { x: -15, drift: -30, delay: 600, color: '#69f0ae', spin: -540 },
  { x: 30, drift: 20, delay: 400, color: '#ff6e40', spin: 720 },
  { x: 75, drift: -40, delay: 550, color: '#e040fb', spin: -600 },
  { x: 120, drift: 30, delay: 300, color: '#ffd600', spin: 540 },
  { x: 165, drift: -20, delay: 650, color: '#ff4081', spin: -720 },
  { x: -135, drift: 15, delay: 800, color: '#40c4ff', spin: 660 },
  { x: 95, drift: -15, delay: 700, color: '#69f0ae', spin: -660 },
  { x: -40, drift: 25, delay: 750, color: '#ff6e40', spin: 600 },
  { x: 145, drift: -25, delay: 800, color: '#e040fb', spin: -540 },
];

export function confettiAnimation(piece: (typeof CONFETTI)[number], { vh }: Viewport): KeyframeAnimation {
  return {
    frames: [
      { at: 0, opacity: 0, transform: { translateX: piece.x, translateY: -48 * vh } },
      { at: 0.1, opacity: 1 },
      { at: 0.85, opacity: 1 },
      {
        at: 1,
        opacity: 0,
        transform: { translateX: piece.x + piece.drift, translateY: 40 * vh, rotate: piece.spin },
      },
    ],
    duration: 1600,
    easing: EASE.in,
    delay: piece.delay,
  };
}

export const HEARTS = [
  { x: -130, drift: -20, delay: 400, size: 22, color: '#ff4081' },
  { x: -70, drift: 15, delay: 700, size: 16, color: '#ff80ab' },
  { x: -20, drift: -10, delay: 500, size: 26, color: '#f50057' },
  { x: 40, drift: 20, delay: 850, size: 18, color: '#ff80ab' },
  { x: 95, drift: -15, delay: 450, size: 24, color: '#ff4081' },
  { x: 140, drift: 10, delay: 750, size: 16, color: '#f50057' },
  { x: -100, drift: 25, delay: 800, size: 18, color: '#f50057' },
  { x: 70, drift: -25, delay: 900, size: 20, color: '#ff80ab' },
];

export function heartAnimation(heart: (typeof HEARTS)[number]): KeyframeAnimation {
  return {
    frames: [
      { at: 0, opacity: 0, transform: { translateX: heart.x, translateY: 90, scale: 0.4 } },
      { at: 0.25, opacity: 1 },
      { at: 1, opacity: 0, transform: { translateX: heart.x + heart.drift, translateY: -230, scale: 1.15 } },
    ],
    duration: 1500,
    easing: EASE.out,
    delay: heart.delay,
  };
}

export const STARS = [
  { x: -150, y: -110, delay: 450, size: 22, color: '#ffd600' },
  { x: 140, y: -130, delay: 600, size: 18, color: '#ffffff' },
  { x: -170, y: 60, delay: 750, size: 16, color: '#ffffff' },
  { x: 160, y: 40, delay: 500, size: 24, color: '#ffd600' },
  { x: -40, y: -170, delay: 900, size: 14, color: '#ffe57f' },
  { x: 60, y: 150, delay: 700, size: 18, color: '#ffe57f' },
  { x: -110, y: 140, delay: 1000, size: 14, color: '#ffd600' },
  { x: 110, y: -60, delay: 1100, size: 12, color: '#ffffff' },
];

export function starAnimation(star: (typeof STARS)[number]): KeyframeAnimation {
  const at = (scale: number, rotate: number) => ({ translateX: star.x, translateY: star.y, scale, rotate });
  return {
    frames: [
      { at: 0, opacity: 0, transform: at(0, 0) },
      { at: 0.4, opacity: 1, transform: at(1.25, 90) },
      { at: 0.7, opacity: 0.8, transform: at(0.8, 150) },
      { at: 1, opacity: 0, transform: at(0, 200) },
    ],
    duration: 1300,
    easing: EASE.inOut,
    delay: star.delay,
  };
}

export const BUBBLES = [
  { x: -140, drift: -15, delay: 300, size: 18 },
  { x: -90, drift: 20, delay: 600, size: 12 },
  { x: -40, drift: -10, delay: 450, size: 24 },
  { x: 20, drift: 15, delay: 750, size: 14 },
  { x: 70, drift: -20, delay: 400, size: 20 },
  { x: 125, drift: 10, delay: 650, size: 16 },
  { x: 160, drift: -10, delay: 900, size: 10 },
  { x: -170, drift: 15, delay: 800, size: 12 },
  { x: 0, drift: -25, delay: 900, size: 16 },
];

export function bubbleAnimation(bubble: (typeof BUBBLES)[number]): KeyframeAnimation {
  return {
    frames: [
      { at: 0, opacity: 0, transform: { translateX: bubble.x, translateY: 130, scale: 0.4 } },
      { at: 0.2, opacity: 1 },
      { at: 0.85, opacity: 0.9 },
      { at: 1, opacity: 0, transform: { translateX: bubble.x + bubble.drift, translateY: -240, scale: 1.1 } },
    ],
    duration: 1500,
    easing: EASE.out,
    delay: bubble.delay,
  };
}

const FIREWORK_DOTS = 10;
const FIREWORK_BURSTS = [
  { x: -120, y: -130, radius: 70, delay: 450, color: '#ffd600' },
  { x: 125, y: -95, radius: 60, delay: 700, color: '#ff4081' },
  { x: -10, y: 150, radius: 55, delay: 950, color: '#40c4ff' },
];

export const FIREWORK = FIREWORK_BURSTS.flatMap((burst) =>
  Array.from({ length: FIREWORK_DOTS }, (_, i) => {
    const angle = (i / FIREWORK_DOTS) * Math.PI * 2;
    return {
      key: `${burst.x}:${burst.y}:${i}`,
      fromX: burst.x,
      fromY: burst.y,
      toX: Math.round(burst.x + Math.cos(angle) * burst.radius),
      toY: Math.round(burst.y + Math.sin(angle) * burst.radius),
      delay: burst.delay,
      color: burst.color,
    };
  })
);

export function fireworkAnimation(dot: (typeof FIREWORK)[number]): KeyframeAnimation {
  return {
    frames: [
      { at: 0, opacity: 0, transform: { translateX: dot.fromX, translateY: dot.fromY, scale: 0.4 } },
      { at: 0.15, opacity: 1 },
      { at: 1, opacity: 0, transform: { translateX: dot.toX, translateY: dot.toY } },
    ],
    duration: 1100,
    easing: EASE.out,
    delay: dot.delay,
  };
}

export const PETALS = [
  { x: -150, drift: 40, delay: 200, spin: 400 },
  { x: -95, drift: -30, delay: 450, spin: -360 },
  { x: -40, drift: 35, delay: 300, spin: 420 },
  { x: 20, drift: -40, delay: 500, spin: -380 },
  { x: 80, drift: 30, delay: 250, spin: 360 },
  { x: 135, drift: -35, delay: 500, spin: -420 },
  { x: -120, drift: 25, delay: 700, spin: 380 },
  { x: 105, drift: -25, delay: 750, spin: -400 },
  { x: -10, drift: 30, delay: 800, spin: 400 },
];

export function petalAnimation(petal: (typeof PETALS)[number], { vh }: Viewport): KeyframeAnimation {
  return {
    frames: [
      { at: 0, opacity: 0, transform: { translateX: petal.x, translateY: -46 * vh } },
      { at: 0.12, opacity: 1 },
      {
        at: 0.5,
        transform: { translateX: petal.x + petal.drift, translateY: -4 * vh, rotate: petal.spin / 2 },
      },
      { at: 0.88, opacity: 1 },
      { at: 1, opacity: 0, transform: { translateX: petal.x, translateY: 38 * vh, rotate: petal.spin } },
    ],
    duration: 1600,
    easing: EASE.inOut,
    delay: petal.delay,
  };
}
