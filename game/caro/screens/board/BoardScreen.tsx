import { useShallow } from 'zustand/react/shallow';
import { assetBg } from '../../assets';
import { useCaro } from '../../store/useCaro';
import { BoardActions } from './components/BoardActions';
import { BoardChat } from './components/BoardChat';
import { BoardHeader } from './components/BoardHeader';
import { GameBoard } from './components/GameBoard';
import { ReactionBalloons } from './components/ReactionBalloons';

export function BoardScreen() {
  const { toast, boardMode } = useCaro(
    useShallow((state) => ({
      toast: state.toast,
      boardMode: state.boardMode,
    })),
  );

  return (
    <div id="app" style={assetBg('boardBg')}>
      <BoardHeader />
      <GameBoard />
      <BoardChat />
      <BoardActions />
      <ReactionBalloons />

      <div id="board-toast" className={toast && boardMode !== 'idle' ? 'show' : 'hidden'}>
        {toast}
      </div>
    </div>
  );
}
