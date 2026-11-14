import { BOARD, tilesOfGroup } from './board';
import { FESTIVAL_MULTIPLIER, MAX_HOUSES, STATION_RENT, WIN_GROUPS, type EndReason } from './constants';
import { housesRefund, housesValue, levelCost, SIDE_STREETS, STREET_GROUPS } from './engine';
import type { PlayerState, TileState, ViewState } from './types';

export type RuleHint = { ok: true } | { ok: false; reason: string };

function ownsGroup(view: ViewState, seat: number, group: string): boolean {
  const tiles = tilesOfGroup(group);
  return tiles.length > 0 && tiles.every((idx) => view.tiles[idx].owner === seat);
}

function ownedCount(view: ViewState, seat: number, group: string): number {
  return tilesOfGroup(group).filter((idx) => view.tiles[idx].owner === seat).length;
}

export function canBuild(view: ViewState, seat: number, idx: number): RuleHint {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (tile.kind !== 'street' || !tile.group) return { ok: false, reason: 'Chỉ nâng cấp được ô thành phố' };
  if (state.owner !== seat) return { ok: false, reason: 'Ô này không phải của bạn' };
  if (view.players[seat].pos !== idx) return { ok: false, reason: 'Đứng vào ô này mới nâng cấp được' };
  if (view.bought === idx) return { ok: false, reason: 'Vừa mua, lần sau đáp lại mới nâng cấp được' };
  if (state.houses >= MAX_HOUSES) return { ok: false, reason: 'Đã lên Khách sạn, cấp cao nhất' };
  if (view.players[seat].cash < levelCost(idx, state.houses + 1)) return { ok: false, reason: 'Không đủ tiền nâng cấp' };
  return { ok: true };
}

export function canSell(view: ViewState, seat: number, idx: number): RuleHint {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (tile.kind !== 'street' || !tile.group) return { ok: false, reason: 'Ô này không có nhà' };
  if (state.owner !== seat) return { ok: false, reason: 'Ô này không phải của bạn' };
  if (state.houses <= 0) return { ok: false, reason: 'Ô này đang là đất trống' };
  return { ok: true };
}

export function currentRent(view: ViewState, idx: number): number {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (state.owner < 0) return 0;
  switch (tile.kind) {
    case 'street': {
      const rent = tile.rent?.[state.houses] ?? 0;
      const base = state.houses === 0 && tile.group && ownsGroup(view, state.owner, tile.group) ? rent * 2 : rent;
      return view.festival === idx ? base * FESTIVAL_MULTIPLIER : base;
    }
    case 'station':
      return STATION_RENT[ownedCount(view, state.owner, 'station')] ?? 0;
    default:
      return 0;
  }
}

export function worthOf(view: ViewState, seat: number): number {
  const player = view.players[seat];
  if (!player || player.bankrupt) return 0;
  let total = player.cash;
  view.tiles.forEach((state, idx) => {
    if (state.owner !== seat) return;
    total += (BOARD[idx].price ?? 0) + housesValue(idx, state.houses);
  });
  return total;
}

export function hasAnyFullGroup(view: ViewState, seat: number): boolean {
  return BOARD.some((tile) => tile.kind === 'street' && tile.group && view.tiles[tile.idx].owner === seat && ownsGroup(view, seat, tile.group));
}

export interface BuildPlan {
  tiles: number[];
  cost: number;
}

export function buildPlan(view: ViewState, seat: number, idx: number, target: number): BuildPlan | null {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (tile.kind !== 'street' || state.owner !== seat || view.players[seat]?.pos !== idx || view.bought === idx) return null;
  if (target > MAX_HOUSES || target <= state.houses) return null;
  const steps = target - state.houses;
  return { tiles: Array.from({ length: steps }, () => idx), cost: housesValue(idx, target) - housesValue(idx, state.houses) };
}

export function sellPlan(view: ViewState, seat: number, idx: number, target: number): BuildPlan | null {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  if (tile.kind !== 'street' || state.owner !== seat) return null;
  if (target < 0 || target >= state.houses) return null;
  const steps = state.houses - target;
  return { tiles: Array.from({ length: steps }, () => idx), cost: housesRefund(idx, state.houses) - housesRefund(idx, target) };
}

export type WinKind = 'groups' | 'line' | 'airports';

export interface WinThreat {
  seat: number;
  kind: WinKind;
  tile: number;
}

const STATIONS = tilesOfGroup('station');

function reachable(tiles: TileState[], players: PlayerState[], idx: number): boolean {
  const t = tiles[idx];
  if (t.owner < 0 || players[t.owner]?.bankrupt) return true;
  return BOARD[idx].kind === 'street' && t.houses < MAX_HOUSES;
}

export function winThreats(tiles: TileState[], players: PlayerState[]): WinThreat[] {
  const threats: WinThreat[] = [];
  players.forEach((player, seat) => {
    if (player.bankrupt) return;
    const missing = (members: number[]) => members.filter((idx) => tiles[idx]?.owner !== seat);
    const add = (kind: WinKind, members: number[]) => {
      const left = missing(members);
      if (left.length === 1 && reachable(tiles, players, left[0])) threats.push({ seat, kind, tile: left[0] });
    };
    const full = STREET_GROUPS.filter((g) => missing(tilesOfGroup(g)).length === 0).length;
    if (full === WIN_GROUPS - 1) STREET_GROUPS.forEach((g) => add('groups', tilesOfGroup(g)));
    SIDE_STREETS.forEach((side) => add('line', side));
    add('airports', STATIONS);
  });
  return threats;
}

export function winningTiles(view: ViewState, seat: number, reason: EndReason | null): number[] {
  const owns = (idx: number) => view.tiles[idx].owner === seat;
  if (reason === 'groups') return STREET_GROUPS.filter((g) => tilesOfGroup(g).every(owns)).flatMap((g) => tilesOfGroup(g));
  if (reason === 'line') return SIDE_STREETS.find((side) => side.every(owns)) ?? [];
  if (reason === 'airports') return STATIONS;
  return [];
}
