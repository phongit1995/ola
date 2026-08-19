export type SeatSlot = 'bottom' | 'left' | 'top' | 'right';

// Vị trí tương đối quanh bàn: mình luôn ngồi dưới, các ghế khác xếp theo chiều
// kim đồng hồ tính từ mình.
export function seatSlots(playerCount: number, myIdx: number): Map<number, SeatSlot> {
  const slots = new Map<number, SeatSlot>();
  const order: SeatSlot[][] = [
    [],
    ['bottom'],
    ['bottom', 'top'],
    ['bottom', 'left', 'right'],
    ['bottom', 'left', 'top', 'right'],
  ];
  const layout = order[Math.min(playerCount, 4)] ?? order[4];
  for (let i = 0; i < playerCount; i += 1) {
    const rel = (i - myIdx + playerCount) % playerCount;
    slots.set(i, layout[rel] ?? 'top');
  }
  return slots;
}

export function placeLabel(place: number, playerCount: number): string {
  if (place === 1) return 'Nhất';
  if (place === playerCount) return 'Bét';
  if (place === 2) return 'Nhì';
  if (place === 3) return 'Ba';
  return `Hạng ${place}`;
}
