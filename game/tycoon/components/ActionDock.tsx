import { useEffect, useLayoutEffect, useRef, useState, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { JAIL_MAX_TURNS } from '../logic/constants';
import { canBuild } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { seatColor } from '../helpers/player';
import { useTycoon } from '../store/useTycoon';
import { UiAvatar, UiButton } from './Ui';

const AUTO_END_MS = 2000;

function AutoEndButton({ label, onEnd, auto }: { label: string; onEnd: () => void; auto: boolean }) {
  const [armed, setArmed] = useState(auto);
  const latest = useRef(onEnd);
  useLayoutEffect(() => {
    latest.current = onEnd;
  });
  useEffect(() => {
    if (!armed) return;
    const timer = setTimeout(() => latest.current(), AUTO_END_MS);
    return () => clearTimeout(timer);
  }, [armed]);
  return (
    <UiButton tone="gold" size="lg" block className={armed ? 'ty-dock-auto' : ''} style={{ '--auto-ms': `${AUTO_END_MS}ms` } as CSSProperties} onClick={onEnd} onPointerDown={() => setArmed(false)}>
      {label}
    </UiButton>
  );
}

export function ActionDock() {
  const { view, you, players, myTurn, replaying, movePending, turnExpired, autoEnd, sendMove, openSheet } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      you: s.you,
      players: s.players,
      myTurn: s.myTurn,
      replaying: s.replaying,
      movePending: s.movePending,
      turnExpired: s.turnExpired,
      autoEnd: s.autoEnd,
      sendMove: s.sendMove,
      openSheet: s.openSheet,
    })),
  );
  if (!view) return <div className="ty-dock" />;
  const me = view.players[you];
  const busy = movePending || replaying;
  const canAct = myTurn && !busy && !me?.bankrupt && !turnExpired;

  const waiting = (seat: number, text: string) => (
    <div className="ty-dock ty-dock-wait" style={{ '--seat': seatColor(seat) } as CSSProperties}>
      <UiAvatar src={players[seat]?.avatar} size={30} ring={seatColor(seat)} />
      <span className="ty-dock-wait-text">{text}</span>
      <span className="ty-s6-thinking" aria-hidden="true">
        <i />
        <i />
        <i />
      </span>
    </div>
  );

  if (!myTurn || view.finished || me?.bankrupt) return waiting(view.turn, me?.bankrupt ? 'Bạn đã phá sản, đang xem tiếp' : `${players[view.turn]?.name ?? '?'} đang đi`);
  if (turnExpired) return <div className="ty-dock ty-dock-wait"><span className="ty-dock-wait-text ty-dock-warn">Hết giờ, máy đi thay bạn…</span></div>;
  if (!canAct) return waiting(you, 'Bạn đang đi');

  switch (view.phase) {
    case 'roll':
      return (
        <div className="ty-dock">
          <UiButton tone="gold" size="lg" block icon="dice" onClick={() => sendMove({ type: 'ROLL' })}>
            {me.doubles > 0 ? 'Gieo thêm (đôi!)' : 'Gieo xúc xắc'}
          </UiButton>
        </div>
      );
    case 'jail':
      return (
        <div className="ty-dock ty-dock-wait">
          <span className="ty-dock-wait-text">
            Đang ở tù · lần {me.jailTurns + 1}/{JAIL_MAX_TURNS}
          </span>
        </div>
      );
    case 'decide':
    case 'takeover':
      return (
        <div className="ty-dock ty-dock-wait">
          <span className="ty-dock-wait-text">{view.phase === 'takeover' ? 'Mua lại ô này?' : 'Mua ô này?'}</span>
        </div>
      );
    case 'festival':
      return (
        <div className="ty-dock">
          <UiButton block onClick={() => sendMove({ type: 'DECLINE' })}>
            Bỏ qua
          </UiButton>
        </div>
      );
    case 'travel':
      return (
        <div className="ty-dock">
          <UiButton block onClick={() => sendMove({ type: 'DECLINE' })}>
            Không bay, ở lại
          </UiButton>
        </div>
      );
    case 'manage': {
      const again = me.doubles > 0 && !me.inJail;
      const upgrade = canBuild(view, you, me.pos).ok;
      const auto = autoEnd && !again && !upgrade;
      const end = <AutoEndButton key={view.moveCount} label={again ? 'Gieo tiếp (đôi!)' : 'Kết thúc lượt'} auto={auto} onEnd={() => sendMove({ type: 'END_TURN' })} />;
      if (!upgrade) return <div className="ty-dock">{end}</div>;
      return (
        <div className="ty-dock">
          <div className="ty-dock-row ty-dock-row-end">
            <UiButton icon="house" onClick={() => openSheet({ kind: 'tile', idx: me.pos })}>
              Nâng cấp
            </UiButton>
            {end}
          </div>
        </div>
      );
    }
    case 'debt':
      return (
        <div className="ty-dock ty-dock-wait">
          <span className="ty-dock-wait-text ty-dock-warn">Bạn đang nợ {formatMoney(view.debt?.amount ?? 0)}</span>
        </div>
      );
    case 'card':
      return (
        <div className="ty-dock ty-dock-wait">
          <span className="ty-dock-wait-text">Đọc thẻ trên bàn</span>
        </div>
      );
    default:
      return <div className="ty-dock" />;
  }
}
