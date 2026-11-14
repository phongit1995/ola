import { useEffect, useRef, useState, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { cardById } from '../logic/board';
import { animate } from '../fx/runtime';
import { cubeTransform, DIE_FACES } from '../helpers/dice';
import { seatColor } from '../helpers/player';
import { useTycoon, type FeedLine } from '../store/useTycoon';
import { cardArt } from './art';
import { TurnRing, URGENT_SECONDS } from './TurnRing';
import { MoneyBadge, UiAvatar, UiButton } from './Ui';

const CELLS = [1, 2, 3, 4, 5, 6, 7, 8, 9];
const CORE_PLANES = ['none', 'rotateX(90deg)', 'rotateY(90deg)'];
const NO_DICE_PHASES = new Set(['festival', 'travel']);

function Dice({ hidden }: { hidden: boolean }) {
  const diceFx = useTycoon((s) => s.diceFx);
  const [a, b] = diceFx.values;
  return (
    <div className={`ty-s6-dice ${diceFx.rolling ? 'ty-s6-dice-rolling' : ''}`} id="ty-s6-dice" hidden={hidden} role="img" aria-label={`Xúc xắc ${a} và ${b}`}>
      {diceFx.values.map((value, index) => (
        <span className="ty-s6-dwrap" data-die key={index}>
          <span className="ty-s6-dshadow" data-die-shadow />
          <span className="ty-s6-dbody">
          <span className="ty-s6-cube" data-cube style={{ transform: cubeTransform(value, index) }}>
            {CORE_PLANES.map((plane) => (
              <span key={plane} className="ty-s6-core" style={{ transform: plane }} />
            ))}
            {DIE_FACES.map((face) => (
              <span key={face.value} className="ty-s6-die" data-face={face.value} style={{ transform: `${face.transform} translateZ(calc(var(--die-half) - 0.5px))` }}>
                {CELLS.map((cell) => (
                  <i key={cell} />
                ))}
              </span>
            ))}
          </span>
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
  const seconds = Math.max(0, Math.ceil(timerLeftMs / 1000));
  const urgent = showTimer && seconds <= URGENT_SECONDS;
  const className = ['ty-s6-chip', mine ? 'ty-s6-chip-me' : '', showTimer ? 'ty-s6-chip-timed' : '', urgent ? 'ty-s6-chip-urgent' : ''].join(' ');
  return (
    <div className="ty-s6-chiprow">
      <span ref={chip} className={className} style={{ '--seat': seatColor(turn) } as CSSProperties}>
        <span className="ty-s6-chip-av">
          <UiAvatar src={players[turn]?.avatar} size={showTimer ? 22 : 24} ring={showTimer ? 'transparent' : seatColor(turn)} />
          {showTimer ? <TurnRing leftMs={timerLeftMs} /> : null}
        </span>
        <span className="ty-s6-chip-name">{mine ? 'Lượt của bạn' : players[turn]?.name ?? '?'}</span>
        {showTimer ? (
          <b className="ty-s6-chip-sec" role="timer" aria-label={`Còn ${seconds} giây`}>
            {seconds}
          </b>
        ) : mine ? null : (
          <span className="ty-s6-thinking" aria-hidden="true">
            <i />
            <i />
            <i />
          </span>
        )}
      </span>
    </div>
  );
}

const FEED_KEEP = 3;

function Feed() {
  const { feed, players, matchSeq } = useTycoon(useShallow((s) => ({ feed: s.feed, players: s.players, matchSeq: s.matchSeq })));
  const [items, setItems] = useState<FeedLine[]>([]);
  const [seenMatch, setSeenMatch] = useState(matchSeq);
  const [seenFeed, setSeenFeed] = useState<FeedLine | null>(null);
  if (seenMatch !== matchSeq) {
    setSeenMatch(matchSeq);
    setItems([]);
  }
  if (feed !== seenFeed) {
    setSeenFeed(feed);
    if (feed && !items.some((item) => item.seq === feed.seq)) setItems([...items, feed].slice(-FEED_KEEP));
  }
  return (
    <ol className="ty-s6-feed" aria-live="polite">
      {items.map((item, i) => {
        const avatar = item.seat >= 0 ? players[item.seat]?.avatar : undefined;
        return (
          <li key={item.seq} className={`ty-s6-fline ty-s6-fline-${item.tone} ${i === items.length - 1 ? 'ty-s6-fline-new' : 'ty-s6-fline-old'}`}>
            {avatar ? <img src={avatar} alt="" draggable={false} /> : null}
            <span>{item.text}</span>
          </li>
        );
      })}
    </ol>
  );
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
          <p>{(card?.text ?? '').replace(/ tr(?=[.,!)]|$)/g, '\u00a0tr')}</p>
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
      {hideDice ? <p className="ty-s6-say">{view.phase === 'festival' ? 'Chạm thành phố của bạn để mở Lễ hội · thuê ×2' : 'Chạm ô bất kỳ để đi tới'}</p> : null}
      <Feed />
      <CardBox />
    </div>
  );
}
