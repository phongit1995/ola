import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { LEVEL_NAMES } from '../logic/constants';
import { takeoverPrice } from '../logic/engine';
import { currentRent } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { useTycoon } from '../store/useTycoon';
import { groupColor, RentLadder, SeatTag, TileThumb } from './DeedParts';
import { houseArt } from './art';
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
  const owner = view.tiles[idx].owner;
  const houses = view.tiles[idx].houses;
  const art = houseArt(houses);
  const price = takeover ? takeoverPrice(view, idx) : tile.price ?? 0;
  const myCash = cash[you] ?? me.cash;
  const short = myCash < price;
  const members = tile.group ? tilesOfGroup(tile.group) : [];
  const mine = members.filter((m) => view.tiles[m].owner === you).length;

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
          {takeover ? (
            <>
              <SeatTag seat={owner} />
              <span>
                Vừa trả thuê <b>{formatMoney(currentRent(view, idx))}</b>
              </span>
            </>
          ) : (
            <>
              <MoneyBadge amount={price} className="ty-buy-price" />
              {members.length > 1 ? (
                <span className="ty-buy-group" aria-label={`Bạn có ${mine} trên ${members.length} ô của nhóm`}>
                  {members.map((m) => (
                    <i key={m} className={view.tiles[m].owner === you ? 'ty-buy-dot-have' : m === idx ? 'ty-buy-dot-here' : undefined} />
                  ))}
                  <small>
                    {mine}/{members.length}
                  </small>
                </span>
              ) : null}
            </>
          )}
        </div>
        {takeover ? (
          <p className="ty-buy-take">
            {houses > 0 ? (
              <>
                {art ? <img src={art} alt="" draggable={false} /> : null}
                Nhận luôn <b>Lv{houses} · {LEVEL_NAMES[houses]}</b>
              </>
            ) : (
              <>Nhận đất trống, chưa có nhà</>
            )}
          </p>
        ) : null}
        <RentLadder view={view} idx={idx} />
        {short ? <p className="ty-buy-note">Thiếu {formatMoney(price - myCash)}</p> : null}
      </div>
    </UiModal>
  );
}
