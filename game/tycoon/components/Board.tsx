import type { CSSProperties, ReactNode } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { BOARD_SIZE, FESTIVAL_MULTIPLIER, GO_SALARY, MAX_HOUSES, TAX_RATE } from '../logic/constants';
import { tileRect, type Side } from '../helpers/boardGeometry';
import { pawnLayout } from '../helpers/pawnLayout';
import { seatColor, SEAT_TINTS } from '../helpers/player';
import { levelLabel, rentLabel, shortName } from '../helpers/tiles';
import { useTycoon } from '../store/useTycoon';
import { TileMark, type TileMarkName } from './TileMark';
import { Token } from './Token';
import { TILE_ART } from './tileArt';

const SIDE_CLASS: Record<Side, string> = { left: 'l', top: 't', right: 'r', bottom: 'b', corner: 'c' };
const MARK_BY_KIND: Partial<Record<string, TileMarkName>> = { chance: 'chance', chest: 'chest', tax: 'tax', go: 'go' };

function caption(idx: number): string {
  const tile = BOARD[idx];
  switch (tile.kind) {
    case 'go':
      return `+${GO_SALARY} tr`;
    case 'jail':
      return 'Thăm tù';
    case 'festival':
      return `Thuê x${FESTIVAL_MULTIPLIER}`;
    case 'travel':
      return 'Bay lượt sau';
    case 'tax':
      return `−${TAX_RATE * 100}%`;
    default:
      return tile.price ? `${tile.price} tr` : '';
  }
}

function Houses({ houses }: { houses: number }) {
  if (houses >= MAX_HOUSES) {
    return (
      <svg className="ty-s6-hotel" viewBox="0 0 20 12" aria-hidden="true">
        <path d="M1 11V3.6L6 1l4 2.2L14 1l5 2.6V11Z" fill="#E4573D" stroke="#1F2A44" strokeWidth="1.1" strokeLinejoin="round" />
        <path d="M5 6h2M9 6h2M13 6h2" stroke="#FFF3C4" strokeWidth="1.4" />
      </svg>
    );
  }
  return (
    <>
      {Array.from({ length: houses }, (_, i) => (
        <svg key={i} viewBox="0 0 12 12" aria-hidden="true">
          <path d="M1 6.2 6 1.6l5 4.6H9.8V11H2.2V6.2Z" fill="#2FA86F" stroke="#1F2A44" strokeWidth="1.1" strokeLinejoin="round" />
        </svg>
      ))}
    </>
  );
}

export function Board({ onTileTap, children }: { onTileTap: (idx: number) => void; children?: ReactNode }) {
  const { tiles, positions, players, view, you, myTurn, replaying, movePending, barsOn } = useTycoon(
    useShallow((s) => ({
      tiles: s.tiles,
      positions: s.positions,
      players: s.players,
      view: s.view,
      you: s.you,
      myTurn: s.myTurn,
      replaying: s.replaying,
      movePending: s.movePending,
      barsOn: s.barsOn,
    })),
  );
  const turn = view?.turn ?? -1;
  const festival = view?.festival ?? -1;
  const idle = !replaying && !movePending;
  const choosingFestival = idle && myTurn && view?.phase === 'festival';
  const choosingTravel = idle && myTurn && view?.phase === 'travel';
  const bankrupt = positions.map((_, seat) => Boolean(view?.players[seat]?.bankrupt));
  const spots = pawnLayout(positions.map((pos) => ((pos % BOARD_SIZE) + BOARD_SIZE) % BOARD_SIZE), bankrupt, turn);

  return (
    <div className="ty-s6-board" id="ty-s6-board" role="group" aria-label="Bàn cờ tỷ phú">
      <div className="ty-s6-grid" id="ty-s6-grid">
        {BOARD.map((tile) => {
          const rect = tileRect(tile.idx);
          const state = tiles[tile.idx];
          const owner = state?.owner ?? -1;
          const houses = state?.houses ?? 0;
          const owned = owner >= 0 && (tile.kind === 'street' || tile.kind === 'station');
          const corner = rect.side === 'corner';
          const art = TILE_ART[tile.idx];
          const mark = MARK_BY_KIND[tile.kind];
          const text = owned ? `${rentLabel(tiles, tile.idx, festival)} tr` : caption(tile.idx);
          const dim = (choosingFestival && !(tile.kind === 'street' && owner === you)) || (choosingTravel && tile.idx === view?.players[you]?.pos);
          const label = `${tile.name}${owned ? `, của ${owner === you ? 'bạn' : players[owner]?.name ?? ''}` : tile.price ? `, giá ${tile.price} tr` : ''}${houses > 0 ? `, ${levelLabel(houses)}` : ''}${festival === tile.idx ? `, đang có Lễ hội, thuê ×${FESTIVAL_MULTIPLIER}` : ''}`;
          const style = {
            left: `calc(${rect.x}% + var(--u) * .15)`,
            top: `calc(${rect.y}% + var(--u) * .15)`,
            width: `calc(${rect.w}% - var(--u) * .3)`,
            height: `calc(${rect.h}% - var(--u) * .3)`,
            ...(owned ? { '--own': SEAT_TINTS[owner], '--owner': seatColor(owner) } : {}),
          } as CSSProperties;
          return (
            <button
              key={tile.idx}
              type="button"
              className={['ty-s6-tile', `ty-s6-side-${SIDE_CLASS[rect.side]}`, `ty-s6-kind-${tile.kind}`, owned ? 'ty-s6-owned' : '', dim ? 'ty-s6-dim' : ''].join(' ')}
              style={style}
              data-tile={tile.idx}
              onClick={() => onTileTap(tile.idx)}
              aria-label={label}
            >
              {tile.kind === 'street' && tile.group ? <i className="ty-s6-band" style={{ background: `var(--ty-g-${tile.group})` }} /> : null}
              <span className="ty-s6-tile-body">
                <b className="ty-s6-tile-name">{corner ? tile.name.toUpperCase() : shortName(tile.idx)}</b>
                {art ? <span className={`ty-s6-art ${tile.kind === 'travel' ? 'ty-s6-art-contain' : ''}`} data-fig style={{ backgroundImage: `url(${art})` }} /> : null}
                {!art && mark ? (
                  <span className="ty-s6-glyph" data-fig>
                    <TileMark name={mark} />
                  </span>
                ) : null}
                {text ? <span className="ty-s6-price">{text}</span> : null}
              </span>
              <span className="ty-s6-houses" data-houses>
                <Houses houses={houses} />
              </span>
              <i className="ty-s6-odot" data-owner-dot style={owned ? { background: seatColor(owner) } : undefined} />
              {festival === tile.idx ? <span className="ty-s6-fest">★</span> : null}
              <span className="ty-s6-trail" data-trail />
              {tile.kind === 'jail' ? (
                <span className={`ty-s6-bars ${barsOn ? 'ty-s6-bars-on' : ''}`} id="ty-s6-bars">
                  <i />
                  <i />
                  <i />
                  <i />
                </span>
              ) : null}
            </button>
          );
        })}
        {positions.map((pos, seat) => {
          const spot = spots[seat];
          if (!spot) return null;
          const active = turn === seat && idle && !view?.finished;
          return <Token key={seat} seat={seat} tile={pos} x={spot.x} y={spot.y} z={spot.z} active={active} offer={active && view?.phase === 'decide'} />;
        })}
      </div>
      {children}
      <div className="ty-s6-annclip">
        <div className="ty-s6-announce" id="ty-s6-announce" role="status" hidden />
      </div>
    </div>
  );
}
