import { useEffect, useId, useRef } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { LEVEL_NAMES } from '../logic/constants';
import { canSell } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { SeatTag, TileThumb } from './DeedParts';
import { houseArt } from './art';
import { MoneyBadge, UiButton } from './Ui';
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
    <div className="ui-modal-layer">
      <div className="ui-scrim" aria-hidden="true" />
      <div ref={ref} className="ui-panel ui-modal ty-debt" role="dialog" aria-modal="true" aria-labelledby={titleId} tabIndex={-1}>
        <header className="ty-debt-head">
          <span className="ty-debt-title">
            <span className="ui-kicker">Thiếu tiền · trả</span>
            <SeatTag seat={debt.creditor} />
          </span>
          <span className={`ty-debt-clock ${seconds <= 10 ? 'ty-debt-clock-late' : ''}`} role="timer" aria-label={`Còn ${seconds} giây`}>
            {seconds}
          </span>
        </header>
        <h2 id={titleId} className="ty-debt-amount">
          <MoneyBadge amount={debt.amount} />
        </h2>

        <div className="ty-debt-meter" aria-hidden="true">
          <i className="ty-debt-meter-cash" style={{ width: `${cashPart}%` }} />
          <i className="ty-debt-meter-sell" style={{ left: `${cashPart}%`, width: `${sellPart}%` }} />
          <b style={{ left: `${target}%` }} />
        </div>
        <p className="ty-debt-legend">
          <span>
            <i className="ty-debt-dot-cash" /> Tiền {formatMoney(myCash)}
          </span>
          <span>
            <i className="ty-debt-dot-sell" /> Bán nhà +{formatMoney(liquidation)}
          </span>
        </p>

        {houses.length > 0 ? (
          <ul className="ty-debt-list">
            {houses.map((t) => {
              const hint = canSell(view, you, t.idx);
              const art = houseArt(t.houses);
              return (
                <li key={t.idx}>
                  <TileThumb idx={t.idx} />
                  <span>
                    <b>{BOARD[t.idx].name}</b>
                    <small>{LEVEL_NAMES[t.houses]}</small>
                  </span>
                  {art ? <img className="ty-debt-house" src={art} alt="" draggable={false} /> : null}
                  <UiButton size="sm" price={(BOARD[t.idx].houseCost ?? 0) / 2} disabled={busy || !hint.ok} title={hint.ok ? undefined : hint.reason} aria-label={`Bán một cấp ${BOARD[t.idx].name}`} onClick={() => sendMove({ type: 'SELL_HOUSE', tile: t.idx })}>
                    Bán
                  </UiButton>
                </li>
              );
            })}
          </ul>
        ) : null}

        {hopeless ? <p className="ty-deed-note ty-deed-note-coral">Bán hết nhà vẫn không đủ.</p> : null}

        <div className="ty-debt-actions">
          {hopeless ? null : canPay ? (
            <UiButton tone="gold" size="lg" block price={debt.amount} disabled={busy} onClick={() => sendMove({ type: 'PAY_DEBT' })} data-dialog-initial-focus>
              Trả
            </UiButton>
          ) : (
            <UiButton tone="gold" size="lg" block disabled={busy} onClick={() => sendMove({ type: 'SETTLE_DEBT' })} data-dialog-initial-focus>
              Bán tự động và trả
            </UiButton>
          )}
          <UiButton tone={hopeless ? 'red' : 'paper'} size={hopeless ? 'lg' : 'sm'} block={hopeless} className="ty-debt-bankrupt" disabled={busy} onClick={askBankrupt}>
            Phá sản
          </UiButton>
        </div>
      </div>
    </div>
  );
}
