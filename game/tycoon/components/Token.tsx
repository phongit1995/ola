import type { CSSProperties } from 'react';
import { seatColor } from '../helpers/player';

const PAWN_BODY =
  'M8 1.5a3.5 3.5 0 0 1 3.5 3.5c0 1.5-.95 2.8-2.28 3.3.12.5.43 1.15.95 1.82.47.6 1.02 1.12 1.67 1.65 1.15.95 2.16 1.77 2.16 3.23 0 1.2-.52 2.1-1.34 2.7H14c.55 0 1 .45 1 1v1.2c0 .55-.45 1-1 1H2c-.55 0-1-.45-1-1v-1.2c0-.55.45-1 1-1h1.34C2.52 17.1 2 16.2 2 15c0-1.46 1.01-2.28 2.16-3.23.65-.53 1.2-1.05 1.67-1.65.52-.67.83-1.32.95-1.82A3.5 3.5 0 0 1 4.5 5 3.5 3.5 0 0 1 8 1.5Z';
const PAWN_SHINE = 'M6.3 3.5c1-.8 2.15-.8 3.1-.1';

function Pawn() {
  return (
    <svg viewBox="-1 -1 18 26" aria-hidden="true">
      <path d={PAWN_BODY} fill="#fff" stroke="#fff" strokeWidth="3.4" strokeLinejoin="round" />
      <path d={PAWN_BODY} fill="currentColor" stroke="#1F2A44" strokeWidth="1.5" strokeLinejoin="round" />
      <path d={PAWN_SHINE} fill="none" stroke="#FFF8EA" strokeWidth="1" strokeLinecap="round" opacity=".8" />
    </svg>
  );
}

export function Token({ seat, tile, x, y, z, active, offer }: { seat: number; tile: number; x: number; y: number; z: number; active: boolean; offer: boolean }) {
  return (
    <span
      className={['ty-s6-pawn', active ? 'ty-s6-pawn-active' : '', offer ? 'ty-s6-pawn-offer' : ''].join(' ')}
      data-pawn={seat}
      data-pawn-tile={tile}
      style={{ left: `${x}%`, top: `${y}%`, zIndex: z, color: seatColor(seat) } as CSSProperties}
      aria-hidden="true"
    >
      <span className="ty-s6-pmove" data-pawn-move>
        <span className="ty-s6-phalo" />
        <span className="ty-s6-pshadow" data-pawn-shadow />
        <span className="ty-s6-pbody" data-pawn-body>
          <Pawn />
        </span>
      </span>
    </span>
  );
}
