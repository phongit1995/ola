import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL } from '../logic/board';
import { takeoverPrice } from '../logic/engine';
import { formatMoney } from '../helpers/format';
import { useTycoon } from '../store/useTycoon';
import { groupColor, TileThumb } from './DeedParts';
import { MoneyBadge, UiButton, UiModal } from './Ui';

export function BuyModal() {
  const { view, you, cash, myTurn, replaying, movePending, turnExpired, sendMove } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      you: s.you,
      cash: s.cash,
      myTurn: s.myTurn,
      replaying: s.replaying,
      movePending: s.movePending,
      turnExpired: s.turnExpired,
      sendMove: s.sendMove,
    })),
  );
  const me = view?.players[you];
  if (!view || !me || !myTurn || replaying || turnExpired || me.bankrupt) return null;
  if (view.phase !== 'decide' && view.phase !== 'takeover') return null;

  const idx = me.pos;
  const tile = BOARD[idx];
  const takeover = view.phase === 'takeover';
  const price = takeover ? takeoverPrice(view, idx) : tile.price ?? 0;
  const myCash = cash[you] ?? me.cash;
  const short = myCash < price;

  return (
    <UiModal
      kicker={takeover ? 'Mua lại đất' : tile.group ? GROUP_LABEL[tile.group] : 'Mua đất'}
      title={tile.name}
      icon={<TileThumb idx={idx} className="ty-buy-thumb" />}
      actions={
        <>
          <UiButton disabled={movePending} onClick={() => sendMove({ type: 'DECLINE' })}>
            Bỏ qua
          </UiButton>
          <UiButton tone="gold" price={price} disabled={movePending || short} onClick={() => sendMove({ type: takeover ? 'TAKEOVER' : 'BUY' })} data-dialog-initial-focus>
            {takeover ? 'Mua lại' : 'Mua'}
          </UiButton>
        </>
      }
    >
      <div className="ty-buy" style={{ '--group': groupColor(idx) } as CSSProperties}>
        <div className="ty-buy-meta">
          <MoneyBadge amount={price} className="ty-buy-price" />
        </div>
        <p className="ty-buy-ask">{takeover ? `Bạn có muốn mua lại ${tile.name} không?` : `Bạn có muốn mua ${tile.kind === 'station' ? 'sân bay này' : tile.name} không?`}</p>
        {short ? <p className="ty-buy-note">Thiếu {formatMoney(price - myCash)}</p> : null}
      </div>
    </UiModal>
  );
}
