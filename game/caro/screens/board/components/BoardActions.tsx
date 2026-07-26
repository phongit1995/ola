import { useEffect } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { ConfirmModal } from '../../../components/ConfirmModal';
import { assetBg, assetSrc } from '../../../assets';
import { useCaro } from '../../../store/useCaro';
import { useBoard } from '../useBoard';

export function BoardActions() {
  const { exitOpen, forfeitOpen, setExitOpen, setForfeitOpen, closeDialogs } = useBoard(
    useShallow((state) => ({
      exitOpen: state.exitOpen,
      forfeitOpen: state.forfeitOpen,
      setExitOpen: state.setExitOpen,
      setForfeitOpen: state.setForfeitOpen,
      closeDialogs: state.closeDialogs,
    })),
  );
  const {
    boardMode,
    roomWaiting,
    roomActionPending,
    result,
    replayVisible,
    forfeitDisabled,
    cancelRoom,
    kickRoomGuest,
    replay,
    forfeit,
    exitMatch,
  } = useCaro(
    useShallow((state) => ({
      boardMode: state.boardMode,
      roomWaiting: state.roomWaiting,
      roomActionPending: state.roomActionPending,
      result: state.result,
      replayVisible: state.replayVisible,
      forfeitDisabled: state.forfeitDisabled,
      cancelRoom: state.cancelRoom,
      kickRoomGuest: state.kickRoomGuest,
      replay: state.replay,
      forfeit: state.forfeit,
      exitMatch: state.exitMatch,
    })),
  );
  const pregame = boardMode === 'pregame';
  const playing = boardMode === 'playing';
  const opponentInRoom = roomWaiting?.members.find((member) => member.id !== roomWaiting.youId);
  const isRoomOwner = roomWaiting != null && roomWaiting.ownerId === roomWaiting.youId;
  const roomBusy = roomActionPending != null;

  useEffect(() => {
    if (!playing) setForfeitOpen(false);
  }, [playing, setForfeitOpen]);

  useEffect(() => {
    if (!result) return;
    closeDialogs();
  }, [closeDialogs, result]);

  useEffect(() => {
    if (boardMode === 'idle') setExitOpen(false);
  }, [boardMode, setExitOpen]);

  return (
    <>
      <footer id="bottombar" className={pregame ? 'pregame' : ''}>
        {pregame ? (
          <>
            {isRoomOwner && opponentInRoom && (
              <button type="button" style={assetBg('boardMenuBtn')} disabled={roomBusy} onClick={kickRoomGuest}>
                Mời ra
              </button>
            )}
            <button
              type="button"
              id="btn-exit"
              className="board-action-btn"
              style={assetBg('boardMenuBtn')}
              disabled={roomBusy || !roomWaiting}
              onClick={() => setExitOpen(true)}
            >
              <img className="board-action-icon" src={assetSrc('icExit')} alt="" />
              <span>Thoát bàn</span>
            </button>
          </>
        ) : (
          <>
            <button
              type="button"
              id="btn-replay"
              className={replayVisible ? '' : 'hidden'}
              style={assetBg('boardMenuBtn')}
              disabled={result != null}
              onClick={replay}
            >
              Chơi lại
            </button>
            <button
              type="button"
              id="btn-forfeit"
              className="board-action-btn"
              style={assetBg('boardMenuBtn')}
              disabled={forfeitDisabled}
              onClick={() => setForfeitOpen(true)}
            >
              <img className="board-action-icon" src={assetSrc('boardForfeitIcon')} alt="" />
              <span>Bỏ cuộc</span>
            </button>
            <button
              type="button"
              id="btn-exit"
              className="board-action-btn"
              style={assetBg('boardMenuBtn')}
              disabled={result != null}
              onClick={() => setExitOpen(true)}
            >
              <img className="board-action-icon" src={assetSrc('icExit')} alt="" />
              <span>Thoát</span>
            </button>
          </>
        )}
      </footer>

      <ConfirmModal
        open={exitOpen}
        text={
          pregame
            ? isRoomOwner
              ? 'Thoát bàn sẽ đóng phòng. Thoát chứ?'
              : 'Bạn sẽ rời bàn; chủ phòng vẫn ở lại. Thoát chứ?'
            : 'Thoát sẽ bị xử thua và rời bàn. Thoát chứ?'
        }
        onConfirm={() => {
          setExitOpen(false);
          if (pregame) cancelRoom();
          else exitMatch();
        }}
        onCancel={() => setExitOpen(false)}
      />
      <ConfirmModal
        open={forfeitOpen}
        icon="boardForfeitIcon"
        text="Bạn sẽ bị xử thua ván này. Cả hai vẫn ở lại bàn để chơi ván tiếp theo."
        confirmLabel="Bỏ cuộc"
        cancelLabel="Tiếp tục"
        onConfirm={() => {
          setForfeitOpen(false);
          forfeit();
        }}
        onCancel={() => setForfeitOpen(false)}
      />
    </>
  );
}
