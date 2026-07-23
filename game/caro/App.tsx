import { useEffect, useState } from 'react';
import { bridge } from '../src/sdk';
import { BOARD_ASSETS, preloadAssets } from './assets';
import { useCaroStore } from './store';
import { Board } from './Board';
import { Lobby } from './Lobby';
import { Ranked } from './Ranked';
import { Result } from './Result';

export function App() {
  const [progress, setProgress] = useState('Đang tải...');
  const [ready, setReady] = useState(false);
  const lobbyAnimKey = useCaroStore((s) => s.lobbyAnimKey);
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
      <Board />
      <Lobby key={lobbyAnimKey} progress={progress} />
      <Ranked />
      <Result />
    </>
  );
}
