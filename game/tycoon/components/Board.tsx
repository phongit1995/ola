import type { CSSProperties, ReactNode } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { BOARD_SIZE, GO_SALARY, JAIL_TILE, MAX_HOUSES, SIDE_TILES } from '../logic/constants';
import { SEAT_SOFT_COLORS, seatColor } from '../helpers/player';
import { levelLabel, rentLabel, shortName } from '../helpers/tiles';
import { useTycoon } from '../store/useTycoon';
import { Skyline } from './Skyline';
import { glyphForTile, TileGlyph } from './TileGlyph';
import { Token } from './Token';

const CORNER = 13.6;
const EDGE = (100 - 2 * CORNER) / (SIDE_TILES - 1);
const TOKEN_SPREAD = 2.6;

export type Side = 'bottom' | 'left' | 'top' | 'right' | 'corner';
export type CornerPos = 'bl' | 'tl' | 'tr' | 'br';

export interface TileRect {
  x: number;
  y: number;
  w: number;
  h: number;
  side: Side;
  corner?: CornerPos;
}

// Xuất phát ở góc dưới-trái, đi thuận kim đồng hồ: lên cột trái → hàng trên → xuống cột phải → về hàng dưới.
export function tileRect(idx: number): TileRect {
  const leg = Math.floor(idx / SIDE_TILES);
  const step = idx % SIDE_TILES;
  if (step === 0) {
    const corner = (['bl', 'tl', 'tr', 'br'] as const)[leg];
    return { x: corner === 'bl' || corner === 'tl' ? 0 : 100 - CORNER, y: corner === 'tl' || corner === 'tr' ? 0 : 100 - CORNER, w: CORNER, h: CORNER, side: 'corner', corner };
  }
  const along = CORNER + (step - 1) * EDGE;
  switch (leg) {
    case 0:
      return { x: 0, y: 100 - along - EDGE, w: CORNER, h: EDGE, side: 'left' };
    case 1:
      return { x: along, y: 0, w: EDGE, h: CORNER, side: 'top' };
    case 2:
      return { x: 100 - CORNER, y: along, w: CORNER, h: EDGE, side: 'right' };
    default:
      return { x: 100 - along - EDGE, y: 100 - CORNER, w: EDGE, h: CORNER, side: 'bottom' };
  }
}

const CORNER_TOKEN_INSET = 6;

function cornerAnchor(r: TileRect): { x: number; y: number; flip?: boolean } {
  switch (r.corner) {
    case 'bl':
      return { x: r.x + r.w + CORNER_TOKEN_INSET, y: r.y - 0.6 };
    case 'br':
      return { x: r.x - CORNER_TOKEN_INSET, y: r.y - 0.6 };
    case 'tr':
      return { x: r.x - CORNER_TOKEN_INSET, y: r.y + r.h + 0.6, flip: true };
    default:
      return { x: r.x + r.w + CORNER_TOKEN_INSET, y: r.y + r.h + 0.6, flip: true };
  }
}

function tokenAnchor(idx: number, inJail: boolean): { x: number; y: number; flip?: boolean } {
  const r = tileRect(idx);
  if (idx === JAIL_TILE && inJail) return { x: r.x + r.w * 0.66, y: r.y + r.h * 0.84 };
  switch (r.side) {
    case 'bottom':
      return { x: r.x + r.w / 2, y: r.y + 1 };
    case 'top':
      return { x: r.x + r.w / 2, y: r.y + r.h - 0.8, flip: true };
    case 'left':
      return { x: r.x + r.w + 1.6, y: r.y + r.h * 0.8 };
    case 'right':
      return { x: r.x - 1.6, y: r.y + r.h * 0.8 };
    default:
      return cornerAnchor(r);
  }
}

function TileHouses({ houses }: { houses: number }) {
  if (houses <= 0) return null;
  if (houses >= MAX_HOUSES) return <i className="ty-hotel" />;
  return (
    <>
      {Array.from({ length: houses }, (_, i) => (
        <i key={i} className="ty-house" />
      ))}
    </>
  );
}

function CornerContent({ idx }: { idx: number }) {
  switch (BOARD[idx].kind) {
    case 'go':
      return (
        <span className="ty-corner ty-corner-go">
          <span className="ty-corner-title">
            XUẤT
            <br />
            PHÁT
          </span>
          <span className="ty-corner-pill">+{GO_SALARY}</span>
          <TileGlyph name="arrow" size={20} />
        </span>
      );
    case 'jail':
      return (
        <>
          <span className="ty-jail-cell">
            <TileGlyph name="jail" size={18} color="var(--ty-cream)" />
            <span>NHÀ TÙ</span>
          </span>
          <span className="ty-jail-visit">Thăm tù</span>
        </>
      );
    case 'parking':
      return (
        <span className="ty-corner ty-corner-parking">
          <TileGlyph name="parking" size={22} />
          <span className="ty-corner-title">
            BÃI
            <br />
            ĐỖ XE
          </span>
        </span>
      );
    default:
      return (
        <span className="ty-corner ty-corner-gotojail">
          <TileGlyph name="gotojail" size={22} />
          <span className="ty-corner-title">
            VÀO
            <br />
            TÙ
          </span>
        </span>
      );
  }
}

function BoardCenter() {
  return (
    <div className="ty-center" aria-hidden="true">
      <Skyline className="ty-center-skyline" />
      <span className="ty-deck ty-deck-chance">
        <TileGlyph name="chance" size={26} color="var(--ty-navy)" />
        <b>CƠ HỘI</b>
      </span>
      <span className="ty-deck ty-deck-chest">
        <TileGlyph name="chest" size={26} color="var(--ty-navy)" />
        <b>KHÍ VẬN</b>
      </span>
      <span className="ty-center-logo">
        <b>CỜ TỶ PHÚ</b>
        <small>Phố Thị Rực Rỡ</small>
      </span>
    </div>
  );
}

export function Board({ onTileTap, children }: { onTileTap: (idx: number) => void; children?: ReactNode }) {
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
      <BoardCenter />
      {BOARD.map((tile) => {
        const rect = tileRect(tile.idx);
        const state = tiles[tile.idx];
        const owner = state?.owner ?? -1;
        const houses = state?.houses ?? 0;
        const corner = rect.side === 'corner';
        const glyph = corner ? null : glyphForTile(tile.idx, tile.kind);
        const owned = owner >= 0;
        const priceText = owned ? rentLabel(tiles, tile.idx) : tile.price ? String(tile.price) : tile.tax ? `−${tile.tax}` : '';
        const label = `${tile.name}${owned ? `, của ${owner === you ? 'bạn' : players[owner]?.name ?? ''}` : tile.price ? `, giá ${tile.price} tr` : ''}${houses > 0 ? `, ${levelLabel(houses)}` : ''}`;
        const style = {
          left: `${rect.x}%`,
          top: `${rect.y}%`,
          width: `${rect.w}%`,
          height: `${rect.h}%`,
          ...(owned ? { '--owner': seatColor(owner), '--owner-soft': SEAT_SOFT_COLORS[owner] ?? SEAT_SOFT_COLORS[0] } : {}),
        } as CSSProperties;
        return (
          <button
            key={tile.idx}
            type="button"
            className={[
              'ty-tile',
              `ty-tile-${rect.side}`,
              `ty-tile-kind-${tile.kind}`,
              rect.corner ? `ty-tile-corner-${rect.corner}` : '',
              glyph ? 'ty-tile-special' : '',
              owned ? 'ty-tile-owned' : '',
              landingTile === tile.idx ? 'ty-tile-landing' : '',
              pathTiles.includes(tile.idx) ? 'ty-tile-path' : '',
            ].join(' ')}
            style={style}
            data-group={tile.group ?? undefined}
            onClick={() => onTileTap(tile.idx)}
            aria-label={label}
          >
            {tile.kind === 'street' && tile.group ? (
              <span className={`ty-tile-band ty-band-${tile.group}`}>
                <TileHouses houses={houses} />
              </span>
            ) : null}
            {corner ? (
              <CornerContent idx={tile.idx} />
            ) : (
              <span className="ty-tile-body">
                {glyph ? <TileGlyph name={glyph} size={16} /> : null}
                <span className="ty-tile-text">
                  <span className="ty-tile-name">{shortName(tile.idx)}</span>
                  {priceText ? <span className={owned ? 'ty-tile-rent' : tile.kind === 'tax' ? 'ty-tile-price ty-tile-price-tax' : 'ty-tile-price'}>{priceText}</span> : null}
                </span>
              </span>
            )}
          </button>
        );
      })}

      {positions.map((pos, seat) => {
        const player = view?.players[seat];
        if (!player || player.bankrupt) return null;
        const idx = ((pos % BOARD_SIZE) + BOARD_SIZE) % BOARD_SIZE;
        const inJail = player.inJail && idx === JAIL_TILE;
        const anchor = tokenAnchor(idx, inJail);
        const mates = positions
          .map((p, s) => ({ p, s }))
          .filter(({ p, s }) => p === pos && !view?.players[s]?.bankrupt && (idx !== JAIL_TILE || Boolean(view?.players[s]?.inJail) === player.inJail))
          .map(({ s }) => s);
        const order = mates.indexOf(seat);
        const offset = mates.length > 1 ? (order - (mates.length - 1) / 2) * TOKEN_SPREAD : 0;
        return (
          <Token
            key={seat}
            seat={seat}
            x={anchor.x + offset}
            y={anchor.y}
            active={turnSeat === seat && !replaying}
            inJail={inJail}
            mine={seat === you}
            flip={anchor.flip}
            avatar={players[seat]?.avatar}
          />
        );
      })}
      {children}
    </div>
  );
}
