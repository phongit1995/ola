import { assetBg } from './assets';
import { SIZE } from './types';
import type { CaroGame } from './useCaroGame';

const CELLS = Array.from({ length: SIZE * SIZE }, (_, i) => i);

export function Board({ game }: { game: CaroGame }) {
  const { me, op, overlay } = game;
  return (
    <div id="app" style={assetBg('boardBg')}>
      <header id="topbar">
        <div className="player" id="player-me">
          <div className="p-avatar" style={assetBg('boardAvatarFrame')}>
            <img className="p-vip" src={me.vip} alt="" />
          </div>
          <div className="name-row">
            <span className="name">{me.name}</span>
            <span className={`mark ${me.mark}`}>{me.mark === 'x' ? 'X' : 'O'}</span>
          </div>
        </div>
        <div id="center">
          <div id="timer" className={game.showTimer ? (game.timerUrgent ? 'urgent' : '') : 'hidden'} style={assetBg('boardTimerFrame')}>
            <span id="timer-val">{game.timerText}</span>
          </div>
          <img id="turn-arrow" className={game.turnArrowSrc ? '' : 'hidden'} src={game.turnArrowSrc ?? undefined} alt="" />
          <div id="status">{game.status}</div>
        </div>
        <div className="player right" id="player-op">
          <div className="p-avatar" style={assetBg('boardAvatarFrame')}>
            <img className="p-vip" src={op.vip} alt="" />
          </div>
          <div className="name-row">
            <span className="name">{op.name}</span>
            <span className={`mark ${op.mark}`}>{op.mark === 'x' ? 'X' : 'O'}</span>
          </div>
        </div>
      </header>

      <main id="board-wrap">
        <div id="board-frame" style={assetBg('boardFrame')}>
          <div id="board" className={game.myTurn ? 'playable' : ''}>
            {CELLS.map((i) => {
              const mark = game.board[i];
              const cls = 'cell' + (mark ? ` p${mark}` : '') + (i === game.lastIdx ? ' last' : '');
              const x = i % SIZE;
              const y = Math.floor(i / SIZE);
              return <div key={i} className={cls} onClick={() => game.placeMove(x, y)} />;
            })}
          </div>
        </div>
        <div id="overlay" className={overlay ? '' : 'hidden'}>
          <div id="overlay-card">
            <div id="overlay-logo" aria-hidden="true">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round">
                <path d="M3 9h18M3 15h18M9 3v18M15 3v18" />
                <path className="logo-x" d="M4.6 4.6l2.8 2.8M7.4 4.6L4.6 7.4" strokeWidth="1.8" />
                <circle className="logo-o" cx="12" cy="12" r="1.6" strokeWidth="1.8" />
              </svg>
            </div>
            <h2 id="overlay-title" className={overlay?.kind === 'win' ? 'win' : overlay?.kind === 'lose' ? 'lose' : ''}>
              {overlay?.title ?? 'Cờ Caro'}
            </h2>
            <p id="overlay-sub">{overlay?.sub ?? '5 quân liên tiếp để thắng'}</p>
            <div id="overlay-actions">
              <button type="button" id="btn-again" className={overlay?.actions.includes('again') ? '' : 'hidden'} onClick={game.again}>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
                  <path d="M3 12a9 9 0 1 0 2.6-6.3L3 8" />
                  <path d="M3 3v5h5" />
                </svg>
                Chơi lại
              </button>
              <button type="button" id="btn-cancel" className={`secondary ${overlay?.actions.includes('cancel') ? '' : 'hidden'}`} onClick={game.cancelSearch}>
                Hủy tìm trận
              </button>
              <button type="button" id="btn-lobby" className={`secondary ${overlay?.actions.includes('lobby') ? '' : 'hidden'}`} onClick={game.toLobby}>
                Về sảnh
              </button>
            </div>
          </div>
        </div>
      </main>

      <footer id="bottombar">
        <button type="button" id="btn-replay" className={game.replayVisible ? '' : 'hidden'} style={assetBg('boardMenuBtn')} onClick={game.replay}>
          Chơi lại
        </button>
        <button type="button" id="btn-forfeit" style={assetBg('boardMenuBtn')} disabled={game.forfeitDisabled} onClick={game.forfeit}>
          Bỏ cuộc
        </button>
        <button type="button" id="btn-exit" style={assetBg('boardMenuBtn')} onClick={game.exitMatch}>
          Thoát
        </button>
      </footer>
    </div>
  );
}
