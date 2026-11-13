import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { FESTIVAL_MULTIPLIER, LEVEL_NAMES, STATION_RENT } from '../logic/constants';
import type { ViewState } from '../logic/types';
import { seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';
import { TileMark, type TileMarkName } from './TileMark';
import { TILE_ART } from './tileArt';
import { houseArt, PIXEL_ART } from './art';

const MARK_BY_KIND: Partial<Record<string, TileMarkName>> = { chance: 'chance', chest: 'chest', tax: 'tax', go: 'go' };

export function groupColor(idx: number): string {
  const tile = BOARD[idx];
  return tile.kind === 'street' && tile.group ? `var(--ty-g-${tile.group})` : tile.kind === 'station' ? '#9AA6BC' : 'var(--ty-navy)';
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

export function ownsWholeGroup(view: ViewState, seat: number, group: string | undefined): boolean {
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

export function rentLadder(view: ViewState, idx: number): RentStep[] {
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

export function landValue(view: ViewState, seat: number): { land: number; houses: number } {
  return BOARD.reduce(
    (sum, tile) => {
      const state = view.tiles[tile.idx];
      if (state.owner !== seat) return sum;
      return { land: sum.land + (tile.price ?? 0), houses: sum.houses + state.houses * (tile.houseCost ?? 0) };
    },
    { land: 0, houses: 0 },
  );
}

const STEP_SHORT = ['Đất', 'Nhà', 'Biệt thự', 'K.sạn'];

export interface LadderPick {
  target: number;
  can: (houses: number) => boolean;
  onPick: (houses: number) => void;
  selling?: boolean;
}

export function RentLadder({ view, idx, pick }: { view: ViewState; idx: number; pick?: LadderPick }) {
  const street = BOARD[idx].kind === 'street';
  const ladder = rentLadder(view, idx);
  const maxRent = Math.max(1, ...ladder.map((step) => step.rent));
  return (
    <ol className={`ty-ladder ${street ? '' : 'ty-ladder-station'} ${pick ? 'ty-ladder-picking' : ''}`} aria-label="Tiền thuê theo cấp">
      {ladder.map((step, i) => {
        const art = street ? houseArt(step.houses) : null;
        const label = street ? STEP_SHORT[step.houses] : `${i + 1} sân bay`;
        const can = pick?.can(step.houses) ?? false;
        const picked = can && pick?.target === step.houses;
        const body = (
          <>
            <span className="ty-ladder-icon">{art ? <img src={art} alt="" draggable={false} /> : street ? <img className="ty-ladder-flag ui-sprite" src={PIXEL_ART.flag} alt="" draggable={false} /> : <b>{i + 1}</b>}</span>
            <span className="ty-ladder-bar">
              <strong>{step.rent}</strong>
            </span>
            <span className="ty-ladder-label">
              {label}
              {street ? <small>Lv{step.houses}</small> : null}
            </span>
          </>
        );
        return (
          <li
            key={step.label}
            className={[step.active ? 'ty-ladder-on' : '', can ? 'ty-ladder-can' : '', picked ? 'ty-ladder-picked' : '', picked && pick?.selling ? 'ty-ladder-picked-sell' : ''].join(' ')}
            style={{ '--h': `${Math.round(30 + (step.rent / maxRent) * 70)}%` } as CSSProperties}
          >
            {can ? (
              <button type="button" aria-pressed={picked} aria-label={`Chọn Lv${step.houses} ${label}, thuê ${step.rent} tr`} onClick={() => pick?.onPick(step.houses)}>
                {body}
              </button>
            ) : (
              body
            )}
          </li>
        );
      })}
    </ol>
  );
}
