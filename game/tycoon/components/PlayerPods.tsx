import { useEffect, useRef, useState, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { reducedMotion } from '../fx/runtime';
import { worthOf } from '../logic/rules-hint';
import { formatDelta, formatMoney } from '../helpers/format';
import { seatColor, SEAT_TINTS } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';
import { TyIcon } from './TyIcon';
import { pawnArt } from './art';

const COUNT_MS = 520;
const BIG_FLOAT = 500;

function PodCash({ value }: { value: number }) {
  const [initial] = useState(value);
  const ref = useRef<HTMLSpanElement>(null);
  const shown = useRef(value);
  useEffect(() => {
    const el = ref.current;
    if (!el || shown.current === value) return;
    if (reducedMotion()) {
      shown.current = value;
      el.textContent = formatMoney(value);
      return;
    }
    const from = shown.current;
    const startedAt = performance.now();
    el.className = value < from ? 'ty-s6-cash-down' : 'ty-s6-cash-up';
    let frame = requestAnimationFrame(function step(now) {
      const progress = Math.min(1, (now - startedAt) / COUNT_MS);
      shown.current = Math.round(from + (value - from) * (1 - (1 - progress) ** 3));
      el.textContent = formatMoney(shown.current);
      if (progress < 1) {
        frame = requestAnimationFrame(step);
      } else {
        el.className = '';
      }
    });
    return () => cancelAnimationFrame(frame);
  }, [value]);
  return <span ref={ref}>{formatMoney(initial)}</span>;
}

export function PlayerPods() {
  const { players, view, cash, you, moneyFloats, result, openSheet } = useTycoon(
    useShallow((s) => ({ players: s.players, view: s.view, cash: s.cash, you: s.you, moneyFloats: s.moneyFloats, result: s.result, openSheet: s.openSheet })),
  );
  if (!view) return null;
  return (
    <div className="ty-s6-pods" style={{ gridTemplateColumns: `repeat(${players.length}, minmax(0, 1fr))` }}>
      {players.map((info, seat) => {
        const player = view.players[seat];
        if (!player) return null;
        const name = seat === you ? 'Bạn' : info.name;
        const money = cash[seat] ?? player.cash;
        const owned = view.tiles.filter((tile) => tile.owner === seat).length;
        return (
          <button
            key={info.id}
            type="button"
            className={['ty-s6-pod', view.turn === seat && !result ? 'ty-s6-pod-active' : '', player.bankrupt ? 'ty-s6-pod-out' : '', seat === you ? 'ty-s6-pod-me' : ''].join(' ')}
            data-pod={seat}
            style={{ '--seat': seatColor(seat), '--soft': SEAT_TINTS[seat] } as CSSProperties}
            onClick={() => openSheet({ kind: 'assets', seat })}
            aria-label={`${name}, tiền mặt ${formatMoney(money)}, ${owned} ô, tổng tài sản ${formatMoney(worthOf(view, seat))}${player.bankrupt ? ', phá sản' : ''}`}
          >
            <span className="ty-s6-av">
              <img src={info.avatar} alt="" draggable={false} />
              <img className="ty-s6-av-pawn" src={pawnArt(seat)} alt="" draggable={false} />
            </span>
            <span className="ty-s6-pod-copy">
              <b className="ty-s6-pod-name">{name}</b>
              <span className="ty-s6-cash">{player.bankrupt ? 'Phá sản' : <PodCash value={money} />}</span>
            </span>
            <span className="ty-s6-pod-tags">
              {owned > 0 && !player.bankrupt ? (
                <span className="ty-s6-pod-tag">
                  <TyIcon name="flag" size={10} />
                  {owned}
                </span>
              ) : null}
              {player.inJail && !player.bankrupt ? (
                <span className="ty-s6-pod-tag ty-s6-pod-tag-jail">
                  <TyIcon name="jail-bars" size={10} />
                </span>
              ) : null}
              {player.jailCards.length > 0 && !player.bankrupt ? (
                <span className="ty-s6-pod-tag">
                  <TyIcon name="key" size={10} />
                </span>
              ) : null}
            </span>
            <svg className="ty-s6-crack" data-crack viewBox="0 0 100 60" aria-hidden="true">
              <path d="M58 0 46 18l12 8-14 14 8 20M46 18 26 22M44 40 20 50" />
            </svg>
            {moneyFloats
              .filter((float) => float.seat === seat)
              .map((float) => (
                <span key={float.seq} className={`ty-s6-float ${float.amount < 0 ? 'ty-s6-float-neg' : ''} ${Math.abs(float.amount) >= BIG_FLOAT ? 'ty-s6-float-big' : ''}`}>
                  {formatDelta(float.amount)}
                </span>
              ))}
          </button>
        );
      })}
    </div>
  );
}
