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

export interface GiftAnimationVariant {
  key: string;
  giftClass: string;
  effects: GiftEffect[];
}

const DEFAULT_VARIANT: GiftAnimationVariant = {
  key: 'fly',
  giftClass: 'animate-gift-fly',
  effects: ['rays', 'sparks'],
};

export const GIFT_ANIMATION_VARIANTS: GiftAnimationVariant[] = [
  DEFAULT_VARIANT,
  {
    key: 'drop',
    giftClass: 'animate-gift-drop',
    effects: ['ring', 'confetti'],
  },
  { key: 'spin', giftClass: 'animate-gift-spin', effects: ['rays', 'ring'] },
  { key: 'zoom', giftClass: 'animate-gift-zoom', effects: ['glow', 'sparks'] },
  {
    key: 'float',
    giftClass: 'animate-gift-float',
    effects: ['glow', 'hearts'],
  },
  {
    key: 'swing',
    giftClass: 'animate-gift-swing',
    effects: ['glow', 'confetti'],
  },
  { key: 'pop', giftClass: 'animate-gift-pop', effects: ['firework', 'stars'] },
  {
    key: 'flip',
    giftClass: 'animate-gift-flip',
    effects: ['rainbow', 'sparks'],
  },
  {
    key: 'heartbeat',
    giftClass: 'animate-gift-heartbeat',
    effects: ['ring', 'hearts'],
  },
  {
    key: 'jelly',
    giftClass: 'animate-gift-jelly',
    effects: ['bubbles', 'stars'],
  },
  {
    key: 'tornado',
    giftClass: 'animate-gift-tornado',
    effects: ['rays', 'petals'],
  },
  {
    key: 'slide',
    giftClass: 'animate-gift-slide',
    effects: ['firework', 'confetti'],
  },
];

const ASSIGNED_LIMIT = 50;
const assignedVariants = new Map<string, GiftAnimationVariant>();
let lastVariantKey = '';

export function variantForAnimation(
  id: string,
  seed: number | undefined
): GiftAnimationVariant {
  const cached = assignedVariants.get(id);
  if (cached != null) return cached;
  const count = GIFT_ANIMATION_VARIANTS.length;
  let index = Math.min(Math.floor((seed ?? 0) * count), count - 1);
  if (GIFT_ANIMATION_VARIANTS[index]?.key === lastVariantKey) {
    index = (index + 1) % count;
  }
  const variant = GIFT_ANIMATION_VARIANTS[index] ?? DEFAULT_VARIANT;
  assignedVariants.set(id, variant);
  lastVariantKey = variant.key;
  if (assignedVariants.size > ASSIGNED_LIMIT) {
    const oldest = assignedVariants.keys().next().value;
    if (oldest != null) assignedVariants.delete(oldest);
  }
  return variant;
}

export const GIFT_SPARKS = [
  { x: '-170px', y: '-120px', delay: '0.35s' },
  { x: '160px', y: '-150px', delay: '0.45s' },
  { x: '-190px', y: '40px', delay: '0.5s' },
  { x: '180px', y: '70px', delay: '0.4s' },
  { x: '-80px', y: '-190px', delay: '0.6s' },
  { x: '100px', y: '170px', delay: '0.55s' },
  { x: '-130px', y: '150px', delay: '0.65s' },
  { x: '30px', y: '-200px', delay: '0.5s' },
  { x: '200px', y: '-30px', delay: '0.7s' },
  { x: '-200px', y: '-40px', delay: '0.75s' },
];

export const GIFT_CONFETTI = [
  {
    x: '-160px',
    drift: '30px',
    delay: '0.3s',
    color: '#ff4081',
    spin: '540deg',
  },
  {
    x: '-110px',
    drift: '-20px',
    delay: '0.5s',
    color: '#ffd600',
    spin: '-720deg',
  },
  {
    x: '-60px',
    drift: '40px',
    delay: '0.35s',
    color: '#40c4ff',
    spin: '600deg',
  },
  {
    x: '-15px',
    drift: '-30px',
    delay: '0.6s',
    color: '#69f0ae',
    spin: '-540deg',
  },
  { x: '30px', drift: '20px', delay: '0.4s', color: '#ff6e40', spin: '720deg' },
  {
    x: '75px',
    drift: '-40px',
    delay: '0.55s',
    color: '#e040fb',
    spin: '-600deg',
  },
  {
    x: '120px',
    drift: '30px',
    delay: '0.3s',
    color: '#ffd600',
    spin: '540deg',
  },
  {
    x: '165px',
    drift: '-20px',
    delay: '0.65s',
    color: '#ff4081',
    spin: '-720deg',
  },
  {
    x: '-135px',
    drift: '15px',
    delay: '0.8s',
    color: '#40c4ff',
    spin: '660deg',
  },
  {
    x: '95px',
    drift: '-15px',
    delay: '0.7s',
    color: '#69f0ae',
    spin: '-660deg',
  },
  {
    x: '-40px',
    drift: '25px',
    delay: '0.75s',
    color: '#ff6e40',
    spin: '600deg',
  },
  {
    x: '145px',
    drift: '-25px',
    delay: '0.8s',
    color: '#e040fb',
    spin: '-540deg',
  },
];

export const GIFT_HEARTS = [
  {
    x: '-130px',
    drift: '-20px',
    delay: '0.4s',
    size: '22px',
    color: '#ff4081',
  },
  { x: '-70px', drift: '15px', delay: '0.7s', size: '16px', color: '#ff80ab' },
  { x: '-20px', drift: '-10px', delay: '0.5s', size: '26px', color: '#f50057' },
  { x: '40px', drift: '20px', delay: '0.85s', size: '18px', color: '#ff80ab' },
  { x: '95px', drift: '-15px', delay: '0.45s', size: '24px', color: '#ff4081' },
  { x: '140px', drift: '10px', delay: '0.75s', size: '16px', color: '#f50057' },
  { x: '-100px', drift: '25px', delay: '0.8s', size: '18px', color: '#f50057' },
  { x: '70px', drift: '-25px', delay: '0.9s', size: '20px', color: '#ff80ab' },
];

export const GIFT_STARS = [
  { x: '-150px', y: '-110px', delay: '0.45s', size: '22px', color: '#ffd600' },
  { x: '140px', y: '-130px', delay: '0.6s', size: '18px', color: '#ffffff' },
  { x: '-170px', y: '60px', delay: '0.75s', size: '16px', color: '#ffffff' },
  { x: '160px', y: '40px', delay: '0.5s', size: '24px', color: '#ffd600' },
  { x: '-40px', y: '-170px', delay: '0.9s', size: '14px', color: '#ffe57f' },
  { x: '60px', y: '150px', delay: '0.7s', size: '18px', color: '#ffe57f' },
  { x: '-110px', y: '140px', delay: '1s', size: '14px', color: '#ffd600' },
  { x: '110px', y: '-60px', delay: '1.1s', size: '12px', color: '#ffffff' },
];

export const GIFT_BUBBLES = [
  { x: '-140px', drift: '-15px', delay: '0.3s', size: '18px' },
  { x: '-90px', drift: '20px', delay: '0.6s', size: '12px' },
  { x: '-40px', drift: '-10px', delay: '0.45s', size: '24px' },
  { x: '20px', drift: '15px', delay: '0.75s', size: '14px' },
  { x: '70px', drift: '-20px', delay: '0.4s', size: '20px' },
  { x: '125px', drift: '10px', delay: '0.65s', size: '16px' },
  { x: '160px', drift: '-10px', delay: '0.9s', size: '10px' },
  { x: '-170px', drift: '15px', delay: '0.8s', size: '12px' },
  { x: '0px', drift: '-25px', delay: '0.9s', size: '16px' },
];

const FIREWORK_DOTS = 10;
const FIREWORK_BURSTS = [
  { x: -120, y: -130, radius: 70, delay: 0.45, color: '#ffd600' },
  { x: 125, y: -95, radius: 60, delay: 0.7, color: '#ff4081' },
  { x: -10, y: 150, radius: 55, delay: 0.95, color: '#40c4ff' },
];

export const GIFT_FIREWORK = FIREWORK_BURSTS.flatMap((burst) =>
  Array.from({ length: FIREWORK_DOTS }, (_, i) => {
    const angle = (i / FIREWORK_DOTS) * Math.PI * 2;
    return {
      key: `${burst.x}:${burst.y}:${i}`,
      fromX: `${burst.x}px`,
      fromY: `${burst.y}px`,
      toX: `${Math.round(burst.x + Math.cos(angle) * burst.radius)}px`,
      toY: `${Math.round(burst.y + Math.sin(angle) * burst.radius)}px`,
      delay: `${burst.delay}s`,
      color: burst.color,
    };
  })
);

export const GIFT_PETALS = [
  { x: '-150px', drift: '40px', delay: '0.2s', spin: '400deg' },
  { x: '-95px', drift: '-30px', delay: '0.45s', spin: '-360deg' },
  { x: '-40px', drift: '35px', delay: '0.3s', spin: '420deg' },
  { x: '20px', drift: '-40px', delay: '0.5s', spin: '-380deg' },
  { x: '80px', drift: '30px', delay: '0.25s', spin: '360deg' },
  { x: '135px', drift: '-35px', delay: '0.5s', spin: '-420deg' },
  { x: '-120px', drift: '25px', delay: '0.7s', spin: '380deg' },
  { x: '105px', drift: '-25px', delay: '0.75s', spin: '-400deg' },
  { x: '-10px', drift: '30px', delay: '0.8s', spin: '400deg' },
];
