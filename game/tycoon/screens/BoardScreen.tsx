import { useEffect, useLayoutEffect, useRef, useState, type CSSProperties, type RefObject } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { AssetsSheet } from '../components/AssetsSheet';
import { Board } from '../components/Board';
import { BoardCenter } from '../components/BoardCenter';
import { BottomSheet } from '../components/BottomSheet';
import { DebtModal } from '../components/DebtModal';
import { PlayerPods } from '../components/PlayerPods';
import { TileSheet } from '../components/TileSheet';
import { TyIcon } from '../components/TyIcon';
import { attachParticles } from '../fx/particles';
import { MAX_ROUNDS, TIME_LIMIT_MS } from '../logic/constants';
import { useTycoon, type LogLine } from '../store/useTycoon';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import logoUrl from '../assets/lobby/logo.webp';

const LOG_MIN_HEIGHT = 140;
const LOG_LINES = 5;
const BOARD_MIN = 260;
const BOARD_MAX = 620;

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

function GameClock() {
  const startedAt = useTycoon((s) => s.startedAt);
  const [now, setNow] = useState(() => Date.now());
  useEffect(() => {
    const timer = setInterval(() => setNow(Date.now()), 1000);
    return () => clearInterval(timer);
  }, []);
  const left = Math.max(0, TIME_LIMIT_MS - (now - startedAt));
  const minutes = Math.floor(left / 60000);
  const seconds = Math.floor((left % 60000) / 1000);
  return (
    <span className={left <= 3 * 60000 ? 'ty-s6-late' : undefined} aria-label={`Còn ${minutes} phút`}>
      {minutes}:{String(seconds).padStart(2, '0')}
    </span>
  );
}

function useBoardFit(screen: RefObject<HTMLDivElement | null>, chrome: RefObject<(HTMLElement | null)[]>): boolean {
  const [roomForLog, setRoomForLog] = useState(false);
  useLayoutEffect(() => {
    const root = screen.current;
    if (!root) return;
    const fit = () => {
      const style = getComputedStyle(root);
      const width = root.clientWidth - parseFloat(style.paddingLeft) - parseFloat(style.paddingRight);
      const height = root.clientHeight - parseFloat(style.paddingTop) - parseFloat(style.paddingBottom);
      const fixed = chrome.current.reduce((sum, el) => sum + (el?.offsetHeight ?? 0), 0) + 24;
      const size = Math.floor(Math.max(BOARD_MIN, Math.min(width, height - fixed, BOARD_MAX)));
      root.style.setProperty('--b', `${size}px`);
      setRoomForLog(height - fixed - size >= LOG_MIN_HEIGHT);
    };
    fit();
    const observer = new ResizeObserver(fit);
    observer.observe(root);
    return () => observer.disconnect();
  }, [chrome, screen]);
  return roomForLog;
}

function LogCard({ lines }: { lines: LogLine[] }) {
  return (
    <ul className="ty-s6-logcard">
      {[...lines].reverse().slice(0, LOG_LINES).map((line) => (
        <li key={line.seq} className={`ty-log-${line.tone}`}>
          {line.text}
        </li>
      ))}
    </ul>
  );
}

export function BoardScreen() {
  const state = useTycoon(
    useShallow((s) => ({
      view: s.view,
      you: s.you,
      log: s.log,
      result: s.result,
      sheet: s.sheet,
      soundOn: s.soundOn,
      toggleSound: s.toggleSound,
      openSheet: s.openSheet,
      forfeitMatch: s.forfeitMatch,
      exitMatch: s.exitMatch,
    })),
  );
  const [menuOpen, setMenuOpen] = useState(false);
  const screen = useRef<HTMLDivElement>(null);
  const top = useRef<HTMLElement>(null);
  const pods = useRef<HTMLDivElement>(null);
  const foot = useRef<HTMLElement>(null);
  const chrome = useRef<(HTMLElement | null)[]>([]);
  const canvas = useRef<HTMLCanvasElement>(null);
  const round = Math.min(state.view?.round ?? 1, MAX_ROUNDS);
  const latest = state.log[state.log.length - 1];

  useLayoutEffect(() => {
    chrome.current = [top.current, pods.current, foot.current];
  }, []);
  const roomForLog = useBoardFit(screen, chrome);

  useEffect(() => (canvas.current ? attachParticles(canvas.current) : undefined), []);

  useEffect(() => {
    if (state.result) setMenuOpen(false);
  }, [state.result]);

  return (
    <div ref={screen} className="ty-screen ty-board-screen" style={{ '--ty-board-bg': `url(${bgUrl})` } as CSSProperties}>
      <header ref={top} className="ty-s6-top">
        <img className="ty-s6-logo" src={logoUrl} alt="Cờ Tỷ Phú" draggable={false} />
        <span className="ty-s6-roundchip" aria-label={`Vòng ${round} trên ${MAX_ROUNDS}`}>
          <span id="ty-s6-round">
            {round >= MAX_ROUNDS ? 'Vòng cuối' : 'Vòng'} {round}/{MAX_ROUNDS}
          </span>
          {state.result ? null : (
            <>
              <span aria-hidden="true">·</span>
              <GameClock />
            </>
          )}
        </span>
        <button type="button" className="ty-s6-roundbtn" onClick={state.toggleSound} aria-label={state.soundOn ? 'Tắt âm' : 'Bật âm'} aria-pressed={state.soundOn}>
          <TyIcon name={state.soundOn ? 'volume-on' : 'volume-off'} size={20} />
        </button>
        <div className="ty-board-menu">
          <button type="button" className="ty-s6-roundbtn" onClick={() => setMenuOpen((open) => !open)} aria-expanded={menuOpen} aria-label="Thêm tùy chọn">
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
      </header>

      <div className="ty-s6-boardwrap">
        <Board onTileTap={(idx) => state.openSheet({ kind: 'tile', idx })}>
          <BoardCenter />
        </Board>
      </div>

      <div ref={pods}>
        <PlayerPods />
      </div>
      {roomForLog ? <LogCard lines={state.log} /> : null}

      <footer ref={foot} className="ty-s6-foot">
        <button type="button" className="ty-s6-pill" onClick={() => state.openSheet({ kind: 'assets', seat: state.you })}>
          <TyIcon name="deed" size={18} />
          Tài sản
        </button>
        <button type="button" className="ty-s6-pill" onClick={() => state.openSheet({ kind: 'log' })}>
          <TyIcon name="history" size={18} />
          Diễn biến
        </button>
        {roomForLog ? null : (
          <button type="button" className="ty-s6-ticker" aria-label="Xem toàn bộ diễn biến" onClick={() => state.openSheet({ kind: 'log' })}>
            {latest?.text ?? ''}
          </button>
        )}
      </footer>

      <canvas ref={canvas} className="ty-s6-fx" aria-hidden="true" />
      <div className="ty-s6-vignette" id="ty-s6-vignette" />
      <div className="ty-s6-banner" id="ty-s6-banner" hidden />
      <img className="ty-s6-bust" id="ty-s6-bust" alt="" hidden />

      {!state.result && state.sheet?.kind === 'tile' ? <TileSheet idx={state.sheet.idx} /> : null}
      {!state.result && state.sheet?.kind === 'assets' ? <AssetsSheet seat={state.sheet.seat} /> : null}
      {!state.result && state.sheet?.kind === 'log' ? <LogSheet /> : null}
      {!state.result ? <DebtModal /> : null}
    </div>
  );
}
