import { BOARD, tilesOfGroup } from './board';
import { MAX_HOUSES, STATION_RENT, UTILITY_MULTIPLIER } from './constants';
import type { GameState } from './types';

export type RuleHint = { ok: true } | { ok: false; reason: string };

function ownsGroup(view: GameState, seat: number, group: string): boolean {
  const tiles = tilesOfGroup(group);
  return tiles.length > 0 && tiles.every((idx) => view.tiles[idx].owner === seat);
}

function ownedCount(view: GameState, seat: number, group: string): number {
  return tilesOfGroup(group).filter((idx) => view.tiles[idx].owner === seat).length;
}

export function canBuild(view: GameState, seat: number, idx: number): RuleHint {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (tile.kind !== 'street' || !tile.group) return { ok: false, reason: 'Chỉ xây được trên ô đất' };
  if (state.owner !== seat) return { ok: false, reason: 'Ô này không phải của bạn' };
  if (!ownsGroup(view, seat, tile.group)) {
    const missing = tilesOfGroup(tile.group)
      .filter((g) => view.tiles[g].owner !== seat)
      .map((g) => BOARD[g].name);
    return { ok: false, reason: `Cần sở hữu trọn nhóm — thiếu ${missing.join(', ')}` };
  }
  if (state.houses >= MAX_HOUSES) return { ok: false, reason: 'Đã có khách sạn' };
  if (view.players[seat].cash < (tile.houseCost ?? 0)) return { ok: false, reason: 'Không đủ tiền xây' };
  for (const g of tilesOfGroup(tile.group)) {
    if (state.houses > view.tiles[g].houses) {
      return { ok: false, reason: `Xây đều: ${BOARD[g].name} mới có ${view.tiles[g].houses} nhà` };
    }
  }
  return { ok: true };
}

export function canSell(view: GameState, seat: number, idx: number): RuleHint {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (tile.kind !== 'street' || !tile.group) return { ok: false, reason: 'Ô này không có nhà' };
  if (state.owner !== seat) return { ok: false, reason: 'Ô này không phải của bạn' };
  if (state.houses <= 0) return { ok: false, reason: 'Chưa có nhà để bán' };
  for (const g of tilesOfGroup(tile.group)) {
    if (state.houses < view.tiles[g].houses) {
      return { ok: false, reason: `Bán đều: ${BOARD[g].name} đang có ${view.tiles[g].houses} nhà` };
    }
  }
  return { ok: true };
}

export function currentRent(view: GameState, idx: number, diceSum: number): number {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (state.owner < 0) return 0;
  switch (tile.kind) {
    case 'street': {
      const rent = tile.rent?.[state.houses] ?? 0;
      return state.houses === 0 && tile.group && ownsGroup(view, state.owner, tile.group) ? rent * 2 : rent;
    }
    case 'station':
      return STATION_RENT[ownedCount(view, state.owner, 'station')] ?? 0;
    case 'utility':
      return diceSum * (UTILITY_MULTIPLIER[ownedCount(view, state.owner, 'utility')] ?? 0);
    default:
      return 0;
  }
}

export function worthOf(view: GameState, seat: number): number {
  const player = view.players[seat];
  if (!player || player.bankrupt) return 0;
  let total = player.cash;
  view.tiles.forEach((state, idx) => {
    if (state.owner !== seat) return;
    total += (BOARD[idx].price ?? 0) + state.houses * (BOARD[idx].houseCost ?? 0);
  });
  return total;
}

export function hasAnyFullGroup(view: GameState, seat: number): boolean {
  return BOARD.some((tile) => tile.kind === 'street' && tile.group && view.tiles[tile.idx].owner === seat && ownsGroup(view, seat, tile.group));
}
