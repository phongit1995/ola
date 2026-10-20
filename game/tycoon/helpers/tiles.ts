import { BOARD, tilesOfGroup } from '../logic/board';
import { FESTIVAL_MULTIPLIER, LEVEL_NAMES, STATION_RENT } from '../logic/constants';
import type { TileState } from '../logic/types';

export const TILE_SHORT_NAME: Record<number, string> = {
  4: 'Nội Bài',
  10: 'Thuế',
  12: 'Tân Sơn Nhất',
  20: 'Cam Ranh',
  28: 'Long Thành',
  31: 'TP. HCM',
};

export function shortName(idx: number): string {
  return TILE_SHORT_NAME[idx] ?? BOARD[idx]?.name ?? '';
}

export function levelLabel(level: number): string {
  return level <= 0 ? LEVEL_NAMES[0] : `Cấp ${level} · ${LEVEL_NAMES[level] ?? ''}`;
}

function ownedInGroup(tiles: TileState[], seat: number, group: string): number {
  return tilesOfGroup(group).filter((idx) => tiles[idx]?.owner === seat).length;
}

export function rentLabel(tiles: TileState[], idx: number, festival = -1): string {
  const tile = BOARD[idx];
  const state = tiles[idx];
  if (!state || state.owner < 0) return '';
  switch (tile.kind) {
    case 'street': {
      const rent = tile.rent?.[state.houses] ?? 0;
      const full = state.houses === 0 && tile.group ? ownedInGroup(tiles, state.owner, tile.group) === tilesOfGroup(tile.group).length : false;
      const base = full ? rent * 2 : rent;
      return String(festival === idx ? base * FESTIVAL_MULTIPLIER : base);
    }
    case 'station':
      return String(STATION_RENT[ownedInGroup(tiles, state.owner, 'station')] ?? 0);
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
  return `${tile.rent?.[0] ?? 0} tr`;
}
