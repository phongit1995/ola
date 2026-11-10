import { useEffect, useId, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { LEVEL_NAMES, TURN_SECONDS } from '../logic/constants';
import { canSell } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { LevelPips, SeatTag, TileThumb } from './DeedParts';
import { TyIcon } from './TyIcon';
import { useDialogFocus } from './useDialogFocus';
import { useTycoon, type NoticeState } from '../store/useTycoon';

export function DebtModal() {
  const { view, you, cash, movePending, replaying, timerLeftMs, sendMove, showNotice, closeNotice } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      you: s.you,
      cash: s.cash,
      movePending: s.movePending,
      replaying: s.replaying,
      timerLeftMs: s.timerLeftMs,
      sendMove: s.sendMove,
      showNotice: s.showNotice,
      closeNotice: s.closeNotice,
    })),
  );
  const titleId = useId();
  const ref = useDialogFocus<HTMLDivElement>();
  const confirmRef = useRef<NoticeState | null>(null);
  const debt = view?.phase === 'debt' && view.debt?.by === you ? view.debt : null;
  const debtKey = debt ? `${debt.by}:${debt.creditor}:${debt.amount}:${debt.reason}` : null;
  useEffect(
    () => () => {
      if (confirmRef.current) closeNotice(confirmRef.current);
      confirmRef.current = null;
    },
    [debtKey, closeNotice],
  );
  if (!view || !debt) return null;
  const myCash = cash[you] ?? view.players[you].cash;
  const busy = movePending || replaying;
  const houses = view.tiles.map((t, idx) => ({ idx, ...t })).filter((t) => t.owner === you && t.houses > 0);
  const liquidation = houses.reduce((sum, t) => sum + (t.houses * (BOARD[t.idx].houseCost ?? 0)) / 2, 0);
  const canPay = myCash >= debt.amount;
  const hopeless = myCash + liquidation < debt.amount;
  const seconds = Math.max(0, Math.ceil(timerLeftMs / 1000));
  const scale = Math.max(debt.amount, myCash + liquidation, 1);
  const cashPart = Math.min(100, (myCash / scale) * 100);
  const sellPart = Math.min(100 - cashPart, (liquidation / scale) * 100);
  const target = (debt.amount / scale) * 100;

  const askBankrupt = () => {
    const confirm: NoticeState = {
      kind: 'confirm',
      tone: 'danger',
      title: 'Tuyên bố phá sản',
      body: 'Toàn bộ tài sản sẽ chuyển cho chủ nợ và bạn rời cuộc chơi. Chắc chứ?',
      okLabel: 'Phá sản',
      onOk: () => sendMove({ type: 'DECLARE_BANKRUPT' }),
    };
    confirmRef.current = confirm;
    showNotice(confirm);
  };

  return (
    <div className="ty-backdrop ty-debt-backdrop">
      <div ref={ref} className="ty-debt" role="dialog" aria-modal="true" aria-labelledby={titleId} tabIndex={-1}>
        <header className="ty-debt-head">
          <span className="ty-debt-emblem">
            <TyIcon name="coins" size={22} />
          </span>
          <span className="ty-debt-title">
            <small>Thiếu tiền</small>
            <h2 id={titleId}>Cần trả {formatMoney(debt.amount)}</h2>
          </span>
          <span className={`ty-debt-clock ${seconds <= 10 ? 'ty-debt-clock-late' : ''}`} role="timer" aria-label={`Còn ${seconds} giây`}>
            <svg viewBox="0 0 36 36" aria-hidden="true">
              <circle cx="18" cy="18" r="15.9" />
              <circle cx="18" cy="18" r="15.9" pathLength={100} strokeDasharray="100" strokeDashoffset={100 - Math.min(1, timerLeftMs / (TURN_SECONDS * 1000)) * 100} />
            </svg>
            <b>{seconds}</b>
          </span>
        </header>

        <p className="ty-debt-to">
          Trả cho <SeatTag seat={debt.creditor} />
        </p>

        <div className="ty-debt-meter" aria-hidden="true">
          <i className="ty-debt-meter-cash" style={{ width: `${cashPart}%` }} />
          <i className="ty-debt-meter-sell" style={{ left: `${cashPart}%`, width: `${sellPart}%` }} />
          <b style={{ left: `${target}%` }} />
        </div>
        <dl className="ty-debt-legend">
          <div>
            <dt>
              <i className="ty-debt-dot-cash" /> Tiền mặt
            </dt>
            <dd>{formatMoney(myCash)}</dd>
          </div>
          <div>
            <dt>
              <i className="ty-debt-dot-sell" /> Hạ cấp nhà tối đa
            </dt>
            <dd>+{formatMoney(liquidation)}</dd>
          </div>
        </dl>

        {houses.length > 0 ? (
          <ul className="ty-debt-list">
            {houses.map((t) => {
              const hint = canSell(view, you, t.idx);
              return (
                <li key={t.idx}>
                  <TileThumb idx={t.idx} />
                  <span>
                    <b>{BOARD[t.idx].name}</b>
                    <small>{LEVEL_NAMES[t.houses]}</small>
                  </span>
                  <LevelPips houses={t.houses} />
                  <button type="button" className="ty-s6-ghost ty-debt-sell" disabled={busy || !hint.ok} title={hint.ok ? undefined : hint.reason} onClick={() => sendMove({ type: 'SELL_HOUSE', tile: t.idx })}>
                    Bán
                    <small>+{formatMoney((BOARD[t.idx].houseCost ?? 0) / 2)}</small>
                  </button>
                </li>
              );
            })}
          </ul>
        ) : null}

        {hopeless ? <p className="ty-deed-note ty-deed-note-coral">Hạ hết cấp nhà vẫn không đủ, chỉ còn cách phá sản.</p> : <p className="ty-sheet-hint">Hết giờ, hệ thống tự hạ cấp nhà để trả.</p>}

        <div className="ty-sheet-pair">
          <button type="button" className="ty-debt-bankrupt" disabled={busy} onClick={askBankrupt}>
            Phá sản
          </button>
          {hopeless ? null : canPay ? (
            <button type="button" className="ty-s6-cta" disabled={busy} onClick={() => sendMove({ type: 'PAY_DEBT' })} data-dialog-initial-focus>
              Trả {formatMoney(debt.amount)}
              <small>còn lại {formatMoney(myCash - debt.amount)}</small>
            </button>
          ) : (
            <button type="button" className="ty-s6-cta" disabled={busy} onClick={() => sendMove({ type: 'SETTLE_DEBT' })} data-dialog-initial-focus>
              Bán vừa đủ rồi trả
              <small>thiếu {formatMoney(debt.amount - myCash)}</small>
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
