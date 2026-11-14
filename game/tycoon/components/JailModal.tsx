import { useShallow } from 'zustand/react/shallow';
import { JAIL_FINE, JAIL_MAX_TURNS, JAIL_TILE } from '../logic/constants';
import { formatMoney } from '../helpers/format';
import { useTycoon } from '../store/useTycoon';
import { TileThumb } from './DeedParts';
import { UiButton, UiModal } from './Ui';

export function JailModal() {
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
  if (!view || !me || !myTurn || replaying || turnExpired || me.bankrupt || view.phase !== 'jail') return null;
  const myCash = cash[you] ?? me.cash;
  const cards = me.jailCards.length;
  const turn = me.jailTurns + 1;
  const last = turn >= JAIL_MAX_TURNS;
  return (
    <UiModal
      kicker={`Ở tù · lần ${turn}/${JAIL_MAX_TURNS}`}
      title="Bạn đang ở tù"
      icon={<TileThumb idx={JAIL_TILE} className="ty-buy-thumb" />}
      actions={
        <>
          <UiButton tone="gold" icon="dice" disabled={movePending} onClick={() => sendMove({ type: 'JAIL_ROLL' })} data-dialog-initial-focus>
            Gieo đôi
          </UiButton>
          <UiButton price={JAIL_FINE} disabled={movePending || myCash < JAIL_FINE} onClick={() => sendMove({ type: 'JAIL_PAY' })}>
            Nộp
          </UiButton>
          {cards > 0 ? (
            <UiButton icon="key" disabled={movePending} onClick={() => sendMove({ type: 'JAIL_CARD' })}>
              Dùng thẻ ra tù
            </UiButton>
          ) : null}
        </>
      }
    >
      <p className="ty-buy-ask ty-jail-ask">
        {last ? `Lần cuối: gieo không ra đôi sẽ tự nộp ${formatMoney(JAIL_FINE)} để ra.` : 'Gieo ra đôi để ra tù, hoặc nộp phạt để ra và gieo luôn.'}
      </p>
    </UiModal>
  );
}
