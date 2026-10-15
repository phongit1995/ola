import { useEffect, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { cardById } from '../logic/board';
import { TileGlyph } from './TileGlyph';
import { useTycoon } from '../store/useTycoon';

const PIPS: Record<number, Array<[number, number]>> = {
  1: [[22, 22]],
  2: [[11, 11], [33, 33]],
  3: [[11, 11], [22, 22], [33, 33]],
  4: [[11, 11], [33, 11], [11, 33], [33, 33]],
  5: [[11, 11], [33, 11], [22, 22], [11, 33], [33, 33]],
  6: [[11, 11], [33, 11], [11, 22], [33, 22], [11, 33], [33, 33]],
};

function Die({ value, rolling, tone }: { value: number; rolling: boolean; tone: 'normal' | 'double' | 'triple' }) {
  const [face, setFace] = useState(value);
  useEffect(() => {
    if (!rolling) {
      setFace(value);
      return;
    }
    const timer = setInterval(() => setFace(1 + Math.floor(Math.random() * 6)), 80);
    return () => clearInterval(timer);
  }, [rolling, value]);
  return (
    <span className={`ty-die ${rolling ? 'ty-die-rolling' : ''} ty-die-${tone}`}>
      <svg viewBox="0 0 44 44" width="100%" height="100%" aria-hidden="true">
        {(PIPS[face] ?? PIPS[1]).map(([x, y], i) => (
          <circle key={i} cx={x} cy={y} r="4" fill="currentColor" />
        ))}
      </svg>
    </span>
  );
}

export function DiceOverlay() {
  const { diceFx, view } = useTycoon(useShallow((s) => ({ diceFx: s.diceFx, view: s.view })));
  const [visible, setVisible] = useState(false);
  useEffect(() => {
    if (diceFx.seq === 0) return;
    setVisible(true);
    const timer = setTimeout(() => setVisible(false), diceFx.rolling ? 4000 : 1400);
    return () => clearTimeout(timer);
  }, [diceFx.seq, diceFx.rolling]);
  if (!visible || diceFx.seq === 0) return null;
  const tone = diceFx.double ? (view?.players[view.turn]?.doubles === 0 && view?.players[view.turn]?.inJail ? 'triple' : 'double') : 'normal';
  return (
    <div className="ty-dice-overlay" aria-live="polite" aria-label={`Xúc xắc ${diceFx.values[0]} và ${diceFx.values[1]}`}>
      <div className="ty-dice-pair">
        <Die value={diceFx.values[0]} rolling={diceFx.rolling} tone={tone} />
        <Die value={diceFx.values[1]} rolling={diceFx.rolling} tone={tone} />
      </div>
      {!diceFx.rolling ? (
        <div className="ty-dice-sum">
          <strong>{diceFx.values[0] + diceFx.values[1]}</strong>
          {diceFx.double ? <span className="ty-chip ty-chip-gold">Đôi!</span> : null}
        </div>
      ) : null}
    </div>
  );
}

export function CardOverlay() {
  const { cardFx, view, you, myTurn, sendMove, movePending, replaying } = useTycoon(
    useShallow((s) => ({ cardFx: s.cardFx, view: s.view, you: s.you, myTurn: s.myTurn, sendMove: s.sendMove, movePending: s.movePending, replaying: s.replaying })),
  );
  const [flipped, setFlipped] = useState(false);
  useEffect(() => {
    setFlipped(false);
    if (!cardFx) return;
    const timer = setTimeout(() => setFlipped(true), 60);
    return () => clearTimeout(timer);
  }, [cardFx?.seq]);
  if (!cardFx) return null;
  const card = cardById(cardFx.id);
  const chance = cardFx.deck === 'chance';
  const canAck = myTurn && view?.phase === 'card' && view.turn === you && !replaying;
  return (
    <div className={`ty-card-overlay ${flipped ? 'ty-card-flipped' : ''}`} role="status" aria-live="polite">
      <div className={`ty-card ${chance ? 'ty-card-chance' : 'ty-card-chest'}`}>
        <div className="ty-card-face ty-card-back">
          <TileGlyph name={chance ? 'chance' : 'chest'} size={48} color="var(--ty-navy)" />
        </div>
        <div className="ty-card-face ty-card-front">
          <span className="ty-card-deck">{chance ? 'CƠ HỘI' : 'KHÍ VẬN'}</span>
          <p className="ty-card-text">{card?.text ?? ''}</p>
          {canAck ? (
            <button type="button" className="ty-btn ty-btn-gold ty-btn-small" disabled={movePending} onClick={() => sendMove({ type: 'CARD_ACK' })}>
              Tiếp tục
            </button>
          ) : null}
        </div>
      </div>
    </div>
  );
}
