import { useId } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { canSell } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { levelLabel } from '../helpers/tiles';
import { ModalHeading } from './ModalHeading';
import { TyIcon } from './TyIcon';
import { useDialogFocus } from './useDialogFocus';
import { useTycoon } from '../store/useTycoon';

export function DebtModal() {
  const { view, players, you, cash, movePending, replaying, timerLeftMs, sendMove, showNotice } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      players: s.players,
      you: s.you,
      cash: s.cash,
      movePending: s.movePending,
      replaying: s.replaying,
      timerLeftMs: s.timerLeftMs,
      sendMove: s.sendMove,
      showNotice: s.showNotice,
    })),
  );
  const titleId = useId();
  const ref = useDialogFocus<HTMLDivElement>();
  if (!view || view.phase !== 'debt' || !view.debt || view.debt.by !== you) return null;
  const debt = view.debt;
  const myCash = cash[you] ?? view.players[you].cash;
  const busy = movePending || replaying;
  const creditor = debt.creditor >= 0 ? players[debt.creditor]?.name ?? '?' : 'ngân hàng';
  const houses = view.tiles
    .map((t, idx) => ({ idx, ...t }))
    .filter((t) => t.owner === you && t.houses > 0);
  const liquidation = houses.reduce((sum, t) => sum + (t.houses * (BOARD[t.idx].houseCost ?? 0)) / 2, 0);
  const canPay = myCash >= debt.amount;
  const hopeless = myCash + liquidation < debt.amount;
  const seconds = Math.ceil(timerLeftMs / 1000);

  return (
    <div className="ty-backdrop ty-debt-backdrop">
      <div ref={ref} className="ty-modal ty-debt-modal" role="dialog" aria-modal="true" aria-labelledby={titleId} tabIndex={-1}>
        <ModalHeading eyebrow="Thiếu tiền" title={`Cần trả ${formatMoney(debt.amount)}`} icon="coins" titleId={titleId} />
        <p className="ty-modal-body">
          Trả cho <strong>{creditor}</strong>. Tiền mặt của bạn: <strong>{formatMoney(myCash)}</strong>. Hạ cấp nhà có thể thu thêm tối đa{' '}
          <strong>{formatMoney(liquidation)}</strong>.
        </p>
        <div className="ty-debt-timer" aria-live="polite">
          Còn {seconds}s · hết giờ hệ thống tự hạ cấp nhà
        </div>
        {houses.length > 0 ? (
          <div className="ty-debt-list">
            {houses.map((t) => {
              const hint = canSell(view, you, t.idx);
              return (
                <div key={t.idx} className="ty-assets-row">
                  <span className="ty-assets-name">
                    <span>{BOARD[t.idx].name}</span>
                    <small>{levelLabel(t.houses)}</small>
                  </span>
                  <button type="button" className="ty-btn ty-btn-small ty-btn-paper" disabled={busy || !hint.ok} title={hint.ok ? undefined : hint.reason} onClick={() => sendMove({ type: 'SELL_HOUSE', tile: t.idx })}>
                    <TyIcon name="minus" size={16} className="ty-icon-coral" />
                    Bán +{formatMoney((BOARD[t.idx].houseCost ?? 0) / 2)}
                  </button>
                </div>
              );
            })}
          </div>
        ) : null}
        <div className="ty-modal-actions">
          <button
            type="button"
            className="ty-btn ty-btn-danger"
            disabled={busy}
            onClick={() =>
              showNotice({
                kind: 'confirm',
                tone: 'danger',
                title: 'Tuyên bố phá sản',
                body: 'Toàn bộ tài sản sẽ chuyển cho chủ nợ và bạn rời cuộc chơi. Chắc chứ?',
                okLabel: 'Phá sản',
                onOk: () => sendMove({ type: 'DECLARE_BANKRUPT' }),
              })
            }
          >
            Phá sản
          </button>
          {hopeless ? null : canPay ? (
            <button type="button" className="ty-btn ty-btn-gold" disabled={busy} onClick={() => sendMove({ type: 'PAY_DEBT' })} data-dialog-initial-focus>
              <TyIcon name="coins" size={18} />
              Trả {formatMoney(debt.amount)}
            </button>
          ) : (
            <button type="button" className="ty-btn ty-btn-gold" disabled={busy} onClick={() => sendMove({ type: 'SETTLE_DEBT' })} data-dialog-initial-focus>
              Bán vừa đủ rồi trả
            </button>
          )}
        </div>
        {hopeless ? <p className="ty-sheet-reason">Hạ hết cấp nhà vẫn không đủ — chỉ còn cách phá sản.</p> : null}
      </div>
    </div>
  );
}
