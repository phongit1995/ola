import { useEffect, useState } from 'react';
import { bridge } from '../src/sdk';
import { BOARD_ASSETS, preloadAssets, preloadModalAssets } from './assets';
import { ConfirmModal } from './components/ConfirmModal';
import { BoardScreen } from './screens/board/BoardScreen';
import { LeaderboardScreen } from './screens/leaderboard/LeaderboardScreen';
import { HistoryScreen } from './screens/history/HistoryScreen';
import { LobbyScreen } from './screens/lobby/LobbyScreen';
import { RankedScreen } from './screens/ranked/RankedScreen';
import { ResultScreen } from './screens/result/ResultScreen';
import { useCaro } from './store/useCaro';

function OppAwayBanner() {
  const oppAway = useCaro((s) => s.oppAway);
  const [left, setLeft] = useState(0);
  useEffect(() => {
    if (oppAway == null) return;
    const tick = (): void => setLeft(Math.max(0, Math.ceil((oppAway - Date.now()) / 1000)));
    tick();
    const id = window.setInterval(tick, 250);
    return () => window.clearInterval(id);
  }, [oppAway]);
  if (oppAway == null) return null;
  return <div className="opp-away-banner">Đối thủ mất kết nối, chờ {left}s...</div>;
}

export function App() {
  const [progress, setProgress] = useState('Đang tải...');
  const [ready, setReady] = useState(false);
  const lobbyAnimKey = useCaro((s) => s.lobbyAnimKey);
  const lobbyVisible = useCaro((s) => s.lobbyVisible);
  const rankedVisible = useCaro((s) => s.rankedVisible);
  const leaderboardVisible = useCaro((s) => s.leaderboardVisible);
  const historyVisible = useCaro((s) => s.historyVisible);
  const boardMode = useCaro((s) => s.boardMode);
  const result = useCaro((s) => s.result);
  const notice = useCaro((s) => s.notice);
  const dismissNotice = useCaro((s) => s.dismissNotice);
  const init = useCaro((s) => s.init);
  const dispose = useCaro((s) => s.dispose);

  useEffect(() => {
    document.documentElement.style.setProperty('--asset-board-x', `url('${BOARD_ASSETS.boardX}')`);
    document.documentElement.style.setProperty('--asset-board-o', `url('${BOARD_ASSETS.boardO}')`);
    bridge.ready();
    let cancelled = false;
    void preloadAssets((loaded, total) => {
      const pct = total === 0 ? 100 : Math.round((loaded / total) * 100);
      setProgress(`Đang tải... ${pct}%`);
    }).then(() => {
      if (!cancelled) {
        void preloadModalAssets();
        setReady(true);
      }
    });
    return () => {
      cancelled = true;
      dispose();
    };
  }, [dispose]);

  useEffect(() => {
    init(ready);
  }, [ready, init]);

  return (
    <>
      {boardMode !== 'idle' && <BoardScreen />}
      {lobbyVisible && <LobbyScreen key={lobbyAnimKey} progress={progress} />}
      {leaderboardVisible && <LeaderboardScreen />}
      {historyVisible && <HistoryScreen />}
      {rankedVisible && <RankedScreen />}
      {result && <ResultScreen />}
      <OppAwayBanner />
      {notice && (
        <ConfirmModal
          open
          title="Thông báo"
          text={notice}
          confirmLabel="Đã hiểu"
          cancelLabel={null}
          confirmTone="primary"
          dismissOnBackdrop={false}
          onConfirm={dismissNotice}
          onCancel={dismissNotice}
        />
      )}
    </>
  );
}
