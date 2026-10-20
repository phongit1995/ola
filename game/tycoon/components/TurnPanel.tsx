import { useShallow } from 'zustand/react/shallow';
import { BOARD, cardById, GROUP_LABEL } from '../logic/board';
import { FESTIVAL_MULTIPLIER, JAIL_FINE, JAIL_MAX_TURNS, TAKEOVER_MULTIPLIER, TURN_SECONDS } from '../logic/constants';
import { computeRent, takeoverPrice } from '../logic/engine';
import { hasAnyFullGroup } from '../logic/rules-hint';
import { formatMoney } from '../helpers/format';
import { SEAT_SOFT_COLORS, seatColor } from '../helpers/player';
import { baseRentText, groupProgress, shortName } from '../helpers/tiles';
import { PodAvatar } from './PodAvatar';
import { glyphForTile, TileGlyph } from './TileGlyph';
import { TyIcon } from './TyIcon';
import { useTycoon } from '../store/useTycoon';

const OTHER_PHASE: Record<string, string> = {
  roll: 'đang gieo xúc xắc',
  jail: 'đang tìm cách ra tù',
  decide: 'đang cân nhắc mua đất',
  takeover: 'đang cân nhắc mua lại đất',
  festival: 'đang chọn nơi tổ chức Lễ hội',
  travel: 'đang chọn điểm du lịch',
  card: 'đang đọc thẻ',
  manage: 'đang tính nước đi',
  debt: 'đang xoay tiền trả nợ',
};

function TimerRing({ leftMs }: { leftMs: number }) {
  const seconds = Math.max(0, Math.ceil(leftMs / 1000));
  const ratio = Math.max(0, Math.min(1, leftMs / (TURN_SECONDS * 1000)));
  const circumference = 2 * Math.PI * 17;
  const urgent = seconds <= 10;
  return (
    <span className={`ty-timer ${urgent ? 'ty-timer-urgent' : ''}`} role="timer" aria-label={`Còn ${seconds} giây`}>
      <svg viewBox="0 0 40 40" aria-hidden="true">
        <circle cx="20" cy="20" r="17" className="ty-timer-track" />
        <circle cx="20" cy="20" r="17" className="ty-timer-fill" strokeDasharray={circumference} strokeDashoffset={circumference * (1 - ratio)} />
      </svg>
      <b>{seconds}</b>
    </span>
  );
}

function DeedPreview({ idx, onOpen }: { idx: number; onOpen: () => void }) {
  const { tiles, you } = useTycoon(useShallow((s) => ({ tiles: s.tiles, you: s.you })));
  const tile = BOARD[idx];
  const progress = groupProgress(tiles, you, idx);
  const glyph = glyphForTile(tile.kind);
  return (
    <button type="button" className="ty-deed" onClick={onOpen} aria-label={`Xem chi tiết ${tile.name}`}>
      <span className={`ty-deed-stripe ${tile.kind === 'street' && tile.group ? `ty-band-${tile.group}` : 'ty-deed-stripe-dim'}`} aria-hidden="true" />
      <span className="ty-deed-main">
        <span className="ty-deed-title">
          {glyph ? <TileGlyph name={glyph} size={18} /> : null}
          <strong>{tile.name}</strong>
        </span>
        <span className="ty-deed-stats">
          <span>
            <small>Giá</small>
            <b>{formatMoney(tile.price ?? 0)}</b>
          </span>
          <span>
            <small>Thuê</small>
            <b>{baseRentText(idx)}</b>
          </span>
          <span>
            <small>{tile.group ? GROUP_LABEL[tile.group] : 'Nhóm'}</small>
            <b>
              {progress ? `${progress.owned}/${progress.total}` : '—'}
              <em> của bạn</em>
            </b>
          </span>
        </span>
      </span>
      <TyIcon name="chevron-right" size={16} className="ty-deed-more" />
    </button>
  );
}

function MyActions() {
  const { view, you, movePending, replaying, cash, sendMove, openSheet } = useTycoon(
    useShallow((s) => ({ view: s.view, you: s.you, movePending: s.movePending, replaying: s.replaying, cash: s.cash, sendMove: s.sendMove, openSheet: s.openSheet })),
  );
  if (!view) return null;
  const me = view.players[you];
  const busy = movePending || replaying;
  const myCash = cash[you] ?? me.cash;
  switch (view.phase) {
    case 'roll':
      return (
        <div className="ty-actions">
          <button type="button" className="ty-btn ty-btn-gold ty-btn-wide ty-btn-cta" disabled={busy} onClick={() => sendMove({ type: 'ROLL' })}>
            <TyIcon name="dice" size={22} />
            {me.doubles > 0 ? 'Gieo thêm lượt (đôi!)' : 'Gieo xúc xắc'}
          </button>
        </div>
      );
    case 'jail':
      return (
        <div className="ty-actions ty-actions-3">
          <button type="button" className="ty-btn ty-btn-gold ty-btn-stack" disabled={busy} onClick={() => sendMove({ type: 'JAIL_ROLL' })}>
            <TyIcon name="dice" size={20} />
            <span>Gieo đôi</span>
            <small>
              lần {me.jailTurns + 1}/{JAIL_MAX_TURNS}
            </small>
          </button>
          <button type="button" className="ty-btn ty-btn-paper ty-btn-stack" disabled={busy || myCash < JAIL_FINE} onClick={() => sendMove({ type: 'JAIL_PAY' })}>
            <TyIcon name="coins" size={20} />
            <span>Nộp phạt</span>
            <small>{formatMoney(JAIL_FINE)}</small>
          </button>
          <button type="button" className="ty-btn ty-btn-paper ty-btn-stack" disabled={busy || me.jailCards <= 0} onClick={() => sendMove({ type: 'JAIL_CARD' })}>
            <TyIcon name="key" size={20} />
            <span>Dùng thẻ</span>
            <small>còn {me.jailCards}</small>
          </button>
        </div>
      );
    case 'decide': {
      const tile = BOARD[me.pos];
      const price = tile.price ?? 0;
      const affordable = myCash >= price;
      return (
        <>
          <DeedPreview idx={me.pos} onOpen={() => openSheet({ kind: 'tile', idx: me.pos })} />
          <div className="ty-actions ty-actions-decide">
            <button type="button" className="ty-btn ty-btn-paper" disabled={busy} onClick={() => sendMove({ type: 'DECLINE' })}>
              Bỏ qua
            </button>
            <button type="button" className="ty-btn ty-btn-gold ty-btn-cta" disabled={busy || !affordable} onClick={() => sendMove({ type: 'BUY' })}>
              <TyIcon name="deed" size={20} />
              <span className="ty-btn-lines">
                <span>{affordable ? `Mua ${formatMoney(price)}` : 'Không đủ tiền'}</span>
                <small>{affordable ? `còn lại ${formatMoney(myCash - price)}` : `cần ${formatMoney(price)}`}</small>
              </span>
            </button>
          </div>
        </>
      );
    }
    case 'takeover': {
      const price = takeoverPrice(view, me.pos);
      const affordable = myCash >= price;
      return (
        <>
          <DeedPreview idx={me.pos} onOpen={() => openSheet({ kind: 'tile', idx: me.pos })} />
          <div className="ty-actions ty-actions-decide">
            <button type="button" className="ty-btn ty-btn-paper" disabled={busy} onClick={() => sendMove({ type: 'DECLINE' })}>
              Bỏ qua
            </button>
            <button type="button" className="ty-btn ty-btn-gold ty-btn-cta" disabled={busy || !affordable} onClick={() => sendMove({ type: 'TAKEOVER' })}>
              <TyIcon name="deed" size={20} />
              <span className="ty-btn-lines">
                <span>{affordable ? `Mua lại ${formatMoney(price)}` : 'Không đủ tiền'}</span>
                <small>{affordable ? `còn lại ${formatMoney(myCash - price)}` : `cần ${formatMoney(price)}`}</small>
              </span>
            </button>
          </div>
        </>
      );
    }
    case 'festival': {
      const mine = BOARD.filter((tile) => tile.kind === 'street' && view.tiles[tile.idx].owner === you);
      return (
        <>
          <div className="ty-festival-picks">
            {mine.map((tile) => (
              <button
                key={tile.idx}
                type="button"
                className={`ty-btn ty-btn-paper ty-btn-stack ${view.festival === tile.idx ? 'ty-festival-current' : ''}`}
                disabled={busy}
                onClick={() => sendMove({ type: 'FESTIVAL', tile: tile.idx })}
              >
                <span>{shortName(tile.idx)}</span>
                <small>thuê {formatMoney(computeRent({ ...view, festival: -1 }, tile.idx, you) * FESTIVAL_MULTIPLIER)}</small>
              </button>
            ))}
          </div>
          <div className="ty-actions">
            <button type="button" className="ty-btn ty-btn-paper ty-btn-wide" disabled={busy} onClick={() => sendMove({ type: 'DECLINE' })}>
              Bỏ qua
            </button>
          </div>
        </>
      );
    }
    case 'travel':
      return (
        <div className="ty-actions">
          <button type="button" className="ty-btn ty-btn-paper ty-btn-wide" disabled={busy} onClick={() => sendMove({ type: 'ROLL' })}>
            <TyIcon name="dice" size={20} />
            Không bay, gieo xúc xắc
          </button>
        </div>
      );
    case 'card':
      return (
        <div className="ty-actions">
          <button type="button" className="ty-btn ty-btn-gold ty-btn-wide ty-btn-cta" disabled={busy} onClick={() => sendMove({ type: 'CARD_ACK' })}>
            Làm theo thẻ
          </button>
        </div>
      );
    case 'manage': {
      const canManage = hasAnyFullGroup(view, you);
      const again = me.doubles > 0 && !me.inJail;
      return (
        <div className={`ty-actions ${canManage ? 'ty-actions-decide' : ''}`}>
          {canManage ? (
            <button type="button" className="ty-btn ty-btn-paper" disabled={busy} onClick={() => openSheet({ kind: 'assets', seat: you })}>
              <TyIcon name="house" size={18} />
              Nâng cấp
            </button>
          ) : null}
          <button type="button" className={`ty-btn ty-btn-gold ty-btn-cta ${canManage ? '' : 'ty-btn-wide'}`} disabled={busy} onClick={() => sendMove({ type: 'END_TURN' })}>
            {again ? (
              <>
                <TyIcon name="dice" size={20} />
                Gieo tiếp (đôi!)
              </>
            ) : (
              <>
                Kết thúc lượt
                <TyIcon name="chevron-right" size={18} />
              </>
            )}
          </button>
        </div>
      );
    }
    case 'debt':
      return (
        <p className="ty-panel-alert">
          <TyIcon name="warning" size={16} />
          Bạn đang nợ {formatMoney(view.debt?.amount ?? 0)} — xử lý trong hộp thoại
        </p>
      );
    default:
      return null;
  }
}

function myPrompt(phase: string, pos: number, jailTurns: number, cardId: string | undefined): string {
  switch (phase) {
    case 'roll':
      return 'Gieo xúc xắc để đi tiếp';
    case 'jail':
      return `Bạn đang ngồi tù · lượt ${jailTurns + 1}/${JAIL_MAX_TURNS}`;
    case 'decide':
      return `Đáp vào ${BOARD[pos].name} — chưa có chủ`;
    case 'takeover':
      return `Đã trả thuê — có thể mua lại ${BOARD[pos].name} với giá ×${TAKEOVER_MULTIPLIER}`;
    case 'festival':
      return `Chọn thành phố tổ chức Lễ hội — thuê ×${FESTIVAL_MULTIPLIER}`;
    case 'travel':
      return 'Du lịch — chạm vào ô bất kỳ trên bàn để bay tới';
    case 'card':
      return cardId ? cardById(cardId)?.text ?? 'Bạn rút được một thẻ' : 'Bạn rút được một thẻ';
    case 'manage':
      return `Đang đứng ở ${BOARD[pos].name}`;
    case 'debt':
      return 'Thiếu tiền — cần bán nhà để trả';
    default:
      return '';
  }
}

export function TurnPanel() {
  const { view, players, you, myTurn, replaying, turnExpired, timerLeftMs, deadline, result } = useTycoon(
    useShallow((s) => ({
      view: s.view,
      players: s.players,
      you: s.you,
      myTurn: s.myTurn,
      replaying: s.replaying,
      turnExpired: s.turnExpired,
      timerLeftMs: s.timerLeftMs,
      deadline: s.deadline,
      result: s.result,
    })),
  );
  if (!view || result) return null;
  const turn = view.turn;
  const turnInfo = players[turn];
  const me = view.players[you];
  const mine = myTurn && !me?.bankrupt;
  const showTimer = mine && deadline > 0 && !replaying;
  const title = mine ? 'Lượt của bạn' : `Lượt của ${turnInfo?.name ?? '?'}`;
  const subtitle = mine ? myPrompt(view.phase, me.pos, me.jailTurns, view.card?.id) : replaying ? 'đang di chuyển…' : `${OTHER_PHASE[view.phase] ?? ''}…`;

  return (
    <section
      className={`ty-panel ${mine ? 'ty-panel-mine' : ''}`}
      style={{ '--seat': seatColor(turn), '--seat-soft': SEAT_SOFT_COLORS[turn] } as React.CSSProperties}
      aria-live="polite"
    >
      <header className="ty-panel-head">
        <PodAvatar src={turnInfo?.avatar} seat={turn} size={36} />
        <span className="ty-panel-copy">
          <strong>{title}</strong>
          <span>{subtitle}</span>
        </span>
        {showTimer ? (
          <TimerRing leftMs={timerLeftMs} />
        ) : !mine ? (
          <span className="ty-thinking" aria-hidden="true">
            <i />
            <i />
            <i />
          </span>
        ) : null}
      </header>
      {mine ? (
        turnExpired ? (
          <p className="ty-panel-alert">
            <TyIcon name="warning" size={16} />
            Hết giờ, hệ thống đang đi thay bạn…
          </p>
        ) : (
          <MyActions />
        )
      ) : null}
    </section>
  );
}

export function GameLog() {
  const { log, openSheet } = useTycoon(useShallow((s) => ({ log: s.log, openSheet: s.openSheet })));
  const recent = log.slice(-8).reverse();
  return (
    <button type="button" className="ty-log" aria-label="Xem toàn bộ diễn biến" onClick={() => openSheet({ kind: 'log' })}>
      <span className="ty-log-head">
        <TyIcon name="history" size={14} />
        Diễn biến
        <span className="ty-log-all">
          Xem tất cả
          <TyIcon name="chevron-right" size={14} />
        </span>
      </span>
      <span className="ty-log-lines">
        {recent.length === 0 ? <span className="ty-log-line ty-log-neutral">Ván mới bắt đầu — chúc may mắn!</span> : null}
        {recent.map((line) => (
          <span key={line.seq} className={`ty-log-line ty-log-${line.tone}`}>
            {line.text}
          </span>
        ))}
      </span>
    </button>
  );
}
