import { useEffect, useMemo, useRef, useState, type PointerEvent as ReactPointerEvent } from 'react';
import { useShallow } from 'zustand/react/shallow';
import { GAME_REACTION_TYPE, type GameReactionType } from '../../src/sdk';
import reactionAngry from '../../caro/assets/reactions/angry.webp';
import reactionHaha from '../../caro/assets/reactions/haha.webp';
import reactionLike from '../../caro/assets/reactions/like.webp';
import reactionLove from '../../caro/assets/reactions/love.webp';
import reactionSad from '../../caro/assets/reactions/sad.webp';
import reactionWow from '../../caro/assets/reactions/wow.webp';
import { BoardSurface, squareLeft, squareTop } from '../components/BoardSurface';
import { ModalHeading } from '../components/ModalHeading';
import { XqIcon } from '../components/XqIcon';
import { useDialogFocus } from '../components/useDialogFocus';
import { EMPTY, KIND_GENERAL, SIDE_RED, boardX, boardY, flipIndex, pieceFor, pieceKind, pieceSide } from '../logic/board';
import { inCheck } from '../logic/moves';
import { pieceGlyph, pieceLabel, sideLabel } from '../logic/pieces';
import { formatKen } from '../helpers/format';
import { PodAvatar } from '../components/PodAvatar';
import { useXiangqi, type SeatInfo } from '../store/useXiangqi';

const REACTION_ASSET: Record<GameReactionType, string> = {
  [GAME_REACTION_TYPE.Like]: reactionLike,
  [GAME_REACTION_TYPE.Love]: reactionLove,
  [GAME_REACTION_TYPE.Haha]: reactionHaha,
  [GAME_REACTION_TYPE.Wow]: reactionWow,
  [GAME_REACTION_TYPE.Sad]: reactionSad,
  [GAME_REACTION_TYPE.Angry]: reactionAngry,
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
const CHAT_TIME_FORMATTER = new Intl.DateTimeFormat('vi-VN', { hour: '2-digit', minute: '2-digit' });
const BOARD_VIEW_WIDTH = 360;
const BOARD_VIEW_HEIGHT = 400;
const BOARD_MARGIN = 20;
const BOARD_CELL = 40;
const BOARD_LAST_ROW = 9;
const BOARD_TOUCH_RADIUS = 22;

function nearestBoardIndex(event: ReactPointerEvent<HTMLDivElement>, flip: boolean): number | null {
  const board = event.currentTarget.parentElement;
  if (!board) return null;
  const rect = board.getBoundingClientRect();
  const viewX = ((event.clientX - rect.left) / rect.width) * BOARD_VIEW_WIDTH;
  const viewY = ((event.clientY - rect.top) / rect.height) * BOARD_VIEW_HEIGHT;
  const x = Math.max(0, Math.min(8, Math.round((viewX - BOARD_MARGIN) / BOARD_CELL)));
  const y = Math.max(0, Math.min(BOARD_LAST_ROW, BOARD_LAST_ROW - Math.round((viewY - BOARD_MARGIN) / BOARD_CELL)));
  const centerX = BOARD_MARGIN + x * BOARD_CELL;
  const centerY = BOARD_MARGIN + (BOARD_LAST_ROW - y) * BOARD_CELL;
  const distanceX = ((viewX - centerX) / BOARD_VIEW_WIDTH) * rect.width;
  const distanceY = ((viewY - centerY) / BOARD_VIEW_HEIGHT) * rect.height;
  if (Math.hypot(distanceX, distanceY) > BOARD_TOUCH_RADIUS) return null;
  const displayedIndex = y * 9 + x;
  return flip ? flipIndex(displayedIndex) : displayedIndex;
}

function formatChatTime(sentAt: number): string {
  return CHAT_TIME_FORMATTER.format(new Date(sentAt));
}

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
      <PodAvatar src={seat.avatar} tone={red ? 'red' : 'black'} />
      <div className="xq-pod-info">
        <div className="xq-pod-name">
          <span className="xq-pod-name-text">@{seat.name}</span>
          {seat.level != null && seat.level > 0 && <span className="xq-level-chip">Lv.{seat.level}</span>}
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
        <div className={`xq-pod-clock ${urgent ? 'xq-pod-clock-urgent' : ''}`} aria-label={`Còn ${secondsLeft} giây`}>
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
        <ModalHeading eyebrow="Phòng chờ" title={`Bàn của @${owner?.name ?? '...'}`} icon="owner" />
        <div className="xq-pregame-bet">
          {roomWaiting.bet > 0 ? `Cược ${formatKen(roomWaiting.bet)} KEN` : 'Giao hữu'}
          {roomWaiting.locked ? <XqIcon name="lock" size={15} /> : null}
        </div>
        <div className="xq-pregame-seats">
          {[meMember, opMember].map((member, index) =>
            member ? (
              <div key={member.id} className="xq-seat">
                <PodAvatar vipType={member.vipType} tone="black" />
                <div className="xq-seat-name">
                  <span className="xq-seat-name-text">
                    {member.id === roomWaiting.youId ? 'Bạn' : `@${member.name}`}
                  </span>
                  {member.level != null && member.level > 0 && <span className="xq-level-chip">Lv.{member.level}</span>}
                </div>
                <div className="xq-seat-side">{member.owner ? 'Chủ bàn · Chờ xếp phe' : 'Khách · Chờ xếp phe'}</div>
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
                      body: `Mời @${opMember.name} ra khỏi bàn?`,
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
  const drawerRef = useDialogFocus<HTMLElement>({ enabled: chatOpen, onEscape: closeChat });

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
    <div className="xq-chat-layer">
      <div className="xq-chat-scrim" aria-hidden="true" onClick={closeChat} />
      <section ref={drawerRef} className="xq-chat" role="dialog" aria-modal="true" aria-labelledby="xq-chat-title" tabIndex={-1}>
        <div className="xq-chat-grip" aria-hidden="true" />
        <header className="xq-chat-head">
          <div className="xq-chat-heading">
            <span className="xq-chat-heading-icon" aria-hidden="true">
              <XqIcon name="chat" size={21} />
            </span>
            <div className="xq-chat-heading-copy">
              <div>
                <h2 id="xq-chat-title">Trò chuyện</h2>
                <span className="xq-chat-room-chip">Trong bàn</span>
              </div>
              <p>{messages.length > 0 ? `${messages.length} tin nhắn gần nhất` : 'Gửi lời chào tới đối thủ'}</p>
            </div>
          </div>
          <button type="button" className="xq-icon-btn xq-chat-close" onClick={closeChat} aria-label="Đóng trò chuyện">
            <XqIcon name="close" size={20} />
          </button>
        </header>

        <div className="xq-chat-list" ref={listRef} role="log" aria-live="polite" aria-relevant="additions">
          <div className="xq-chat-notice">Tin nhắn chỉ hiển thị trong bàn cờ này</div>
          {messages.length === 0 ? (
            <div className="xq-chat-empty">
              <span aria-hidden="true"><XqIcon name="chat" size={26} /></span>
              <strong>Chưa có tin nhắn</strong>
              <small>Một lời chào vui vẻ sẽ làm ván cờ thú vị hơn.</small>
            </div>
          ) : null}
          {messages.map((message, index) => {
            const mine = message.userId === userInfo?.id;
            return (
              <div key={`${message.sentAt}-${index}`} className={`xq-chat-row ${mine ? 'xq-chat-mine' : ''}`}>
                <div className="xq-chat-message">
                  <div className="xq-chat-meta">
                    <strong>{mine ? 'Bạn' : `@${message.name}`}</strong>
                    <time dateTime={new Date(message.sentAt).toISOString()}>{formatChatTime(message.sentAt)}</time>
                  </div>
                  <div className="xq-chat-bubble">{message.text}</div>
                </div>
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
          <div className="xq-chat-input-shell">
            <input
              value={draft}
              onChange={(event) => setDraft(event.target.value)}
              placeholder="Nhập tin nhắn..."
              maxLength={CHAT_MAX_CHARS}
              aria-label="Tin nhắn"
              data-dialog-initial-focus
            />
            <span className={`xq-chat-count ${draft ? 'xq-chat-count-visible' : ''}`} aria-hidden="true">
              {draft.length}/{CHAT_MAX_CHARS}
            </span>
          </div>
          <button type="submit" className="xq-btn xq-btn-gold xq-chat-send" disabled={!draft.trim()} aria-label="Gửi tin nhắn">
            <XqIcon name="send" size={18} />
            <span>Gửi</span>
          </button>
        </form>
      </section>
    </div>
  );
}

export function BoardScreen() {
  const state = useXiangqi(
    useShallow((s) => ({
      boardMode: s.boardMode,
      gameMode: s.gameMode,
      botThinking: s.botThinking,
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
      closeChat: s.closeChat,
      sendReactionType: s.sendReactionType,
      restartBotGame: s.restartBotGame,
    })),
  );
  const [checkVisible, setCheckVisible] = useState(false);
  const [pickerOpen, setPickerOpen] = useState(false);
  const [oppAwayLeft, setOppAwayLeft] = useState(0);
  const reactionTriggerRef = useRef<HTMLButtonElement>(null);
  const reactionPickerRef = useRef<HTMLDivElement>(null);

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

  useEffect(() => {
    if (pickerOpen) reactionPickerRef.current?.querySelector<HTMLButtonElement>('button')?.focus();
  }, [pickerOpen]);

  const capturedByMe = useMemo(() => capturedKinds(state.board, 1 - mySide), [state.board, mySide]);
  const capturedByOp = useMemo(() => capturedKinds(state.board, mySide), [state.board, mySide]);

  const seconds = Math.ceil(state.timerLeftMs / 1000);
  const urgent = seconds <= 10;
  const playing = state.boardMode === 'playing';
  const boardLocked = !playing || !state.myTurn || state.movePending || !!state.result || state.turnExpired;
  useEffect(() => {
    if (!playing || state.result || state.gameMode !== 'online') setPickerOpen(false);
    if (!playing || state.result) setCheckVisible(false);
    if (state.result) state.closeChat();
  }, [playing, state.result, state.gameMode, state.closeChat]);
  let statusTone = 'turn';
  let statusText = state.myTurn ? 'Lượt của bạn' : 'Lượt đối thủ';
  let statusIcon: 'check' | 'refresh' | 'warning' | 'wifi-off' | null = state.myTurn ? 'check' : null;
  if (!playing) {
    statusTone = 'waiting';
    statusText = 'Phòng chờ';
    statusIcon = null;
  } else if (state.gameMode === 'bot' && state.botThinking) {
    statusTone = 'pending';
    statusText = 'Máy đang suy nghĩ…';
    statusIcon = 'refresh';
  } else if (state.oppAway) {
    statusTone = 'network';
    statusText = `Đối thủ mất kết nối · còn ${oppAwayLeft}s`;
    statusIcon = 'wifi-off';
  } else if (state.turnExpired && !state.result) {
    statusTone = 'danger';
    statusText = state.myTurn ? 'Bạn đã hết giờ · máy chủ đang đi thay' : 'Đối thủ đã hết giờ · máy chủ đang đi thay';
    statusIcon = 'warning';
  } else if (state.movePending) {
    statusTone = 'pending';
    statusText = 'Đang xác nhận nước đi…';
    statusIcon = 'refresh';
  } else if (state.turnAnnounce) {
    statusText = state.turnAnnounce;
  }
  const checkedSide = useMemo(() => {
    if (!playing || state.result) return -1;
    if (inCheck(state.board, mySide)) return mySide;
    if (inCheck(state.board, 1 - mySide)) return 1 - mySide;
    return -1;
  }, [playing, state.result, state.board, mySide]);
  if (
    checkedSide >= 0 &&
    !state.oppAway &&
    !state.turnExpired &&
    !state.movePending &&
    !state.botThinking
  ) {
    statusTone = 'danger';
    statusText = checkedSide === mySide ? 'Tướng của bạn đang bị chiếu' : 'Đối thủ đang bị chiếu';
    statusIcon = 'warning';
  }
  const generalInCheckIdx = useMemo(() => {
    // The banner is a short animation, but the general must stay marked for
    // the whole checked position so the player cannot miss the constraint.
    if (checkedSide < 0) return -1;
    return state.board.indexOf(pieceFor(checkedSide, KIND_GENERAL));
  }, [checkedSide, state.board]);

  return (
    <div className="xq-screen xq-board-screen">
      <div className="xq-board-stage">
        <PlayerPod
          seat={state.op}
          clockActive={state.gameMode === 'online' && playing && !state.myTurn && !state.result}
          secondsLeft={seconds}
          urgent={urgent}
          captured={capturedByOp}
          mine={false}
        />

        <div
          className={`xq-board-status xq-board-status-${statusTone}`}
          role="status"
          aria-live="polite"
          aria-label={state.oppAway ? 'Đối thủ mất kết nối' : undefined}
        >
          {statusIcon ? <XqIcon name={statusIcon} size={15} /> : null}
          <span aria-hidden={state.oppAway ? true : undefined}>{statusText}</span>
        </div>

        <div
          className={`xq-board-wrap ${state.boardMode === 'pregame' ? 'xq-board-dimmed' : ''} ${boardLocked ? 'xq-board-input-locked' : ''}`}
        >
          <BoardSurface />
          {state.bet > 0 ? (
            <div className="xq-bet-badge">
              <XqIcon name="ken" size={15} />
              <span>{formatKen(state.bet)}</span>
            </div>
          ) : null}
          <div
            className="xq-board-hit-area"
            aria-hidden="true"
            onPointerUp={(event) => {
              if (boardLocked || event.button !== 0) return;
              const index = nearestBoardIndex(event, flip);
              if (index != null) state.tapSquare(index);
            }}
          />
          <div
            className="xq-board-layer"
            role="group"
            aria-label={`Bàn cờ Tướng. ${statusText}`}
            aria-disabled={boardLocked}
          >
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
              const pieceInteractive = !boardLocked && (pieceSide(piece.piece) === mySide || isCaptureHint);
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
                  disabled={!pieceInteractive}
                  aria-label={`${pieceLabel(piece.piece)} ${red ? 'đỏ' : 'đen'}, cột ${boardX(displayIdx) + 1}, hàng ${boardY(displayIdx) + 1}`}
                >
                  <span className="xq-piece-face" aria-hidden="true">{pieceGlyph(piece.piece)}</span>
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
          {playing && checkVisible ? (
            <div className="xq-check-banner" role="status">
              <XqIcon name="warning" size={18} />
              Chiếu tướng!
            </div>
          ) : null}
          {state.reactionFloats.map((float) => (
            <div key={float.seq} className={`xq-reaction-float ${float.mine ? 'xq-reaction-mine' : ''}`}>
              <img src={REACTION_ASSET[float.type]} alt="" draggable={false} />
            </div>
          ))}
        </div>

        <PlayerPod
          seat={state.me}
          clockActive={state.gameMode === 'online' && playing && state.myTurn && !state.result}
          secondsLeft={seconds}
          urgent={urgent}
          captured={capturedByMe}
          mine
        />
      </div>

      {playing ? (
        <div className={`xq-actionbar ${state.gameMode === 'bot' ? 'xq-actionbar-bot' : ''}`}>
          {state.gameMode === 'bot' ? (
            <button type="button" className="xq-action" onClick={state.restartBotGame}>
              <XqIcon name="refresh" size={24} />
              <span className="xq-action-label">Ván mới</span>
            </button>
          ) : (
            <>
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
                ref={reactionTriggerRef}
                type="button"
                className="xq-action"
                onClick={() => setPickerOpen((open) => !open)}
                aria-expanded={pickerOpen}
                aria-controls="xq-reaction-picker"
              >
                <XqIcon name="reaction" size={24} />
                <span className="xq-action-label">Cảm xúc</span>
              </button>
            </>
          )}
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

      {state.gameMode === 'online' && !state.result && pickerOpen ? (
        <div
          ref={reactionPickerRef}
          className="xq-reaction-picker"
          id="xq-reaction-picker"
          role="group"
          aria-label="Chọn cảm xúc"
          onKeyDown={(event) => {
            if (event.key !== 'Escape') return;
            event.preventDefault();
            event.stopPropagation();
            setPickerOpen(false);
            reactionTriggerRef.current?.focus();
          }}
        >
          {(Object.keys(REACTION_ASSET) as GameReactionType[]).map((type) => (
            <button
              key={type}
              type="button"
              onClick={() => {
                state.sendReactionType(type);
                setPickerOpen(false);
                reactionTriggerRef.current?.focus();
              }}
              aria-label={REACTION_LABEL[type]}
            >
              <img src={REACTION_ASSET[type]} alt="" draggable={false} />
            </button>
          ))}
        </div>
      ) : null}

      {state.boardMode === 'pregame' ? <PregamePanel /> : null}
      {state.gameMode === 'online' && !state.result ? <ChatDrawer /> : null}
    </div>
  );
}
