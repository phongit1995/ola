import { useEffect, useLayoutEffect, useMemo, useRef, useState, type RefObject } from 'react';
import { cardAsset, CARD_BACK, REACTION_ASSETS, type ReactionKey } from '../../assets';
import backIcon from '../../assets/icons/ic-back.svg';
import chatIcon from '../../assets/icons/ic-chat.svg';
import closeIcon from '../../assets/icons/ic-close.svg';
import hintIcon from '../../assets/icons/ic-hint.svg';
import sendIcon from '../../assets/icons/ic-send.svg';
import wifiOffIcon from '../../assets/icons/ic-wifi-off.svg';
import chopRays from '../../assets/fx/fx-chop-rays.svg';
import { PlayerAvatar } from '../../components/PlayerAvatar';
import { PlayerName } from '../../components/PlayerName';
import type { FlightOrigin } from '../../helpers/cardFlight';
import { HAND_SELECTED_LIFT, handArc, handArcDrop, handLayout, trickLayout, trickRotation } from '../../helpers/cardLayout';
import { atName } from '../../helpers/name';
import { TURN_SECONDS } from '../../logic/constants.gen';
import { cardLabel } from '../../logic/cards';
import { comboLabel } from '../../logic/beats';
import { detectCombo } from '../../logic/combos';
import { hintPlays } from '../../logic/hints';
import { seatSlots, placeLabel } from '../../helpers/seats';
import { useThirteen, type TableEvent } from '../../store/useThirteen';
import { QUICK_CHATS } from './constants';
import { useCardFlight } from './useCardFlight';
import { useElementWidth } from './useElementWidth';
import { localBox, tableRoot } from './localBox';

type HandRects = Map<number, FlightOrigin>;

const URGENT_SECONDS = 5;
const TIMER_RADIUS = 10;

function secondsLeft(deadlineAt: number): number {
  return Math.min(TURN_SECONDS, Math.max(0, Math.ceil((deadlineAt - performance.now()) / 1000)));
}

function useCountdown(deadlineAt: number, active: boolean): number {
  const [left, setLeft] = useState(() => secondsLeft(deadlineAt));
  useEffect(() => {
    if (!active) return;
    const tick = (): void => setLeft(secondsLeft(deadlineAt));
    tick();
    const id = window.setInterval(tick, 250);
    return () => window.clearInterval(id);
  }, [deadlineAt, active]);
  return active ? left : TURN_SECONDS;
}

function TurnRing({ seat, children }: { seat: number; children: React.ReactNode }) {
  const turn = useThirteen((s) => s.turn);
  const animating = useThirteen((s) => s.animating);
  const deadlineAt = useThirteen((s) => s.deadlineAt);
  const active = turn === seat && !animating;
  const left = useCountdown(deadlineAt, active);
  const fraction = Math.max(0, Math.min(1, left / TURN_SECONDS));
  const progressColor = left <= URGENT_SECONDS ? '#e9574d' : '#ffc83d';
  const style = active
    ? { background: `conic-gradient(${progressColor} ${fraction * 360}deg, rgba(255, 253, 245, 0.64) 0deg)` }
    : undefined;
  return (
    <span className={'tl-turn-ring' + (active ? ' active' : '') + (active && left <= URGENT_SECONDS ? ' urgent' : '')} style={style}>
      {children}
    </span>
  );
}

function AwayBadge({ seat }: { seat: number }) {
  const away = useThirteen((s) => s.awaySeats[seat]);
  const [left, setLeft] = useState(0);
  useEffect(() => {
    if (away == null) return;
    const tick = (): void => setLeft(Math.max(0, Math.ceil((away - performance.now()) / 1000)));
    tick();
    const id = window.setInterval(tick, 500);
    return () => window.clearInterval(id);
  }, [away]);
  if (away == null) return null;
  return <span className="tl-away-badge">Mất kết nối · {left}s</span>;
}

function SeatReactions({ seat }: { seat: number }) {
  const reactions = useThirteen((s) => s.reactions);
  const mine = reactions.filter((r) => r.seat === seat);
  if (mine.length === 0) return null;
  return (
    <span className="tl-seat-reactions">
      {mine.map((r, i) => (
        <span key={r.key} className="tl-reaction-pop" style={{ '--drift': `${i % 2 ? 8 : -8}px` } as React.CSSProperties}>
          <img src={REACTION_ASSETS[r.type as ReactionKey] ?? REACTION_ASSETS.LIKE} alt="" className="tl-reaction-balloon" />
        </span>
      ))}
    </span>
  );
}

function SeatChatBubble({ seat }: { seat: number }) {
  const bubble = useThirteen((s) => s.chatBubbles.find((item) => item.seat === seat));
  if (!bubble) return null;
  return (
    <span key={bubble.key} className="tl-chat-bubble" role="status">
      <span className="tl-chat-bubble-text">{bubble.text}</span>
    </span>
  );
}

function ChatButton() {
  const setChatOpen = useThirteen((s) => s.setChatOpen);
  const unread = useThirteen((s) => s.chatUnread);
  return (
    <button
      type="button"
      className="tl-icon-btn tl-chat-btn"
      onClick={() => setChatOpen(true)}
      aria-label={unread > 0 ? `Trò chuyện, ${unread} tin chưa đọc` : 'Trò chuyện'}
    >
      <img src={chatIcon} alt="" />
      {unread > 0 && (
        <span key={unread} className="tl-unread-badge" aria-hidden="true">
          {unread > 9 ? '9+' : unread}
        </span>
      )}
    </button>
  );
}

function OpponentSeat({ seat }: { seat: number }) {
  const players = useThirteen((s) => s.players);
  const handCounts = useThirteen((s) => s.handCounts);
  const passed = useThirteen((s) => s.passed);
  const quit = useThirteen((s) => s.quit);
  const finishOrder = useThirteen((s) => s.finishOrder);
  const passFxSeat = useThirteen((s) => s.passFxSeat);
  const player = players[seat];
  if (!player) return null;
  const count = handCounts[seat] ?? 0;
  const finishPlace = finishOrder.indexOf(seat);
  const playing = !quit[seat] && finishPlace < 0;
  return (
    <div className={'tl-opponent' + (quit[seat] ? ' quit' : '')}>
      <span className="tl-seat-avatar" data-seat={seat}>
        <TurnRing seat={seat}>
          <PlayerAvatar name={player.name} vipType={player.vipType} size="md" />
        </TurnRing>
        {playing && (
          <span className="tl-count-badge" aria-label={`${count} lá`}>
            <img src={CARD_BACK} alt="" />
            {count}
          </span>
        )}
        <SeatReactions seat={seat} />
        <SeatChatBubble seat={seat} />
      </span>
      <span className="tl-opponent-name">
        <PlayerName name={player.name} />
      </span>
      {quit[seat] ? (
        <span className="tl-badge">Đã rời</span>
      ) : finishPlace >= 0 ? (
        <span className="tl-badge tl-badge-gold">{placeLabel(finishPlace + 1, players.length)}</span>
      ) : null}
      {(passed[seat] || passFxSeat === seat) && !quit[seat] && finishPlace < 0 && (
        <span className="tl-pass-chip">Bỏ lượt</span>
      )}
      <AwayBadge seat={seat} />
    </div>
  );
}

function seatOrigin(from: Element | null, seat: number): FlightOrigin | null {
  const root = tableRoot(from);
  const anchor = root?.querySelector<HTMLElement>(`[data-seat="${seat}"]`);
  if (!root || !anchor) return null;
  const box = localBox(anchor, root);
  return { x: box.left + box.width / 2, y: box.top + box.height / 2, width: 0 };
}

const EVENT_HOLD_MS = 1100;

function useEventHold(event: TableEvent | null): boolean {
  const [released, setReleased] = useState(() =>
    event && Date.now() - event.at >= EVENT_HOLD_MS ? event.at : 0,
  );
  useEffect(() => {
    if (!event) return;
    const id = window.setTimeout(() => setReleased(event.at), Math.max(0, EVENT_HOLD_MS - (Date.now() - event.at)));
    return () => window.clearTimeout(id);
  }, [event]);
  return event != null && released !== event.at;
}

function TurnTimer({ deadlineAt }: { deadlineAt: number }) {
  const left = useCountdown(deadlineAt, true);
  const [drain] = useState(() => {
    const remainingMs = Math.max(0, Math.min(TURN_SECONDS * 1000, deadlineAt - performance.now()));
    return { '--timer-from': remainingMs / (TURN_SECONDS * 1000), '--timer-ms': `${Math.round(remainingMs)}ms` };
  });
  return (
    <span className={'tl-turn-timer' + (left <= URGENT_SECONDS ? ' urgent' : '')} role="timer" aria-label={`Còn ${left} giây`}>
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <circle className="tl-turn-timer-track" cx="12" cy="12" r={TIMER_RADIUS} />
        <circle className="tl-turn-timer-progress" cx="12" cy="12" r={TIMER_RADIUS} style={drain as React.CSSProperties} />
      </svg>
      <span key={left} className="tl-turn-timer-value">
        {left}
      </span>
    </span>
  );
}

function TableTicker() {
  const event = useThirteen((s) => s.tableEvent);
  const turn = useThirteen((s) => s.turn);
  const you = useThirteen((s) => s.you);
  const animating = useThirteen((s) => s.animating);
  const deadlineAt = useThirteen((s) => s.deadlineAt);
  const leading = useThirteen((s) => s.table == null);
  const openingLead = useThirteen((s) => s.openingLead);
  const players = useThirteen((s) => s.players);
  const over = useThirteen((s) => s.result != null);
  const holding = useEventHold(event);
  if (holding && event) {
    return (
      <span key={`event:${event.at}`} className={'tl-ticker ' + event.kind} role="status">
        <PlayerName name={players[event.seat]?.name ?? ''} self={event.seat === you} />{' '}
        {event.kind === 'play' ? 'vừa đánh' : 'bỏ lượt'}
      </span>
    );
  }
  const player = players[turn];
  if (animating || over || !player) return <span className="tl-ticker pending" aria-hidden="true" />;
  const mine = turn === you;
  return (
    <span key={`turn:${turn}:${deadlineAt}`} className={'tl-ticker turn' + (mine ? ' mine' : '')} role="status">
      <span className="tl-ticker-text">
        {mine ? 'Tới lượt bạn' : <>Tới lượt <PlayerName name={player.name} /></>}
        {leading && ' ra bài'}
        {leading && openingLead && ' · thắng ván trước'}
      </span>
      <TurnTimer deadlineAt={deadlineAt} />
    </span>
  );
}

function TableCenter({ handRects }: { handRects: RefObject<HandRects> }) {
  const table = useThirteen((s) => s.table);
  const you = useThirteen((s) => s.you);
  const chopFx = useThirteen((s) => s.chopFx);
  const event = useThirteen((s) => s.tableEvent);
  const selectedComboFn = useThirteen((s) => s.selectedCombo);
  const selected = useThirteen((s) => s.selected);
  const combo = selected.length > 0 ? selectedComboFn() : null;
  const centerRef = useRef<HTMLDivElement>(null);
  const trickRef = useRef<HTMLDivElement>(null);
  const width = useElementWidth(centerRef);
  const cards = table?.cards ?? [];
  const trick = trickLayout(cards.length, width);
  useCardFlight(trickRef, table, event?.kind === 'play' ? event.at : 0, trick.cardHeight, (card, by) =>
    (by === you ? handRects.current.get(card) : null) ?? seatOrigin(centerRef.current, by),
  );
  return (
    <div
      ref={centerRef}
      className={'tl-table-center' + (chopFx && Date.now() - chopFx < 900 ? ' chop' : '')}
      key={chopFx || 'center'}
    >
      {table && chopFx > 0 && <img className="tl-chop-rays" src={chopRays} alt="" />}
      <div ref={trickRef} className="tl-trick" style={{ height: trick.cardHeight + 4 }}>
        {width > 0 &&
          cards.map((card, i) => (
            <img
              key={card}
              src={cardAsset(card)}
              alt={cardLabel(card)}
              className="tl-trick-card"
              style={{
                left: trick.lefts[i],
                width: trick.cardWidth,
                transform: `rotate(${trickRotation(i, cards.length)}deg)`,
                zIndex: i,
              }}
            />
          ))}
        {!table && combo && <span className="tl-table-hint">Đang chọn: {comboLabel(combo)}</span>}
      </div>
      <TableTicker />
    </div>
  );
}

function HandFan({ handRects }: { handRects: RefObject<HandRects> }) {
  const hand = useThirteen((s) => s.hand);
  const selected = useThirteen((s) => s.selected);
  const toggleCard = useThirteen((s) => s.toggleCard);
  const dealing = useThirteen((s) => s.dealing);
  const handRef = useRef<HTMLDivElement>(null);
  const width = useElementWidth(handRef);
  const layout = useMemo(() => handLayout(hand.length, width), [hand.length, width]);
  const lift = Math.round(layout.cardHeight * HAND_SELECTED_LIFT);
  const arcDrop = handArcDrop(layout.cardHeight);
  const firstCardTop = lift + handArc(0, hand.length, layout.cardHeight).drop;

  useLayoutEffect(() => {
    const rects = handRects.current;
    rects.clear();
    const root = tableRoot(handRef.current);
    if (!handRef.current || !root || width === 0) return;
    const box = localBox(handRef.current, root);
    hand.forEach((card, i) => {
      const raised = selected.includes(card) ? lift : 0;
      const { drop } = handArc(i, hand.length, layout.cardHeight);
      rects.set(card, {
        x: box.left + layout.lefts[i] + layout.cardWidth / 2,
        y: box.top + box.height - arcDrop + drop - raised - layout.cardHeight / 2,
        width: layout.cardWidth,
      });
    });
  });

  return (
    <div
      ref={handRef}
      className={'tl-hand' + (dealing ? ' dealing' : '')}
      style={{ height: layout.cardHeight + lift + arcDrop, marginTop: Math.min(0, 2 - firstCardTop) }}
    >
      {width > 0 && hand.map((card, i) => {
        const isSelected = selected.includes(card);
        const arc = handArc(i, hand.length, layout.cardHeight);
        return (
          <button
            key={card}
            type="button"
            className={'tl-hand-card' + (isSelected ? ' selected' : '')}
            style={{
              width: `${layout.cardWidth}px`,
              left: `${layout.lefts[i]}px`,
              bottom: `${arcDrop}px`,
              transform: `translateY(${arc.drop - (isSelected ? lift : 0)}px) rotate(${arc.angle}deg)`,
              zIndex: i,
              transitionDelay: dealing ? `${i * 40}ms` : '0ms',
            }}
            onClick={() => toggleCard(card)}
            aria-pressed={isSelected}
            aria-label={`${cardLabel(card)}${isSelected ? ', đã chọn' : ''}`}
          >
            <img src={cardAsset(card)} alt="" draggable={false} />
          </button>
        );
      })}
    </div>
  );
}

function HintButton() {
  const hand = useThirteen((s) => s.hand);
  const table = useThirteen((s) => s.table);
  const require3s = useThirteen((s) => s.require3s);
  const turn = useThirteen((s) => s.turn);
  const you = useThirteen((s) => s.you);
  const animating = useThirteen((s) => s.animating);
  const movePending = useThirteen((s) => s.movePending);
  const over = useThirteen((s) => s.result != null);
  const selected = useThirteen((s) => s.selected);
  const suggestPlay = useThirteen((s) => s.suggestPlay);
  const myTurn = turn === you && !animating && !movePending && !over;
  const hints = useMemo(
    () => (myTurn ? hintPlays(hand, table ? detectCombo(table.cards) : null, require3s) : []),
    [myTurn, hand, table, require3s],
  );
  const available = hints.length > 0;
  const picked = [...selected].sort((a, b) => a - b).join(',');
  const step = hints.findIndex((play) => play.join(',') === picked);
  return (
    <button
      type="button"
      className={'tl-hint-btn' + (available ? ' lit' : '')}
      disabled={!available}
      onClick={suggestPlay}
      aria-label="Gợi ý nước đi"
    >
      <img src={hintIcon} alt="" />
      <span>Gợi ý</span>
      {hints.length > 1 && step >= 0 && (
        <span key={step} className="tl-hint-step">
          {step + 1}/{hints.length}
        </span>
      )}
    </button>
  );
}

function ActionBar() {
  const you = useThirteen((s) => s.you);
  const turn = useThirteen((s) => s.turn);
  const animating = useThirteen((s) => s.animating);
  const movePending = useThirteen((s) => s.movePending);
  const table = useThirteen((s) => s.table);
  const selected = useThirteen((s) => s.selected);
  const canPlaySelected = useThirteen((s) => s.canPlaySelected);
  const playSelected = useThirteen((s) => s.playSelected);
  const passTurn = useThirteen((s) => s.passTurn);
  const clearSelection = useThirteen((s) => s.clearSelection);
  const myTurn = turn === you && !animating && !movePending;
  const canPlay = myTurn && canPlaySelected();
  const canPass = myTurn && table != null;
  return (
    <div className="tl-action-bar">
      {selected.length > 0 && (
        <button type="button" className="tl-btn tl-btn-ghost tl-btn-sm" onClick={clearSelection}>
          Bỏ chọn
        </button>
      )}
      <button
        type="button"
        className={'tl-btn tl-btn-wide ' + (canPass ? 'tl-btn-ghost' : 'tl-btn-disabled')}
        disabled={!canPass}
        onClick={passTurn}
      >
        Bỏ lượt
      </button>
      <button
        type="button"
        className={'tl-btn tl-btn-wide ' + (canPlay ? 'tl-btn-gold' : 'tl-btn-disabled')}
        disabled={!canPlay}
        onClick={playSelected}
      >
        Đánh
      </button>
    </div>
  );
}

function ChatOverlay() {
  const chatOpen = useThirteen((s) => s.chatOpen);
  const setChatOpen = useThirteen((s) => s.setChatOpen);
  const matchChat = useThirteen((s) => s.matchChat);
  const sendChat = useThirteen((s) => s.sendChat);
  const sendReaction = useThirteen((s) => s.sendReaction);
  const user = useThirteen((s) => s.user);
  const roomOwnerId = useThirteen((s) => s.roomOwnerId || s.room?.ownerId || '');
  const [draft, setDraft] = useState('');
  const logRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    logRef.current?.scrollTo({ top: logRef.current.scrollHeight });
  }, [matchChat, chatOpen]);

  if (!chatOpen) return null;
  const send = (): void => {
    if (!draft.trim()) return;
    sendChat(draft);
    setDraft('');
  };
  const sendQuick = (text: string): void => {
    sendChat(text);
    setChatOpen(false);
  };
  return (
    <div className="tl-chat-overlay" onClick={(e) => e.target === e.currentTarget && setChatOpen(false)}>
      <div className="tl-chat-panel" role="dialog" aria-modal="true" aria-labelledby="tl-table-chat-title">
        <div className="tl-chat-header">
          <strong id="tl-table-chat-title">Trò chuyện</strong>
          <button type="button" className="tl-chat-close" onClick={() => setChatOpen(false)} aria-label="Đóng trò chuyện">
            <img src={closeIcon} alt="" />
          </button>
        </div>
        <div ref={logRef} className="tl-room-chat-log">
          {matchChat.length === 0 && <span className="tl-chat-hint">Chưa có tin nhắn nào</span>}
          {matchChat.map((msg) => (
            <div key={`${msg.userId}-${msg.sentAt}`} className="tl-chat-line">
              <b>
                <PlayerName name={msg.name} self={msg.userId === user?.id} owner={msg.userId === roomOwnerId} />:
              </b>{' '}
              {msg.text}
            </div>
          ))}
        </div>
        <div className="tl-reaction-row">
          {(Object.keys(REACTION_ASSETS) as ReactionKey[]).map((key) => (
            <button
              key={key}
              type="button"
              className="tl-reaction-btn"
              onClick={() => {
                sendReaction(key);
                setChatOpen(false);
              }}
            >
              <img src={REACTION_ASSETS[key]} alt={key} />
            </button>
          ))}
        </div>
        <div className="tl-quick-row">
          {QUICK_CHATS.map((text) => (
            <button key={text} type="button" className="tl-quick-chip" onClick={() => sendQuick(text)}>
              {text}
            </button>
          ))}
        </div>
        <div className="tl-chat-input-row">
          <input
            className="tl-input"
            value={draft}
            maxLength={120}
            placeholder="Nhập tin nhắn..."
            onChange={(e) => setDraft(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && send()}
          />
          <button type="button" className="tl-btn tl-btn-gold tl-send-btn" disabled={!draft.trim()} onClick={send}>
            <span>Gửi</span>
            <img src={sendIcon} alt="" />
          </button>
        </div>
      </div>
    </div>
  );
}

export function TableScreen() {
  const players = useThirteen((s) => s.players);
  const you = useThirteen((s) => s.you);
  const user = useThirteen((s) => s.user);
  const finishFx = useThirteen((s) => s.finishFx);
  const selfDisconnected = useThirteen((s) => s.selfDisconnected);
  const requestExit = useThirteen((s) => s.requestExit);
  const passFxSeat = useThirteen((s) => s.passFxSeat);
  const passed = useThirteen((s) => s.passed);
  const finishOrder = useThirteen((s) => s.finishOrder);
  const practice = useThirteen((s) => s.practice != null);

  const slots = seatSlots(players.length, you);
  const seatsBySlot = new Map<string, number>();
  slots.forEach((slot, seat) => seatsBySlot.set(slot, seat));
  const leftSeat = seatsBySlot.get('left');
  const topSeat = seatsBySlot.get('top');
  const rightSeat = seatsBySlot.get('right');
  const myPlace = finishOrder.indexOf(you);
  const handRects = useRef<HandRects>(new Map());

  return (
    <div className="tl-screen tl-table-screen">
      <div className="tl-topbar">
        <button type="button" className="tl-icon-btn" onClick={requestExit} aria-label="Rời ván">
          <img src={backIcon} alt="" />
        </button>
        <span className="tl-table-title">{practice ? 'Tập luyện' : 'Tiến Lên Miền Nam'}</span>
        <ChatButton />
      </div>

      <div className={'tl-felt' + (players.length >= 4 ? ' full' : players.length === 3 ? ' trio' : '')}>
        {topSeat != null && (
          <div className="tl-seat-slot top">
            <OpponentSeat seat={topSeat} />
          </div>
        )}
        {leftSeat != null && (
          <div className="tl-seat-slot left">
            <OpponentSeat seat={leftSeat} />
          </div>
        )}
        {rightSeat != null && (
          <div className="tl-seat-slot right">
            <OpponentSeat seat={rightSeat} />
          </div>
        )}
        <TableCenter handRects={handRects} />
      </div>

      {finishFx && (
        <div className="tl-finish-banner">
          {players[finishFx.seat]?.id === user?.id ? 'Bạn' : atName(players[finishFx.seat]?.name ?? '')} về{' '}
          {placeLabel(finishFx.place, players.length)}!
        </div>
      )}

      <div className="tl-bottom">
        <div className="tl-my-row">
          <span className="tl-seat-avatar" data-seat={you}>
            <TurnRing seat={you}>
              <PlayerAvatar name="Bạn" vipType={user?.vipType ?? players[you]?.vipType} size="md" />
            </TurnRing>
            <SeatReactions seat={you} />
            <SeatChatBubble seat={you} />
          </span>
          <div className="tl-my-info">
            <span className="tl-my-name">Bạn</span>
            {myPlace >= 0 && <span className="tl-badge tl-badge-gold">{placeLabel(myPlace + 1, players.length)}</span>}
            {(passed[you] || passFxSeat === you) && <span className="tl-pass-chip">Bỏ lượt</span>}
          </div>
          <HintButton />
        </div>
        <HandFan handRects={handRects} />
        <ActionBar />
      </div>
      <ChatOverlay />

      {selfDisconnected && (
        <div className="tl-disconnect-overlay">
          <img src={wifiOffIcon} alt="" />
          <span>Mất kết nối, đang kết nối lại...</span>
        </div>
      )}
    </div>
  );
}
