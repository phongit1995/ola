import {
  useEffect,
  useLayoutEffect,
  useRef,
  useState,
  type PointerEvent as ReactPointerEvent,
} from 'react';
import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from './assets';
import { SIZE } from './types';
import { useCaroStore } from './store';
import { ConfirmModal } from './ConfirmModal';

const CELLS = Array.from({ length: SIZE * SIZE }, (_, i) => i);

const DRAG_THRESHOLD = 6;

interface PanPoint {
  x: number;
  y: number;
}

interface PanBounds {
  minX: number;
  maxX: number;
  minY: number;
  maxY: number;
}

function clampPan(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), Math.max(min, max));
}

// The board (grid) is bigger than the clip window and pans inside it.
// When an axis fits (board <= clip) it stays centered; when it overflows it pans.
function panBounds(clip: Pick<DOMRect, 'width' | 'height'>, board: Pick<DOMRect, 'width' | 'height'>): PanBounds {
  const slackX = clip.width - board.width;
  const slackY = clip.height - board.height;
  return {
    minX: slackX >= 0 ? slackX / 2 : slackX,
    maxX: slackX >= 0 ? slackX / 2 : 0,
    minY: slackY >= 0 ? slackY / 2 : slackY,
    maxY: slackY >= 0 ? slackY / 2 : 0,
  };
}

function clampPanPoint(point: PanPoint, bounds: PanBounds): PanPoint {
  return {
    x: clampPan(point.x, bounds.minX, bounds.maxX),
    y: clampPan(point.y, bounds.minY, bounds.maxY),
  };
}

function centerPan(bounds: PanBounds): PanPoint {
  return {
    x: (bounds.minX + bounds.maxX) / 2,
    y: (bounds.minY + bounds.maxY) / 2,
  };
}

function revealCell(
  current: PanPoint,
  index: number,
  clip: Pick<DOMRect, 'width' | 'height'>,
  board: Pick<DOMRect, 'width' | 'height'>,
  bounds: PanBounds,
): PanPoint {
  const cellWidth = board.width / SIZE;
  const cellHeight = board.height / SIZE;
  const x = index % SIZE;
  const y = Math.floor(index / SIZE);
  const marginX = cellWidth * 0.6;
  const marginY = cellHeight * 0.6;
  const left = current.x + x * cellWidth;
  const right = left + cellWidth;
  const top = current.y + y * cellHeight;
  const bottom = top + cellHeight;
  let nextX = current.x;
  let nextY = current.y;

  if (left < marginX) nextX += marginX - left;
  else if (right > clip.width - marginX) nextX -= right - (clip.width - marginX);
  if (top < marginY) nextY += marginY - top;
  else if (bottom > clip.height - marginY) nextY -= bottom - (clip.height - marginY);

  return clampPanPoint({ x: nextX, y: nextY }, bounds);
}

function formatKen(value: number): string {
  return value.toLocaleString('vi-VN', { maximumFractionDigits: 0 });
}

function RoomOwnerIcon() {
  return (
    <span className="room-owner-icon" role="img" aria-label="Chủ phòng" title="Chủ phòng">
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <path d="M4 8l4.2 3.2L12 5l3.8 6.2L20 8l-1.5 9h-13L4 8Z" />
        <path d="M6 19h12" />
      </svg>
    </span>
  );
}

export function Board() {
  const [chatInput, setChatInput] = useState('');
  const [exitOpen, setExitOpen] = useState(false);
  const [forfeitOpen, setForfeitOpen] = useState(false);
  const chatLogRef = useRef<HTMLDivElement>(null);
  const clipRef = useRef<HTMLDivElement>(null);
  const boardRef = useRef<HTMLDivElement>(null);
  const [pan, setPan] = useState({ x: 0, y: 0 });
  const dragRef = useRef<{
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
  } | null>(null);
  const {
    me,
    op,
    overlay,
    status,
    myTurn,
    movePending,
    showTimer,
    timerText,
    timerUrgent,
    turnArrowSrc,
    board,
    lastIdx,
    turnAnnounce,
    winLine,
    replayVisible,
    forfeitDisabled,
    messages,
    matchSeq,
    betDeductionVisible,
    boardMode,
    roomWaiting,
    roomActionPending,
    bet,
    result,
    toast,
  } = useCaroStore(
    useShallow((s) => ({
      me: s.me,
      op: s.op,
      overlay: s.overlay,
      status: s.status,
      myTurn: s.myTurn,
      movePending: s.movePending,
      showTimer: s.showTimer,
      timerText: s.timerText,
      timerUrgent: s.timerUrgent,
      turnArrowSrc: s.turnArrowSrc,
      board: s.board,
      lastIdx: s.lastIdx,
      turnAnnounce: s.turnAnnounce,
      winLine: s.winLine,
      replayVisible: s.replayVisible,
      forfeitDisabled: s.forfeitDisabled,
      messages: s.messages,
      matchSeq: s.matchSeq,
      betDeductionVisible: s.betDeductionVisible,
      boardMode: s.boardMode,
      roomWaiting: s.roomWaiting,
      roomActionPending: s.roomActionPending,
      bet: s.bet,
      result: s.result,
      toast: s.toast,
    })),
  );
  const {
    placeMove,
    again,
    cancelSearch,
    toLobby,
    replay,
    forfeit,
    exitMatch,
    sendChat,
    cancelRoom,
    toggleRoomReady,
    startRoom,
    kickRoomGuest,
  } = useCaroStore(
    useShallow((s) => ({
      placeMove: s.placeMove,
      again: s.again,
      cancelSearch: s.cancelSearch,
      toLobby: s.toLobby,
      replay: s.replay,
      forfeit: s.forfeit,
      exitMatch: s.exitMatch,
      sendChat: s.sendChat,
      cancelRoom: s.cancelRoom,
      toggleRoomReady: s.toggleRoomReady,
      startRoom: s.startRoom,
      kickRoomGuest: s.kickRoomGuest,
    })),
  );
  const pregame = boardMode === 'pregame';
  const playing = boardMode === 'playing';
  const meInRoom = roomWaiting?.members.find((member) => member.id === roomWaiting.youId);
  const opponentInRoom = roomWaiting?.members.find((member) => member.id !== roomWaiting.youId);
  const isRoomOwner = roomWaiting != null && roomWaiting.ownerId === roomWaiting.youId;
  const roomFull = roomWaiting?.members.length === 2;
  const roomCanStart = roomFull === true && roomWaiting.members.some((member) => !member.owner && member.ready);
  const chatEnabled = result == null && (playing || (pregame && roomFull === true));
  const roomBusy = roomActionPending != null;
  const betText = formatKen(bet);
  const showBetDeduction = playing && result == null && betDeductionVisible;
  const winnerPayoutText = result?.winnerPayout != null ? formatKen(result.winnerPayout) : '';
  const showWinnerPayout = result?.winnerPayout != null && result.winnerPayout > 0 && !replayVisible;

  useEffect(() => {
    setChatInput('');
  }, [matchSeq]);

  useEffect(() => {
    if (!playing) setForfeitOpen(false);
  }, [playing]);

  useEffect(() => {
    if (!result) return;
    setExitOpen(false);
    setForfeitOpen(false);
  }, [result]);

  useEffect(() => {
    if (boardMode === 'idle') setExitOpen(false);
  }, [boardMode]);

  useEffect(() => {
    const log = chatLogRef.current;
    if (log) log.scrollTop = log.scrollHeight;
  }, [messages.length]);

  useLayoutEffect(() => {
    const clip = clipRef.current;
    const board = boardRef.current;
    if (!clip || !board) return;
    const resize = (recenter: boolean): void => {
      const bounds = panBounds(clip.getBoundingClientRect(), board.getBoundingClientRect());
      setPan((current) => {
        const next = recenter ? centerPan(bounds) : clampPanPoint(current, bounds);
        return next.x === current.x && next.y === current.y ? current : next;
      });
    };

    resize(true);
    const observer = new ResizeObserver(() => resize(false));
    const onWindowResize = (): void => resize(false);
    observer.observe(clip);
    observer.observe(board);
    window.addEventListener('resize', onWindowResize);
    return () => {
      observer.disconnect();
      window.removeEventListener('resize', onWindowResize);
    };
  }, [matchSeq]);

  useLayoutEffect(() => {
    if (lastIdx < 0) return;
    const clip = clipRef.current;
    const board = boardRef.current;
    if (!clip || !board) return;
    const clipRect = clip.getBoundingClientRect();
    const boardRect = board.getBoundingClientRect();
    const bounds = panBounds(clipRect, boardRect);
    setPan((current) => {
      const next = revealCell(current, lastIdx, clipRect, boardRect, bounds);
      return next.x === current.x && next.y === current.y ? current : next;
    });
  }, [lastIdx, matchSeq]);

  const onBoardPointerDown = (event: ReactPointerEvent<HTMLDivElement>): void => {
    if (!event.isPrimary || event.button !== 0 || dragRef.current) return;
    if (event.target instanceof Element && event.target.closest('button')) return;
    const clip = clipRef.current;
    const board = boardRef.current;
    if (!clip || !board) return;
    const bounds = panBounds(clip.getBoundingClientRect(), board.getBoundingClientRect());
    dragRef.current = {
      startX: event.clientX,
      startY: event.clientY,
      baseX: pan.x,
      baseY: pan.y,
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
    setPan({
      x: clampPan(drag.baseX + dx, drag.minX, drag.maxX),
      y: clampPan(drag.baseY + dy, drag.minY, drag.maxY),
    });
  };

  const onBoardPointerUp = (event: ReactPointerEvent<HTMLDivElement>): void => {
    const drag = dragRef.current;
    if (!drag || drag.pointerId !== event.pointerId) return;
    dragRef.current = null;
    const clip = clipRef.current;
    if (clip?.hasPointerCapture(event.pointerId)) clip.releasePointerCapture(event.pointerId);
    if (drag.moved) return;
    const board = boardRef.current;
    if (!board) return;
    const rect = board.getBoundingClientRect();
    const x = Math.floor((event.clientX - rect.left) / (rect.width / SIZE));
    const y = Math.floor((event.clientY - rect.top) / (rect.height / SIZE));
    if (x < 0 || x >= SIZE || y < 0 || y >= SIZE) return;
    placeMove(x, y);
  };

  const onBoardPointerCancel = (event: ReactPointerEvent<HTMLDivElement>): void => {
    if (dragRef.current?.pointerId !== event.pointerId) return;
    dragRef.current = null;
  };

  const send = (): void => {
    sendChat(chatInput);
    setChatInput('');
  };
  return (
    <div id="app" style={assetBg('boardBg')}>
      <header id="topbar">
        <div className={'player' + (op.active ? ' active' : '')} id="player-op">
          <div className="player-avatar">
            <div className="p-avatar" style={assetBg('boardAvatarFrame')}>
              <img className="p-vip" src={op.vip} alt="" />
            </div>
            {op.owner && <RoomOwnerIcon />}
            {showBetDeduction && (
              <span key={`op-bet-${matchSeq}`} className="player-ken-change debit">
                -{betText} KEN
              </span>
            )}
            {showWinnerPayout && result != null && !result.win && (
              <span key={`op-payout-${result.matchId}`} className="player-ken-change credit">
                +{winnerPayoutText} KEN
              </span>
            )}
          </div>
          <div className="name-row">
            <span className="name">{op.name}</span>
            {playing && <span className={`mark ${op.mark}`}>{op.mark === 'x' ? 'X' : 'O'}</span>}
          </div>
          {pregame && opponentInRoom && !opponentInRoom.owner && (
            <span className={'room-ready-state' + (opponentInRoom.ready ? ' ready' : '')}>
              {opponentInRoom.ready ? 'Sẵn sàng' : 'Chưa sẵn sàng'}
            </span>
          )}
        </div>
        <div id="center">
          <div
            id="timer"
            className={[showTimer ? '' : 'hidden', myTurn ? 'mine' : 'opponent', timerUrgent ? 'urgent' : '']
              .filter(Boolean)
              .join(' ')}
            style={assetBg(myTurn ? 'boardTimerFrameMine' : 'boardTimerFrame')}
          >
            <span id="timer-val">{timerText}</span>
          </div>
          <img id="turn-arrow" className={turnArrowSrc ? '' : 'hidden'} src={turnArrowSrc ?? undefined} alt="" />
          {!pregame && <div id="status">{status}</div>}
        </div>
        <div className={'player right' + (me.active ? ' active' : '')} id="player-me">
          <div className="player-avatar">
            <div className="p-avatar" style={assetBg('boardAvatarFrame')}>
              <img className="p-vip" src={me.vip} alt="" />
            </div>
            {me.owner && <RoomOwnerIcon />}
            {showBetDeduction && (
              <span key={`me-bet-${matchSeq}`} className="player-ken-change debit">
                -{betText} KEN
              </span>
            )}
            {showWinnerPayout && result != null && result.win && (
              <span key={`me-payout-${result.matchId}`} className="player-ken-change credit">
                +{winnerPayoutText} KEN
              </span>
            )}
          </div>
          <div className="name-row">
            <span className="name">{me.name}</span>
            {playing && <span className={`mark ${me.mark}`}>{me.mark === 'x' ? 'X' : 'O'}</span>}
          </div>
          {pregame && meInRoom && !meInRoom.owner && (
            <span className={'room-ready-state' + (meInRoom.ready ? ' ready' : '')}>{meInRoom.ready ? 'Sẵn sàng' : 'Chưa sẵn sàng'}</span>
          )}
        </div>
      </header>

      <main id="board-wrap">
        {turnAnnounce && (
          <div key={turnAnnounce.id} className={'turn-announce ' + (turnAnnounce.mine ? 'mine' : 'foe')}>
            {turnAnnounce.text}
          </div>
        )}
        <div
          id="board-frame"
          className={timerUrgent && myTurn ? 'urgent' : ''}
          style={assetBg('boardFrame')}
        >
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
              style={{ transform: `translate(${pan.x}px, ${pan.y}px)` }}
              aria-busy={movePending}
            >
              {CELLS.map((i) => {
                const mark = board[i];
                const cls = 'cell' + (mark ? ` p${mark}` : '') + (i === lastIdx ? ' last' : '');
                return <div key={i} className={cls} />;
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
            <h2 id="overlay-title" className={overlay?.kind === 'win' ? 'win' : overlay?.kind === 'lose' ? 'lose' : ''}>
              {overlay?.title ?? 'Cờ Caro'}
            </h2>
            <p id="overlay-sub">{overlay?.sub ?? '5 quân liên tiếp để thắng'}</p>
            <div id="overlay-actions">
              <button type="button" id="btn-again" className={overlay?.actions.includes('again') ? '' : 'hidden'} onClick={again}>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
                  <path d="M3 12a9 9 0 1 0 2.6-6.3L3 8" />
                  <path d="M3 3v5h5" />
                </svg>
                Chơi lại
              </button>
              <button type="button" id="btn-cancel" className={`secondary ${overlay?.actions.includes('cancel') ? '' : 'hidden'}`} onClick={cancelSearch}>
                Hủy tìm trận
              </button>
              <button type="button" id="btn-lobby" className={`secondary ${overlay?.actions.includes('lobby') ? '' : 'hidden'}`} onClick={toLobby}>
                Về sảnh
              </button>
            </div>
          </div>
        </div>
      </main>

      <div id="chatbox" style={assetBg('chatFrame')}>
        <div id="chat-log" ref={chatLogRef}>
          {messages.map((m) => (
            <div key={m.id} className="chat-msg">
              {m.who && <span className="chat-who">{m.who}: </span>}
              {m.text}
            </div>
          ))}
        </div>
        <form
          id="chat-input-row"
          onSubmit={(e) => {
            e.preventDefault();
            send();
          }}
        >
          <input
            id="chat-input"
            type="text"
            autoComplete="off"
            maxLength={120}
            disabled={!chatEnabled}
            placeholder={pregame && !roomFull ? 'CHỜ ĐỦ HAI NGƯỜI...' : 'NHẬP TIN NHẮN...'}
            value={chatInput}
            onChange={(e) => setChatInput(e.target.value)}
          />
          <button type="submit" className="chat-send" aria-label="Gửi" disabled={!chatEnabled}>
            <img src={assetSrc('sendIcon')} alt="" />
          </button>
        </form>
      </div>

      <footer id="bottombar" className={pregame ? 'pregame' : ''}>
        {pregame ? (
          <>
            {isRoomOwner && opponentInRoom && (
              <button type="button" style={assetBg('boardMenuBtn')} disabled={roomBusy} onClick={kickRoomGuest}>
                Mời ra
              </button>
            )}
            <button
              type="button"
              id="btn-exit"
              className="board-action-btn"
              style={assetBg('boardMenuBtn')}
              disabled={roomBusy || !roomWaiting}
              onClick={() => setExitOpen(true)}
            >
              <img className="board-action-icon" src={assetSrc('icExit')} alt="" />
              <span>Thoát bàn</span>
            </button>
          </>
        ) : (
          <>
            <button
              type="button"
              id="btn-replay"
              className={replayVisible ? '' : 'hidden'}
              style={assetBg('boardMenuBtn')}
              disabled={result != null}
              onClick={replay}
            >
              Chơi lại
            </button>
            <button
              type="button"
              id="btn-forfeit"
              className="board-action-btn"
              style={assetBg('boardMenuBtn')}
              disabled={forfeitDisabled}
              onClick={() => setForfeitOpen(true)}
            >
              <img className="board-action-icon" src={assetSrc('boardForfeitIcon')} alt="" />
              <span>Bỏ cuộc</span>
            </button>
            <button
              type="button"
              id="btn-exit"
              className="board-action-btn"
              style={assetBg('boardMenuBtn')}
              disabled={result != null}
              onClick={() => setExitOpen(true)}
            >
              <img className="board-action-icon" src={assetSrc('icExit')} alt="" />
              <span>Thoát</span>
            </button>
          </>
        )}
      </footer>

      <div id="board-toast" className={toast && boardMode !== 'idle' ? 'show' : 'hidden'}>
        {toast}
      </div>

      <ConfirmModal
        open={exitOpen}
        text={
          pregame
            ? isRoomOwner
              ? 'Thoát bàn sẽ đóng phòng. Thoát chứ?'
              : 'Bạn sẽ rời bàn; chủ phòng vẫn ở lại. Thoát chứ?'
            : 'Thoát sẽ bị xử thua và rời bàn. Thoát chứ?'
        }
        onConfirm={() => {
          setExitOpen(false);
          if (pregame) cancelRoom();
          else exitMatch();
        }}
        onCancel={() => setExitOpen(false)}
      />
      <ConfirmModal
        open={forfeitOpen}
        icon="boardForfeitIcon"
        text="Bạn sẽ bị xử thua ván này. Cả hai vẫn ở lại bàn để chơi ván tiếp theo."
        confirmLabel="Bỏ cuộc"
        cancelLabel="Tiếp tục"
        onConfirm={() => {
          setForfeitOpen(false);
          forfeit();
        }}
        onCancel={() => setForfeitOpen(false)}
      />
    </div>
  );
}
