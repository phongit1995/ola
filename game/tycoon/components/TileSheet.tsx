import { useShallow } from 'zustand/react/shallow';
import { BOARD, GROUP_LABEL, tilesOfGroup } from '../logic/board';
import { GO_SALARY, JAIL_FINE, MAX_HOUSES, STATION_RENT, UTILITY_MULTIPLIER } from '../logic/constants';
import { canBuild, canSell, currentRent } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { seatColor } from '../helpers/player';
import { BottomSheet } from './BottomSheet';
import { glyphForTile, TileGlyph } from './TileGlyph';
import { TyIcon } from './TyIcon';
import { useTycoon } from '../store/useTycoon';

const HOUSE_LABELS = ['Đất trống', '1 nhà', '2 nhà', '3 nhà', '4 nhà', 'Khách sạn'];
const DARK_GROUPS = new Set(['brown', 'red', 'green', 'blue']);

function specialDescription(idx: number): string {
  switch (BOARD[idx].kind) {
    case 'go':
      return `Nhận ${GO_SALARY} tr mỗi lần đi qua hoặc đáp vào.`;
    case 'jail':
      return `Đáp vào chỉ là ghé thăm. Bị bắt vào tù thì gieo đôi, nộp ${JAIL_FINE} tr hoặc dùng thẻ để ra.`;
    case 'parking':
      return 'Bãi đỗ xe — nghỉ một lượt, không có gì xảy ra.';
    case 'gotojail':
      return 'Vào tù ngay, không qua Xuất phát, không nhận lương.';
    case 'chance':
      return 'Rút một thẻ Cơ hội: có thể được tiền, mất tiền hoặc phải di chuyển.';
    case 'chest':
      return 'Rút một thẻ Khí vận: thường là tiền vào, đôi khi mất tiền.';
    case 'tax':
      return `Trả ${BOARD[idx].tax} tr cho ngân hàng.`;
    default:
      return '';
  }
}

export function TileSheet({ idx }: { idx: number }) {
  const { view, players, you, myTurn, movePending, replaying, cash, sendMove, closeSheet } = useTycoon(
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
    })),
  );
  if (!view) return null;
  const tile = BOARD[idx];
  const state = view.tiles[idx];
  const owner = state.owner;
  const me = view.players[you];
  const myCash = cash[you] ?? me?.cash ?? 0;
  const busy = movePending || replaying;
  const glyph = glyphForTile(idx, tile.kind);
  const isProperty = tile.kind === 'street' || tile.kind === 'station' || tile.kind === 'utility';
  const canBuyHere = myTurn && view.phase === 'decide' && me?.pos === idx && owner < 0;
  const buildHint = owner === you && tile.kind === 'street' ? canBuild(view, you, idx) : null;
  const sellHint = owner === you && tile.kind === 'street' ? canSell(view, you, idx) : null;
  const manageAllowed = myTurn && (view.phase === 'manage' || (view.phase === 'debt' && view.debt?.by === you));
  const diceSum = view.dice[0] + view.dice[1] || 7;

  return (
    <BottomSheet onClose={closeSheet} title={tile.name}>
      <div className={`ty-sheet-band ${tile.kind === 'street' && tile.group ? `ty-band-${tile.group} ty-sheet-band-${DARK_GROUPS.has(tile.group) ? 'dark' : 'light'}` : 'ty-sheet-band-dim'}`}>
        {glyph ? <TileGlyph name={glyph} size={34} /> : null}
        <span className="ty-sheet-band-copy">
          <small>{tile.kind === 'street' ? `Sổ đỏ · ${GROUP_LABEL[tile.group ?? 'brown']}` : isProperty ? GROUP_LABEL[tile.group ?? 'station'] : 'Ô đặc biệt'}</small>
          <h2 className="ty-sheet-title">{tile.name}</h2>
        </span>
      </div>

      {isProperty ? (
        <>
          <div className="ty-sheet-row">
            <span>Chủ sở hữu</span>
            {owner >= 0 ? (
              <span className="ty-owner-chip" style={{ '--seat': seatColor(owner) } as React.CSSProperties}>
                <i />
                {owner === you ? 'Bạn' : players[owner]?.name ?? '?'}
              </span>
            ) : (
              <strong>Chưa có chủ</strong>
            )}
          </div>
          <div className="ty-sheet-row">
            <span>Giá</span>
            <strong>{formatMoney(tile.price ?? 0)}</strong>
          </div>
          {tile.kind === 'street' ? (
            <>
              <div className="ty-sheet-row">
                <span>Giá xây nhà</span>
                <strong>{formatMoney(tile.houseCost ?? 0)}</strong>
              </div>
              <table className="ty-rent-table">
                <tbody>
                  {(tile.rent ?? []).map((rent, houses) => {
                    const active = owner >= 0 && state.houses === houses;
                    const groupBonus = houses === 0 && owner >= 0 && tilesOfGroup(tile.group ?? '').every((g) => view.tiles[g].owner === owner);
                    return (
                      <tr key={houses} className={active ? 'ty-rent-active' : ''}>
                        <td>
                          {HOUSE_LABELS[houses]}
                          {houses === 0 ? <small> · ×2 khi trọn nhóm</small> : null}
                        </td>
                        <td>{formatMoney(groupBonus ? rent * 2 : rent)}</td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
              <div className="ty-sheet-row">
                <span>Nhà hiện có</span>
                <span className="ty-sheet-houses" aria-label={HOUSE_LABELS[state.houses]}>
                  {state.houses >= MAX_HOUSES ? <i className="ty-hotel ty-hotel-lg" /> : Array.from({ length: state.houses }, (_, i) => <i key={i} className="ty-house ty-house-lg" />)}
                  <small>{state.houses === 0 ? 'Chưa xây' : HOUSE_LABELS[state.houses]}</small>
                </span>
              </div>
            </>
          ) : tile.kind === 'station' ? (
            <table className="ty-rent-table">
              <tbody>
                {[1, 2, 3, 4].map((count) => {
                  const ownedCount = owner >= 0 ? tilesOfGroup('station').filter((g) => view.tiles[g].owner === owner).length : 0;
                  return (
                    <tr key={count} className={ownedCount === count ? 'ty-rent-active' : ''}>
                      <td>Sở hữu {count} bến</td>
                      <td>{formatMoney(STATION_RENT[count])}</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          ) : (
            <table className="ty-rent-table">
              <tbody>
                {[1, 2].map((count) => {
                  const ownedCount = owner >= 0 ? tilesOfGroup('utility').filter((g) => view.tiles[g].owner === owner).length : 0;
                  return (
                    <tr key={count} className={ownedCount === count ? 'ty-rent-active' : ''}>
                      <td>Sở hữu {count} tiện ích</td>
                      <td>{UTILITY_MULTIPLIER[count]} × xúc xắc</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          )}
          {owner >= 0 && owner !== you ? (
            <div className="ty-sheet-row ty-sheet-row-note">
              <span>Đáp vào lúc này phải trả</span>
              <strong className="ty-neg">{formatMoney(currentRent(view, idx, diceSum))}</strong>
            </div>
          ) : null}
        </>
      ) : (
        <p className="ty-sheet-desc">{specialDescription(idx)}</p>
      )}

      <div className="ty-sheet-actions">
        {canBuyHere ? (
          <>
            <button type="button" className="ty-btn ty-btn-paper" disabled={busy} onClick={() => { sendMove({ type: 'DECLINE' }); closeSheet(); }}>
              Bỏ qua
            </button>
            <button type="button" className="ty-btn ty-btn-gold" disabled={busy || myCash < (tile.price ?? 0)} onClick={() => { sendMove({ type: 'BUY' }); closeSheet(); }}>
              {myCash < (tile.price ?? 0) ? 'Thiếu tiền' : `Mua ${formatMoney(tile.price ?? 0)}`}
            </button>
          </>
        ) : null}
        {owner === you && tile.kind === 'street' && manageAllowed ? (
          <>
            <div className="ty-sheet-manage">
              <button type="button" className="ty-btn ty-btn-paper" disabled={busy || !sellHint?.ok || view.phase !== 'debt' && view.phase !== 'manage'} onClick={() => sendMove({ type: 'SELL_HOUSE', tile: idx })}>
                <TyIcon name="minus" size={18} className="ty-icon-coral" />
                Bán nhà (+{formatMoney((tile.houseCost ?? 0) / 2)})
              </button>
              <button type="button" className="ty-btn ty-btn-paper" disabled={busy || !buildHint?.ok || view.phase !== 'manage'} onClick={() => sendMove({ type: 'BUILD', tile: idx })}>
                <TyIcon name="plus" size={18} className="ty-icon-jade" />
                Xây ({formatMoney(tile.houseCost ?? 0)})
              </button>
            </div>
            {buildHint && !buildHint.ok && view.phase === 'manage' ? (
              <p className="ty-sheet-reason">
                <TyIcon name="warning" size={14} /> {buildHint.reason}
              </p>
            ) : null}
          </>
        ) : null}
      </div>
    </BottomSheet>
  );
}
