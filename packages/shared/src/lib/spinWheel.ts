import type {
  SegmentTheme,
  WheelDividerLine,
  WheelPoint,
} from '../types/client/spinWheel.type';
import {
  SEGMENT_PALETTE,
  SPIN_TURNS,
  WHEEL_CENTER,
  WHEEL_DIVIDER_INNER_RADIUS,
  WHEEL_SLICE_RADIUS,
} from './spinWheel.constants';

export * from './spinWheel.constants';
export type {
  SegmentTheme,
  WheelDividerLine,
  WheelPoint,
} from '../types/client/spinWheel.type';

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
