import type { CSSProperties, ReactNode } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { BOARD_SIZE, FESTIVAL_MULTIPLIER, GO_SALARY, TAX_RATE } from '../logic/constants';
import { tileRect, type Side } from '../helpers/boardGeometry';
import { pawnLayout } from '../helpers/pawnLayout';
import { seatColor, SEAT_TINTS } from '../helpers/player';
import { levelLabel, rentLabel, shortName } from '../helpers/tiles';
import { useTycoon } from '../store/useTycoon';
import { houseArt, PIXEL_ART } from './art';
import { TileMark, type TileMarkName } from './TileMark';
import { Token } from './Token';
import { TILE_ART } from './tileArt';

const SIDE_CLASS: Record<Side, string> = { left: 'l', top: 't', right: 'r', bottom: 'b', corner: 'c' };
const MARK_BY_KIND: Partial<Record<string, TileMarkName>> = { chance: 'chance', chest: 'chest', tax: 'tax', go: 'go' };

function caption(idx: number): string {
  const tile = BOARD[idx];
  switch (tile.kind) {
    case 'go':
      return `+${GO_SALARY}`;
    case 'jail':
      return 'Thăm tù';
    case 'festival':
      return `Thuê ×${FESTIVAL_MULTIPLIER}`;
    case 'travel':
      return 'Bay';
    case 'tax':
      return `−${TAX_RATE * 100}%`;
    default:
      return tile.price ? String(tile.price) : '';
  }
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
    <div className={`ty-s6-board ${choosingFestival || choosingTravel ? 'ty-s6-board-pick' : ''}`} id="ty-s6-board" role="group" aria-label="Bàn cờ tỷ phú">
      <div className="ty-s6-grid" id="ty-s6-grid">
        {BOARD.map((tile) => {
          const rect = tileRect(tile.idx);
          const state = tiles[tile.idx];
          const owner = state?.owner ?? -1;
          const houses = state?.houses ?? 0;
          const property = tile.kind === 'street' || tile.kind === 'station';
          const owned = owner >= 0 && property;
          const corner = rect.side === 'corner';
          const art = TILE_ART[tile.idx];
          const mark = MARK_BY_KIND[tile.kind];
          const text = owned ? rentLabel(tiles, tile.idx, festival) : caption(tile.idx);
          const pickable = (choosingFestival && tile.kind === 'street' && owner === you) || (choosingTravel && tile.idx !== view?.players[you]?.pos);
          const dim = (choosingFestival || choosingTravel) && !pickable;
          const house = houseArt(houses);
          const label = `${tile.name}${owned ? `, của ${owner === you ? 'bạn' : players[owner]?.name ?? ''}, thuê ${text} tr` : tile.price ? `, giá ${tile.price} tr` : ''}${houses > 0 ? `, ${levelLabel(houses)}` : ''}${festival === tile.idx ? `, đang có Lễ hội, thuê ×${FESTIVAL_MULTIPLIER}` : ''}`;
          const style = {
            left: `${rect.x}%`,
            top: `${rect.y}%`,
            width: `${rect.w}%`,
            height: `${rect.h}%`,
            ...(owned ? { '--own': SEAT_TINTS[owner], '--owner': seatColor(owner) } : {}),
          } as CSSProperties;
          return (
            <button
              key={tile.idx}
              type="button"
              className={[
                'ty-s6-tile',
                `ty-s6-side-${SIDE_CLASS[rect.side]}`,
                `ty-s6-kind-${tile.kind}`,
                owned ? 'ty-s6-owned' : '',
                dim ? 'ty-s6-dim' : '',
                pickable ? 'ty-s6-pick' : '',
                festival === tile.idx ? 'ty-s6-festive' : '',
              ].join(' ')}
              style={style}
              data-tile={tile.idx}
              onClick={() => onTileTap(tile.idx)}
              aria-label={label}
            >
              <span className="ty-s6-tile-body">
                <b className="ty-s6-tile-name">{corner ? tile.name : shortName(tile.idx)}</b>
                {art ? <span className={`ty-s6-art ${tile.kind === 'travel' ? 'ty-s6-art-contain' : ''}`} data-fig style={{ backgroundImage: `url(${art})` }} /> : null}
                {!art && mark ? (
                  <span className="ty-s6-glyph" data-fig>
                    <TileMark name={mark} />
                  </span>
                ) : null}
                {text ? <span className={`ty-s6-price ${owned ? 'ty-s6-rent' : ''}`}>{text}</span> : null}
              </span>
              <span className="ty-s6-houses" data-houses>
                {house ? <img src={house} alt="" draggable={false} /> : null}
              </span>
              <span className="ty-s6-flag" data-owner-dot>
                {owned ? <img className="ui-sprite" src={PIXEL_ART.flag} alt="" draggable={false} /> : null}
              </span>
              {festival === tile.idx ? <img className="ty-s6-fest ui-sprite" src={PIXEL_ART.lantern} alt="" draggable={false} /> : null}
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
