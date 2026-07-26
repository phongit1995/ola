import { useLayoutEffect } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { ConfirmModal } from '../../components/ConfirmModal';
import { assetBg, assetSrc } from '../../assets';
import { formatKen } from '../../helpers/format';
import { avatarIconSrc } from '../../helpers/player';
import { useCaro } from '../../store/useCaro';
import type { BotLevel } from '../../types';
import { BotLevelPicker } from './components/BotLevelPicker';
import { useLobby } from './useLobby';

export function LobbyScreen({ progress }: { progress: string }) {
  const { pickOpen, exitOpen, setPickOpen, setExitOpen, reset } = useLobby(
    useShallow((state) => ({
      pickOpen: state.pickOpen,
      exitOpen: state.exitOpen,
      setPickOpen: state.setPickOpen,
      setExitOpen: state.setExitOpen,
      reset: state.reset,
    })),
  );

  const { lobbyVisible, lobbyPhase: phase, lobbyError, lobbyAnimKey, userInfo, ken, toast } = useCaro(
    useShallow((s) => ({
      lobbyVisible: s.lobbyVisible,
      lobbyPhase: s.lobbyPhase,
      lobbyError: s.lobbyError,
      lobbyAnimKey: s.lobbyAnimKey,
      userInfo: s.userInfo,
      ken: s.ken,
      toast: s.toast,
    })),
  );

  useLayoutEffect(() => {
    reset();
  }, [lobbyAnimKey, reset]);

  const { playBot, playRanked, showLeaderboard, showHistory, retry, exitApp, showToast } = useCaro(
    useShallow((s) => ({
      playBot: s.playBot,
      playRanked: s.playRanked,
      showLeaderboard: s.showLeaderboard,
      showHistory: s.showHistory,
      retry: s.retry,
      exitApp: s.exitApp,
      showToast: s.showToast,
    })),
  );

  const cls = [
    !lobbyVisible && 'hidden',
    phase === 'loading' && 'loading',
    (phase === 'connecting' || phase === 'error') && 'connecting',
    phase === 'ready' && 'show',
    phase === 'ready' && lobbyAnimKey > 1 && 'enter',
  ]
    .filter(Boolean)
    .join(' ');

  const vipSrc = avatarIconSrc(userInfo?.vipType);

  const choose = (level: BotLevel): void => {
    setPickOpen(false);
    playBot(level);
  };

  return (
    <div id="lobby" className={cls} data-loading={progress}>
      <div id="lobby-inner" style={assetBg('bg')}>
        <div className="lobby-top-space" />
        <div id="lobby-content">
          <div className="lobby-avatar" style={assetBg('avatarFrame')}>
            <img id="lobby-vip" className={phase === 'ready' ? '' : 'hidden'} src={vipSrc} alt="VIP" />
          </div>
          <div className="lobby-name" style={assetBg('nameFrame')}>
            <span id="lobby-name-text">{userInfo ? `@${userInfo.username}` : '...'}</span>
          </div>
          <div className="lobby-ken" style={assetBg('kenFrame')}>
            <img className="lobby-ken-icon" src={assetSrc('icKen')} alt="Ken" />
            <span id="lobby-ken-text">{formatKen(ken)}</span>
            <button type="button" id="lobby-plus" style={assetBg('btnPlus')} aria-label="Nạp Ken" onClick={() => showToast('Nạp Ken trong app Ola nhé!')}>
              <img src={assetSrc('icPlus')} alt="" />
            </button>
          </div>
          <button type="button" className="lobby-mode" id="lobby-bot" style={assetBg('modeFrame')} onClick={() => setPickOpen(true)}>
            <img src={assetSrc('icBot')} alt="" />
            <span>Chơi với máy</span>
          </button>
          <button type="button" className="lobby-mode" id="lobby-ranked" style={assetBg('modeFrame')} onClick={playRanked}>
            <img src={assetSrc('icRanked')} alt="" />
            <span>Chơi xếp hạng</span>
          </button>
        </div>
        <div id="lobby-status" className={phase === 'connecting' || phase === 'error' ? '' : 'hidden'}>
          <span id="lobby-status-text">
            {phase === 'error' ? lobbyError ?? 'Không kết nối được máy chủ' : 'Đang kết nối máy chủ...'}
          </span>
          <button type="button" id="lobby-retry" className={phase === 'error' ? '' : 'hidden'} onClick={retry}>
            Thử lại
          </button>
        </div>
        <div className="lobby-bottom" style={assetBg('bottomFrame')}>
          <button type="button" id="lobby-history" onClick={showHistory}>
            <img src={assetSrc('icHistory')} alt="" />
            <span>Lịch sử</span>
          </button>
          <button type="button" id="lobby-leaderboard" onClick={showLeaderboard}>
            <img src={assetSrc('icLeaderboard')} alt="" />
            <span>Bảng xếp hạng</span>
          </button>
          <button type="button" id="lobby-exit" onClick={() => setExitOpen(true)}>
            <img src={assetSrc('icExit')} alt="" />
            <span>Thoát</span>
          </button>
        </div>
        <div id="lobby-toast" className={toast ? 'show' : 'hidden'}>
          {toast}
        </div>
      </div>
      {pickOpen && <BotLevelPicker open onChoose={choose} onClose={() => setPickOpen(false)} />}
      {exitOpen && (
        <ConfirmModal
          open
          text="Bạn có chắc muốn thoát trò chơi?"
          onConfirm={exitApp}
          onCancel={() => setExitOpen(false)}
        />
      )}
    </div>
  );
}
