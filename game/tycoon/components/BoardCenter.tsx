import { useEffect, useRef, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { cardById } from '../logic/board';
import { TURN_SECONDS } from '../logic/constants';
import { animate, reducedMotion } from '../fx/runtime';
import { seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';
import { cardArt } from './art';
import { MoneyBadge, UiAvatar, UiButton } from './Ui';

const CELLS = [1, 2, 3, 4, 5, 6, 7, 8, 9];
const TIMER_BLOCKS = 10;
const NO_DICE_PHASES = new Set(['festival', 'travel']);

function Dice({ hidden }: { hidden: boolean }) {
  const diceFx = useTycoon((s) => s.diceFx);
  const [a, b] = diceFx.values;
  return (
    <div className={`ty-s6-dice ${diceFx.rolling ? 'ty-s6-dice-rolling' : ''}`} id="ty-s6-dice" hidden={hidden} role="img" aria-label={`Xúc xắc ${a} và ${b}`}>
      {diceFx.values.map((value, index) => (
        <span className="ty-s6-dwrap" data-die key={index}>
          <span className="ty-s6-dshadow" data-die-shadow />
          <span className="ty-s6-die" data-face={value}>
            {CELLS.map((cell) => (
              <i key={cell} />
            ))}
          </span>
        </span>
      ))}
      <span className={`ty-s6-dtotal ${diceFx.double ? 'ty-s6-dtotal-double' : ''}`} id="ty-s6-dice-total" hidden={!diceFx.showTotal}>
        <strong>{a + b}</strong>
        {diceFx.double ? <small>ĐÔI</small> : null}
      </span>
    </div>
  );
}

function TimerBar({ leftMs }: { leftMs: number }) {
  const seconds = Math.max(0, Math.ceil(leftMs / 1000));
  const lit = Math.ceil((Math.max(0, Math.min(1, leftMs / (TURN_SECONDS * 1000))) * TIMER_BLOCKS));
  const urgent = seconds <= 10;
  return (
    <span className={`ty-s6-timer ${urgent ? 'ty-s6-timer-urgent' : ''}`} role="timer" aria-label={`Còn ${seconds} giây`}>
      <span className="ty-s6-timer-bar" aria-hidden="true">
        {Array.from({ length: TIMER_BLOCKS }, (_, i) => (
          <i key={i} className={i < lit ? 'ty-s6-timer-on' : undefined} />
        ))}
      </span>
      <b>{seconds}</b>
    </span>
  );
}

function TurnChip() {
  const { view, players, you, myTurn, replaying, deadline, timerLeftMs } = useTycoon(
    useShallow((s) => ({ view: s.view, players: s.players, you: s.you, myTurn: s.myTurn, replaying: s.replaying, deadline: s.deadline, timerLeftMs: s.timerLeftMs })),
  );
  const chip = useRef<HTMLSpanElement>(null);
  const turn = view?.turn ?? 0;
  const first = useRef(true);
  useEffect(() => {
    if (first.current) {
      first.current = false;
      return;
    }
    animate(chip.current, [{ transform: 'translateY(-60%)', opacity: 0 }, { transform: 'translateY(10%)', opacity: 1, offset: 0.6 }, { transform: 'none', opacity: 1 }], { duration: 240, easing: 'cubic-bezier(.22,1.2,.36,1)' });
  }, [turn]);
  const mine = myTurn && !view?.players[you]?.bankrupt;
  const showTimer = mine && !replaying && deadline !== 0;
  return (
    <div className="ty-s6-chiprow">
      <span ref={chip} className={`ty-s6-chip ${mine ? 'ty-s6-chip-me' : ''}`} style={{ '--seat': seatColor(turn) } as CSSProperties}>
        <UiAvatar src={players[turn]?.avatar} size={22} ring={seatColor(turn)} />
        <span>{mine ? 'Lượt của bạn' : players[turn]?.name ?? '?'}</span>
        {mine ? null : (
          <span className="ty-s6-thinking" aria-hidden="true">
            <i />
            <i />
            <i />
          </span>
        )}
      </span>
      {showTimer ? <TimerBar leftMs={timerLeftMs} /> : null}
    </div>
  );
}

function Feed({ hidden }: { hidden: boolean }) {
  const feed = useTycoon((s) => s.feed);
  const box = useRef<HTMLDivElement>(null);
  useEffect(() => {
    const root = box.current;
    if (!root) return;
    if (!feed || reducedMotion()) root.replaceChildren();
    else
      Array.from(root.children).forEach((old) => {
        void animate(old, [{ transform: 'translateY(0)', opacity: 1 }, { transform: 'translateY(-60%)', opacity: 0 }], { duration: 150, easing: 'cubic-bezier(.22,1.2,.36,1)', fill: 'forwards' }).then(() => old.remove());
      });
    if (!feed || feed.text.startsWith('Vòng ')) return;
    const line = document.createElement('div');
    line.className = `ty-s6-fline ty-s6-fline-${feed.tone}`;
    const avatar = feed.seat >= 0 ? useTycoon.getState().players[feed.seat]?.avatar : undefined;
    if (avatar) {
      const img = document.createElement('img');
      img.src = avatar;
      img.alt = '';
      line.append(img);
    }
    const text = document.createElement('span');
    text.textContent = feed.text;
    line.append(text);
    root.append(line);
    animate(line, [{ transform: 'translateY(60%)', opacity: 0 }, { transform: 'translateY(-8%)', opacity: 1, offset: 0.7 }, { transform: 'none', opacity: 1 }], { duration: 200, easing: 'cubic-bezier(.22,1.2,.36,1)' });
  }, [feed]);
  return <div ref={box} className="ty-s6-feed" hidden={hidden} aria-live="polite" />;
}

function CardBox() {
  const { cardFx, view, you, myTurn, replaying, movePending, sendMove } = useTycoon(
    useShallow((s) => ({ cardFx: s.cardFx, view: s.view, you: s.you, myTurn: s.myTurn, replaying: s.replaying, movePending: s.movePending, sendMove: s.sendMove })),
  );
  if (!cardFx) return null;
  const chance = cardFx.deck === 'chance';
  const label = chance ? 'CƠ HỘI' : 'KHÍ VẬN';
  const card = cardById(cardFx.id);
  const canAck = myTurn && view?.phase === 'card' && view.turn === you && !replaying;
  const amount = card?.effect === 'cash' ? card.amount ?? 0 : null;
  return (
    <div className="ty-s6-cardbox" id="ty-s6-cardbox" key={cardFx.seq}>
      <div className={`ty-s6-card3d ${chance ? 'ty-s6-card-chance' : 'ty-s6-card-chest'}`} data-card>
        <div className="ty-s6-cback">
          <b>?</b>
          <span>{label}</span>
        </div>
        <div className="ty-s6-cfront">
          <header>{label}</header>
          <img className="ty-s6-cart" src={cardArt(card)} alt="" draggable={false} />
          <p>{card?.text ?? ''}</p>
          {amount != null ? <MoneyBadge amount={amount} signed className={amount < 0 ? 'ty-s6-camt-neg' : 'ty-s6-camt-pos'} /> : null}
          {canAck ? (
            <UiButton tone="gold" size="sm" disabled={movePending} onClick={() => sendMove({ type: 'CARD_ACK' })}>
              Làm theo thẻ
            </UiButton>
          ) : null}
        </div>
      </div>
    </div>
  );
}

export function BoardCenter() {
  const { view, you, myTurn, replaying, movePending } = useTycoon(
    useShallow((s) => ({ view: s.view, you: s.you, myTurn: s.myTurn, replaying: s.replaying, movePending: s.movePending })),
  );
  if (!view) return null;
  const canAct = myTurn && !replaying && !movePending && !view.players[you]?.bankrupt;
  const hideDice = canAct && NO_DICE_PHASES.has(view.phase);
  return (
    <div className="ty-s6-inner">
      <div className="ty-s6-deck ty-s6-deck-chance" id="ty-s6-deck-chance" aria-hidden="true">
        <b>?</b>
      </div>
      <div className="ty-s6-deck ty-s6-deck-chest" id="ty-s6-deck-chest" aria-hidden="true">
        <b>$</b>
      </div>
      <TurnChip />
      <Dice hidden={hideDice} />
      {hideDice ? <p className="ty-s6-say">{view.phase === 'festival' ? 'Chạm thành phố của bạn để mở Lễ hội' : 'Chạm ô bất kỳ để bay tới'}</p> : null}
      <Feed hidden={false} />
      <CardBox />
    </div>
  );
}
