import { useEffect, useLayoutEffect, useRef, useState, type CSSProperties, type RefObject } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { ActionDock } from '../components/ActionDock';
import { AssetsSheet } from '../components/AssetsSheet';
import { Board } from '../components/Board';
import { BoardCenter } from '../components/BoardCenter';
import { BuyModal } from '../components/BuyModal';
import { DebtModal } from '../components/DebtModal';
import { ChatSheet, ReactionBubbles } from '../components/MatchChat';
import { TyIcon } from '../components/TyIcon';
import { KenBadge, UiAvatar, UiIconButton } from '../components/Ui';
import { PlayerPods } from '../components/PlayerPods';
import { TileSheet } from '../components/TileSheet';
import { LogSheet } from '../components/LogSheet';
import { attachParticles } from '../fx/particles';
import { MAX_ROUNDS, TIME_LIMIT_MS } from '../logic/constants';
import { logLineText, useTycoon } from '../store/useTycoon';
import bgUrl from '../assets/lobby/bg-board-pixel.webp';
import logoUrl from '../assets/lobby/logo.webp';

const BOARD_MIN = 260;
const BOARD_MAX = 600;
const DOCK_RESERVE = 112;

function ConnectionBanner() {
  const { awaySeats, selfDisconnected, players, you, spectating, spectators, result } = useTycoon(
    useShallow((s) => ({ awaySeats: s.awaySeats, selfDisconnected: s.selfDisconnected, players: s.players, you: s.you, spectating: s.spectating, spectators: s.spectators, result: s.result })),
  );
  const [now, setNow] = useState(() => Date.now());
  const away = Object.entries(awaySeats).filter(([seat]) => Number(seat) !== you);
  useEffect(() => {
    if (away.length === 0) return;
    const timer = setInterval(() => setNow(Date.now()), 500);
    return () => clearInterval(timer);
  }, [away.length]);
  if (selfDisconnected) {
    return (
      <div className="ty-net-banner ty-net-banner-self" role="status">
        <TyIcon name="wifi-off" size={16} />
        Mất kết nối, đang nối lại…
      </div>
    );
  }
  if (away.length === 0) {
    if (!spectating || result) return null;
    return (
      <div className="ty-net-banner ty-net-banner-watch" role="status">
        <TyIcon name="eye" size={16} />
        Đang xem · {spectators} người xem
      </div>
    );
  }
  const [seat, deadline] = away[0];
  const left = Math.max(0, Math.ceil((deadline - now) / 1000));
  return (
    <div className="ty-net-banner" role="status">
      <UiAvatar src={players[Number(seat)]?.avatar} size={20} />
      @{players[Number(seat)]?.name ?? '?'} mất kết nối · còn {left}s
    </div>
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

function useBoardFit(screen: RefObject<HTMLDivElement | null>, chrome: RefObject<(HTMLElement | null)[]>): void {
  useLayoutEffect(() => {
    const root = screen.current;
    if (!root) return;
    const fit = () => {
      const style = getComputedStyle(root);
      const width = root.clientWidth - parseFloat(style.paddingLeft) - parseFloat(style.paddingRight);
      const height = root.clientHeight - parseFloat(style.paddingTop) - parseFloat(style.paddingBottom);
      const fixed = chrome.current.reduce((sum, el) => sum + (el?.offsetHeight ?? 0), 0) + DOCK_RESERVE + 52;
      const size = Math.floor(Math.max(BOARD_MIN, Math.min(width, height - fixed, BOARD_MAX)) / 2) * 2;
      root.style.setProperty('--b', `${size}px`);
    };
    fit();
    const observer = new ResizeObserver(fit);
    observer.observe(root);
    return () => observer.disconnect();
  }, [chrome, screen]);
}

function BoardMenu({ onClose }: { onClose: () => void }) {
  const { speed, autoEnd, spectating, practice, matchBet, spectators, setSpeed, setAutoEnd, setRulesOpen, exitMatch, forfeitMatch } = useTycoon(
    useShallow((s) => ({
      speed: s.speed,
      autoEnd: s.autoEnd,
      spectating: s.spectating,
      practice: s.practice,
      matchBet: s.matchBet,
      spectators: s.spectators,
      setSpeed: s.setSpeed,
      setAutoEnd: s.setAutoEnd,
      setRulesOpen: s.setRulesOpen,
      exitMatch: s.exitMatch,
      forfeitMatch: s.forfeitMatch,
    })),
  );
  return (
    <div className="ui-panel ty-popover" role="menu">
      {practice ? null : (
        <p className="ty-popover-info">
          <span className="ty-popover-info-item">
            {matchBet > 0 ? (
              <>
                Cược <KenBadge amount={matchBet} />
              </>
            ) : (
              'Giao lưu'
            )}
          </span>
          {spectators > 0 ? (
            <span className="ty-popover-info-item">
              <TyIcon name="eye" size={14} />
              {spectators} người đang xem
            </span>
          ) : null}
        </p>
      )}
      <div className="ty-popover-row">
        <span>Tốc độ</span>
        <span className="ui-segmented" role="radiogroup" aria-label="Tốc độ hiệu ứng">
          {[1, 2].map((value) => (
            <button key={value} type="button" role="radio" aria-checked={speed === value} onClick={() => setSpeed(value as 1 | 2)}>
              ×{value}
            </button>
          ))}
        </span>
      </div>
      {spectating ? null : (
        <button type="button" role="menuitemcheckbox" aria-checked={autoEnd} className="ty-popover-row" onClick={() => setAutoEnd(!autoEnd)}>
          <span>Tự kết thúc lượt</span>
          <span className={`ty-switch ${autoEnd ? 'ty-switch-on' : ''}`} aria-hidden="true">
            <i />
          </span>
        </button>
      )}
      <button
        type="button"
        role="menuitem"
        onClick={() => {
          onClose();
          exitMatch();
        }}
      >
        <TyIcon name="exit-door" size={16} /> {spectating ? 'Thôi xem' : 'Về sảnh'}
      </button>
      <button
        type="button"
        role="menuitem"
        onClick={() => {
          onClose();
          setRulesOpen(true);
        }}
      >
        <TyIcon name="info" size={16} /> Luật chơi
      </button>
      {spectating ? null : (
        <button
          type="button"
          role="menuitem"
          className="ty-popover-danger"
          onClick={() => {
            onClose();
            forfeitMatch();
          }}
        >
          <TyIcon name="flag" size={16} /> Bỏ cuộc
        </button>
      )}
    </div>
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
      replaying: s.replaying,
      practice: s.practice,
      spectating: s.spectating,
      chatUnread: s.chatUnread,
      toggleSound: s.toggleSound,
      openSheet: s.openSheet,
      skipReplay: s.skipReplay,
    })),
  );
  const [menuOpen, setMenuOpen] = useState(false);
  const screen = useRef<HTMLDivElement>(null);
  const top = useRef<HTMLElement>(null);
  const pods = useRef<HTMLDivElement>(null);
  const dock = useRef<HTMLDivElement>(null);
  const foot = useRef<HTMLElement>(null);
  const chrome = useRef<(HTMLElement | null)[]>([]);
  const canvas = useRef<HTMLCanvasElement>(null);
  const round = Math.min(state.view?.round ?? 1, MAX_ROUNDS);
  const latest = state.log[state.log.length - 1];

  useLayoutEffect(() => {
    chrome.current = [top.current, pods.current, foot.current];
  }, []);
  useBoardFit(screen, chrome);

  useEffect(() => (canvas.current ? attachParticles(canvas.current) : undefined), []);

  useEffect(() => {
    if (state.result) setMenuOpen(false);
  }, [state.result]);

  return (
    <div ref={screen} className="ty-screen ty-board-screen" style={{ '--ty-board-bg': `url(${bgUrl})` } as CSSProperties}>
      <header ref={top} className="ty-s6-top">
        <img className="ty-s6-logo" src={logoUrl} alt="Cờ Tỷ Phú" draggable={false} />
        <span className="ui-chip ty-s6-roundchip" aria-label={`Vòng ${round} trên ${MAX_ROUNDS}`}>
          <span id="ty-s6-round">
            {round >= MAX_ROUNDS ? 'Vòng cuối' : 'Vòng'} {round}/{MAX_ROUNDS}
          </span>
          {state.result ? null : (
            <>
              <i className="ty-s6-sep" aria-hidden="true" />
              <GameClock />
            </>
          )}
        </span>
        <UiIconButton icon={state.soundOn ? 'volume-on' : 'volume-off'} label={state.soundOn ? 'Tắt âm' : 'Bật âm'} size="sm" aria-pressed={state.soundOn} onClick={state.toggleSound} />
        <div className="ty-board-menu">
          <UiIconButton icon="more" label="Thêm tùy chọn" size="sm" aria-expanded={menuOpen} onClick={() => setMenuOpen((open) => !open)} />
          {menuOpen ? <BoardMenu onClose={() => setMenuOpen(false)} /> : null}
        </div>
      </header>

      <div className="ty-s6-boardwrap" onPointerDownCapture={state.replaying ? state.skipReplay : undefined}>
        <Board onTileTap={(idx) => state.openSheet({ kind: 'tile', idx })}>
          <BoardCenter />
        </Board>
      </div>

      <div ref={pods}>
        <PlayerPods />
      </div>

      <div ref={dock} className="ty-s6-dockwrap">
        <ActionDock />
      </div>

      <footer ref={foot} className="ty-s6-foot">
        <UiIconButton icon="deed" label="Tài sản" size="sm" onClick={() => state.openSheet({ kind: 'assets', seat: state.you >= 0 ? state.you : (state.view?.turn ?? 0) })} />
        <button type="button" className="ty-s6-ticker" aria-label="Xem toàn bộ diễn biến" onClick={() => state.openSheet({ kind: 'log' })}>
          <span key={latest?.seq} className={`ty-log-${latest?.tone ?? 'neutral'}`}>
            {latest ? logLineText(latest) : 'Ván mới bắt đầu'}
          </span>
        </button>
        <UiIconButton icon="history" label="Diễn biến" size="sm" onClick={() => state.openSheet({ kind: 'log' })} />
        {state.practice || state.spectating ? null : (
          <UiIconButton
            icon="chat"
            label={state.chatUnread ? 'Trò chuyện, có tin mới' : 'Trò chuyện'}
            size="sm"
            className={state.chatUnread ? 'ty-chat-unread' : undefined}
            onClick={() => state.openSheet({ kind: 'chat' })}
          />
        )}
      </footer>

      <ConnectionBanner />
      <canvas ref={canvas} className="ty-s6-fx" aria-hidden="true" />
      <div className="ty-s6-vignette" id="ty-s6-vignette" />
      <div className="ty-s6-banner" id="ty-s6-banner" hidden />
      <img className="ty-s6-bust" id="ty-s6-bust" alt="" hidden />

      {!state.result && state.sheet?.kind === 'tile' ? <TileSheet key={state.sheet.idx} idx={state.sheet.idx} /> : null}
      {!state.result && state.sheet?.kind === 'assets' ? <AssetsSheet seat={state.sheet.seat} /> : null}
      {!state.result && state.sheet?.kind === 'log' ? <LogSheet /> : null}
      {!state.result && state.sheet?.kind === 'chat' ? <ChatSheet /> : null}
      <ReactionBubbles />
      {!state.result ? <BuyModal /> : null}
      {!state.result ? <DebtModal /> : null}
    </div>
  );
}
