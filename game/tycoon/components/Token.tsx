import { seatColor } from '../helpers/player';

export function Token({ seat, x, y, active, inJail, mine, avatar }: { seat: number; x: number; y: number; active: boolean; inJail: boolean; mine: boolean; avatar?: string }) {
  return (
    <div
      className={['ty-token', active ? 'ty-token-active' : '', inJail ? 'ty-token-jail' : '', mine ? 'ty-token-mine' : ''].join(' ')}
      style={{ left: `${x}%`, top: `${y}%`, '--seat': seatColor(seat) } as React.CSSProperties}
      aria-hidden="true"
    >
      <span className="ty-token-shadow" />
      <span className="ty-token-pin">
        <span className="ty-token-face">{avatar ? <img src={avatar} alt="" draggable={false} /> : null}</span>
      </span>
    </div>
  );
}
