import {
  useLayoutEffect,
  useRef,
  type KeyboardEvent as ReactKeyboardEvent,
  type PointerEvent as ReactPointerEvent,
} from 'react';
import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from '../../../assets';
import { formatKen } from '../../../helpers/format';
import { useCaro } from '../../../store/useCaro';
import { SIZE } from '../../../types';
import { centerPan, clampPan, clampPanPoint, panBounds, revealCell } from '../helpers/pan';
import { useBoard } from '../useBoard';

const CELLS = Array.from({ length: SIZE * SIZE }, (_, index) => index);
const DRAG_THRESHOLD = 6;

interface BoardDrag {
  startX: number;
  startY: number;
  baseX: number;
  baseY: number;
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
  moved: boolean;
  pointerId: number;
}

export function GameBoard() {
  const clipRef = useRef<HTMLDivElement>(null);
  const boardRef = useRef<HTMLDivElement>(null);
  const dragRef = useRef<BoardDrag | null>(null);
  const panRef = useRef({ x: 0, y: 0 });
  const pendingPanRef = useRef({ x: 0, y: 0 });
  const panFrameRef = useRef<number | null>(null);
  const { pan, setPan } = useBoard(
    useShallow((state) => ({
      pan: state.pan,
      setPan: state.setPan,
    })),
  );
  const {
    overlay,
    status,
    myTurn,
    movePending,
    timerUrgent,
    board,
    lastIdx,
    turnAnnounce,
    winLine,
    matchSeq,
    boardMode,
    roomWaiting,
    roomActionPending,
    bet,
    result,
    placeMove,
    again,
    cancelSearch,
    toLobby,
    toggleRoomReady,
    startRoom,
  } = useCaro(
    useShallow((state) => ({
      overlay: state.overlay,
      status: state.status,
      myTurn: state.myTurn,
      movePending: state.movePending,
      timerUrgent: state.timerUrgent,
      board: state.board,
      lastIdx: state.lastIdx,
      turnAnnounce: state.turnAnnounce,
      winLine: state.winLine,
      matchSeq: state.matchSeq,
      boardMode: state.boardMode,
      roomWaiting: state.roomWaiting,
      roomActionPending: state.roomActionPending,
      bet: state.bet,
      result: state.result,
      placeMove: state.placeMove,
      again: state.again,
      cancelSearch: state.cancelSearch,
      toLobby: state.toLobby,
      toggleRoomReady: state.toggleRoomReady,
      startRoom: state.startRoom,
    })),
  );
  const pregame = boardMode === 'pregame';
  const meInRoom = roomWaiting?.members.find((member) => member.id === roomWaiting.youId);
  const isRoomOwner = roomWaiting != null && roomWaiting.ownerId === roomWaiting.youId;
  const roomFull = roomWaiting?.members.length === 2;
  const roomCanStart = roomFull === true && roomWaiting.members.some((member) => !member.owner && member.ready);
  const roomBusy = roomActionPending != null;
  const betText = formatKen(bet);
  const keyboardStartIdx = Math.max(0, board.findIndex((mark) => mark === 0));

  useLayoutEffect(() => {
    panRef.current = pan;
    pendingPanRef.current = pan;
    if (!dragRef.current && boardRef.current) {
      boardRef.current.style.transform = `translate3d(${pan.x}px, ${pan.y}px, 0)`;
    }
  }, [pan]);

  useLayoutEffect(
    () => () => {
      if (panFrameRef.current != null) cancelAnimationFrame(panFrameRef.current);
    },
    [],
  );

  const applyPanTransform = (next: { x: number; y: number }): void => {
    panRef.current = next;
    const boardElement = boardRef.current;
    if (boardElement) boardElement.style.transform = `translate3d(${next.x}px, ${next.y}px, 0)`;
  };

  const schedulePanTransform = (next: { x: number; y: number }): void => {
    pendingPanRef.current = next;
    if (panFrameRef.current != null) return;
    panFrameRef.current = requestAnimationFrame(() => {
      panFrameRef.current = null;
      applyPanTransform(pendingPanRef.current);
    });
  };

  const commitPan = (next = pendingPanRef.current): void => {
    if (panFrameRef.current != null) {
      cancelAnimationFrame(panFrameRef.current);
      panFrameRef.current = null;
    }
    pendingPanRef.current = next;
    applyPanTransform(next);
    setPan((current) => (current.x === next.x && current.y === next.y ? current : next));
  };

  useLayoutEffect(() => {
    const clip = clipRef.current;
    const boardElement = boardRef.current;
    if (!clip || !boardElement) return;
    const resize = (recenter: boolean): void => {
      const bounds = panBounds(clip.getBoundingClientRect(), boardElement.getBoundingClientRect());
      setPan((current) => {
        const next = recenter ? centerPan(bounds) : clampPanPoint(current, bounds);
        return next.x === current.x && next.y === current.y ? current : next;
      });
    };

    resize(true);
    const observer = new ResizeObserver(() => resize(false));
    const onWindowResize = (): void => resize(false);
    observer.observe(clip);
    observer.observe(boardElement);
    window.addEventListener('resize', onWindowResize);
    return () => {
      observer.disconnect();
      window.removeEventListener('resize', onWindowResize);
    };
  }, [matchSeq]);

  useLayoutEffect(() => {
    if (lastIdx < 0) return;
    const clip = clipRef.current;
    const boardElement = boardRef.current;
    if (!clip || !boardElement) return;
    const clipRect = clip.getBoundingClientRect();
    const boardRect = boardElement.getBoundingClientRect();
    const bounds = panBounds(clipRect, boardRect);
    setPan((current) => {
      const next = revealCell(current, lastIdx, clipRect, boardRect, bounds);
      return next.x === current.x && next.y === current.y ? current : next;
    });
  }, [lastIdx, matchSeq]);

  const onBoardPointerDown = (event: ReactPointerEvent<HTMLDivElement>): void => {
    if (!event.isPrimary || event.button !== 0 || dragRef.current) return;
    if (event.target instanceof Element && event.target.closest('button:not(.cell)')) return;
    const clip = clipRef.current;
    const boardElement = boardRef.current;
    if (!clip || !boardElement) return;
    const bounds = panBounds(clip.getBoundingClientRect(), boardElement.getBoundingClientRect());
    dragRef.current = {
      startX: event.clientX,
      startY: event.clientY,
      baseX: panRef.current.x,
      baseY: panRef.current.y,
      minX: bounds.minX,
      maxX: bounds.maxX,
      minY: bounds.minY,
      maxY: bounds.maxY,
      moved: false,
      pointerId: event.pointerId,
    };
    clip.setPointerCapture(event.pointerId);
  };

  const onBoardPointerMove = (event: ReactPointerEvent<HTMLDivElement>): void => {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== event.pointerId) return;
    const dx = event.clientX - drag.startX;
    const dy = event.clientY - drag.startY;
    if (Math.abs(dx) > DRAG_THRESHOLD || Math.abs(dy) > DRAG_THRESHOLD) drag.moved = true;
    if (!drag.moved) return;
    schedulePanTransform({
      x: clampPan(drag.baseX + dx, drag.minX, drag.maxX),
      y: clampPan(drag.baseY + dy, drag.minY, drag.maxY),
    });
  };

  const onBoardPointerUp = (event: ReactPointerEvent<HTMLDivElement>): void => {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== event.pointerId) return;
    const clip = clipRef.current;
    if (clip?.hasPointerCapture(event.pointerId)) clip.releasePointerCapture(event.pointerId);
    if (drag.moved) {
      commitPan({
        x: clampPan(drag.baseX + event.clientX - drag.startX, drag.minX, drag.maxX),
        y: clampPan(drag.baseY + event.clientY - drag.startY, drag.minY, drag.maxY),
      });
      dragRef.current = null;
      return;
    }
    dragRef.current = null;
    const boardElement = boardRef.current;
    if (!boardElement) return;
    const rect = boardElement.getBoundingClientRect();
    const x = Math.floor((event.clientX - rect.left) / (rect.width / SIZE));
    const y = Math.floor((event.clientY - rect.top) / (rect.height / SIZE));
    if (x < 0 || x >= SIZE || y < 0 || y >= SIZE) return;
    placeMove(x, y);
  };

  const onBoardPointerCancel = (event: ReactPointerEvent<HTMLDivElement>): void => {
    if (dragRef.current?.pointerId !== event.pointerId) return;
    dragRef.current = null;
    commitPan();
  };

  const onCellKeyDown = (event: ReactKeyboardEvent<HTMLButtonElement>, index: number): void => {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      if (board[index] === 0) placeMove(index % SIZE, Math.floor(index / SIZE));
      return;
    }
    const direction =
      event.key === 'ArrowLeft'
        ? [-1, 0]
        : event.key === 'ArrowRight'
          ? [1, 0]
          : event.key === 'ArrowUp'
            ? [0, -1]
            : event.key === 'ArrowDown'
              ? [0, 1]
              : null;
    if (!direction) return;
    event.preventDefault();
    const x = Math.min(SIZE - 1, Math.max(0, (index % SIZE) + direction[0]));
    const y = Math.min(SIZE - 1, Math.max(0, Math.floor(index / SIZE) + direction[1]));
    boardRef.current?.querySelector<HTMLButtonElement>(`.cell[data-index="${y * SIZE + x}"]`)?.focus();
  };

  return (
    <main id="board-wrap">
      {turnAnnounce && (
        <div key={turnAnnounce.id} className={'turn-announce ' + (turnAnnounce.mine ? 'mine' : 'foe')}>
          {turnAnnounce.text}
        </div>
      )}
      <div id="board-frame" className={timerUrgent && myTurn ? 'urgent' : ''} style={assetBg('boardFrame')}>
        {boardMode !== 'idle' && (
          <div
            className="board-bet-badge"
            style={assetBg('kenFrame')}
            role="status"
            aria-label={`Cược ${betText} Ken`}
          >
            <span>{betText}</span>
            <img src={assetSrc('icKen')} alt="" />
          </div>
        )}
        <div
          id="board-clip"
          ref={clipRef}
          onPointerDown={onBoardPointerDown}
          onPointerMove={onBoardPointerMove}
          onPointerUp={onBoardPointerUp}
          onPointerCancel={onBoardPointerCancel}
        >
          <div
            id="board"
            ref={boardRef}
            className={myTurn && !movePending ? 'playable' : ''}
            style={{ transform: `translate3d(${pan.x}px, ${pan.y}px, 0)` }}
            role="grid"
            aria-label="Bàn cờ Caro 20 nhân 20"
            aria-busy={movePending}
          >
            {CELLS.map((index) => {
              const mark = board[index];
              const className = 'cell' + (mark ? ` p${mark}` : '') + (index === lastIdx ? ' last' : '');
              const x = index % SIZE;
              const y = Math.floor(index / SIZE);
              const label = mark === 1 ? 'quân X' : mark === 2 ? 'quân O' : 'ô trống';
              return (
                <button
                  key={index}
                  type="button"
                  className={className}
                  data-index={index}
                  role="gridcell"
                  tabIndex={index === keyboardStartIdx ? 0 : -1}
                  aria-label={`Hàng ${y + 1}, cột ${x + 1}, ${label}`}
                  aria-disabled={!myTurn || movePending || mark !== 0}
                  onKeyDown={(event) => onCellKeyDown(event, index)}
                  onClick={(event) => {
                    if (event.detail === 0 && mark === 0) placeMove(x, y);
                  }}
                />
              );
            })}
            {winLine && (
              <svg className="win-line-svg" viewBox={`0 0 ${SIZE} ${SIZE}`} preserveAspectRatio="none" aria-hidden="true">
                <line
                  className="win-line-bg"
                  x1={winLine.x1 + 0.5}
                  y1={winLine.y1 + 0.5}
                  x2={winLine.x2 + 0.5}
                  y2={winLine.y2 + 0.5}
                  pathLength={1}
                />
                <line
                  className="win-line-fg"
                  x1={winLine.x1 + 0.5}
                  y1={winLine.y1 + 0.5}
                  x2={winLine.x2 + 0.5}
                  y2={winLine.y2 + 0.5}
                  pathLength={1}
                />
              </svg>
            )}
            {pregame && !result && (
              <div className="room-pregame-panel">
                <span>{status}</span>
                {roomFull && !isRoomOwner && (
                  <button
                    type="button"
                    className="room-pregame-action"
                    style={assetBg('boardMenuBtn')}
                    disabled={roomBusy}
                    onClick={toggleRoomReady}
                  >
                    {meInRoom?.ready ? 'Hủy sẵn sàng' : 'Sẵn sàng'}
                  </button>
                )}
                {isRoomOwner && roomFull && (
                  <button
                    type="button"
                    className="room-pregame-action"
                    style={assetBg('boardMenuBtn')}
                    disabled={roomBusy || !roomCanStart}
                    onClick={startRoom}
                  >
                    Bắt đầu
                  </button>
                )}
              </div>
            )}
          </div>
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
          <h2
            id="overlay-title"
            className={overlay?.kind === 'win' ? 'win' : overlay?.kind === 'lose' ? 'lose' : ''}
          >
            {overlay?.title ?? 'Cờ Caro'}
          </h2>
          <p id="overlay-sub">{overlay?.sub ?? '5 quân liên tiếp để thắng'}</p>
          <div id="overlay-actions">
            <button
              type="button"
              id="btn-again"
              className={overlay?.actions.includes('again') ? '' : 'hidden'}
              onClick={again}
            >
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                aria-hidden="true"
              >
                <path d="M3 12a9 9 0 1 0 2.6-6.3L3 8" />
                <path d="M3 3v5h5" />
              </svg>
              Chơi lại
            </button>
            <button
              type="button"
              id="btn-cancel"
              className={`secondary ${overlay?.actions.includes('cancel') ? '' : 'hidden'}`}
              onClick={cancelSearch}
            >
              Hủy tìm trận
            </button>
            <button
              type="button"
              id="btn-lobby"
              className={`secondary ${overlay?.actions.includes('lobby') ? '' : 'hidden'}`}
              onClick={toLobby}
            >
              Về sảnh
            </button>
          </div>
        </div>
      </div>
    </main>
  );
}
