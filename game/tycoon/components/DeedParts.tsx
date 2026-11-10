import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { FESTIVAL_MULTIPLIER, LEVEL_NAMES, MAX_HOUSES, STATION_RENT } from '../logic/constants';
import type { GameState } from '../logic/types';
import { seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';
import { TileMark, type TileMarkName } from './TileMark';
import { TILE_ART } from './tileArt';

const MARK_BY_KIND: Partial<Record<string, TileMarkName>> = { chance: 'chance', chest: 'chest', tax: 'tax', go: 'go' };

export function groupColor(idx: number): string {
  const tile = BOARD[idx];
  return tile.kind === 'street' && tile.group ? `var(--ty-g-${tile.group})` : tile.kind === 'station' ? '#9AA6BC' : 'var(--ty-navy)';
}

export function HouseIcon() {
  return (
    <svg viewBox="0 0 12 12" aria-hidden="true">
      <path d="M1 6.2 6 1.6l5 4.6H9.8V11H2.2V6.2Z" fill="#2FA86F" stroke="#1F2A44" strokeWidth="1.1" strokeLinejoin="round" />
    </svg>
  );
}

export function HotelIcon({ className }: { className?: string }) {
  return (
    <svg className={className} viewBox="0 0 20 12" aria-hidden="true">
      <path d="M1 11V3.6L6 1l4 2.2L14 1l5 2.6V11Z" fill="#E4573D" stroke="#1F2A44" strokeWidth="1.1" strokeLinejoin="round" />
      <path d="M5 6h2M9 6h2M13 6h2" stroke="#FFF3C4" strokeWidth="1.4" />
    </svg>
  );
}

export function TileThumb({ idx, className = '' }: { idx: number; className?: string }) {
  const art = TILE_ART[idx];
  const mark = MARK_BY_KIND[BOARD[idx].kind];
  return (
    <span className={`ty-thumb ${art ? '' : 'ty-thumb-mark'} ${BOARD[idx].kind === 'travel' ? 'ty-thumb-contain' : ''} ${className}`} style={art ? { backgroundImage: `url(${art})` } : undefined} aria-hidden="true">
      {!art && mark ? <TileMark name={mark} /> : null}
    </span>
  );
}

export function GroupTag({ idx }: { idx: number }) {
  const tile = BOARD[idx];
  const label = tile.group ? GROUP_LABEL[tile.group] : 'Ô đặc biệt';
  return (
    <span className="ty-group-tag">
      <i style={{ background: groupColor(idx) }} />
      {label}
    </span>
  );
}

export function SeatTag({ seat }: { seat: number }) {
  const { players, you } = useTycoon(useShallow((s) => ({ players: s.players, you: s.you })));
  if (seat < 0) return <span className="ty-seat-tag ty-seat-tag-bank">Ngân hàng</span>;
  return (
    <span className="ty-seat-tag" style={{ '--seat': seatColor(seat) } as CSSProperties}>
      <img src={players[seat]?.avatar} alt="" draggable={false} />
      {seat === you ? 'Bạn' : players[seat]?.name ?? '?'}
    </span>
  );
}

export function LevelPips({ houses }: { houses: number }) {
  return (
    <span className="ty-pips" role="img" aria-label={LEVEL_NAMES[houses] ?? ''}>
      {Array.from({ length: MAX_HOUSES }, (_, i) => (
        <i key={i} className={`${i < houses ? 'ty-pip-on' : ''} ${i === MAX_HOUSES - 1 ? 'ty-pip-hotel' : ''}`}>
          {i < houses ? i === MAX_HOUSES - 1 ? <HotelIcon /> : <HouseIcon /> : null}
        </i>
      ))}
    </span>
  );
}

export function ownsWholeGroup(view: GameState, seat: number, group: string | undefined): boolean {
  if (!group || seat < 0) return false;
  return tilesOfGroup(group).every((idx) => view.tiles[idx].owner === seat);
}

export interface RentStep {
  label: string;
  rent: number;
  active: boolean;
  houses: number;
  note?: string;
}

export function rentLadder(view: GameState, idx: number): RentStep[] {
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  const owner = state.owner;
  const festival = view.festival === idx ? FESTIVAL_MULTIPLIER : 1;
  if (tile.kind === 'station') {
    const count = owner >= 0 ? tilesOfGroup('station').filter((g) => view.tiles[g].owner === owner).length : 0;
    return [1, 2, 3, 4].map((n) => ({ label: `${n} sân bay`, rent: STATION_RENT[n] * festival, active: n === count, houses: 0 }));
  }
  const fullGroup = ownsWholeGroup(view, owner, tile.group);
  return (tile.rent ?? []).map((rent, houses) => ({
    label: houses === 0 ? 'Đất trống' : LEVEL_NAMES[houses] ?? '',
    rent: (houses === 0 && fullGroup ? rent * 2 : rent) * festival,
    active: owner >= 0 && state.houses === houses,
    houses,
    note: houses === 0 ? (fullGroup ? 'đã ×2 trọn nhóm' : '×2 khi trọn nhóm') : undefined,
  }));
}

export function landValue(view: GameState, seat: number): { land: number; houses: number } {
  return BOARD.reduce(
    (sum, tile) => {
      const state = view.tiles[tile.idx];
      if (state.owner !== seat) return sum;
      return { land: sum.land + (tile.price ?? 0), houses: sum.houses + state.houses * (tile.houseCost ?? 0) };
    },
    { land: 0, houses: 0 },
  );
}
