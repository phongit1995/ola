import { useEffect, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { cardById } from '../logic/board';
import { TileGlyph } from './TileGlyph';
import { useTycoon } from '../store/useTycoon';

const PIPS: Record<number, number[]> = {
  1: [5],
  2: [3, 7],
  3: [3, 5, 7],
  4: [1, 3, 7, 9],
  5: [1, 3, 5, 7, 9],
  6: [1, 3, 4, 6, 7, 9],
};

const FACE_ROTATION: Record<number, [number, number]> = {
  1: [0, 0],
  6: [0, 180],
  2: [0, -90],
  5: [0, 90],
  3: [-90, 0],
  4: [90, 0],
};

function Face({ value }: { value: number }) {
  return (
    <span className={`ty-face ty-face-${value}`} aria-hidden="true">
      {Array.from({ length: 9 }, (_, i) => (
        <i key={i} className={PIPS[value].includes(i + 1) ? 'ty-pip' : 'ty-pip ty-pip-off'} />
      ))}
    </span>
  );
}

function Die3D({ value, index, tone }: { value: number; index: number; tone: 'normal' | 'double' }) {
  const [settled, setSettled] = useState(false);
  useEffect(() => {
    let inner = 0;
    const outer = requestAnimationFrame(() => {
      inner = requestAnimationFrame(() => setSettled(true));
    });
    return () => {
      cancelAnimationFrame(outer);
      cancelAnimationFrame(inner);
    };
  }, []);
  const [rx, ry] = FACE_ROTATION[value] ?? FACE_ROTATION[1];
  const transform = settled
    ? `rotateX(${rx + 720 + index * 360}deg) rotateY(${ry + (index === 1 ? -1080 : 1080)}deg)`
    : `rotateX(${-160 - index * 70}deg) rotateY(${index === 1 ? 140 : -120}deg) rotateZ(${index === 1 ? -25 : 20}deg)`;
  return (
    <span className={`ty-die3d ty-die3d-${index} ty-die3d-${tone}`}>
      <span className="ty-die-shadow" />
      <span className="ty-cube" style={{ transform }}>
        {[1, 2, 3, 4, 5, 6].map((face) => (
          <Face key={face} value={face} />
        ))}
      </span>
    </span>
  );
}

export function DiceOverlay() {
  const diceFx = useTycoon((s) => s.diceFx);
  const [visible, setVisible] = useState(false);
  useEffect(() => {
    if (diceFx.seq === 0) return;
    setVisible(true);
    const timer = setTimeout(() => setVisible(false), diceFx.rolling ? 4000 : 1600);
    return () => clearTimeout(timer);
  }, [diceFx.seq, diceFx.rolling]);
  if (!visible || diceFx.seq === 0) return null;
  const tone = diceFx.double ? 'double' : 'normal';
  return (
    <div className="ty-dice-overlay" aria-live="polite" aria-label={`Xúc xắc ${diceFx.values[0]} và ${diceFx.values[1]}`}>
      <div className="ty-dice-pair">
        <Die3D key={`${diceFx.seq}-0`} value={diceFx.values[0]} index={0} tone={tone} />
        <Die3D key={`${diceFx.seq}-1`} value={diceFx.values[1]} index={1} tone={tone} />
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
