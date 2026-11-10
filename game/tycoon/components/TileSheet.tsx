import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { FESTIVAL_MULTIPLIER, GO_SALARY, JAIL_FINE, MAX_HOUSES, TAKEOVER_MULTIPLIER, TAX_RATE } from '../logic/constants';
import { takeoverPrice } from '../logic/engine';
import { canBuild, canSell, currentRent } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { BottomSheet } from './BottomSheet';
import { groupColor, GroupTag, HotelIcon, HouseIcon, rentLadder, SeatTag, TileThumb } from './DeedParts';
import { TyIcon } from './TyIcon';
import { useTycoon } from '../store/useTycoon';

function specialDescription(idx: number): string {
  switch (BOARD[idx].kind) {
    case 'go':
      return `Nhận ${GO_SALARY} tr mỗi lần đi qua hoặc đáp vào.`;
    case 'jail':
      return `Đáp vào chỉ là ghé thăm. Bị bắt vào tù thì gieo đôi, nộp ${JAIL_FINE} tr hoặc dùng thẻ để ra.`;
    case 'festival':
      return `Chọn một thành phố của bạn để tổ chức Lễ hội: tiền thuê ô đó ×${FESTIVAL_MULTIPLIER}. Cả bàn chỉ có một Lễ hội, người sau tổ chức thì Lễ hội chuyển đi.`;
    case 'travel':
      return 'Lượt sau được bay tới bất kỳ ô nào thay vì gieo xúc xắc. Bay qua Xuất phát vẫn nhận lương.';
    case 'chance':
      return 'Rút một thẻ Cơ hội: có thể được tiền, mất tiền hoặc phải di chuyển.';
    case 'chest':
      return 'Rút một thẻ Khí vận: thường là tiền vào, đôi khi mất tiền.';
    case 'tax':
      return `Đóng ${TAX_RATE * 100}% tổng tài sản (tiền mặt + giá đất + tiền nâng cấp) cho ngân hàng.`;
    default:
      return '';
  }
}

function StepIcon({ houses }: { houses: number }) {
  if (houses >= MAX_HOUSES) return <HotelIcon />;
  if (houses === 0) return <i className="ty-ladder-lot" />;
  return (
    <>
      {Array.from({ length: houses }, (_, i) => (
        <HouseIcon key={i} />
      ))}
    </>
  );
}

export function TileSheet({ idx }: { idx: number }) {
  const { view, you, myTurn, movePending, replaying, cash, sendMove, closeSheet } = useTycoon(
    useShallow((s) => ({
      view: s.view,
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
  const street = tile.kind === 'street';
  const property = street || tile.kind === 'station';
  const price = tile.price ?? 0;
  const houseCost = tile.houseCost ?? 0;
  const canBuyHere = myTurn && view.phase === 'decide' && me?.pos === idx && owner < 0;
  const manageAllowed = myTurn && owner === you && street && (view.phase === 'manage' || (view.phase === 'debt' && view.debt?.by === you));
  const buildHint = manageAllowed && view.phase === 'manage' ? canBuild(view, you, idx) : null;
  const sellHint = manageAllowed ? canSell(view, you, idx) : null;
  const canFestivalHere = myTurn && view.phase === 'festival' && owner === you && street;
  const canTravelHere = myTurn && view.phase === 'travel' && me?.pos !== idx;
  const passesGo = canTravelHere && me != null && idx < me.pos;
  const act = (move: Parameters<typeof sendMove>[0]) => {
    sendMove(move);
    closeSheet();
  };

  const footer =
    canBuyHere || canFestivalHere || canTravelHere || manageAllowed ? (
      <>
        {canBuyHere ? (
          <div className="ty-sheet-pair">
            <button type="button" className="ty-s6-ghost" disabled={busy} onClick={() => act({ type: 'DECLINE' })}>
              Bỏ qua
            </button>
            <button type="button" className="ty-s6-cta" disabled={busy || myCash < price} onClick={() => act({ type: 'BUY' })}>
              Mua {formatMoney(price)}
              <small>{myCash < price ? `cần thêm ${formatMoney(price - myCash)}` : `còn lại ${formatMoney(myCash - price)}`}</small>
            </button>
          </div>
        ) : null}
        {canFestivalHere ? (
          <button type="button" className="ty-s6-cta ty-s6-wide" disabled={busy} onClick={() => act({ type: 'FESTIVAL', tile: idx })}>
            Tổ chức Lễ hội ở đây
            <small>
              thuê {formatMoney(currentRent({ ...view, festival: -1 }, idx))} → {formatMoney(currentRent({ ...view, festival: idx }, idx))}
            </small>
          </button>
        ) : null}
        {canTravelHere ? (
          <button type="button" className="ty-s6-cta ty-s6-wide" disabled={busy} onClick={() => act({ type: 'TRAVEL', tile: idx })}>
            Bay tới đây
            {passesGo ? <small>qua Xuất phát +{GO_SALARY} tr</small> : null}
          </button>
        ) : null}
        {manageAllowed ? (
          <>
            <div className="ty-sheet-pair">
              <button type="button" className="ty-s6-ghost" disabled={busy || !sellHint?.ok} onClick={() => sendMove({ type: 'SELL_HOUSE', tile: idx })}>
                Hạ cấp
                <small>+{formatMoney(houseCost / 2)}</small>
              </button>
              <button type="button" className="ty-s6-cta" disabled={busy || !buildHint?.ok} onClick={() => sendMove({ type: 'BUILD', tile: idx })}>
                Nâng cấp
                <small>{formatMoney(houseCost)}</small>
              </button>
            </div>
            {buildHint && !buildHint.ok ? (
              <p className="ty-sheet-reason">
                <TyIcon name="warning" size={14} /> {buildHint.reason}
              </p>
            ) : null}
          </>
        ) : null}
      </>
    ) : null;

  return (
    <BottomSheet onClose={closeSheet} title={tile.name} accent={groupColor(idx)} footer={footer}>
      <header className="ty-deed-hero">
        <TileThumb idx={idx} className="ty-thumb-lg" />
        <span className="ty-deed-hero-copy">
          <GroupTag idx={idx} />
          <h2 className="ty-sheet-title">{tile.name}</h2>
          {property ? owner >= 0 ? <SeatTag seat={owner} /> : <span className="ty-deed-free">Chưa có chủ · giá {formatMoney(price)}</span> : null}
        </span>
      </header>

      {view.festival === idx ? (
        <p className="ty-deed-note ty-deed-note-gold">
          <b>★ Đang có Lễ hội</b> thuê ×{FESTIVAL_MULTIPLIER}
        </p>
      ) : null}

      {property && owner >= 0 && owner !== you ? (
        <p className="ty-deed-note ty-deed-note-coral">
          Đáp vào lúc này phải trả <b>{formatMoney(currentRent(view, idx))}</b>
        </p>
      ) : null}

      {property ? (
        <>
          <ol className="ty-ladder" aria-label="Tiền thuê theo cấp">
            {rentLadder(view, idx).map((step) => (
              <li key={step.label} className={step.active ? 'ty-ladder-on' : undefined}>
                <span className="ty-ladder-icon">{street ? <StepIcon houses={step.houses} /> : <b>{step.label.split(' ')[0]}</b>}</span>
                <span className="ty-ladder-label">{street ? step.label : 'sân bay'}</span>
                <strong>{step.rent} tr</strong>
                {step.note ? <small>{step.note}</small> : null}
              </li>
            ))}
          </ol>
          <dl className="ty-deed-facts">
            <div>
              <dt>Giá đất</dt>
              <dd>{formatMoney(price)}</dd>
            </div>
            {street ? (
              <>
                <div>
                  <dt>Nâng mỗi cấp</dt>
                  <dd>{formatMoney(houseCost)}</dd>
                </div>
                <div>
                  <dt>Hạ cấp thu về</dt>
                  <dd>{formatMoney(houseCost / 2)}</dd>
                </div>
              </>
            ) : null}
            {street && owner >= 0 && state.houses < MAX_HOUSES ? (
              <div>
                <dt>Mua lại ×{TAKEOVER_MULTIPLIER}</dt>
                <dd>{formatMoney(takeoverPrice(view, idx))}</dd>
              </div>
            ) : null}
          </dl>
        </>
      ) : (
        <p className="ty-deed-desc">{specialDescription(idx)}</p>
      )}
    </BottomSheet>
  );
}
