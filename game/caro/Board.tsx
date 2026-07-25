import { useEffect, useRef, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { assetBg, assetSrc } from './assets';
import { SIZE } from './types';
import { useCaroStore } from './store';
import { ConfirmModal } from './ConfirmModal';

const CELLS = Array.from({ length: SIZE * SIZE }, (_, i) => i);

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
  const {
    me,
    op,
    overlay,
    status,
    myTurn,
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
          <div id="board" className={myTurn ? 'playable' : ''}>
            {CELLS.map((i) => {
              const mark = board[i];
              const cls = 'cell' + (mark ? ` p${mark}` : '') + (i === lastIdx ? ' last' : '');
              const x = i % SIZE;
              const y = Math.floor(i / SIZE);
              return <div key={i} className={cls} onClick={() => placeMove(x, y)} />;
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
