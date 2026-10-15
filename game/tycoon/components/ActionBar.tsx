import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { JAIL_FINE } from '../logic/constants';
import { hasAnyFullGroup } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { TyIcon } from './TyIcon';
import { useTycoon } from '../store/useTycoon';

const PHASE_LABEL: Record<string, string> = {
  roll: 'đang gieo xúc xắc…',
  jail: 'đang ở trong tù…',
  decide: 'đang cân nhắc mua đất…',
  card: 'đang đọc thẻ…',
  manage: 'đang xây dựng…',
  debt: 'đang xoay tiền trả nợ…',
};

export function ActionBar() {
  const { view, players, you, myTurn, movePending, replaying, turnExpired, cash, sendMove, openSheet, result } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      players: s.players,
      you: s.you,
      myTurn: s.myTurn,
      movePending: s.movePending,
      replaying: s.replaying,
      turnExpired: s.turnExpired,
      cash: s.cash,
      sendMove: s.sendMove,
      openSheet: s.openSheet,
      result: s.result,
    })),
  );
  if (!view || result) return null;
  const me = view.players[you];
  const turnName = players[view.turn]?.name ?? '?';

  if (!myTurn || me?.bankrupt) {
    return (
      <div className="ty-actionbar ty-actionbar-wait" role="status" aria-live="polite">
        <span className="ty-actionbar-wait-dot" aria-hidden="true" />
        <span>
          Lượt của <strong>{turnName}</strong> · {PHASE_LABEL[view.phase] ?? ''}
        </span>
      </div>
    );
  }

  if (turnExpired) {
    return (
      <div className="ty-actionbar ty-actionbar-wait" role="status">
        <TyIcon name="warning" size={16} />
        <span>Hết giờ, hệ thống đang xử lý…</span>
      </div>
    );
  }

  const busy = movePending || replaying;
  const myCash = cash[you] ?? me.cash;
  const tile = BOARD[me.pos];

  switch (view.phase) {
    case 'roll':
      return (
        <div className="ty-actionbar">
          <button type="button" className="ty-btn ty-btn-gold ty-btn-wide" disabled={busy} onClick={() => sendMove({ type: 'ROLL' })}>
            <TyIcon name="dice" size={22} />
            Gieo xúc xắc
          </button>
        </div>
      );
    case 'jail':
      return (
        <div className="ty-actionbar ty-actionbar-3">
          <button type="button" className="ty-btn ty-btn-paper ty-btn-recommend" disabled={busy} onClick={() => sendMove({ type: 'JAIL_ROLL' })}>
            <TyIcon name="dice" size={18} />
            Gieo
          </button>
          <button type="button" className="ty-btn ty-btn-paper" disabled={busy || myCash < JAIL_FINE} onClick={() => sendMove({ type: 'JAIL_PAY' })}>
            Nộp {JAIL_FINE} tr
          </button>
          <button type="button" className="ty-btn ty-btn-paper" disabled={busy || me.jailCards <= 0} onClick={() => sendMove({ type: 'JAIL_CARD' })}>
            <TyIcon name="key" size={18} />
            Dùng thẻ
          </button>
        </div>
      );
    case 'decide': {
      const price = tile.price ?? 0;
      const affordable = myCash >= price;
      return (
        <div className="ty-actionbar ty-actionbar-decide">
          <button type="button" className="ty-btn ty-btn-gold" disabled={busy || !affordable} onClick={() => sendMove({ type: 'BUY' })}>
            {affordable ? `Mua ${formatMoney(price)}` : `Thiếu tiền (${formatMoney(price)})`}
          </button>
          <button type="button" className="ty-btn ty-btn-paper" disabled={busy} onClick={() => sendMove({ type: 'DECLINE' })}>
            Bỏ qua
          </button>
        </div>
      );
    }
    case 'card':
      return (
        <div className="ty-actionbar">
          <button type="button" className="ty-btn ty-btn-gold ty-btn-wide" disabled={busy} onClick={() => sendMove({ type: 'CARD_ACK' })}>
            Tiếp tục
          </button>
        </div>
      );
    case 'manage': {
      const canManage = hasAnyFullGroup(view, you);
      const again = me.doubles > 0 && !me.inJail;
      return (
        <div className={`ty-actionbar ${canManage ? 'ty-actionbar-decide' : ''}`}>
          {canManage ? (
            <button type="button" className="ty-btn ty-btn-paper" disabled={busy} onClick={() => openSheet({ kind: 'assets', seat: you })}>
              <TyIcon name="house" size={18} />
              Xây / bán
            </button>
          ) : null}
          <button type="button" className={`ty-btn ty-btn-gold ${canManage ? '' : 'ty-btn-wide'}`} disabled={busy} onClick={() => sendMove({ type: 'END_TURN' })}>
            {again ? 'Gieo tiếp (đôi!)' : 'Kết thúc lượt'}
          </button>
        </div>
      );
    }
    case 'debt':
      return (
        <div className="ty-actionbar ty-actionbar-wait" role="status">
          <TyIcon name="warning" size={16} />
          <span>Bạn đang nợ {formatMoney(view.debt?.amount ?? 0)} — xử lý trong hộp thoại</span>
        </div>
      );
    default:
      return null;
  }
}
