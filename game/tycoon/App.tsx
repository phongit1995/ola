import { useEffect } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BotSetupModal } from './components/BotSetupModal';
import { ConfirmModal } from './components/ConfirmModal';
import { RulesModal } from './components/RulesModal';
import { BoardScreen } from './screens/BoardScreen';
import { LobbyScreen } from './screens/LobbyScreen';
import { ResultScreen } from './screens/ResultScreen';
import { useTycoon } from './store/useTycoon';

export function App() {
  const { boardMode, rulesOpen, setupOpen, result, toast, notice, init, dispose, showNotice } = useTycoon(
    useShallow((s) => ({
      boardMode: s.boardMode,
      rulesOpen: s.rulesOpen,
      setupOpen: s.setupOpen,
      result: s.result,
      toast: s.toast,
      notice: s.notice,
      init: s.init,
      dispose: s.dispose,
      showNotice: s.showNotice,
    })),
  );

  useEffect(() => {
    init();
    return dispose;
  }, [dispose, init]);

  return (
    <div className="ty-app">
      {boardMode === 'playing' ? <BoardScreen /> : <LobbyScreen />}
      {setupOpen ? <BotSetupModal /> : null}
      {rulesOpen ? <RulesModal /> : null}
      {result ? <ResultScreen /> : null}
      {notice ? (
        <ConfirmModal title={notice.title} body={notice.body} okLabel={notice.okLabel} danger={notice.danger} onOk={notice.onOk} onCancel={() => showNotice(null)} />
      ) : null}
      {toast ? (
        <div className="ty-toast" role="status">
          {toast}
        </div>
      ) : null}
    </div>
  );
}
