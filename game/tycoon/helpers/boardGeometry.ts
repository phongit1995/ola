import { SIDE_TILES } from '../logic/constants';

const CORNER = 13.6;
const EDGE = (100 - 2 * CORNER) / (SIDE_TILES - 1);

export type Side = 'bottom' | 'left' | 'top' | 'right' | 'corner';

export interface TileRect {
  x: number;
  y: number;
  w: number;
  h: number;
  side: Side;
}

// Xuất phát ở góc dưới-trái, đi thuận kim đồng hồ: lên cột trái → hàng trên → xuống cột phải → về hàng dưới.
export function tileRect(idx: number): TileRect {
  const leg = Math.floor(idx / SIDE_TILES);
  const step = idx % SIDE_TILES;
  if (step === 0) {
    return { x: leg <= 1 ? 0 : 100 - CORNER, y: leg === 1 || leg === 2 ? 0 : 100 - CORNER, w: CORNER, h: CORNER, side: 'corner' };
  }
  const along = CORNER + (step - 1) * EDGE;
  switch (leg) {
    case 0:
      return { x: 0, y: 100 - along - EDGE, w: CORNER, h: EDGE, side: 'left' };
    case 1:
      return { x: along, y: 0, w: EDGE, h: CORNER, side: 'top' };
    case 2:
      return { x: 100 - CORNER, y: along, w: CORNER, h: EDGE, side: 'right' };
    default:
      return { x: 100 - along - EDGE, y: 100 - CORNER, w: EDGE, h: CORNER, side: 'bottom' };
  }
}

export function tileCenter(idx: number): { x: number; y: number } {
  const rect = tileRect(idx);
  return { x: rect.x + rect.w / 2, y: rect.y + rect.h / 2 };
}
