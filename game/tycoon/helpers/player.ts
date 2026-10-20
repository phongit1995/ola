export { avatarIconUrl } from '../../src/sdk/avatar';

export const SEAT_COLORS = ['#F2B807', '#2F9BD6', '#E4573D', '#8E5BD9'] as const;
export const SEAT_SOFT_COLORS = ['#FBE9A6', '#BFE2F5', '#F8C9BF', '#DCCBF4'] as const;
export const SEAT_LABELS = ['Vàng', 'Xanh', 'Cam', 'Tím'] as const;

export function seatColor(seat: number): string {
  return SEAT_COLORS[seat] ?? SEAT_COLORS[0];
}

export function placeLabel(place: number, playerCount: number): string {
  if (place === 1) return 'Tỷ phú số 1';
  if (place === playerCount) return 'Hạng cuối';
  return `Hạng ${place}`;
}
