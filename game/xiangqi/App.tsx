import { useEffect } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { ConfirmModal } from './components/ConfirmModal';
import { BotSetupModal } from './components/BotSetupModal';
import { BoardScreen } from './screens/BoardScreen';
import { HistoryScreen } from './screens/HistoryScreen';
import { LeaderboardScreen } from './screens/LeaderboardScreen';
import { LobbyScreen } from './screens/LobbyScreen';
import { RankedScreen } from './screens/RankedScreen';
import { ResultScreen } from './screens/ResultScreen';
import { useXiangqi } from './store/useXiangqi';

export function App() {
  const { boardMode, rankedVisible, historyVisible, leaderboardVisible, botSetupVisible, result, toast, notice, init, dispose, showNotice } =
    useXiangqi(
      useShallow((s) => ({
        boardMode: s.boardMode,
        rankedVisible: s.rankedVisible,
        historyVisible: s.historyVisible,
        leaderboardVisible: s.leaderboardVisible,
        botSetupVisible: s.botSetupVisible,
        result: s.result,
        toast: s.toast,
        notice: s.notice,
        init: s.init,
        dispose: s.dispose,
        showNotice: s.showNotice,
      })),
    );

  useEffect(() => {
    void init();
    return dispose;
  }, [dispose, init]);

  return (
    <div className="xq-app">
      {boardMode !== 'idle' ? (
        <BoardScreen />
      ) : rankedVisible ? (
        <RankedScreen />
      ) : (
        <LobbyScreen />
      )}
      {historyVisible ? <HistoryScreen /> : null}
      {leaderboardVisible ? <LeaderboardScreen /> : null}
      {botSetupVisible ? <BotSetupModal /> : null}
      {result ? <ResultScreen /> : null}
      {notice ? (
        <ConfirmModal
          title={notice.title}
          body={notice.body}
          okLabel={notice.okLabel}
          danger={notice.danger}
          onOk={notice.onOk}
          onCancel={() => showNotice(null)}
        />
      ) : null}
      {toast ? (
        <div className="xq-toast" role="status">
          {toast}
        </div>
      ) : null}
    </div>
  );
}
