import { useEffect, useState } from 'react';
import { bridge } from '../src/sdk';
import { BOARD_ASSETS, preloadAssets } from './assets';
import { ConfirmModal } from './components/ConfirmModal';
import { BoardScreen } from './screens/BoardScreen';
import { LeaderboardScreen } from './screens/LeaderboardScreen';
import { LobbyScreen } from './screens/LobbyScreen';
import { RankedScreen } from './screens/RankedScreen';
import { ResultScreen } from './screens/ResultScreen';
import { useCaroStore } from './store';

function OppAwayBanner() {
  const oppAway = useCaroStore((s) => s.oppAway);
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
  const lobbyAnimKey = useCaroStore((s) => s.lobbyAnimKey);
  const notice = useCaroStore((s) => s.notice);
  const dismissNotice = useCaroStore((s) => s.dismissNotice);
  const init = useCaroStore((s) => s.init);
  const dispose = useCaroStore((s) => s.dispose);

  useEffect(() => {
    document.documentElement.style.setProperty('--asset-board-x', `url('${BOARD_ASSETS.boardX}')`);
    document.documentElement.style.setProperty('--asset-board-o', `url('${BOARD_ASSETS.boardO}')`);
    bridge.ready();
    let cancelled = false;
    void preloadAssets((loaded, total) => {
      const pct = total === 0 ? 100 : Math.round((loaded / total) * 100);
      setProgress(`Đang tải... ${pct}%`);
    }).then(() => {
      if (!cancelled) setReady(true);
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
      <BoardScreen />
      <LobbyScreen key={lobbyAnimKey} progress={progress} />
      <LeaderboardScreen />
      <RankedScreen />
      <ResultScreen />
      <OppAwayBanner />
      <ConfirmModal
        open={notice != null}
        title="Thông báo"
        text={notice ?? ''}
        confirmLabel="Đã hiểu"
        cancelLabel={null}
        confirmTone="primary"
        dismissOnBackdrop={false}
        onConfirm={dismissNotice}
        onCancel={dismissNotice}
      />
    </>
  );
}
