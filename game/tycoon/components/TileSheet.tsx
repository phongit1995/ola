import { useState, type CSSProperties } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BOARD } from '../logic/board';
import { FESTIVAL_MULTIPLIER, GO_SALARY, JAIL_FINE, MAX_HOUSES, TAX_RATE } from '../logic/constants';
import { levelCost, takeoverPrice } from '../logic/engine';
import { buildPlan, canBuild, currentRent, sellPlan } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { BottomSheet } from './BottomSheet';
import { groupColor, GroupTag, RentLadder, SeatTag, TileThumb, type LadderPick } from './DeedParts';
import { MoneyBadge, UiButton, UiModal } from './Ui';
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

export function TileSheet({ idx }: { idx: number }) {
  const [want, setWant] = useState<number | null>(null);
  const { view, you, myTurn, movePending, replaying, cash, sendMove, sendMoves, closeSheet } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      you: s.you,
      myTurn: s.myTurn,
      movePending: s.movePending,
      replaying: s.replaying,
      cash: s.cash,
      sendMove: s.sendMove,
      sendMoves: s.sendMoves,
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
  const nextCost = street && state.houses < MAX_HOUSES ? levelCost(idx, state.houses + 1) : 0;
  const canBuyHere = myTurn && view.phase === 'decide' && me?.pos === idx && owner < 0;
  const manageAllowed = myTurn && owner === you && street && (view.phase === 'manage' || (view.phase === 'debt' && view.debt?.by === you));
  const buildHint = manageAllowed && view.phase === 'manage' ? canBuild(view, you, idx) : null;
  const canFestivalHere = myTurn && view.phase === 'festival' && owner === you && street;
  const canTravelHere = myTurn && view.phase === 'travel' && me?.pos !== idx;
  const passesGo = canTravelHere && me != null && idx < me.pos;
  const canUpgrade = buildHint != null && state.houses < MAX_HOUSES && buildPlan(view, you, idx, state.houses + 1) != null;
  const canDowngrade = manageAllowed && sellPlan(view, you, idx, state.houses - 1) != null;
  const selling = canDowngrade && want != null && want < state.houses;
  const target = selling ? (want ?? 0) : canUpgrade ? Math.min(MAX_HOUSES, Math.max(state.houses + 1, want ?? 0)) : state.houses;
  const plan = canUpgrade && !selling ? buildPlan(view, you, idx, target) : null;
  const sale = canDowngrade ? sellPlan(view, you, idx, selling ? target : state.houses - 1) : null;
  const short = plan ? Math.max(0, plan.cost - myCash) : 0;
  const pick: LadderPick | undefined =
    canUpgrade || canDowngrade ? { target, can: (houses) => houses !== state.houses && (houses > state.houses ? canUpgrade : canDowngrade), onPick: setWant, selling } : undefined;
  const run = (type: 'BUILD' | 'SELL_HOUSE', tiles: number[]) => {
    sendMoves(tiles.map((t) => ({ type, tile: t })));
    setWant(null);
    closeSheet();
  };
  const act = (move: Parameters<typeof sendMove>[0]) => {
    sendMove(move);
    closeSheet();
  };

  const upgradeHere = manageAllowed && view.phase === 'manage' && me?.pos === idx;
  const manageButtons = (
    <>
      <UiButton tone={selling ? 'red' : 'paper'} gain={sale?.cost} disabled={busy || !sale} onClick={() => sale && run('SELL_HOUSE', sale.tiles)}>
        Bán nhà
      </UiButton>
      <UiButton tone="gold" price={plan?.cost ?? nextCost} disabled={busy || !plan || short > 0} onClick={() => plan && run('BUILD', plan.tiles)} data-dialog-initial-focus>
        Nâng cấp
      </UiButton>
    </>
  );
  const manageReasons = (
    <>
      {plan && short > 0 ? <p className="ty-sheet-reason">Thiếu {formatMoney(short)}</p> : null}
      {!canUpgrade && buildHint && !buildHint.ok && !selling ? <p className="ty-sheet-reason">{buildHint.reason}</p> : null}
    </>
  );

  const footer =
    canBuyHere || canFestivalHere || canTravelHere || manageAllowed ? (
      <>
        {canBuyHere ? (
          <div className="ui-actions">
            <UiButton disabled={busy} onClick={() => act({ type: 'DECLINE' })}>
              Bỏ qua
            </UiButton>
            <UiButton tone="gold" price={price} disabled={busy || myCash < price} onClick={() => act({ type: 'BUY' })}>
              Mua
            </UiButton>
          </div>
        ) : null}
        {canFestivalHere ? (
          <UiButton tone="gold" block disabled={busy} onClick={() => act({ type: 'FESTIVAL', tile: idx })}>
            Mở Lễ hội · thuê {formatMoney(currentRent({ ...view, festival: idx }, idx))}
          </UiButton>
        ) : null}
        {canTravelHere ? (
          <UiButton tone="gold" block disabled={busy} onClick={() => act({ type: 'TRAVEL', tile: idx })}>
            Đi tới đây{passesGo ? ` · +${formatMoney(GO_SALARY)}` : ''}
          </UiButton>
        ) : null}
        {manageAllowed ? (
          <>
            <div className="ui-actions ty-manage-actions">{manageButtons}</div>
            {manageReasons}
          </>
        ) : null}
      </>
    ) : null;

  const ladder = property ? (
    <>
      {pick ? <p className="ty-ladder-hint">Chạm vào cấp muốn nâng lên hoặc bán xuống</p> : null}
      <RentLadder view={view} idx={idx} pick={pick} />
      <p className="ty-deed-facts">
        {street && (owner < 0 || owner === you) ? (
          <>
            <span>
              Nâng {levelCost(idx, 1)} · {levelCost(idx, 2)} · {formatMoney(levelCost(idx, 3))}
            </span>
            <span>Bán lại nửa giá nâng</span>
          </>
        ) : null}
        {street && owner >= 0 && state.houses < MAX_HOUSES ? (
          <span>
            {owner === you ? 'Người khác mua lại' : 'Mua lại'} {formatMoney(takeoverPrice(view, idx))}
          </span>
        ) : null}
        {street && owner >= 0 && state.houses >= MAX_HOUSES ? <span>Khách sạn không mua lại được</span> : null}
        {street && owner < 0 ? <span>Trọn nhóm thuê ×2</span> : null}
      </p>
    </>
  ) : null;
  const festivalNote = view.festival === idx ? <p className="ty-deed-note ty-deed-note-gold">Đang có Lễ hội · thuê ×{FESTIVAL_MULTIPLIER}</p> : null;

  if (upgradeHere) {
    return (
      <UiModal wide closable onClose={closeSheet} kicker={<GroupTag idx={idx} />} title={tile.name} icon={<TileThumb idx={idx} className="ty-buy-thumb" />} actions={manageButtons}>
        <div className="ty-upgrade" style={{ '--accent': groupColor(idx) } as CSSProperties}>
          {festivalNote}
          {ladder}
          {manageReasons}
        </div>
      </UiModal>
    );
  }

  return (
    <BottomSheet onClose={closeSheet} title={tile.name} accent={groupColor(idx)} footer={footer}>
      <header className="ty-deed-hero">
        <TileThumb idx={idx} className="ty-thumb-lg" />
        <span className="ty-deed-hero-copy">
          <GroupTag idx={idx} />
          <h2 className="ui-title">{tile.name}</h2>
          {property ? owner >= 0 ? <SeatTag seat={owner} /> : <MoneyBadge amount={price} className="ty-deed-price" /> : null}
        </span>
      </header>

      {festivalNote}

      {property && owner >= 0 && owner !== you ? (
        <p className="ty-deed-note ty-deed-note-coral">
          Đáp vào phải trả <b>{formatMoney(currentRent(view, idx))}</b>
        </p>
      ) : null}

      {property ? (
        ladder
      ) : (
        <p className="ty-deed-desc">{specialDescription(idx)}</p>
      )}
    </BottomSheet>
  );
}
