import { useEffect, useRef, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD, cardById, tilesOfGroup } from '../logic/board';
import { JAIL_FINE, JAIL_MAX_TURNS, LEVEL_NAMES, STATION_RENT, TURN_SECONDS, WIN_GROUPS } from '../logic/constants';
import { takeoverPrice } from '../logic/engine';
import { hasAnyFullGroup } from '../logic/rules-hint';
import { cubeTransform } from '../fx/boardFx';
import { animate, reducedMotion } from '../fx/runtime';
import { formatMoney } from '../helpers/format';
import { seatColor } from '../helpers/player';
import { shortName } from '../helpers/tiles';
import { useTycoon } from '../store/useTycoon';
import { groupColor, GroupTag, LevelPips, SeatTag, TileThumb } from './DeedParts';
import { TileMark } from './TileMark';
import { TyIcon } from './TyIcon';

const PIPS: Record<number, number[]> = { 1: [5], 2: [3, 7], 3: [3, 5, 7], 4: [1, 3, 7, 9], 5: [1, 3, 5, 7, 9], 6: [1, 3, 4, 6, 7, 9] };
const CELLS = [1, 2, 3, 4, 5, 6, 7, 8, 9];
const FACES = [1, 2, 3, 4, 5, 6];
const NO_DICE_PHASES = new Set(['decide', 'takeover', 'festival', 'travel', 'debt']);
const WHITE = '#FFFFFF';

function DiceFace({ value }: { value: number }) {
  return (
    <span className={`ty-s6-face ty-s6-f${value}`} aria-hidden="true">
      {CELLS.map((cell) => (
        <i key={cell} className={PIPS[value].includes(cell) ? 'ty-s6-pip' : undefined} />
      ))}
    </span>
  );
}

function Dice({ hidden }: { hidden: boolean }) {
  const diceFx = useTycoon((s) => s.diceFx);
  const [a, b] = diceFx.values;
  return (
    <div className={`ty-s6-dice ${diceFx.rolling ? 'ty-s6-dice-rolling' : ''}`} id="ty-s6-dice" hidden={hidden} role="img" aria-label={`Xúc xắc ${a} và ${b}`}>
      {diceFx.values.map((value, index) => (
        <span className="ty-s6-dwrap" data-die key={index}>
          <span className="ty-s6-dshadow" data-die-shadow />
          <span className="ty-s6-die">
            <span className="ty-s6-cube" data-cube style={{ transform: cubeTransform(value) }}>
              {FACES.map((face) => (
                <DiceFace key={face} value={face} />
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

function TimerRing({ leftMs, hidden }: { leftMs: number; hidden: boolean }) {
  const seconds = Math.max(0, Math.ceil(leftMs / 1000));
  const urgent = seconds <= 10;
  const ref = useRef<HTMLSpanElement>(null);
  useEffect(() => {
    if (hidden || !urgent || seconds === 0) return;
    animate(ref.current, [{ transform: 'scale(1)' }, { transform: `scale(${seconds <= 3 ? 1.22 : 1.1})` }, { transform: 'scale(1)' }], { duration: 300, easing: 'ease-out' });
  }, [hidden, seconds, urgent]);
  return (
    <span ref={ref} className="ty-s6-ring" style={{ visibility: hidden ? 'hidden' : 'visible' }} role="timer" aria-label={`Còn ${seconds} giây`}>
      <svg viewBox="0 0 36 36" aria-hidden="true">
        <circle cx="18" cy="18" r="15.9" stroke="#E9E6D3" />
        <circle
          className="ty-s6-ring-bar"
          cx="18"
          cy="18"
          r="15.9"
          stroke={urgent ? '#E4573D' : '#F2B807'}
          pathLength={100}
          strokeDasharray="100"
          strokeDashoffset={100 - Math.max(0, Math.min(1, leftMs / (TURN_SECONDS * 1000))) * 100}
        />
      </svg>
      <b>0:{String(seconds).padStart(2, '0')}</b>
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
    animate(chip.current, [{ transform: 'scale(.7) translateY(6px)', opacity: 0 }, { transform: 'scale(1.08)', opacity: 1, offset: 0.7 }, { transform: 'scale(1)', opacity: 1 }], { duration: 300, easing: 'ease-out' });
  }, [turn]);
  const mine = myTurn && !view?.players[you]?.bankrupt;
  return (
    <div className="ty-s6-chiprow">
      <span ref={chip} className={`ty-s6-chip ${mine ? 'ty-s6-chip-me' : ''}`} style={{ '--seat': seatColor(turn) } as CSSProperties}>
        <img src={players[turn]?.avatar} alt="" draggable={false} />
        <span>{mine ? 'Lượt của bạn' : `Lượt của ${players[turn]?.name ?? '?'}`}</span>
      </span>
      <TimerRing leftMs={timerLeftMs} hidden={!mine || replaying || deadline === 0} />
      {mine ? null : (
        <span className="ty-s6-thinking" aria-hidden="true">
          <i />
          <i />
          <i />
        </span>
      )}
    </div>
  );
}

function Deed({ idx, owner }: { idx: number; owner?: number }) {
  const { view, you, openSheet } = useTycoon(useShallow((s) => ({ view: s.view, you: s.you, openSheet: s.openSheet })));
  if (!view) return null;
  const tile = BOARD[idx];
  const members = tile.group ? tilesOfGroup(tile.group) : [];
  const baseRent = tile.kind === 'station' ? STATION_RENT[1] : tile.rent?.[0] ?? 0;
  return (
    <button type="button" className="ty-s6-deed" style={{ '--group': groupColor(idx) } as CSSProperties} onClick={() => openSheet({ kind: 'tile', idx })} aria-label={`Xem chi tiết ${tile.name}`}>
      <TileThumb idx={idx} className="ty-s6-deed-art" />
      <span className="ty-s6-deed-copy">
        <GroupTag idx={idx} />
        <b className="ty-s6-deed-name">{tile.name}</b>
        {owner == null ? (
          <span className="ty-s6-deed-stats">
            <span>
              <small>Giá</small>
              <strong>{formatMoney(tile.price ?? 0)}</strong>
            </span>
            <span>
              <small>Thuê</small>
              <strong>{baseRent} tr</strong>
            </span>
            {members.length > 1 ? (
              <span>
                <small>Nhóm</small>
                <span className="ty-s6-deed-dots" aria-label={`Bạn có ${members.filter((m) => view.tiles[m].owner === you).length} trên ${members.length}`}>
                  {members.map((m) => (
                    <i key={m} className={view.tiles[m].owner === you ? 'ty-s6-deed-have' : m === idx ? 'ty-s6-deed-here' : undefined} />
                  ))}
                </span>
              </span>
            ) : null}
          </span>
        ) : (
          <span className="ty-s6-deed-stats">
            <span>
              <small>Chủ</small>
              <SeatTag seat={owner} />
            </span>
            <span>
              <small>{LEVEL_NAMES[view.tiles[idx].houses]}</small>
              <LevelPips houses={view.tiles[idx].houses} />
            </span>
          </span>
        )}
      </span>
      <TyIcon name="chevron-right" size={16} className="ty-s6-deed-more" />
    </button>
  );
}

function BuyButton({ label, price, cash, move }: { label: string; price: number; cash: number; move: 'BUY' | 'TAKEOVER' }) {
  const { busy, sendMove } = useTycoon(useShallow((s) => ({ busy: s.movePending || s.replaying, sendMove: s.sendMove })));
  const affordable = cash >= price;
  return (
    <button type="button" className="ty-s6-cta" disabled={busy || !affordable} onClick={() => sendMove({ type: move })}>
      {label} {price} tr
      <small>{affordable ? `còn lại ${formatMoney(cash - price)}` : `cần ${formatMoney(price - cash)}`}</small>
    </button>
  );
}

function usePhaseView() {
  return useTycoon(useShallow((s) => ({ view: s.view, you: s.you, cash: s.cash, busy: s.movePending || s.replaying, sendMove: s.sendMove, openSheet: s.openSheet })));
}

function Prompt() {
  const { view, you, openSheet } = usePhaseView();
  if (!view) return null;
  const me = view.players[you];
  switch (view.phase) {
    case 'decide':
      return <Deed idx={me.pos} />;
    case 'takeover':
      return <Deed idx={me.pos} owner={view.tiles[me.pos].owner} />;
    case 'festival':
      return (
        <>
          <p className="ty-s6-say">Chọn thành phố của bạn để tổ chức Lễ hội, thuê ×2</p>
          <div className="ty-s6-chips">
            {BOARD.filter((tile) => tile.kind === 'street' && view.tiles[tile.idx].owner === you).map((tile) => (
              <button key={tile.idx} type="button" className={view.festival === tile.idx ? 'ty-s6-chip-on' : undefined} onClick={() => openSheet({ kind: 'tile', idx: tile.idx })}>
                {shortName(tile.idx)}
              </button>
            ))}
          </div>
        </>
      );
    case 'travel':
      return <p className="ty-s6-say">Du lịch: chạm ô bất kỳ để bay tới</p>;
    case 'debt':
      return <p className="ty-s6-say ty-s6-warn">Bạn đang nợ {formatMoney(view.debt?.amount ?? 0)}</p>;
    default:
      return null;
  }
}

function Actions() {
  const { view, you, cash, busy, sendMove, openSheet } = usePhaseView();
  if (!view) return null;
  const me = view.players[you];
  const myCash = cash[you] ?? me.cash;
  switch (view.phase) {
    case 'roll':
      return (
        <button type="button" className="ty-s6-cta" disabled={busy} onClick={() => sendMove({ type: 'ROLL' })}>
          {me.doubles > 0 ? 'Gieo thêm lượt (đôi!)' : 'Gieo xúc xắc'}
        </button>
      );
    case 'jail':
      return (
        <div className="ty-s6-trio">
          <button type="button" className="ty-s6-cta ty-s6-mini" disabled={busy} onClick={() => sendMove({ type: 'JAIL_ROLL' })}>
            Gieo đôi
            <small>
              lần {me.jailTurns + 1}/{JAIL_MAX_TURNS}
            </small>
          </button>
          <button type="button" className="ty-s6-ghost ty-s6-mini" disabled={busy || myCash < JAIL_FINE} onClick={() => sendMove({ type: 'JAIL_PAY' })}>
            Nộp phạt
            <small>{JAIL_FINE} tr</small>
          </button>
          <button type="button" className="ty-s6-ghost ty-s6-mini" disabled={busy || me.jailCards.length === 0} onClick={() => sendMove({ type: 'JAIL_CARD' })}>
            Dùng thẻ
            <small>còn {me.jailCards.length}</small>
          </button>
        </div>
      );
    case 'decide':
      return (
        <div className="ty-s6-pair">
          <button type="button" className="ty-s6-ghost" disabled={busy} onClick={() => sendMove({ type: 'DECLINE' })}>
            Bỏ qua
          </button>
          <BuyButton label="Mua" price={BOARD[me.pos].price ?? 0} cash={myCash} move="BUY" />
        </div>
      );
    case 'takeover':
      return (
        <div className="ty-s6-pair">
          <button type="button" className="ty-s6-ghost" disabled={busy} onClick={() => sendMove({ type: 'DECLINE' })}>
            Bỏ qua
          </button>
          <BuyButton label="Mua lại" price={takeoverPrice(view, me.pos)} cash={myCash} move="TAKEOVER" />
        </div>
      );
    case 'festival':
      return (
        <button type="button" className="ty-s6-ghost ty-s6-wide" disabled={busy} onClick={() => sendMove({ type: 'DECLINE' })}>
          Bỏ qua
        </button>
      );
    case 'travel':
      return (
        <button type="button" className="ty-s6-ghost ty-s6-wide" disabled={busy} onClick={() => sendMove({ type: 'ROLL' })}>
          Không bay, gieo xúc xắc
        </button>
      );
    case 'manage': {
      const end = (
        <button type="button" className="ty-s6-cta" disabled={busy} onClick={() => sendMove({ type: 'END_TURN' })}>
          {me.doubles > 0 && !me.inJail ? 'Gieo tiếp (đôi!)' : 'Kết thúc lượt ›'}
        </button>
      );
      if (!hasAnyFullGroup(view, you)) return end;
      return (
        <div className="ty-s6-pair">
          <button type="button" className="ty-s6-ghost" disabled={busy} onClick={() => openSheet({ kind: 'assets', seat: you })}>
            Nâng cấp
          </button>
          {end}
        </div>
      );
    }
    default:
      return null;
  }
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
        void animate(old, [{ transform: 'translateY(0)', opacity: 1 }, { transform: 'translateY(-55%) scale(.96)', opacity: 0 }], { duration: 170, easing: 'ease-in', fill: 'forwards' }).then(() => old.remove());
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
    } else {
      line.classList.add('ty-s6-fline-plain');
    }
    const text = document.createElement('span');
    text.textContent = feed.text;
    line.append(text);
    root.append(line);
    animate(line, [{ transform: 'translateY(55%) scale(.94)', opacity: 0 }, { transform: 'none', opacity: 1 }], { duration: 230, easing: 'cubic-bezier(.2,.9,.3,1.12)' });
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
  const canAck = myTurn && view?.phase === 'card' && view.turn === you && !replaying;
  return (
    <div className="ty-s6-cardbox" id="ty-s6-cardbox" key={cardFx.seq}>
      <div className={`ty-s6-card3d ${chance ? 'ty-s6-card-chance' : 'ty-s6-card-chest'}`} data-card>
        <div className="ty-s6-cback">
          <b>
            <TileMark name={cardFx.deck} color={WHITE} />
            <span>{label}</span>
          </b>
        </div>
        <div className="ty-s6-cfront">
          <header>
            <TileMark name={cardFx.deck} color={WHITE} />
            <b>{label}</b>
          </header>
          <p>{cardById(cardFx.id)?.text ?? ''}</p>
          {canAck ? (
            <button type="button" className="ty-s6-cta" disabled={movePending} onClick={() => sendMove({ type: 'CARD_ACK' })}>
              Làm theo thẻ
            </button>
          ) : null}
        </div>
      </div>
    </div>
  );
}

export function BoardCenter() {
  const { view, you, myTurn, replaying, movePending, turnExpired } = useTycoon(
    useShallow((s) => ({ view: s.view, you: s.you, myTurn: s.myTurn, replaying: s.replaying, movePending: s.movePending, turnExpired: s.turnExpired })),
  );
  if (!view) return null;
  const canAct = myTurn && !replaying && !movePending && !view.players[you]?.bankrupt;
  const showActions = canAct && !turnExpired && view.phase !== 'card' && view.phase !== 'debt';
  const showPrompt = canAct && !turnExpired;
  const hideDice = showPrompt && NO_DICE_PHASES.has(view.phase);
  return (
    <div className="ty-s6-inner">
      <div className="ty-s6-deck ty-s6-deck-chance" id="ty-s6-deck-chance">
        <b>CƠ HỘI</b>
        <i>?</i>
      </div>
      <div className="ty-s6-deck ty-s6-deck-chest" id="ty-s6-deck-chest">
        <b>KHÍ VẬN</b>
        <TileMark name="chest" color={WHITE} />
      </div>
      <TurnChip />
      <Dice hidden={hideDice} />
      {showPrompt && hideDice ? (
        <div className="ty-s6-mid">
          <Prompt />
        </div>
      ) : null}
      {showActions ? (
        <div className="ty-s6-actions">
          <Actions />
        </div>
      ) : null}
      {turnExpired && myTurn ? <p className="ty-s6-say ty-s6-warn">Hết giờ, hệ thống đang đi thay bạn…</p> : null}
      <Feed hidden={showActions || (turnExpired && myTurn)} />
      {hideDice ? null : (
        <p className="ty-s6-hint" style={{ visibility: showActions && view.phase === 'roll' ? 'visible' : 'hidden' }}>
          Thắng ngay: {WIN_GROUPS} nhóm · 1 cạnh · 4 sân bay
        </p>
      )}
      <CardBox />
    </div>
  );
}
