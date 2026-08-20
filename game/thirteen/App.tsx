import { useEffect, useState } from 'react';
import { ARCADE_BRIDGE_EVENT } from '@ola/shared/constants';
import type { ArcadeKenUpdatedData } from '@ola/shared/types';
import { bridge } from '../src/sdk';
import { preloadCardAssets } from './assets';
import { BrandMark } from './components/BrandMark';
import { ConfirmModal } from './components/ConfirmModal';
import { LobbyScreen } from './screens/lobby/LobbyScreen';
import { RoomScreen } from './screens/room/RoomScreen';
import { TableScreen } from './screens/table/TableScreen';
import { ResultScreen } from './screens/result/ResultScreen';
import { useThirteen } from './store/useThirteen';

export function App() {
  const [assetsReady, setAssetsReady] = useState(false);
  const phase = useThirteen((s) => s.phase);
  const result = useThirteen((s) => s.result);
  const notice = useThirteen((s) => s.notice);
  const toast = useThirteen((s) => s.toast);
  const confirmExit = useThirteen((s) => s.confirmExit);
  const dismissNotice = useThirteen((s) => s.dismissNotice);
  const cancelExit = useThirteen((s) => s.cancelExit);
  const confirmExitNow = useThirteen((s) => s.confirmExitNow);
  const init = useThirteen((s) => s.init);
  const dispose = useThirteen((s) => s.dispose);

  useEffect(() => {
    const stopKenSync = bridge.onHost(ARCADE_BRIDGE_EVENT.KenUpdated, (data) => {
      const ken = (data as Partial<ArcadeKenUpdatedData> | undefined)?.ken;
      const user = useThirteen.getState().user;
      if (typeof ken === 'number' && user) useThirteen.setState({ user: { ...user, ken } });
    });
    bridge.ready();
    init();
    let cancelled = false;
    void preloadCardAssets().then(() => {
      if (!cancelled) setAssetsReady(true);
    });
    return () => {
      cancelled = true;
      stopKenSync();
      dispose();
    };
  }, [dispose, init]);

  return (
    <div id="tl-app">
      {phase === 'connecting' && (
        <div className="tl-loading" role="status" aria-live="polite" aria-label="Đang kết nối">
          <div className="tl-loading-mat" aria-hidden="true" />
          <div className="tl-loading-content">
            <BrandMark className="tl-loading-logo" />
            <span className="tl-loading-sub">Đang kết nối...</span>
            <span className="tl-loading-dots" aria-hidden="true">
              <i />
              <i />
              <i />
            </span>
          </div>
        </div>
      )}
      {phase === 'lobby' && <LobbyScreen assetsReady={assetsReady} />}
      {phase === 'room' && <RoomScreen />}
      {phase === 'table' && <TableScreen />}
      {result && <ResultScreen />}
      {toast && <div className="tl-toast">{toast}</div>}
      {confirmExit && (
        <ConfirmModal
          title="Rời ván đấu?"
          text={
            phase === 'table' && !result
              ? 'Rời ngay bây giờ bạn sẽ bị xử thua ván này. Vẫn muốn rời?'
              : 'Bạn muốn thoát trò chơi?'
          }
          confirmLabel="Rời ván"
          cancelLabel="Ở lại"
          onConfirm={confirmExitNow}
          onCancel={cancelExit}
          style02
        />
      )}
      {notice && (
        <ConfirmModal
          title="Thông báo"
          text={notice}
          confirmLabel="Đã hiểu"
          cancelLabel={null}
          onConfirm={dismissNotice}
          onCancel={dismissNotice}
          style02
        />
      )}
    </div>
  );
}
