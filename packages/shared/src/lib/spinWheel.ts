export interface SegmentTheme {
  light: string;
  dark: string;
  stroke: string;
  shadow: string;
}

export const SEGMENT_PALETTE = [
  '#ff8a34',
  '#2cb8d0',
  '#ffc93c',
  '#8b5cf6',
  '#a0d22b',
  '#f06ba0',
  '#2e7dd1',
  '#ff6b6b',
  '#34c759',
  '#c558d8',
  '#ffd93c',
  '#26c6da',
  '#7ac943',
  '#ec407a',
  '#5b7cf0',
  '#ff9a8b',
  '#2cc7b0',
  '#b06bf0',
  '#f4a62a',
  '#4dd0e1',
];

function hexToRgb(hex: string): [number, number, number] {
  const value = hex.replace('#', '');
  const full =
    value.length === 3
      ? value
          .split('')
          .map((c) => c + c)
          .join('')
      : value;
  const int = parseInt(full, 16);
  return [(int >> 16) & 255, (int >> 8) & 255, int & 255];
}

function toHex(channel: number): string {
  return Math.max(0, Math.min(255, Math.round(channel))).toString(16).padStart(2, '0');
}

function mix(hex: string, target: number, amount: number): string {
  const [r, g, b] = hexToRgb(hex);
  const blend = (channel: number) => channel + (target - channel) * amount;
  return `#${toHex(blend(r))}${toHex(blend(g))}${toHex(blend(b))}`;
}

export function themeFromColor(hex: string): SegmentTheme {
  return {
    light: mix(hex, 255, 0.2),
    dark: mix(hex, 0, 0.18),
    stroke: mix(hex, 0, 0.55),
    shadow: mix(hex, 0, 0.72),
  };
}

export function segmentColor(index: number): string {
  return SEGMENT_PALETTE[index % SEGMENT_PALETTE.length] ?? SEGMENT_PALETTE[0]!;
}

export function segmentTheme(index: number): SegmentTheme {
  return themeFromColor(segmentColor(index));
}

export function segmentAngle(count: number): number {
  return count > 0 ? 360 / count : 360;
}

export function rotationForIndex(current: number, index: number, count: number): number {
  const angle = segmentAngle(count);
  const landing = (360 - index * angle) % 360;
  const currentAngle = ((current % 360) + 360) % 360;
  const delta = (landing - currentAngle + 360) % 360;
  return current + SPIN_TURNS * 360 + delta;
}

export const SPIN_TURNS = 6;
export const SPIN_DURATION_MS = 4200;
export const SPIN_START_KEN = 0;

export const WHEEL_VIEWBOX = 100;
export const WHEEL_CENTER = WHEEL_VIEWBOX / 2;
export const WHEEL_SLICE_RADIUS = 48;
export const WHEEL_LABEL_RADIUS = 31;
export const WHEEL_DIVIDER_INNER_RADIUS = 12;

export interface WheelPoint {
  x: number;
  y: number;
}

export interface WheelDividerLine {
  x1: number;
  y1: number;
  x2: number;
  y2: number;
}

export function wheelPolar(angleDeg: number, radius: number): WheelPoint {
  const radians = ((angleDeg - 90) * Math.PI) / 180;
  return {
    x: WHEEL_CENTER + radius * Math.cos(radians),
    y: WHEEL_CENTER + radius * Math.sin(radians),
  };
}

export function wheelSlicePath(index: number, angle: number): string {
  const half = angle / 2;
  const start = wheelPolar(index * angle - half, WHEEL_SLICE_RADIUS);
  const end = wheelPolar(index * angle + half, WHEEL_SLICE_RADIUS);
  return `M ${WHEEL_CENTER} ${WHEEL_CENTER} L ${start.x} ${start.y} A ${WHEEL_SLICE_RADIUS} ${WHEEL_SLICE_RADIUS} 0 0 1 ${end.x} ${end.y} Z`;
}

export function wheelDividerLine(index: number, angle: number): WheelDividerLine {
  const boundary = index * angle - angle / 2;
  const inner = wheelPolar(boundary, WHEEL_DIVIDER_INNER_RADIUS);
  const outer = wheelPolar(boundary, WHEEL_SLICE_RADIUS);
  return { x1: inner.x, y1: inner.y, x2: outer.x, y2: outer.y };
}
