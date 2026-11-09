import { tileCenter } from './boardGeometry';

export interface PawnSpot {
  x: number;
  y: number;
  z: number;
}

const GAP_PAIR = 2.6;
const GAP_CROWD = 2;
const DRIFT_Y = 0.7;

// Quân đứng giữa ô và đè lên nhau; người đang tới lượt nằm trên cùng.
export function pawnLayout(positions: number[], bankrupt: boolean[], turn: number): (PawnSpot | undefined)[] {
  const byTile = new Map<number, number[]>();
  positions.forEach((pos, seat) => {
    if (bankrupt[seat]) return;
    byTile.set(pos, [...(byTile.get(pos) ?? []), seat]);
  });
  const spots: (PawnSpot | undefined)[] = positions.map(() => undefined);
  byTile.forEach((seats, tile) => {
    seats.sort((a, b) => Number(a === turn) - Number(b === turn) || a - b);
    const center = tileCenter(tile);
    const gap = seats.length === 2 ? GAP_PAIR : GAP_CROWD;
    seats.forEach((seat, order) => {
      const offset = order - (seats.length - 1) / 2;
      spots[seat] = {
        x: center.x + offset * gap,
        y: center.y + offset * DRIFT_Y,
        z: 10 + Math.round(center.y / 5) + order + (seat === turn ? 25 : 0),
      };
    });
  });
  return spots;
}
