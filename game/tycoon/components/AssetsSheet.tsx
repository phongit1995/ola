import type { CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { GROUPS, LEVEL_NAMES } from '../logic/constants';
import { canBuild, canSell, worthOf } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { seatColor, SEAT_TINTS } from '../helpers/player';
import { shortName } from '../helpers/tiles';
import { BottomSheet } from './BottomSheet';
import { landValue, LevelPips, TileThumb } from './DeedParts';
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
  const title = mine ? 'Tài sản của bạn' : `Tài sản của ${players[seat]?.name ?? '?'}`;
  const groups = GROUPS.filter((group) => tilesOfGroup(group).some((idx) => view.tiles[idx].owner === seat));
  const { land, houses } = landValue(view, seat);
  const money = cash[seat] ?? player?.cash ?? 0;

  return (
    <BottomSheet onClose={closeSheet} title={title} tall accent={seatColor(seat)}>
      <header className="ty-wealth" style={{ '--seat': seatColor(seat), '--soft': SEAT_TINTS[seat] } as CSSProperties}>
        <img src={players[seat]?.avatar} alt="" draggable={false} />
        <span className="ty-wealth-copy">
          <small>{title}</small>
          <strong>{player?.bankrupt ? 'Phá sản' : formatMoney(worthOf(view, seat))}</strong>
        </span>
        <span className="ty-wealth-split">
          <span>
            <i className="ty-s6-coin" /> Tiền mặt <b>{formatMoney(money)}</b>
          </span>
          <span>
            <i className="ty-wealth-dot ty-wealth-land" /> Đất <b>{formatMoney(land)}</b>
          </span>
          <span>
            <i className="ty-wealth-dot ty-wealth-house" /> Nhà <b>{formatMoney(houses)}</b>
          </span>
        </span>
      </header>
      {manageAllowed && view.phase === 'manage' ? <p className="ty-sheet-hint">Nâng đều từng cấp trong cả nhóm. Bấm tên ô để xem bảng tiền thuê.</p> : null}
      {groups.length === 0 && !player?.bankrupt ? <p className="ty-deed-desc">Chưa sở hữu ô nào.</p> : null}
      {groups.map((group) => {
        const members = tilesOfGroup(group);
        const owned = members.filter((idx) => view.tiles[idx].owner === seat);
        const full = owned.length === members.length;
        const missing = members.filter((idx) => view.tiles[idx].owner !== seat).map((idx) => shortName(idx));
        return (
          <section key={group} className={`ty-holding ${full ? 'ty-holding-full' : ''}`} style={{ '--group': `var(--ty-g-${group})` } as CSSProperties}>
            <header>
              <span>{GROUP_LABEL[group]}</span>
              <span className="ty-holding-count" aria-label={`${owned.length} trên ${members.length}`}>
                {members.map((idx) => (
                  <i key={idx} className={view.tiles[idx].owner === seat ? 'ty-holding-have' : undefined} />
                ))}
              </span>
              <small>{full ? (group === 'station' ? 'Sân bay' : 'Trọn nhóm · thuê ×2') : `Thiếu ${missing.join(', ')}`}</small>
            </header>
            {owned.map((idx) => {
              const tile = BOARD[idx];
              const level = view.tiles[idx].houses;
              const street = tile.kind === 'street';
              const buildHint = street && manageAllowed && view.phase === 'manage' ? canBuild(view, seat, idx) : null;
              const sellHint = street && manageAllowed ? canSell(view, seat, idx) : null;
              return (
                <div key={idx} className="ty-holding-row">
                  <button type="button" className="ty-holding-name" onClick={() => openSheet({ kind: 'tile', idx })}>
                    <TileThumb idx={idx} />
                    <span>
                      <b>{tile.name}</b>
                      <small>{street ? LEVEL_NAMES[level] : `Thuê theo số sân bay`}</small>
                    </span>
                  </button>
                  {street ? <LevelPips houses={level} /> : null}
                  {street && manageAllowed ? (
                    <span className="ty-holding-controls">
                      <button
                        type="button"
                        className="ty-step-btn"
                        disabled={busy || !sellHint?.ok}
                        title={sellHint && !sellHint.ok ? sellHint.reason : `Hạ cấp, thu về ${formatMoney((tile.houseCost ?? 0) / 2)}`}
                        aria-label={`Hạ cấp ${tile.name}`}
                        onClick={() => sendMove({ type: 'SELL_HOUSE', tile: idx })}
                      >
                        <TyIcon name="minus" size={16} />
                      </button>
                      <button
                        type="button"
                        className="ty-step-btn ty-step-btn-plus"
                        disabled={busy || !buildHint?.ok}
                        title={buildHint && !buildHint.ok ? buildHint.reason : `Nâng cấp ${formatMoney(tile.houseCost ?? 0)}`}
                        aria-label={`Nâng cấp ${tile.name}, ${formatMoney(tile.houseCost ?? 0)}`}
                        onClick={() => sendMove({ type: 'BUILD', tile: idx })}
                      >
                        <TyIcon name="plus" size={16} />
                        <small>{tile.houseCost}</small>
                      </button>
                    </span>
                  ) : null}
                </div>
              );
            })}
          </section>
        );
      })}
      {!mine && !player?.bankrupt ? <p className="ty-sheet-hint">Tiền mặt + giá đất + tiền nâng cấp = tổng tài sản dùng để xếp hạng.</p> : null}
    </BottomSheet>
  );
}
