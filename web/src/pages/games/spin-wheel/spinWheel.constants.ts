export type SpinRewardKind = 'ken' | 'vip' | 'item' | 'miss';

export interface SpinSegment {
  id: string;
  kind: SpinRewardKind;
  kenAmount?: number;
  vipDays?: number;
  weight: number;
}

export const SPIN_SEGMENTS: SpinSegment[] = [
  { id: 'ken-2000', kind: 'ken', kenAmount: 2000, weight: 22 },
  { id: 'ken-5000', kind: 'ken', kenAmount: 5000, weight: 15 },
  { id: 'ken-10000', kind: 'ken', kenAmount: 10000, weight: 5 },
  { id: 'ken-20000', kind: 'ken', kenAmount: 20000, weight: 1 },
  { id: 'item-doll', kind: 'item', weight: 6 },
  { id: 'vip-1', kind: 'vip', vipDays: 1, weight: 8 },
  { id: 'vip-2', kind: 'vip', vipDays: 2, weight: 3 },
  { id: 'miss', kind: 'miss', weight: 40 },
];

export const SEGMENT_COUNT = SPIN_SEGMENTS.length;
export const SEGMENT_ANGLE = 360 / SEGMENT_COUNT;

export const SPIN_START_KEN = 100_000;
export const SPIN_START_TURNS = 5;
export const SPIN_TURNS = 6;
export const SPIN_DURATION_MS = 4200;
