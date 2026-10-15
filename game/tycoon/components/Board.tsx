import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { BOARD_SIZE, MAX_HOUSES } from '../logic/constants';
import { seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';
import { glyphForTile, TileGlyph } from './TileGlyph';
import { Token } from './Token';

const CORNER = 12.6;
const EDGE = (100 - 2 * CORNER) / 9;

export type Side = 'bottom' | 'left' | 'top' | 'right' | 'corner';

export interface TileRect {
  x: number;
  y: number;
  w: number;
  h: number;
  side: Side;
}

export function tileRect(idx: number): TileRect {
  if (idx === 0) return { x: 100 - CORNER, y: 100 - CORNER, w: CORNER, h: CORNER, side: 'corner' };
  if (idx < 10) return { x: 100 - CORNER - idx * EDGE, y: 100 - CORNER, w: EDGE, h: CORNER, side: 'bottom' };
  if (idx === 10) return { x: 0, y: 100 - CORNER, w: CORNER, h: CORNER, side: 'corner' };
  if (idx < 20) return { x: 0, y: 100 - CORNER - (idx - 10) * EDGE, w: CORNER, h: EDGE, side: 'left' };
  if (idx === 20) return { x: 0, y: 0, w: CORNER, h: CORNER, side: 'corner' };
  if (idx < 30) return { x: CORNER + (idx - 21) * EDGE, y: 0, w: EDGE, h: CORNER, side: 'top' };
  if (idx === 30) return { x: 100 - CORNER, y: 0, w: CORNER, h: CORNER, side: 'corner' };
  return { x: 100 - CORNER, y: CORNER + (idx - 31) * EDGE, w: CORNER, h: EDGE, side: 'right' };
}

export function tileCenter(idx: number): { x: number; y: number } {
  const r = tileRect(idx);
  return { x: r.x + r.w / 2, y: r.y + r.h / 2 };
}

const TOKEN_OFFSETS: Array<[number, number]> = [
  [-1.4, -1.4],
  [1.4, -1.4],
  [-1.4, 1.4],
  [1.4, 1.4],
];

export function Board({ onTileTap, children }: { onTileTap: (idx: number) => void; children?: React.ReactNode }) {
  const { tiles, positions, players, view, landingTile, pathTiles, you, replaying } = useTycoon(
    useShallow((s) => ({
      tiles: s.tiles,
      positions: s.positions,
      players: s.players,
      view: s.view,
      landingTile: s.landingTile,
      pathTiles: s.pathTiles,
      you: s.you,
      replaying: s.replaying,
    })),
  );
  const turnSeat = view?.turn ?? -1;

  return (
    <div className="ty-board" role="group" aria-label="Bàn cờ tỷ phú">
      {BOARD.map((tile) => {
        const rect = tileRect(tile.idx);
        const state = tiles[tile.idx];
        const owner = state?.owner ?? -1;
        const houses = state?.houses ?? 0;
        const glyph = glyphForTile(tile.idx, tile.kind);
        const landing = landingTile === tile.idx;
        const onPath = pathTiles.includes(tile.idx);
        const label = `${tile.name}${tile.group ? `, ${tile.group}` : ''}${owner >= 0 ? `, của ${owner === you ? 'bạn' : players[owner]?.name ?? ''}` : ''}${houses > 0 ? `, ${houses >= MAX_HOUSES ? 'khách sạn' : `${houses} nhà`}` : ''}`;
        const style: CSSProperties = { left: `${rect.x}%`, top: `${rect.y}%`, width: `${rect.w}%`, height: `${rect.h}%` };
        return (
          <button
            key={tile.idx}
            type="button"
            className={['ty-tile', `ty-tile-${rect.side}`, `ty-tile-kind-${tile.kind}`, landing ? 'ty-tile-landing' : '', onPath ? 'ty-tile-path' : ''].join(' ')}
            style={style}
            data-group={tile.group ?? undefined}
            onClick={() => onTileTap(tile.idx)}
            aria-label={label}
          >
            {tile.kind === 'street' && tile.group ? <span className={`ty-tile-band ty-band-${tile.group}`} /> : null}
            {glyph ? (
              <span className="ty-tile-glyph-wrap">
                <TileGlyph name={glyph} size={rect.side === 'corner' ? 24 : 16} />
              </span>
            ) : null}
            {houses > 0 ? (
              <span className="ty-tile-houses" aria-hidden="true">
                {houses >= MAX_HOUSES ? <i className="ty-hotel" /> : Array.from({ length: houses }, (_, i) => <i key={i} className="ty-house" />)}
              </span>
            ) : null}
            {owner >= 0 ? <span className="ty-owner-dot" style={{ background: seatColor(owner) }} aria-hidden="true" /> : null}
          </button>
        );
      })}

      {positions.map((pos, seat) => {
        const player = view?.players[seat];
        if (!player || player.bankrupt) return null;
        const center = tileCenter(((pos % BOARD_SIZE) + BOARD_SIZE) % BOARD_SIZE);
        const stacked = positions.filter((p, s) => p === pos && s !== seat && !view?.players[s]?.bankrupt).length > 0;
        const [ox, oy] = stacked ? TOKEN_OFFSETS[seat] ?? [0, 0] : [0, 0];
        return (
          <Token
            key={seat}
            seat={seat}
            x={center.x + ox}
            y={center.y + oy}
            active={turnSeat === seat && !replaying}
            inJail={player.inJail}
            mine={seat === you}
          />
        );
      })}
      {children}
    </div>
  );
}
