import { BOARD, tilesOfGroup } from '../logic/board';
import { STATION_RENT, UTILITY_MULTIPLIER } from '../logic/constants';
import type { TileState } from '../logic/types';

export const TILE_SHORT_NAME: Record<number, string> = {
  0: 'Xuất phát',
  1: 'Phố Hiến',
  2: 'Khí vận',
  3: 'Hội An',
  4: 'Thuế',
  5: 'Ga Hà Nội',
  6: 'Sa Pa',
  7: 'Cơ hội',
  8: 'Mộc Châu',
  9: 'Ninh Bình',
  10: 'Nhà tù',
  11: 'Cần Thơ',
  12: 'Điện lực',
  13: 'Phú Quốc',
  14: 'Hạ Long',
  15: 'Sân bay',
  16: 'Hải Phòng',
  17: 'Khí vận',
  18: 'Huế',
  19: 'Nha Trang',
  20: 'Bãi đỗ xe',
  21: 'Đà Lạt',
  22: 'Cơ hội',
  23: 'Đà Nẵng',
  24: 'Quy Nhơn',
  25: 'Cảng biển',
  26: 'Biên Hòa',
  27: 'Thủ Dầu Một',
  28: 'Cấp nước',
  29: 'Vũng Tàu',
  30: 'Vào tù',
  31: 'Đồng Khởi',
  32: 'Nguyễn Huệ',
  33: 'Khí vận',
  34: 'Thủ Thiêm',
  35: 'Bến xe',
  36: 'Cơ hội',
  37: 'Hồ Gươm',
  38: 'Thuế xa xỉ',
  39: 'Hồ Tây',
};

export function shortName(idx: number): string {
  return TILE_SHORT_NAME[idx] ?? BOARD[idx]?.name ?? '';
}

function ownedInGroup(tiles: TileState[], seat: number, group: string): number {
  return tilesOfGroup(group).filter((idx) => tiles[idx]?.owner === seat).length;
}

export function rentLabel(tiles: TileState[], idx: number): string {
  const tile = BOARD[idx];
  const state = tiles[idx];
  if (!state || state.owner < 0) return '';
  switch (tile.kind) {
    case 'street': {
      const rent = tile.rent?.[state.houses] ?? 0;
      const full = state.houses === 0 && tile.group ? ownedInGroup(tiles, state.owner, tile.group) === tilesOfGroup(tile.group).length : false;
      return String(full ? rent * 2 : rent);
    }
    case 'station':
      return String(STATION_RENT[ownedInGroup(tiles, state.owner, 'station')] ?? 0);
    case 'utility':
      return `×${UTILITY_MULTIPLIER[ownedInGroup(tiles, state.owner, 'utility')] ?? 0}`;
    default:
      return '';
  }
}

export function groupProgress(tiles: TileState[], seat: number, idx: number): { owned: number; total: number } | null {
  const group = BOARD[idx]?.group;
  if (!group) return null;
  return { owned: ownedInGroup(tiles, seat, group), total: tilesOfGroup(group).length };
}

export function baseRentText(idx: number): string {
  const tile = BOARD[idx];
  if (tile.kind === 'station') return `${STATION_RENT[1]} tr`;
  if (tile.kind === 'utility') return `${UTILITY_MULTIPLIER[1]}× xúc xắc`;
  return `${tile.rent?.[0] ?? 0} tr`;
}
