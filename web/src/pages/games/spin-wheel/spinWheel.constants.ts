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

export interface SegmentTheme {
  light: string;
  dark: string;
  stroke: string;
  shadow: string;
}

export const SEGMENT_THEMES: SegmentTheme[] = [
  { light: '#ff9a24', dark: '#f06416', stroke: '#81460e', shadow: '#4d2600' },
  { light: '#ffe24a', dark: '#f6b91d', stroke: '#a5670a', shadow: '#5e3a00' },
  { light: '#b9e33a', dark: '#76b92b', stroke: '#3f6a12', shadow: '#24400a' },
  { light: '#42d2dd', dark: '#1ba6c4', stroke: '#0b6478', shadow: '#063947' },
  { light: '#3d8be5', dark: '#1757b5', stroke: '#123a72', shadow: '#0a2450' },
  { light: '#a46ceb', dark: '#733cc9', stroke: '#4a238b', shadow: '#2a1250' },
  { light: '#c558d8', dark: '#9c37b0', stroke: '#5e1f6c', shadow: '#380f42' },
  { light: '#ff7aa5', dark: '#e94e82', stroke: '#9c3154', shadow: '#5e1a32' },
];

const FALLBACK_THEME: SegmentTheme = {
  light: '#ff9a24',
  dark: '#f06416',
  stroke: '#81460e',
  shadow: '#4d2600',
};

export const SEGMENT_COUNT = SPIN_SEGMENTS.length;
export const SEGMENT_ANGLE = 360 / SEGMENT_COUNT;

export function segmentTheme(index: number): SegmentTheme {
  return SEGMENT_THEMES[index % SEGMENT_THEMES.length] ?? FALLBACK_THEME;
}

export function segmentIndexById(id: string): number {
  return SPIN_SEGMENTS.findIndex((segment) => segment.id === id);
}

export const SPIN_START_KEN = 100_000;
export const SPIN_START_TURNS = 5;
export const SPIN_TURNS = 5;
export const SPIN_DURATION_MS = 5200;
