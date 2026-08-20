import { useEffect, useMemo, useRef, useState } from 'react';
import { cardAsset, CARD_BACK, REACTION_ASSETS, type ReactionKey } from '../../assets';
import { TURN_SECONDS } from '../../logic/constants.gen';
import { comboLabel } from '../../logic/beats';
import { seatSlots, placeLabel } from '../../helpers/seats';
import { useThirteen } from '../../store/useThirteen';

function useCountdown(deadlineAt: number, active: boolean): number {
  const [left, setLeft] = useState(TURN_SECONDS);
  useEffect(() => {
    if (!active) return;
    const tick = (): void => {
      const remain = Math.max(0, Math.ceil((deadlineAt - performance.now()) / 1000));
      setLeft(Math.min(remain, TURN_SECONDS));
    };
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
  const style = active
    ? { background: `conic-gradient(#f0b53c ${fraction * 360}deg, rgba(247, 236, 215, 0.18) 0deg)` }
    : undefined;
  return (
    <span className={'tl-turn-ring' + (active ? ' active' : '') + (active && left <= 5 ? ' urgent' : '')} style={style}>
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
      {mine.map((r) => (
        <img key={r.key} src={REACTION_ASSETS[r.type as ReactionKey] ?? REACTION_ASSETS.LIKE} alt="" className="tl-reaction-balloon" />
      ))}
    </span>
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
  return (
    <div className={'tl-opponent' + (quit[seat] ? ' quit' : '')}>
      <TurnRing seat={seat}>
        <span className="tl-avatar tl-avatar-md">{player.name.charAt(0).toUpperCase()}</span>
      </TurnRing>
      <span className="tl-opponent-name">{player.name}</span>
      {quit[seat] ? (
        <span className="tl-badge">Đã rời</span>
      ) : finishPlace >= 0 ? (
        <span className="tl-badge tl-badge-gold">{placeLabel(finishPlace + 1, players.length)}</span>
      ) : (
        <span className="tl-card-count">
          <span className="tl-mini-stack">
            <img src={CARD_BACK} alt="" />
            <img src={CARD_BACK} alt="" />
            <img src={CARD_BACK} alt="" />
          </span>
          <b>{count} lá</b>
        </span>
      )}
      {(passed[seat] || passFxSeat === seat) && !quit[seat] && finishPlace < 0 && (
        <span className="tl-pass-chip">Bỏ lượt</span>
      )}
      <AwayBadge seat={seat} />
      <SeatReactions seat={seat} />
    </div>
  );
}

function TableCenter() {
  const table = useThirteen((s) => s.table);
  const players = useThirteen((s) => s.players);
  const chopFx = useThirteen((s) => s.chopFx);
  const selectedComboFn = useThirteen((s) => s.selectedCombo);
  const selected = useThirteen((s) => s.selected);
  const combo = selected.length > 0 ? selectedComboFn() : null;
  const owner = table ? players[table.by] : null;
  return (
    <div className={'tl-table-center' + (chopFx && Date.now() - chopFx < 900 ? ' chop' : '')} key={chopFx || 'center'}>
      {table ? (
        <>
          <div className="tl-trick">
            {table.cards.map((card, i) => (
              <img
                key={card}
                src={cardAsset(card)}
                alt=""
                className="tl-trick-card"
                style={{ transform: `rotate(${(i - (table.cards.length - 1) / 2) * 6}deg)`, zIndex: i }}
              />
            ))}
          </div>
          {owner && <span className="tl-trick-owner">{owner.name} vừa đánh</span>}
        </>
      ) : (
        <span className="tl-table-hint">{combo ? `Đang chọn: ${comboLabel(combo)}` : 'Mời bạn ra bài'}</span>
      )}
    </div>
  );
}

function HandFan() {
  const hand = useThirteen((s) => s.hand);
  const selected = useThirteen((s) => s.selected);
  const toggleCard = useThirteen((s) => s.toggleCard);
  const dealing = useThirteen((s) => s.dealing);
  const n = hand.length;
  const layout = useMemo(() => {
    const width = Math.min(500, window.innerWidth - 20);
    const cardWidth = 66;
    const step = n > 1 ? Math.min(38, (width - cardWidth) / (n - 1)) : 0;
    const total = cardWidth + step * (n - 1);
    const startX = (width - total) / 2;
    return hand.map((card, i) => {
      const mid = (n - 1) / 2;
      const rot = n > 1 ? ((i - mid) / Math.max(mid, 1)) * 12 : 0;
      const lift = n > 1 ? 22 - Math.pow(Math.abs(i - mid) / Math.max(mid, 1), 2) * 18 : 22;
      return { card, x: startX + i * step, rot, lift };
    });
  }, [hand, n]);

  return (
    <div className={'tl-hand' + (dealing ? ' dealing' : '')}>
      {layout.map(({ card, x, rot, lift }, i) => {
        const isSelected = selected.includes(card);
        return (
          <button
            key={card}
            type="button"
            className={'tl-hand-card' + (isSelected ? ' selected' : '')}
            style={{
              left: `${x}px`,
              bottom: `${lift + (isSelected ? 18 : 0)}px`,
              transform: `rotate(${rot}deg)`,
              zIndex: i,
              transitionDelay: dealing ? `${i * 40}ms` : '0ms',
            }}
            onClick={() => toggleCard(card)}
            aria-pressed={isSelected}
          >
            <img src={cardAsset(card)} alt="" draggable={false} />
          </button>
        );
      })}
    </div>
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
  const [draft, setDraft] = useState('');
  const logRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    logRef.current?.scrollTo({ top: logRef.current.scrollHeight });
  }, [matchChat, chatOpen]);

  if (!chatOpen) return null;
  const send = (): void => {
    sendChat(draft);
    setDraft('');
  };
  return (
    <div className="tl-chat-overlay" onClick={(e) => e.target === e.currentTarget && setChatOpen(false)}>
      <div className="tl-chat-panel">
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
        <div ref={logRef} className="tl-room-chat-log">
          {matchChat.length === 0 && <span className="tl-chat-hint">Chưa có tin nhắn nào</span>}
          {matchChat.map((msg) => (
            <div key={`${msg.userId}-${msg.sentAt}`} className="tl-chat-line">
              <b>{msg.userId === user?.id ? 'Bạn' : msg.name}:</b> {msg.text}
            </div>
          ))}
        </div>
        <div className="tl-chat-input-row">
          <input
            className="tl-input"
            value={draft}
            maxLength={120}
            placeholder="Nhập tin nhắn..."
            autoFocus
            onChange={(e) => setDraft(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && send()}
          />
          <button type="button" className="tl-btn tl-btn-gold" onClick={send}>
            Gửi
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
  const setChatOpen = useThirteen((s) => s.setChatOpen);
  const passFxSeat = useThirteen((s) => s.passFxSeat);
  const finishOrder = useThirteen((s) => s.finishOrder);

  const slots = seatSlots(players.length, you);
  const seatsBySlot = new Map<string, number>();
  slots.forEach((slot, seat) => seatsBySlot.set(slot, seat));
  const leftSeat = seatsBySlot.get('left');
  const topSeat = seatsBySlot.get('top');
  const rightSeat = seatsBySlot.get('right');
  const myPlace = finishOrder.indexOf(you);

  return (
    <div className="tl-screen tl-table-screen">
      <div className="tl-topbar">
        <button type="button" className="tl-icon-btn" onClick={requestExit} aria-label="Rời ván">
          ←
        </button>
        <span className="tl-table-title">Tiến Lên Miền Nam</span>
        <button type="button" className="tl-icon-btn" onClick={() => setChatOpen(true)} aria-label="Trò chuyện">
          💬
        </button>
      </div>

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

      <TableCenter />

      {finishFx && (
        <div className="tl-finish-banner">
          {players[finishFx.seat]?.id === user?.id ? 'Bạn' : players[finishFx.seat]?.name} về{' '}
          {placeLabel(finishFx.place, players.length)}!
        </div>
      )}

      <div className="tl-my-row">
        <TurnRing seat={you}>
          <span className="tl-avatar tl-avatar-md">{user?.username.charAt(0).toUpperCase() ?? 'B'}</span>
        </TurnRing>
        <div className="tl-my-info">
          <span className="tl-my-name">Bạn</span>
          {myPlace >= 0 && <span className="tl-badge tl-badge-gold">{placeLabel(myPlace + 1, players.length)}</span>}
          {passFxSeat === you && <span className="tl-pass-chip">Bỏ lượt</span>}
        </div>
        <SeatReactions seat={you} />
      </div>

      <HandFan />
      <ActionBar />
      <ChatOverlay />

      {selfDisconnected && (
        <div className="tl-disconnect-overlay">
          <span>Mất kết nối, đang kết nối lại...</span>
        </div>
      )}
    </div>
  );
}
