import { useEffect } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { BotSetupModal } from './components/BotSetupModal';
import { NoticeModal } from './components/NoticeModal';
import { RulesModal } from './components/RulesModal';
import { BoardScreen } from './screens/BoardScreen';
import { LeaderboardScreen } from './screens/LeaderboardScreen';
import { LobbyScreen } from './screens/LobbyScreen';
import { ResultScreen } from './screens/ResultScreen';
import { RoomListScreen } from './screens/RoomListScreen';
import { useTycoon } from './store/useTycoon';

export function App() {
  const { boardMode, roomsOpen, leaderboardOpen, rulesOpen, setupOpen, result, toast, notice, noticeId, init, dispose } = useTycoon(
    useShallow((s) => ({
      boardMode: s.boardMode,
      roomsOpen: s.roomsOpen,
      leaderboardOpen: s.leaderboardOpen,
      rulesOpen: s.rulesOpen,
      setupOpen: s.setupOpen,
      result: s.result,
      toast: s.toast,
      notice: s.notice,
      noticeId: s.noticeId,
      init: s.init,
      dispose: s.dispose,
    })),
  );

  useEffect(() => {
    init();
    return dispose;
  }, [dispose, init]);

  return (
    <div className={roomsOpen && boardMode !== 'playing' ? 'ty-app ty-app-rooms' : 'ty-app'}>
      {boardMode === 'playing' ? <BoardScreen /> : roomsOpen ? <RoomListScreen /> : leaderboardOpen ? <LeaderboardScreen /> : <LobbyScreen />}
      {setupOpen ? <BotSetupModal /> : null}
      {rulesOpen ? <RulesModal /> : null}
      {result ? <ResultScreen /> : null}
      {notice ? <NoticeModal key={noticeId} notice={notice} /> : null}
      {toast ? (
        <div className="ty-toast" role="status">
          {toast}
        </div>
      ) : null}
    </div>
  );
}
