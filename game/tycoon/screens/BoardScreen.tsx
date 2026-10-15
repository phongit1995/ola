import { useEffect, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { ActionBar } from '../components/ActionBar';
import { AssetsSheet } from '../components/AssetsSheet';
import { Board } from '../components/Board';
import { BottomSheet } from '../components/BottomSheet';
import { DebtModal } from '../components/DebtModal';
import { CardOverlay, DiceOverlay } from '../components/Overlays';
import { PlayerPods } from '../components/PlayerPods';
import { TileSheet } from '../components/TileSheet';
import { TyIcon } from '../components/TyIcon';
import { MAX_ROUNDS } from '../logic/constants';
import { useTycoon } from '../store/useTycoon';

function LogSheet() {
  const { log, closeSheet } = useTycoon(useShallow((s) => ({ log: s.log, closeSheet: s.closeSheet })));
  return (
    <BottomSheet title="Diễn biến ván chơi" onClose={closeSheet} tall>
      <h2 className="ty-sheet-title">Diễn biến</h2>
      <div className="ty-log-full">
        {log.length === 0 ? <p className="ty-sheet-desc">Chưa có gì xảy ra.</p> : null}
        {[...log].reverse().map((line) => (
          <div key={line.seq} className={`ty-log-line ty-log-${line.tone}`}>
            {line.text}
          </div>
        ))}
      </div>
    </BottomSheet>
  );
}

export function BoardScreen() {
  const state = useTycoon(
    useShallow((s) => ({
      view: s.view,
      myTurn: s.myTurn,
      timerLeftMs: s.timerLeftMs,
      deadline: s.deadline,
      replaying: s.replaying,
      turnAnnounce: s.turnAnnounce,
      result: s.result,
      sheet: s.sheet,
      you: s.you,
      log: s.log,
      openSheet: s.openSheet,
      forfeitMatch: s.forfeitMatch,
      exitMatch: s.exitMatch,
    })),
  );
  const [menuOpen, setMenuOpen] = useState(false);
  const round = state.view?.round ?? 1;
  const seconds = Math.ceil(state.timerLeftMs / 1000);
  const clockVisible = state.myTurn && state.deadline > 0 && !state.replaying && !state.result;
  const recentLog = state.log.slice(-2);

  useEffect(() => {
    if (state.result) setMenuOpen(false);
  }, [state.result]);

  return (
    <div className="ty-screen ty-board-screen">
      <div className="ty-topbar ty-board-topbar">
        <span className={`ty-round-chip ${round >= MAX_ROUNDS ? 'ty-round-final' : round >= MAX_ROUNDS - 2 ? 'ty-round-late' : ''}`}>
          Vòng {Math.min(round, MAX_ROUNDS)}/{MAX_ROUNDS}
        </span>
        <span className={`ty-turn-clock ${clockVisible && seconds <= 10 ? 'ty-turn-clock-urgent' : ''}`} aria-label={clockVisible ? `Còn ${seconds} giây` : undefined}>
          {clockVisible ? `0:${String(Math.max(0, seconds)).padStart(2, '0')}` : ''}
        </span>
        <div className="ty-board-menu">
          <button type="button" className="ty-icon-btn ty-icon-btn-dark" onClick={() => setMenuOpen((open) => !open)} aria-expanded={menuOpen} aria-label="Thêm tùy chọn">
            <TyIcon name="more" size={22} />
          </button>
          {menuOpen ? (
            <div className="ty-popover" role="menu">
              <button
                type="button"
                role="menuitem"
                onClick={() => {
                  setMenuOpen(false);
                  state.exitMatch();
                }}
              >
                <TyIcon name="exit-door" size={18} /> Về sảnh
              </button>
              <button
                type="button"
                role="menuitem"
                className="ty-popover-danger"
                onClick={() => {
                  setMenuOpen(false);
                  state.forfeitMatch();
                }}
              >
                <TyIcon name="flag" size={18} /> Bỏ cuộc
              </button>
            </div>
          ) : null}
        </div>
      </div>

      <div className="ty-board-wrap">
        <Board onTileTap={(idx) => state.openSheet({ kind: 'tile', idx })}>
          <DiceOverlay />
          <CardOverlay />
          {state.turnAnnounce ? (
            <div className="ty-turn-announce" role="status">
              {state.turnAnnounce}
            </div>
          ) : null}
        </Board>
      </div>

      <PlayerPods />
      <ActionBar />
      <button type="button" className="ty-log" aria-label="Xem toàn bộ diễn biến" onClick={() => state.openSheet({ kind: 'log' })}>
        {recentLog.length === 0 ? <span className="ty-log-line">Ván mới bắt đầu — chúc may mắn!</span> : null}
        {recentLog.map((line) => (
          <span key={line.seq} className={`ty-log-line ty-log-${line.tone}`}>
            {line.text}
          </span>
        ))}
      </button>

      {!state.result && state.sheet?.kind === 'tile' ? <TileSheet idx={state.sheet.idx} /> : null}
      {!state.result && state.sheet?.kind === 'assets' ? <AssetsSheet seat={state.sheet.seat} /> : null}
      {!state.result && state.sheet?.kind === 'log' ? <LogSheet /> : null}
      {!state.result ? <DebtModal /> : null}
    </div>
  );
}
