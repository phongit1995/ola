import { useShallow } from 'zustand/react/shallow';
import { assetBg } from '../../../assets';
import { formatKen } from '../../../helpers/format';
import { useCaro } from '../../../store/useCaro';

function RoomOwnerIcon() {
  return (
    <span className="room-owner-icon" role="img" aria-label="Chủ phòng" title="Chủ phòng">
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <path d="M4 8l4.2 3.2L12 5l3.8 6.2L20 8l-1.5 9h-13L4 8Z" />
        <path d="M6 19h12" />
      </svg>
    </span>
  );
}

export function BoardHeader() {
  const {
    me,
    op,
    status,
    myTurn,
    showTimer,
    timerText,
    timerUrgent,
    turnArrowSrc,
    matchSeq,
    betDeductionVisible,
    boardMode,
    roomWaiting,
    bet,
    result,
    replayVisible,
  } = useCaro(
    useShallow((state) => ({
      me: state.me,
      op: state.op,
      status: state.status,
      myTurn: state.myTurn,
      showTimer: state.showTimer,
      timerText: state.timerText,
      timerUrgent: state.timerUrgent,
      turnArrowSrc: state.turnArrowSrc,
      matchSeq: state.matchSeq,
      betDeductionVisible: state.betDeductionVisible,
      boardMode: state.boardMode,
      roomWaiting: state.roomWaiting,
      bet: state.bet,
      result: state.result,
      replayVisible: state.replayVisible,
    })),
  );
  const pregame = boardMode === 'pregame';
  const playing = boardMode === 'playing';
  const meInRoom = roomWaiting?.members.find((member) => member.id === roomWaiting.youId);
  const opponentInRoom = roomWaiting?.members.find((member) => member.id !== roomWaiting.youId);
  const betText = formatKen(bet);
  const showBetDeduction = playing && result == null && betDeductionVisible;
  const winnerPayoutText = result?.winnerPayout != null ? formatKen(result.winnerPayout) : '';
  const showWinnerPayout = result?.winnerPayout != null && result.winnerPayout > 0 && !replayVisible;

  return (
    <header id="topbar">
      <div className={'player' + (op.active ? ' active' : '')} id="player-op">
        <div className="player-avatar">
          <div className="p-avatar" style={assetBg('boardAvatarFrame')}>
            <img className="p-vip" src={op.vip} alt="" />
          </div>
          {op.owner && <RoomOwnerIcon />}
          {showBetDeduction && (
            <span key={`op-bet-${matchSeq}`} className="player-ken-change debit">
              -{betText} KEN
            </span>
          )}
          {showWinnerPayout && result != null && !result.win && (
            <span key={`op-payout-${result.matchId}`} className="player-ken-change credit">
              +{winnerPayoutText} KEN
            </span>
          )}
        </div>
        <div className="name-row">
          <span className="name">{op.name}</span>
          {playing && <span className={`mark ${op.mark}`}>{op.mark === 'x' ? 'X' : 'O'}</span>}
        </div>
        {pregame && opponentInRoom && !opponentInRoom.owner && (
          <span className={'room-ready-state' + (opponentInRoom.ready ? ' ready' : '')}>
            {opponentInRoom.ready ? 'Sẵn sàng' : 'Chưa sẵn sàng'}
          </span>
        )}
      </div>

      <div id="center">
        <div
          id="timer"
          className={[showTimer ? '' : 'hidden', myTurn ? 'mine' : 'opponent', timerUrgent ? 'urgent' : '']
            .filter(Boolean)
            .join(' ')}
          style={assetBg(myTurn ? 'boardTimerFrameMine' : 'boardTimerFrame')}
        >
          <span id="timer-val">{timerText}</span>
        </div>
        <img id="turn-arrow" className={turnArrowSrc ? '' : 'hidden'} src={turnArrowSrc ?? undefined} alt="" />
        {!pregame && <div id="status">{status}</div>}
      </div>

      <div className={'player right' + (me.active ? ' active' : '')} id="player-me">
        <div className="player-avatar">
          <div className="p-avatar" style={assetBg('boardAvatarFrame')}>
            <img className="p-vip" src={me.vip} alt="" />
          </div>
          {me.owner && <RoomOwnerIcon />}
          {showBetDeduction && (
            <span key={`me-bet-${matchSeq}`} className="player-ken-change debit">
              -{betText} KEN
            </span>
          )}
          {showWinnerPayout && result != null && result.win && (
            <span key={`me-payout-${result.matchId}`} className="player-ken-change credit">
              +{winnerPayoutText} KEN
            </span>
          )}
        </div>
        <div className="name-row">
          <span className="name">{me.name}</span>
          {playing && <span className={`mark ${me.mark}`}>{me.mark === 'x' ? 'X' : 'O'}</span>}
        </div>
        {pregame && meInRoom && !meInRoom.owner && (
          <span className={'room-ready-state' + (meInRoom.ready ? ' ready' : '')}>
            {meInRoom.ready ? 'Sẵn sàng' : 'Chưa sẵn sàng'}
          </span>
        )}
      </div>
    </header>
  );
}
