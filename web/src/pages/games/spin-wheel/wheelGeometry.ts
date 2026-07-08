import type { CSSProperties } from 'react';

export const VIEWBOX = 100;
export const CENTER = VIEWBOX / 2;
export const SLICE_RADIUS = 48;
export const LABEL_RADIUS = 31;
export const DIVIDER_INNER_RADIUS = 12;

export interface Point {
  x: number;
  y: number;
}

export interface DividerLine {
  x1: number;
  y1: number;
  x2: number;
  y2: number;
}

export function polar(angleDeg: number, radius: number): Point {
  const radians = ((angleDeg - 90) * Math.PI) / 180;
  return {
    x: CENTER + radius * Math.cos(radians),
    y: CENTER + radius * Math.sin(radians),
  };
}

export function slicePath(index: number, angle: number): string {
  const half = angle / 2;
  const start = polar(index * angle - half, SLICE_RADIUS);
  const end = polar(index * angle + half, SLICE_RADIUS);
  return `M ${CENTER} ${CENTER} L ${start.x} ${start.y} A ${SLICE_RADIUS} ${SLICE_RADIUS} 0 0 1 ${end.x} ${end.y} Z`;
}

export function dividerLine(index: number, angle: number): DividerLine {
  const boundary = index * angle - angle / 2;
  const inner = polar(boundary, DIVIDER_INNER_RADIUS);
  const outer = polar(boundary, SLICE_RADIUS);
  return { x1: inner.x, y1: inner.y, x2: outer.x, y2: outer.y };
}

export function labelStyle(index: number, angle: number): CSSProperties {
  const point = polar(index * angle, LABEL_RADIUS);
  return {
    left: `${point.x}%`,
    top: `${point.y}%`,
    transform: 'translate(-50%, -50%)',
  };
}
