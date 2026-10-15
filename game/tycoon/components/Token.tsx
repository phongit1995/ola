import { seatColor } from '../helpers/player';

const SHAPES = ['circle', 'triangle', 'square', 'diamond'] as const;

export function Token({ seat, x, y, active, inJail, mine }: { seat: number; x: number; y: number; active: boolean; inJail: boolean; mine: boolean }) {
  const shape = SHAPES[seat] ?? 'circle';
  const color = seatColor(seat);
  return (
    <div
      className={['ty-token', active ? 'ty-token-active' : '', inJail ? 'ty-token-jail' : '', mine ? 'ty-token-mine' : ''].join(' ')}
      style={{ left: `${x}%`, top: `${y}%`, '--seat': color } as React.CSSProperties}
      aria-hidden="true"
    >
      <svg viewBox="0 0 24 24" width="100%" height="100%">
        {shape === 'circle' ? <circle cx="12" cy="12" r="7" fill={color} stroke="#1F2A44" strokeWidth="2" /> : null}
        {shape === 'triangle' ? <path d="M12 4l8 15H4z" fill={color} stroke="#1F2A44" strokeWidth="2" strokeLinejoin="round" /> : null}
        {shape === 'square' ? <rect x="5" y="5" width="14" height="14" rx="3" fill={color} stroke="#1F2A44" strokeWidth="2" /> : null}
        {shape === 'diamond' ? <path d="M12 3l9 9-9 9-9-9z" fill={color} stroke="#1F2A44" strokeWidth="2" strokeLinejoin="round" /> : null}
      </svg>
    </div>
  );
}
