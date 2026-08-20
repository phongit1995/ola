import { useShallow } from 'zustand/react/shallow';
import { formatKen } from '../helpers/format';
import { useXiangqi } from '../store/useXiangqi';

export function LobbyScreen() {
  const {
    lobbyPhase,
    lobbyError,
    userInfo,
    ken,
    soundOn,
    toggleSound,
    retryConnect,
    playRanked,
    showHistory,
    showLeaderboard,
    exitGame,
  } = useXiangqi(
    useShallow((s) => ({
      lobbyPhase: s.lobbyPhase,
      lobbyError: s.lobbyError,
      userInfo: s.userInfo,
      ken: s.ken,
      soundOn: s.soundOn,
      toggleSound: s.toggleSound,
      retryConnect: s.retryConnect,
      playRanked: s.playRanked,
      showHistory: s.showHistory,
      showLeaderboard: s.showLeaderboard,
      exitGame: s.exitGame,
    })),
  );

  return (
    <div className="xq-screen xq-lobby">
      <div className="xq-topbar">
        {userInfo ? (
          <div className="xq-user">
            <div className="xq-pod-avatar xq-pod-avatar-red">{userInfo.username.slice(0, 1).toUpperCase()}</div>
            <span className="xq-user-name">{userInfo.username}</span>
          </div>
        ) : (
          <div />
        )}
        <div className="xq-topbar-right">
          {userInfo ? <div className="xq-ken-badge">⛁ {formatKen(ken)}</div> : null}
          <button type="button" className="xq-icon-btn" onClick={toggleSound} aria-label={soundOn ? 'Tắt âm' : 'Bật âm'}>
            {soundOn ? '🔊' : '🔇'}
          </button>
        </div>
      </div>

      <div className="xq-logo">
        <div className="xq-logo-pieces">
          <span className="xq-logo-piece xq-piece-red">帥</span>
          <span className="xq-logo-piece xq-piece-black">將</span>
        </div>
        <h1 className="xq-logo-title">CỜ TƯỚNG</h1>
      </div>

      {lobbyPhase === 'ready' ? (
        <div className="xq-cta-stack">
          <button type="button" className="xq-btn xq-btn-gold xq-btn-big" onClick={playRanked}>
            Chơi xếp hạng
          </button>
          <button type="button" className="xq-btn xq-btn-paper" onClick={showHistory}>
            Lịch sử
          </button>
          <button type="button" className="xq-btn xq-btn-paper" onClick={showLeaderboard}>
            Bảng xếp hạng
          </button>
        </div>
      ) : (
        <div className="xq-lobby-status" role="status">
          {lobbyPhase === 'error' ? (
            <>
              <p className="xq-lobby-error">{lobbyError}</p>
              <button type="button" className="xq-btn xq-btn-gold" onClick={retryConnect}>
                Thử lại
              </button>
            </>
          ) : (
            <p>Đang kết nối...</p>
          )}
        </div>
      )}

      <button type="button" className="xq-exit-link" onClick={exitGame}>
        Thoát game
      </button>
    </div>
  );
}
