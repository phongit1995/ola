import { useEffect, useMemo, useRef, useState } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { GAME_REACTION_TYPE, type GameReactionType } from '../../src/sdk';
import { BoardSurface, squareLeft, squareTop } from '../components/BoardSurface';
import { XqIcon } from '../components/XqIcon';
import { EMPTY, KIND_GENERAL, SIDE_RED, boardX, boardY, flipIndex, pieceFor, pieceKind, pieceSide } from '../logic/board';
import { pieceGlyph, pieceLabel, sideLabel } from '../logic/pieces';
import { formatKen } from '../helpers/format';
import { useXiangqi, type SeatInfo } from '../store/useXiangqi';

const REACTION_EMOJI: Record<GameReactionType, string> = {
  [GAME_REACTION_TYPE.Like]: '👍',
  [GAME_REACTION_TYPE.Love]: '❤️',
  [GAME_REACTION_TYPE.Haha]: '😆',
  [GAME_REACTION_TYPE.Wow]: '😮',
  [GAME_REACTION_TYPE.Sad]: '😢',
  [GAME_REACTION_TYPE.Angry]: '😡',
};

const REACTION_LABEL: Record<GameReactionType, string> = {
  [GAME_REACTION_TYPE.Like]: 'Thích',
  [GAME_REACTION_TYPE.Love]: 'Yêu thích',
  [GAME_REACTION_TYPE.Haha]: 'Cười lớn',
  [GAME_REACTION_TYPE.Wow]: 'Bất ngờ',
  [GAME_REACTION_TYPE.Sad]: 'Buồn',
  [GAME_REACTION_TYPE.Angry]: 'Tức giận',
};

// Mirrors maxChatRunes in server/internal/game/engine/engine.go; anything longer
// is rejected server-side.
const CHAT_MAX_CHARS = 120;

const FULL_SET: number[] = (() => {
  const kinds: Array<[number, number]> = [
    [1, 1], [2, 2], [3, 2], [4, 2], [5, 2], [6, 2], [7, 5],
  ];
  const out: number[] = [];
  for (const [kind, count] of kinds) {
    for (let i = 0; i < count; i++) out.push(kind);
  }
  return out;
})();

function capturedKinds(board: number[], side: number): number[] {
  const remaining = new Map<number, number>();
  for (const piece of board) {
    if (piece !== EMPTY && pieceSide(piece) === side) {
      remaining.set(pieceKind(piece), (remaining.get(pieceKind(piece)) ?? 0) + 1);
    }
  }
  const captured: number[] = [];
  const pool = new Map<number, number>();
  for (const kind of FULL_SET) pool.set(kind, (pool.get(kind) ?? 0) + 1);
  for (const [kind, total] of pool) {
    const missing = total - (remaining.get(kind) ?? 0);
    for (let i = 0; i < missing; i++) captured.push(kind);
  }
  return captured;
}

function PlayerPod({
  seat,
  clockActive,
  secondsLeft,
  urgent,
  captured,
  mine,
}: {
  seat: SeatInfo | null;
  clockActive: boolean;
  secondsLeft: number;
  urgent: boolean;
  captured: number[];
  mine: boolean;
}) {
  if (!seat) return <div className="xq-pod xq-pod-empty" />;
  const red = seat.side === SIDE_RED;
  return (
    <div className={`xq-pod ${clockActive ? 'xq-pod-active' : ''} ${mine ? 'xq-pod-mine' : ''}`}>
      <div className={`xq-pod-avatar ${red ? 'xq-pod-avatar-red' : 'xq-pod-avatar-black'}`}>
        {seat.name.slice(0, 1).toUpperCase()}
      </div>
      <div className="xq-pod-info">
        <div className="xq-pod-name">
          {seat.name}
          <span className={`xq-side-chip ${red ? 'xq-side-chip-red' : 'xq-side-chip-black'}`}>{sideLabel(seat.side)}</span>
        </div>
        <div className="xq-pod-captured" aria-label="Quân đã ăn">
          {captured.slice(0, 8).map((kind, index) => (
            <span key={index} className={`xq-mini-piece ${red ? 'xq-mini-black' : 'xq-mini-red'}`}>
              {pieceGlyph(pieceFor(red ? 1 : 0, kind))}
            </span>
          ))}
          {captured.length > 8 ? <span className="xq-mini-more">+{captured.length - 8}</span> : null}
        </div>
      </div>
      {clockActive ? (
        <div className={`xq-pod-clock ${urgent ? 'xq-pod-clock-urgent' : ''}`} aria-live={mine ? 'polite' : 'off'}>
          {secondsLeft}
        </div>
      ) : null}
    </div>
  );
}

function PregamePanel() {
  const { roomWaiting, userInfo, roomActionPending, setReady, startMatch, leaveRoom, kickOpponent, showNotice } = useXiangqi(
    useShallow((s) => ({
      roomWaiting: s.roomWaiting,
      userInfo: s.userInfo,
      roomActionPending: s.roomActionPending,
      setReady: s.setReady,
      startMatch: s.startMatch,
      leaveRoom: s.leaveRoom,
      kickOpponent: s.kickOpponent,
      showNotice: s.showNotice,
    })),
  );
  if (!roomWaiting) return null;
  const meMember = roomWaiting.members.find((m) => m.id === roomWaiting.youId);
  const opMember = roomWaiting.members.find((m) => m.id !== roomWaiting.youId);
  const isOwner = roomWaiting.ownerId === roomWaiting.youId;
  const owner = roomWaiting.members.find((m) => m.owner);
  const canStart = isOwner && opMember?.ready;
  return (
    <div className="xq-pregame">
      <div className="xq-pregame-panel">
        <h2 className="xq-pregame-title">Bàn của @{owner?.name ?? '...'}</h2>
        <div className="xq-pregame-bet">
          {roomWaiting.bet > 0 ? `Cược ${formatKen(roomWaiting.bet)} KEN` : 'Giao hữu'}
          {roomWaiting.locked ? <XqIcon name="lock" size={15} /> : null}
        </div>
        <div className="xq-pregame-seats">
          {[meMember, opMember].map((member, index) =>
            member ? (
              <div key={member.id} className="xq-seat">
                <div className={`xq-pod-avatar ${member.owner ? 'xq-pod-avatar-red' : 'xq-pod-avatar-black'}`}>
                  {member.name.slice(0, 1).toUpperCase()}
                </div>
                <div className="xq-seat-name">{member.id === roomWaiting.youId ? 'Bạn' : member.name}</div>
                <div className="xq-seat-side">{member.owner ? 'Đỏ — đi trước' : 'Đen'}</div>
                {member.owner ? (
                  <span className="xq-chip xq-chip-gold">Chủ bàn</span>
                ) : member.ready ? (
                  <span className="xq-chip xq-chip-jade">Sẵn sàng</span>
                ) : (
                  <span className="xq-chip">Chưa sẵn sàng</span>
                )}
              </div>
            ) : (
              <div key={`empty-${index}`} className="xq-seat xq-seat-empty">
                <div className="xq-pod-avatar xq-pod-avatar-empty">?</div>
                <div className="xq-seat-name">Đang chờ...</div>
              </div>
            ),
          )}
        </div>
        <div className="xq-pregame-actions">
          {isOwner ? (
            <>
              <button type="button" className="xq-btn xq-btn-gold" disabled={!canStart || roomActionPending === 'starting'} onClick={startMatch}>
                {roomActionPending === 'starting' ? 'Đang bắt đầu...' : 'Bắt đầu'}
              </button>
              {opMember ? (
                <button
                  type="button"
                  className="xq-btn xq-btn-paper"
                  onClick={() =>
                    showNotice({
                      title: 'Mời ra',
                      body: `Mời ${opMember.name} ra khỏi bàn?`,
                      okLabel: 'Mời ra',
                      onOk: () => {
                        kickOpponent();
                        showNotice(null);
                      },
                    })
                  }
                >
                  Mời ra
                </button>
              ) : null}
            </>
          ) : (
            <button type="button" className={`xq-btn ${meMember?.ready ? 'xq-btn-paper' : 'xq-btn-gold'}`} onClick={() => setReady(!meMember?.ready)}>
              {meMember?.ready ? 'Hủy sẵn sàng' : 'Sẵn sàng'}
            </button>
          )}
          <button
            type="button"
            className="xq-btn xq-btn-paper"
            onClick={() =>
              showNotice({
                title: 'Thoát bàn',
                body: isOwner ? 'Thoát bàn sẽ đóng phòng. Thoát chứ?' : 'Bạn sẽ rời bàn; chủ bàn vẫn ở lại.',
                okLabel: 'Thoát bàn',
                danger: true,
                onOk: () => {
                  leaveRoom();
                  showNotice(null);
                },
              })
            }
          >
            Thoát bàn
          </button>
        </div>
        {userInfo ? <div className="xq-pregame-hint">Đủ 2 người và khách bấm Sẵn sàng thì chủ bàn có thể Bắt đầu.</div> : null}
      </div>
    </div>
  );
}

function ChatDrawer() {
  const { messages, chatOpen, chatRestore, closeChat, sendChatText, consumeChatRestore, userInfo } = useXiangqi(
    useShallow((s) => ({
      messages: s.messages,
      chatOpen: s.chatOpen,
      chatRestore: s.chatRestore,
      closeChat: s.closeChat,
      sendChatText: s.sendChatText,
      consumeChatRestore: s.consumeChatRestore,
      userInfo: s.userInfo,
    })),
  );
  const [draft, setDraft] = useState('');
  const listRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (chatOpen) listRef.current?.scrollTo({ top: listRef.current.scrollHeight });
  }, [messages, chatOpen]);

  useEffect(() => {
    if (chatRestore == null) return;
    setDraft((current) => (current ? current : chatRestore));
    consumeChatRestore();
  }, [chatRestore, consumeChatRestore]);

  if (!chatOpen) return null;
  const submit = () => {
    sendChatText(draft);
    setDraft('');
  };
  return (
    <div className="xq-chat" role="dialog" aria-label="Trò chuyện">
      <div className="xq-chat-head">
        <span>Trò chuyện</span>
        <button type="button" className="xq-icon-btn" onClick={closeChat} aria-label="Đóng chat">
          <XqIcon name="close" size={20} />
        </button>
      </div>
      <div className="xq-chat-list" ref={listRef}>
        {messages.length === 0 ? <div className="xq-chat-empty">Chưa có tin nhắn</div> : null}
        {messages.map((message, index) => {
          const mine = message.userId === userInfo?.id;
          return (
            <div key={`${message.sentAt}-${index}`} className={`xq-chat-row ${mine ? 'xq-chat-mine' : ''}`}>
              {!mine ? <span className="xq-chat-name">{message.name}</span> : null}
              <span className="xq-chat-bubble">{message.text}</span>
            </div>
          );
        })}
      </div>
      <form
        className="xq-chat-input"
        onSubmit={(event) => {
          event.preventDefault();
          submit();
        }}
      >
        <input
          value={draft}
          onChange={(event) => setDraft(event.target.value)}
          placeholder="Nhập tin nhắn..."
          maxLength={CHAT_MAX_CHARS}
          aria-label="Tin nhắn"
        />
        <button type="submit" className="xq-btn xq-btn-gold xq-btn-small" disabled={!draft.trim()}>
          <XqIcon name="send" size={17} />
          Gửi
        </button>
      </form>
    </div>
  );
}

export function BoardScreen() {
  const state = useXiangqi(
    useShallow((s) => ({
      boardMode: s.boardMode,
      board: s.board,
      pieces: s.pieces,
      selected: s.selected,
      hints: s.hints,
      lastFrom: s.lastFrom,
      lastTo: s.lastTo,
      checkSeq: s.checkSeq,
      me: s.me,
      op: s.op,
      myTurn: s.myTurn,
      movePending: s.movePending,
      timerLeftMs: s.timerLeftMs,
      turnExpired: s.turnExpired,
      turnAnnounce: s.turnAnnounce,
      bet: s.bet,
      oppAway: s.oppAway,
      chatUnread: s.chatUnread,
      reactionFloats: s.reactionFloats,
      result: s.result,
      tapSquare: s.tapSquare,
      forfeitMatch: s.forfeitMatch,
      exitMatch: s.exitMatch,
      openChat: s.openChat,
      sendReactionType: s.sendReactionType,
    })),
  );
  const [checkVisible, setCheckVisible] = useState(false);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [oppAwayLeft, setOppAwayLeft] = useState(0);

  const mySide = state.me?.side ?? SIDE_RED;
  const flip = mySide !== SIDE_RED;
  const view = (idx: number) => (flip ? flipIndex(idx) : idx);

  useEffect(() => {
    if (state.checkSeq === 0) return;
    setCheckVisible(true);
    const timer = setTimeout(() => setCheckVisible(false), 1400);
    return () => clearTimeout(timer);
  }, [state.checkSeq]);

  useEffect(() => {
    if (!state.oppAway) return;
    const update = () => setOppAwayLeft(Math.max(0, Math.ceil((state.oppAway! - Date.now()) / 1000)));
    update();
    const timer = setInterval(update, 500);
    return () => clearInterval(timer);
  }, [state.oppAway]);

  const capturedByMe = useMemo(() => capturedKinds(state.board, 1 - mySide), [state.board, mySide]);
  const capturedByOp = useMemo(() => capturedKinds(state.board, mySide), [state.board, mySide]);

  const seconds = Math.ceil(state.timerLeftMs / 1000);
  const urgent = seconds <= 10;
  const playing = state.boardMode === 'playing';
  const boardLocked = !playing || state.movePending || !!state.result || state.turnExpired;
  const generalInCheckIdx = useMemo(() => {
    if (!checkVisible) return -1;
    return state.board.indexOf(pieceFor(state.myTurn ? mySide : 1 - mySide, KIND_GENERAL));
  }, [checkVisible, state.board, state.myTurn, mySide]);

  return (
    <div className="xq-screen xq-board-screen">
      <PlayerPod
        seat={state.op}
        clockActive={playing && !state.myTurn && !state.result}
        secondsLeft={seconds}
        urgent={urgent}
        captured={capturedByOp}
        mine={false}
      />

      <div className={`xq-board-wrap ${state.boardMode === 'pregame' ? 'xq-board-dimmed' : ''}`}>
        <BoardSurface />
        {state.bet > 0 ? (
          <div className="xq-bet-badge">
            <XqIcon name="ken" size={15} />
            <span>{formatKen(state.bet)}</span>
          </div>
        ) : null}
        <div className="xq-board-layer">
          {state.lastFrom >= 0 ? (
            <div
              className="xq-last-marker xq-last-from"
              style={{ left: squareLeft(boardX(view(state.lastFrom))), top: squareTop(boardY(view(state.lastFrom))) }}
            />
          ) : null}
          {state.lastTo >= 0 ? (
            <div
              className="xq-last-marker xq-last-to"
              style={{ left: squareLeft(boardX(view(state.lastTo))), top: squareTop(boardY(view(state.lastTo))) }}
            />
          ) : null}
          {state.pieces.map((piece) => {
            const displayIdx = view(piece.idx);
            const red = pieceSide(piece.piece) === SIDE_RED;
            const isSelected = state.selected === piece.idx;
            const isCaptureHint = state.hints.includes(piece.idx);
            const isCheckedGeneral = piece.idx === generalInCheckIdx;
            return (
              <button
                key={piece.key}
                type="button"
                className={[
                  'xq-piece',
                  red ? 'xq-piece-red' : 'xq-piece-black',
                  isSelected ? 'xq-piece-selected' : '',
                  isCaptureHint ? 'xq-piece-capture-hint' : '',
                  isCheckedGeneral ? 'xq-piece-checked' : '',
                ].join(' ')}
                style={{ left: squareLeft(boardX(displayIdx)), top: squareTop(boardY(displayIdx)) }}
                onClick={() => state.tapSquare(piece.idx)}
                disabled={boardLocked}
                aria-label={`${pieceLabel(piece.piece)} ${red ? 'đỏ' : 'đen'}`}
              >
                {pieceGlyph(piece.piece)}
              </button>
            );
          })}
          {state.hints
            .filter((idx) => state.board[idx] === EMPTY)
            .map((idx) => {
              const displayIdx = view(idx);
              return (
                <button
                  key={`hint-${idx}`}
                  type="button"
                  className="xq-hint-dot"
                  style={{ left: squareLeft(boardX(displayIdx)), top: squareTop(boardY(displayIdx)) }}
                  onClick={() => state.tapSquare(idx)}
                  disabled={boardLocked}
                  aria-label={`Đi tới cột ${boardX(displayIdx) + 1} hàng ${boardY(displayIdx) + 1}`}
                />
              );
            })}
        </div>
        {checkVisible ? (
          <div className="xq-check-banner" role="status">
            <XqIcon name="warning" size={20} />
            Chiếu tướng!
          </div>
        ) : null}
        {state.reactionFloats.map((float) => (
          <div key={float.seq} className={`xq-reaction-float ${float.mine ? 'xq-reaction-mine' : ''}`}>
            {REACTION_EMOJI[float.type]}
          </div>
        ))}
      </div>

      <PlayerPod
        seat={state.me}
        clockActive={playing && state.myTurn && !state.result}
        secondsLeft={seconds}
        urgent={urgent}
        captured={capturedByMe}
        mine
      />

      {state.turnAnnounce ? (
        <div className="xq-turn-announce" aria-live="polite">
          {state.turnAnnounce}
        </div>
      ) : null}

      {state.oppAway ? (
        <div className="xq-oppaway" role="status">
          <XqIcon name="wifi-off" size={18} />
          Đối thủ mất kết nối, chờ {oppAwayLeft}s...
        </div>
      ) : null}

      {playing && state.turnExpired && !state.result ? (
        <div className="xq-expired" role="status">
          <XqIcon name="warning" size={18} />
          {state.myTurn ? 'Bạn đã hết giờ — chờ máy chủ xử' : 'Đối thủ đã hết giờ — chờ máy chủ xử'}
        </div>
      ) : null}

      {playing ? (
        <div className="xq-actionbar">
          <button
            type="button"
            className="xq-action"
            onClick={state.openChat}
            aria-label={state.chatUnread ? 'Mở trò chuyện, có tin nhắn mới' : 'Mở trò chuyện'}
          >
            <XqIcon name="chat" size={24} />
            <span className="xq-action-label">Chat</span>
            {state.chatUnread ? <i className="xq-dot" /> : null}
          </button>
          <button
            type="button"
            className="xq-action"
            onClick={() => setPickerOpen((open) => !open)}
            aria-expanded={pickerOpen}
            aria-controls="xq-reaction-picker"
          >
            <XqIcon name="reaction" size={24} />
            <span className="xq-action-label">Cảm xúc</span>
          </button>
          <button type="button" className="xq-action xq-action-danger" onClick={state.forfeitMatch} disabled={!!state.result}>
            <XqIcon name="flag" size={24} />
            <span className="xq-action-label">Bỏ cuộc</span>
          </button>
          <button type="button" className="xq-action" onClick={state.exitMatch}>
            <XqIcon name="exit-door" size={24} />
            <span className="xq-action-label">Thoát</span>
          </button>
        </div>
      ) : null}

      {pickerOpen ? (
        <div className="xq-reaction-picker" id="xq-reaction-picker" role="toolbar" aria-label="Chọn cảm xúc">
          {(Object.keys(REACTION_EMOJI) as GameReactionType[]).map((type) => (
            <button
              key={type}
              type="button"
              onClick={() => {
                state.sendReactionType(type);
                setPickerOpen(false);
              }}
              aria-label={REACTION_LABEL[type]}
            >
              {REACTION_EMOJI[type]}
            </button>
          ))}
        </div>
      ) : null}

      {state.boardMode === 'pregame' ? <PregamePanel /> : null}
      <ChatDrawer />
    </div>
  );
}
