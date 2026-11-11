import type { CSSProperties } from 'react';
import { seatColor } from '../helpers/player';
import { pawnArt } from './art';

export function Token({ seat, tile, x, y, z, active, offer }: { seat: number; tile: number; x: number; y: number; z: number; active: boolean; offer: boolean }) {
  return (
    <span
      className={['ty-s6-pawn', active ? 'ty-s6-pawn-active' : '', offer ? 'ty-s6-pawn-offer' : ''].join(' ')}
      data-pawn={seat}
      data-pawn-tile={tile}
      style={{ left: `${x}%`, top: `${y}%`, zIndex: z, '--seat': seatColor(seat) } as CSSProperties}
      aria-hidden="true"
    >
      <span className="ty-s6-pmove" data-pawn-move>
        <span className="ty-s6-phalo" />
        <span className="ty-s6-pshadow" data-pawn-shadow />
        <span className="ty-s6-pbody" data-pawn-body>
          <img src={pawnArt(seat)} alt="" draggable={false} />
        </span>
      </span>
    </span>
  );
}
