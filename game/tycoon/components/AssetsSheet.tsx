import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { GROUPS, MAX_HOUSES } from '../logic/constants';
import { canBuild, canSell, worthOf } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { seatColor } from '../helpers/player';
import { BottomSheet } from './BottomSheet';
import { TyIcon } from './TyIcon';
import { useTycoon } from '../store/useTycoon';

export function AssetsSheet({ seat }: { seat: number }) {
  const { view, players, you, myTurn, movePending, replaying, cash, sendMove, closeSheet, openSheet } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      players: s.players,
      you: s.you,
      myTurn: s.myTurn,
      movePending: s.movePending,
      replaying: s.replaying,
      cash: s.cash,
      sendMove: s.sendMove,
      closeSheet: s.closeSheet,
      openSheet: s.openSheet,
    })),
  );
  if (!view) return null;
  const player = view.players[seat];
  const mine = seat === you;
  const busy = movePending || replaying;
  const manageAllowed = mine && myTurn && (view.phase === 'manage' || (view.phase === 'debt' && view.debt?.by === you));
  const name = mine ? 'Tài sản của bạn' : `Tài sản của @${players[seat]?.name ?? '?'}`;
  const groups = GROUPS.filter((group) => tilesOfGroup(group).some((idx) => view.tiles[idx].owner === seat));

  return (
    <BottomSheet onClose={closeSheet} title={name} tall>
      <div className="ty-assets-head" style={{ '--seat': seatColor(seat) } as React.CSSProperties}>
        <div>
          <span className="ty-assets-kicker">{name}</span>
          <strong className="ty-assets-total">{formatMoney(worthOf(view, seat))}</strong>
          <small>tiền mặt + giá đất + nhà</small>
        </div>
        <div className="ty-assets-cash">
          <span>Tiền mặt</span>
          <strong>{formatMoney(cash[seat] ?? player?.cash ?? 0)}</strong>
        </div>
      </div>
      {player?.bankrupt ? <p className="ty-sheet-desc">Người chơi này đã phá sản.</p> : null}
      {groups.length === 0 && !player?.bankrupt ? <p className="ty-sheet-desc">Chưa sở hữu ô nào.</p> : null}
      {groups.map((group) => {
        const tiles = tilesOfGroup(group);
        const owned = tiles.filter((idx) => view.tiles[idx].owner === seat);
        const full = owned.length === tiles.length;
        const missing = tiles.filter((idx) => view.tiles[idx].owner !== seat).map((idx) => BOARD[idx].name);
        return (
          <section key={group} className={`ty-assets-group ${full ? '' : 'ty-assets-group-partial'}`}>
            <header>
              <i className={`ty-group-swatch ty-band-${group}`} />
              <span>{GROUP_LABEL[group]}</span>
              <small>
                {owned.length}/{tiles.length}
                {!full && missing.length > 0 ? ` · thiếu ${missing.join(', ')}` : ''}
              </small>
            </header>
            {owned.map((idx) => {
              const tile = BOARD[idx];
              const state = view.tiles[idx];
              const buildHint = tile.kind === 'street' ? canBuild(view, seat, idx) : null;
              const sellHint = tile.kind === 'street' ? canSell(view, seat, idx) : null;
              return (
                <div key={idx} className="ty-assets-row">
                  <button type="button" className="ty-assets-name" onClick={() => openSheet({ kind: 'tile', idx })}>
                    <span>{tile.name}</span>
                    {tile.kind === 'street' ? (
                      <span className="ty-assets-houses" aria-label={state.houses >= MAX_HOUSES ? 'Khách sạn' : `${state.houses} nhà`}>
                        {state.houses >= MAX_HOUSES ? <i className="ty-hotel" /> : Array.from({ length: state.houses }, (_, i) => <i key={i} className="ty-house" />)}
                      </span>
                    ) : null}
                  </button>
                  {tile.kind === 'street' && manageAllowed ? (
                    <div className="ty-assets-controls">
                      <button
                        type="button"
                        className="ty-mini-btn"
                        disabled={busy || !sellHint?.ok}
                        title={sellHint && !sellHint.ok ? sellHint.reason : `Bán nhà +${formatMoney((tile.houseCost ?? 0) / 2)}`}
                        aria-label={`Bán nhà ở ${tile.name}`}
                        onClick={() => sendMove({ type: 'SELL_HOUSE', tile: idx })}
                      >
                        <TyIcon name="minus" size={16} className="ty-icon-coral" />
                      </button>
                      <span className="ty-assets-price">{formatMoney(tile.houseCost ?? 0)}</span>
                      <button
                        type="button"
                        className="ty-mini-btn"
                        disabled={busy || view.phase !== 'manage' || !buildHint?.ok}
                        title={buildHint && !buildHint.ok ? buildHint.reason : `Xây ${formatMoney(tile.houseCost ?? 0)}`}
                        aria-label={`Xây nhà ở ${tile.name}`}
                        onClick={() => sendMove({ type: 'BUILD', tile: idx })}
                      >
                        <TyIcon name="plus" size={16} className="ty-icon-jade" />
                      </button>
                    </div>
                  ) : null}
                </div>
              );
            })}
          </section>
        );
      })}
    </BottomSheet>
  );
}
