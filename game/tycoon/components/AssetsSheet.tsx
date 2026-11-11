import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { GROUPS, MAX_HOUSES } from '../logic/constants';
import { canBuild, canSell, currentRent, worthOf } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { seatColor, SEAT_TINTS } from '../helpers/player';
import { shortName } from '../helpers/tiles';
import { BottomSheet } from './BottomSheet';
import { landValue, TileThumb } from './DeedParts';
import { houseArt } from './art';
import { UiAvatar, UiButton } from './Ui';
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
  const title = mine ? 'Tài sản của bạn' : `Tài sản của ${players[seat]?.name ?? '?'}`;
  const groups = GROUPS.filter((group) => tilesOfGroup(group).some((idx) => view.tiles[idx].owner === seat));
  const { land, houses } = landValue(view, seat);
  const money = cash[seat] ?? player?.cash ?? 0;

  return (
    <BottomSheet onClose={closeSheet} title={title} tall accent={seatColor(seat)}>
      <header className="ty-wealth" style={{ '--seat': seatColor(seat), '--soft': SEAT_TINTS[seat] } as CSSProperties}>
        <UiAvatar src={players[seat]?.avatar} size={40} ring={seatColor(seat)} />
        <span className="ty-wealth-copy">
          <span className="ui-kicker">{title}</span>
          <strong>{player?.bankrupt ? 'Phá sản' : formatMoney(worthOf(view, seat))}</strong>
        </span>
      </header>
      <div className="ty-wealth-split">
        <span>
          <small>Tiền mặt</small>
          <b>{formatMoney(money)}</b>
        </span>
        <span>
          <small>Đất</small>
          <b>{formatMoney(land)}</b>
        </span>
        <span>
          <small>Nhà</small>
          <b>{formatMoney(houses)}</b>
        </span>
      </div>
      {groups.length === 0 && !player?.bankrupt ? <p className="ty-deed-desc">Chưa sở hữu ô nào.</p> : null}
      {groups.map((group) => {
        const members = tilesOfGroup(group);
        const owned = members.filter((idx) => view.tiles[idx].owner === seat);
        const full = owned.length === members.length;
        const missing = members.filter((idx) => view.tiles[idx].owner !== seat).map((idx) => shortName(idx));
        return (
          <section key={group} className={`ty-holding ${full ? 'ty-holding-full' : ''}`} style={{ '--group': group === 'station' ? 'var(--pk-grey-lo)' : `var(--ty-g-${group})` } as CSSProperties}>
            <header>
              <i className="ty-holding-swatch" />
              <span>{GROUP_LABEL[group]}</span>
              <small>{group === 'station' ? `${owned.length}/${members.length} sân bay` : full ? 'Trọn nhóm ×2' : `Thiếu ${missing.join(', ')}`}</small>
            </header>
            {owned.map((idx) => {
              const tile = BOARD[idx];
              const level = view.tiles[idx].houses;
              const street = tile.kind === 'street';
              const art = houseArt(level);
              const buildHint = street && manageAllowed && view.phase === 'manage' ? canBuild(view, seat, idx) : null;
              const sellHint = street && manageAllowed ? canSell(view, seat, idx) : null;
              return (
                <div key={idx} className="ty-holding-row">
                  <button type="button" className="ty-holding-name" onClick={() => openSheet({ kind: 'tile', idx })}>
                    <TileThumb idx={idx} />
                    <span>
                      <b>{tile.name}</b>
                      <small>
                        {street ? `Lv${level}` : 'Sân bay'} · <em>Thuê {currentRent(view, idx)}</em>
                      </small>
                    </span>
                    {art ? <img className="ty-holding-house" src={art} alt="" draggable={false} /> : null}
                  </button>
                  {street && manageAllowed && (full || level > 0) ? (
                    <span className="ty-holding-controls">
                      {level > 0 ? (
                        <UiButton
                          size="sm"
                          icon="minus"
                          className="ty-holding-sell"
                          aria-label={`Hạ cấp ${tile.name}, thu về ${formatMoney(Math.floor((tile.houseCost ?? 0) / 2))}`}
                          disabled={busy || !sellHint?.ok}
                          title={sellHint && !sellHint.ok ? sellHint.reason : undefined}
                          onClick={() => sendMove({ type: 'SELL_HOUSE', tile: idx })}
                        >
                          +{Math.floor((tile.houseCost ?? 0) / 2)}
                        </UiButton>
                      ) : null}
                      {full && level < MAX_HOUSES ? (
                        <UiButton
                          tone="gold"
                          size="sm"
                          icon="plus"
                          aria-label={`Nâng cấp ${tile.name}, ${formatMoney(tile.houseCost ?? 0)}`}
                          disabled={busy || !buildHint?.ok}
                          title={buildHint && !buildHint.ok ? buildHint.reason : undefined}
                          onClick={() => sendMove({ type: 'BUILD', tile: idx })}
                        >
                          {tile.houseCost ?? 0}
                        </UiButton>
                      ) : null}
                    </span>
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
