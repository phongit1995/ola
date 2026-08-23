import { useShallow } from 'zustand/react/shallow';
import { XqIcon } from '../components/XqIcon';
import { formatKen } from '../helpers/format';
import { PodAvatar } from '../components/PodAvatar';
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
    openBotSetup,
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
      openBotSetup: s.openBotSetup,
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
            <PodAvatar vipType={userInfo.vipType} tone="red" />
            <span className="xq-user-name">@{userInfo.username}</span>
          </div>
        ) : (
          <div />
        )}
        <div className="xq-topbar-right">
          {userInfo ? (
            <div className="xq-ken-badge">
              <XqIcon name="ken" size={18} />
              <span>{formatKen(ken)}</span>
            </div>
          ) : null}
          <button
            type="button"
            className="xq-icon-btn"
            onClick={toggleSound}
            aria-label={soundOn ? 'Tắt âm' : 'Bật âm'}
            aria-pressed={soundOn}
          >
            <XqIcon name={soundOn ? 'volume-on' : 'volume-off'} size={22} />
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
          <button type="button" className="xq-btn xq-btn-jade" onClick={openBotSetup}>
            Chơi với máy
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
              <button type="button" className="xq-btn xq-btn-jade" onClick={openBotSetup}>
                Chơi với máy
              </button>
            </>
          ) : (
            <>
              <p>Đang kết nối...</p>
              <button type="button" className="xq-btn xq-btn-paper" onClick={openBotSetup}>
                Chơi với máy trong lúc chờ
              </button>
            </>
          )}
        </div>
      )}

      <button type="button" className="xq-exit-link" onClick={exitGame}>
        Thoát game
      </button>
    </div>
  );
}
