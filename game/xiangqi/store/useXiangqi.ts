import { create } from 'zustand';
import { ARCADE_ATTENTION_REASON, ARCADE_BRIDGE_EVENT } from '@ola/shared/constants';
import {
  bridge,
  GameAuthenticationExpiredError,
  GameAuthenticationRequiredError,
  joinGame,
} from '../../src/sdk';
import type {
  ChatMessageData,
  GameReactionType,
  GameSession,
  LeaderboardEntry,
  LeaderboardPeriod,
  MatchFoundData,
  MatchHistoryEntry,
  MatchOverData,
  RoomInfo,
  RoomStateData,
  StateData,
  UserInfoData,
} from '../../src/sdk';
import { GAME_ID, START_BOARD } from '../logic/constants.gen';
import { decodeServerState, type ServerMove, type ServerState } from '../logic/server-types';
import { EMPTY, SIDE_RED, pieceSide } from '../logic/board';
import { legalMovesFrom } from '../logic/moves';
import { errorText } from '../helpers/errorText';
import { playSound, setSoundEnabled } from '../audio';

export type LobbyPhase = 'loading' | 'connecting' | 'error' | 'ready';
export type BoardMode = 'idle' | 'pregame' | 'playing';
export type RoomActionPending = 'creating' | 'joining' | 'ready' | 'starting' | 'leaving' | 'kicking' | null;

export interface PieceView {
  key: string;
  piece: number;
  idx: number;
}

export interface SeatInfo {
  id: string;
  name: string;
  side: number;
}

export interface MatchResultState {
  matchId: string;
  outcome: 'win' | 'lose' | 'draw';
  kenDelta: number | null;
  reasonText: string;
}

export interface NoticeState {
  title: string;
  body: string;
  okLabel: string;
  danger?: boolean;
  onOk: () => void;
}

export interface ReactionFloat {
  seq: number;
  type: GameReactionType;
  mine: boolean;
}

interface XiangqiState {
  lobbyVisible: boolean;
  lobbyPhase: LobbyPhase;
  lobbyError: string;
  userInfo: UserInfoData | null;
  ken: number;
  soundOn: boolean;

  rankedVisible: boolean;
  rooms: RoomInfo[];
  roomActionPending: RoomActionPending;
  roomWaiting: RoomStateData | null;

  boardMode: BoardMode;
  board: number[];
  pieces: PieceView[];
  selected: number | null;
  hints: number[];
  lastFrom: number;
  lastTo: number;
  checkSeq: number;
  me: SeatInfo | null;
  op: SeatInfo | null;
  myTurn: boolean;
  movePending: boolean;
  deadline: number;
  timerLeftMs: number;
  turnExpired: boolean;
  turnAnnounce: string | null;
  bet: number;
  matchSeq: number;
  oppAway: number | null;
  messages: ChatMessageData[];
  chatOpen: boolean;
  chatUnread: boolean;
  chatRestore: string | null;
  reactionFloats: ReactionFloat[];

  result: MatchResultState | null;
  toast: string | null;
  notice: NoticeState | null;

  historyVisible: boolean;
  historyItems: MatchHistoryEntry[];
  historyLoading: boolean;
  leaderboardVisible: boolean;
  leaderboardItems: LeaderboardEntry[];
  leaderboardPeriod: LeaderboardPeriod;
  leaderboardLoading: boolean;

  init(): Promise<void>;
  retryConnect(): void;
  toggleSound(): void;
  exitGame(): void;

  playRanked(): void;
  closeRanked(): void;
  refreshRooms(): void;
  createRoom(bet: number, password: string): void;
  joinRoom(roomId: string, password: string): void;
  setReady(ready: boolean): void;
  startMatch(): void;
  leaveRoom(): void;
  kickOpponent(): void;

  tapSquare(idx: number): void;
  forfeitMatch(): void;
  exitMatch(): void;

  openChat(): void;
  closeChat(): void;
  sendChatText(text: string): void;
  consumeChatRestore(): void;
  sendReactionType(type: GameReactionType): void;

  closeResult(): void;
  playAgain(): void;

  showHistory(): void;
  closeHistory(): void;
  showLeaderboard(): void;
  setLeaderboardPeriod(period: LeaderboardPeriod): void;
  closeLeaderboard(): void;

  showToast(text: string): void;
  clearToast(): void;
  showNotice(notice: NoticeState | null): void;
}

const SOUND_KEY = 'ola:xiangqi:sound';
const TURN_ANNOUNCE_MS = 1200;
const TOAST_MS = 2400;
// Let the closing move land on the board before the result modal covers it.
const RESULT_REVEAL_MS = 1100;
const CHAT_RESTORE_CODES = new Set(['CHAT_TOO_LONG', 'CHAT_RATE_LIMITED', 'INVALID_CHAT']);

type Session = GameSession<ServerState, ServerMove>;

function buildPieces(board: number[]): PieceView[] {
  const pieces: PieceView[] = [];
  for (let idx = 0; idx < board.length; idx++) {
    if (board[idx] !== EMPTY) pieces.push({ key: `p${idx}-${board[idx]}`, piece: board[idx], idx });
  }
  return pieces;
}

function advancePieces(prev: PieceView[], board: number[], lastFrom: number, lastTo: number): PieceView[] {
  if (lastFrom < 0 || lastTo < 0) return buildPieces(board);
  const next = prev.filter((p) => p.idx !== lastTo).map((p) => (p.idx === lastFrom ? { ...p, idx: lastTo } : p));
  const occupied = new Map<number, number>();
  for (const p of next) {
    if (occupied.has(p.idx)) return buildPieces(board);
    occupied.set(p.idx, p.piece);
  }
  for (let idx = 0; idx < board.length; idx++) {
    if ((occupied.get(idx) ?? EMPTY) !== board[idx]) return buildPieces(board);
  }
  return next;
}

function drawReasonText(state: ServerState | null): string {
  const step = state?.steps?.find((s) => s.kind === 'draw');
  if (step?.reason === 'repetition') return 'Ván hòa — lặp thế 3 lần';
  if (step?.reason === 'halfmove') return 'Ván hòa — 60 nước không ăn quân';
  return 'Ván hòa';
}

function winReasonText(state: ServerState | null, won: boolean): string {
  const step = state?.steps?.find((s) => s.kind === 'mate');
  switch (step?.reason) {
    case 'checkmate':
      return won ? 'Chiếu bí! Bạn thắng' : 'Bạn bị chiếu bí';
    case 'stalemate':
      return won ? 'Đối thủ hết nước đi' : 'Bạn hết nước đi';
    case 'perpetual':
      return won ? 'Đối thủ chiếu dai — phạm luật lặp thế' : 'Bạn chiếu dai — phạm luật lặp thế';
    default:
      return won ? 'Bạn thắng!' : 'Bạn thua';
  }
}

export const useXiangqi = create<XiangqiState>((set, get) => {
  const refs = {
    session: null as Session | null,
    connectPromise: null as Promise<void> | null,
    user: null as UserInfoData | null,
    match: null as MatchFoundData<ServerState> | null,
    matchBet: 0,
    serverState: null as ServerState | null,
    handledMatchIds: new Set<string>(),
    exitingMatch: false,
    roomConnectionLost: false,
    timer: 0 as ReturnType<typeof setInterval> | 0,
    announceTimer: 0 as ReturnType<typeof setTimeout> | 0,
    toastTimer: 0 as ReturnType<typeof setTimeout> | 0,
    resultTimer: 0 as ReturnType<typeof setTimeout> | 0,
    reactionSeq: 0,
    lastChatText: '',
  };

  const rememberMatchId = (matchId: string): boolean => {
    if (refs.handledMatchIds.has(matchId)) return false;
    refs.handledMatchIds.add(matchId);
    if (refs.handledMatchIds.size > 64) {
      const first = refs.handledMatchIds.values().next().value;
      if (first) refs.handledMatchIds.delete(first);
    }
    return true;
  };

  const stopTimer = () => {
    if (refs.timer) clearInterval(refs.timer);
    refs.timer = 0;
  };

  const cancelResultReveal = () => {
    if (refs.resultTimer) clearTimeout(refs.resultTimer);
    refs.resultTimer = 0;
  };

  const startTimer = () => {
    stopTimer();
    refs.timer = setInterval(() => {
      const { deadline, boardMode, turnExpired } = get();
      if (boardMode !== 'playing' || !deadline) return;
      const left = Math.max(0, deadline - Date.now());
      set({ timerLeftMs: left });
      // The server drops moves sent past the deadline, so the board must lock
      // itself instead of leaving the player stuck on movePending.
      if (left === 0 && !turnExpired) set({ turnExpired: true, selected: null, hints: [] });
    }, 250);
  };

  const announce = (text: string) => {
    if (refs.announceTimer) clearTimeout(refs.announceTimer);
    set({ turnAnnounce: text });
    refs.announceTimer = setTimeout(() => set({ turnAnnounce: null }), TURN_ANNOUNCE_MS);
  };

  const applyTurn = (turn: number, deadline: number, silent = false) => {
    const you = refs.match?.you ?? 0;
    const myTurn = turn === you;
    const left = Math.max(0, deadline - Date.now());
    set({ myTurn, deadline, timerLeftMs: left, turnExpired: deadline > 0 && left === 0 });
    bridge.turnChanged({ yourTurn: myTurn, deadline });
    if (!silent) announce(myTurn ? 'ĐẾN LƯỢT BẠN' : 'ĐẾN LƯỢT ĐỐI THỦ');
  };

  const backToRanked = () => {
    refs.match = null;
    refs.serverState = null;
    stopTimer();
    cancelResultReveal();
    set({
      boardMode: 'idle',
      roomWaiting: null,
      rankedVisible: true,
      selected: null,
      hints: [],
      movePending: false,
      turnExpired: false,
      oppAway: null,
      messages: [],
      chatOpen: false,
      chatUnread: false,
      chatRestore: null,
      result: null,
    });
    refs.session?.listRooms();
  };

  const enterWaitingRoom = (room: RoomStateData) => {
    refs.match = null;
    refs.serverState = null;
    stopTimer();
    const preserveOutcome = get().result != null;
    set({
      roomWaiting: room,
      rankedVisible: false,
      selected: null,
      hints: [],
      movePending: false,
      turnExpired: false,
      oppAway: null,
      roomActionPending: null,
      ...(preserveOutcome
        ? {}
        : {
            boardMode: 'pregame' as BoardMode,
            board: [...START_BOARD],
            pieces: buildPieces([...START_BOARD]),
            lastFrom: -1,
            lastTo: -1,
            messages: [],
          }),
    });
  };

  const wireSession = (target: Session) => {
    const guard = <T>(handler: (data: T) => void) => (data: T) => {
      if (refs.session !== target) return;
      handler(data);
    };

    target.onUserInfo(
      guard((data: UserInfoData) => {
        refs.user = data;
        set({ userInfo: data, ken: data.ken, lobbyPhase: 'ready', lobbyError: '' });
      }),
    );

    target.onRoomList(guard((data) => set({ rooms: data.rooms ?? [] })));
    target.onRoomUpsert(
      guard((data) => {
        set((state) => {
          const rooms = state.rooms.filter((room) => room.id !== data.room.id);
          return { rooms: [data.room, ...rooms] };
        });
      }),
    );
    target.onRoomRemoved(guard((data) => set((state) => ({ rooms: state.rooms.filter((room) => room.id !== data.roomId) }))));

    target.onRoomState(
      guard((data: RoomStateData) => {
        enterWaitingRoom(data);
        const opMember = data.members.find((member) => member.id !== data.youId);
        if (opMember && get().boardMode === 'pregame') {
          bridge.attention({ reason: ARCADE_ATTENTION_REASON.OpponentJoined });
        }
      }),
    );
    target.onRoomSync(
      guard((data) => {
        if (!data.roomId && get().boardMode === 'pregame') backToRanked();
      }),
    );
    target.onRoomClosed(
      guard(() => {
        if (get().boardMode !== 'playing') {
          get().showToast('Bàn đã đóng');
          backToRanked();
        }
      }),
    );
    target.onRoomKicked(
      guard(() => {
        get().showToast('Bạn đã bị mời khỏi bàn');
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.RoomKicked });
        backToRanked();
      }),
    );

    target.onMatchFound(
      guard((data: MatchFoundData<ServerState>) => {
        if (!data.resumed && !rememberMatchId(`found:${data.matchId}`)) return;
        let serverState: ServerState;
        try {
          serverState = decodeServerState(data.state);
        } catch {
          return;
        }
        refs.match = data;
        refs.matchBet = data.bet ?? get().roomWaiting?.bet ?? 0;
        refs.serverState = serverState;
        refs.exitingMatch = false;
        cancelResultReveal();
        const you = data.you;
        const players = data.players ?? [];
        const meInfo = players[you];
        const opInfo = players[1 - you];
        set({
          boardMode: 'playing',
          rankedVisible: false,
          lobbyVisible: false,
          board: serverState.board,
          pieces: buildPieces(serverState.board),
          lastFrom: serverState.lastFrom,
          lastTo: serverState.lastTo,
          selected: null,
          hints: [],
          movePending: false,
          bet: refs.matchBet,
          me: meInfo ? { id: meInfo.id, name: meInfo.name, side: you } : null,
          op: opInfo ? { id: opInfo.id, name: opInfo.name, side: 1 - you } : null,
          matchSeq: get().matchSeq + 1,
          oppAway: null,
          result: null,
          // A resumed match carries no steps, so the check flag is the only way
          // to raise the banner and the red ring on the general under attack.
          checkSeq: serverState.check ? get().checkSeq + 1 : get().checkSeq,
        });
        applyTurn(data.turn, data.deadline, data.resumed);
        startTimer();
        if (data.resumed) {
          get().showToast('Đã vào lại trận đấu');
          if (serverState.check) playSound('check');
        } else {
          bridge.attention({ reason: ARCADE_ATTENTION_REASON.MatchStarted, matchId: data.matchId });
          playSound('place');
        }
      }),
    );

    target.onState(
      guard((data: StateData<ServerState, ServerMove>) => {
        if (!refs.match || data.matchId !== refs.match.matchId) return;
        let serverState: ServerState;
        try {
          serverState = decodeServerState(data.state);
        } catch {
          return;
        }
        refs.serverState = serverState;
        const steps = serverState.steps ?? [];
        const captured = steps.some((step) => step.kind === 'capture');
        const checked = steps.some((step) => step.kind === 'check');
        set((state) => ({
          board: serverState.board,
          pieces: advancePieces(state.pieces, serverState.board, serverState.lastFrom, serverState.lastTo),
          lastFrom: serverState.lastFrom,
          lastTo: serverState.lastTo,
          selected: null,
          hints: [],
          movePending: false,
          checkSeq: checked ? state.checkSeq + 1 : state.checkSeq,
        }));
        playSound(captured ? 'capture' : 'place');
        if (checked) playSound('check');
        applyTurn(data.turn, data.deadline);
      }),
    );

    target.onMatchOver(
      guard((data: MatchOverData<ServerState>) => {
        if (!rememberMatchId(`over:${data.matchId}`)) return;
        stopTimer();
        cancelResultReveal();
        let finalState: ServerState | null = null;
        try {
          finalState = decodeServerState(data.state);
        } catch {
          finalState = null;
        }
        const finalSteps = finalState?.steps ?? [];
        if (finalState) {
          const state = finalState;
          const checked = finalSteps.some((step) => step.kind === 'check');
          set((prev) => ({
            board: state.board,
            pieces: advancePieces(prev.pieces, state.board, state.lastFrom, state.lastTo),
            lastFrom: state.lastFrom,
            lastTo: state.lastTo,
            checkSeq: checked ? prev.checkSeq + 1 : prev.checkSeq,
          }));
          if (finalSteps.some((step) => step.kind === 'capture')) playSound('capture');
          else if (finalSteps.some((step) => step.kind === 'move')) playSound('place');
          if (checked) playSound('check');
        }
        const myId = refs.user?.id;
        const draw = data.reason === 'draw';
        const won = !draw && data.winnerId != null && data.winnerId === myId;
        const bet = data.bet ?? refs.matchBet;
        const winnerPayout = data.payout ?? bet * 2;
        const winnerNet = data.kenDelta ?? winnerPayout - bet;
        const kenDelta = draw ? null : bet === 0 ? 0 : won ? winnerNet : -bet;
        const reasonText = (() => {
          switch (data.reason) {
            case 'forfeit':
              return won ? 'Đối thủ đầu hàng' : 'Bạn đã đầu hàng';
            case 'timeout':
              return won ? 'Đối thủ hết giờ' : 'Bạn hết giờ suy nghĩ';
            case 'disconnect':
              return won ? 'Đối thủ mất kết nối' : 'Bạn mất kết nối quá lâu';
            case 'draw':
              return drawReasonText(finalState);
            default:
              return winReasonText(finalState, won);
          }
        })();
        bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
        bridge.refreshUser();
        set({
          myTurn: false,
          movePending: false,
          turnExpired: false,
          selected: null,
          hints: [],
          oppAway: null,
        });
        if (refs.exitingMatch) {
          refs.exitingMatch = false;
          backToRanked();
          return;
        }
        const matchSeq = get().matchSeq;
        const reveal = () => {
          refs.resultTimer = 0;
          if (get().matchSeq !== matchSeq) return;
          playSound(draw ? 'place' : won ? 'win' : 'lose');
          set({
            result: {
              matchId: data.matchId,
              outcome: draw ? 'draw' : won ? 'win' : 'lose',
              kenDelta,
              reasonText,
            },
          });
        };
        if (finalSteps.length > 0) {
          refs.resultTimer = setTimeout(reveal, RESULT_REVEAL_MS);
        } else {
          reveal();
        }
      }),
    );

    target.onChat(
      guard((data: ChatMessageData) => {
        set((state) => ({
          messages: [...state.messages.slice(-19), data],
          chatUnread: state.chatOpen || data.userId === refs.user?.id ? state.chatUnread : true,
        }));
        if (data.userId === refs.user?.id) {
          refs.lastChatText = '';
        } else {
          bridge.attention({ reason: ARCADE_ATTENTION_REASON.NewChat });
        }
      }),
    );

    target.onReaction(
      guard((data) => {
        refs.reactionSeq += 1;
        const float: ReactionFloat = { seq: refs.reactionSeq, type: data.type, mine: data.userId === refs.user?.id };
        set((state) => ({ reactionFloats: [...state.reactionFloats.slice(-4), float] }));
        setTimeout(() => {
          set((state) => ({ reactionFloats: state.reactionFloats.filter((item) => item.seq !== float.seq) }));
        }, 2600);
      }),
    );

    target.onError(
      guard((data) => {
        set({ roomActionPending: null, movePending: false });
        // Give the rejected draft back instead of silently eating what was typed.
        if (CHAT_RESTORE_CODES.has(data.code) && refs.lastChatText) {
          set({ chatRestore: refs.lastChatText });
          refs.lastChatText = '';
        }
        get().showToast(errorText(data.code));
      }),
    );

    target.onHistory(
      guard((data) => {
        set({ historyItems: data.items ?? [], historyLoading: false });
      }),
    );

    target.onLeaderboard(
      guard((data) => {
        if (data.period !== get().leaderboardPeriod) return;
        set({ leaderboardItems: data.items ?? [], leaderboardLoading: false });
      }),
    );

    target.onOpponentDisconnected(guard((data) => {
      set({ oppAway: data.graceDeadline });
      bridge.attention({ reason: ARCADE_ATTENTION_REASON.OpponentDisconnected });
    }));
    target.onOpponentReconnected(guard(() => set({ oppAway: null })));

    target.onConnectionChange(
      guard((connected: boolean) => {
        if (!connected) {
          if (get().boardMode === 'pregame') refs.roomConnectionLost = true;
          if (get().lobbyPhase === 'ready') get().showToast('Mất kết nối, đang thử lại...');
          return;
        }
        if (refs.roomConnectionLost) {
          refs.roomConnectionLost = false;
          if (get().boardMode === 'pregame') {
            get().showToast('Kết nối bị gián đoạn, bạn đã rời bàn');
            backToRanked();
          }
        }
      }),
    );
  };

  const connectToServer = (): Promise<void> => {
    if (refs.connectPromise) return refs.connectPromise;
    set({ lobbyPhase: 'connecting', lobbyError: '' });
    refs.connectPromise = (async () => {
      try {
        const session = await joinGame<ServerState, ServerMove>(GAME_ID);
        refs.session = session;
        wireSession(session);
        await new Promise<void>((resolve, reject) => {
          const timeout = setTimeout(() => reject(new Error('timeout')), 8000);
          const offInfo = session.onUserInfo(() => {
            clearTimeout(timeout);
            offInfo();
            resolve();
          });
          const offErr = session.onConnectionError((error) => {
            clearTimeout(timeout);
            offErr();
            reject(error);
          });
        });
      } catch (error) {
        refs.connectPromise = null;
        const message =
          error instanceof GameAuthenticationRequiredError || error instanceof GameAuthenticationExpiredError
            ? 'Phiên đăng nhập hết hạn, hãy mở lại game'
            : 'Không kết nối được máy chủ';
        set({ lobbyPhase: 'error', lobbyError: message });
        throw error;
      }
    })();
    return refs.connectPromise;
  };

  return {
    lobbyVisible: true,
    lobbyPhase: 'loading',
    lobbyError: '',
    userInfo: null,
    ken: 0,
    soundOn: localStorage.getItem(SOUND_KEY) !== '0',

    rankedVisible: false,
    rooms: [],
    roomActionPending: null,
    roomWaiting: null,

    boardMode: 'idle',
    board: [...START_BOARD],
    pieces: buildPieces([...START_BOARD]),
    selected: null,
    hints: [],
    lastFrom: -1,
    lastTo: -1,
    checkSeq: 0,
    me: null,
    op: null,
    myTurn: false,
    movePending: false,
    deadline: 0,
    timerLeftMs: 0,
    turnExpired: false,
    turnAnnounce: null,
    bet: 0,
    matchSeq: 0,
    oppAway: null,
    messages: [],
    chatOpen: false,
    chatUnread: false,
    chatRestore: null,
    reactionFloats: [],

    result: null,
    toast: null,
    notice: null,

    historyVisible: false,
    historyItems: [],
    historyLoading: false,
    leaderboardVisible: false,
    leaderboardItems: [],
    leaderboardPeriod: 'day',
    leaderboardLoading: false,

    async init() {
      setSoundEnabled(get().soundOn);
      bridge.onHost(ARCADE_BRIDGE_EVENT.KenUpdated, (data) => {
        const ken = Number((data as { ken?: unknown } | null)?.ken);
        if (Number.isFinite(ken)) set({ ken });
      });
      bridge.ready();
      try {
        await connectToServer();
      } catch {
        return;
      }
    },

    retryConnect() {
      refs.connectPromise = null;
      void connectToServer().catch(() => undefined);
    },

    toggleSound() {
      const soundOn = !get().soundOn;
      localStorage.setItem(SOUND_KEY, soundOn ? '1' : '0');
      setSoundEnabled(soundOn);
      set({ soundOn });
      if (soundOn) playSound('click');
    },

    exitGame() {
      bridge.exit();
    },

    playRanked() {
      playSound('click');
      set({ rankedVisible: true });
      refs.session?.listRooms();
    },

    closeRanked() {
      set({ rankedVisible: false });
    },

    refreshRooms() {
      refs.session?.listRooms();
    },

    createRoom(bet: number, password: string) {
      if (get().roomActionPending) return;
      set({ roomActionPending: 'creating' });
      refs.session?.createRoom(bet, password);
    },

    joinRoom(roomId: string, password: string) {
      if (get().roomActionPending) return;
      set({ roomActionPending: 'joining' });
      refs.session?.joinRoom(roomId, password);
    },

    setReady(ready: boolean) {
      const room = get().roomWaiting;
      if (!room) return;
      playSound('click');
      refs.session?.setRoomReady(room.roomId, ready);
    },

    startMatch() {
      const room = get().roomWaiting;
      if (!room || get().roomActionPending) return;
      set({ roomActionPending: 'starting' });
      refs.session?.startRoom(room.roomId);
      setTimeout(() => {
        if (get().roomActionPending === 'starting') set({ roomActionPending: null });
      }, 4000);
    },

    leaveRoom() {
      const room = get().roomWaiting;
      refs.session?.leaveRoom(room?.roomId);
      backToRanked();
    },

    kickOpponent() {
      const room = get().roomWaiting;
      if (!room) return;
      const guest = room.members.find((member) => member.id !== room.ownerId);
      if (guest) refs.session?.kickRoomMember(room.roomId, guest.id);
    },

    tapSquare(idx: number) {
      const { boardMode, myTurn, movePending, board, selected, hints, deadline } = get();
      if (boardMode !== 'playing' || !myTurn || movePending || get().result) return;
      if (deadline > 0 && Date.now() >= deadline) {
        set({ turnExpired: true, selected: null, hints: [] });
        return;
      }
      const mySide = refs.match?.you ?? SIDE_RED;
      const piece = board[idx];
      if (selected != null && hints.includes(idx)) {
        set({ movePending: true, hints: [], selected: null });
        refs.session?.sendMove(refs.match!.matchId, { from: selected, to: idx });
        return;
      }
      if (piece !== EMPTY && pieceSide(piece) === mySide) {
        if (selected === idx) {
          set({ selected: null, hints: [] });
          return;
        }
        playSound('click');
        set({ selected: idx, hints: legalMovesFrom(board, idx) });
        return;
      }
      set({ selected: null, hints: [] });
    },

    forfeitMatch() {
      const match = refs.match;
      if (!match) return;
      get().showNotice({
        title: 'Bỏ cuộc',
        body: 'Bạn sẽ bị xử thua ván này. Cả hai vẫn ở lại bàn. Tiếp tục?',
        okLabel: 'Bỏ cuộc',
        danger: true,
        onOk: () => {
          refs.session?.forfeit(match.matchId);
          get().showNotice(null);
        },
      });
    },

    exitMatch() {
      const match = refs.match;
      if (!match) {
        get().leaveRoom();
        return;
      }
      get().showNotice({
        title: 'Thoát bàn',
        body: 'Thoát sẽ bị xử thua và rời bàn.',
        okLabel: 'Thoát',
        danger: true,
        onOk: () => {
          refs.exitingMatch = true;
          refs.session?.forfeit(match.matchId, true);
          get().showNotice(null);
        },
      });
    },

    openChat() {
      set({ chatOpen: true, chatUnread: false });
    },

    closeChat() {
      set({ chatOpen: false });
    },

    sendChatText(text: string) {
      const trimmed = text.trim();
      if (!trimmed) return;
      const match = refs.match;
      const room = get().roomWaiting;
      if (match && get().boardMode === 'playing') {
        refs.lastChatText = trimmed;
        refs.session?.sendChat(match.matchId, trimmed);
      } else if (room) {
        refs.lastChatText = trimmed;
        refs.session?.sendRoomChat(room.roomId, trimmed);
      }
    },

    consumeChatRestore() {
      if (get().chatRestore != null) set({ chatRestore: null });
    },

    sendReactionType(type: GameReactionType) {
      const match = refs.match;
      if (!match) return;
      refs.session?.sendReaction(match.matchId, type);
    },

    closeResult() {
      const room = get().roomWaiting;
      set({ result: null });
      if (room) {
        set({
          boardMode: 'pregame',
          board: [...START_BOARD],
          pieces: buildPieces([...START_BOARD]),
          lastFrom: -1,
          lastTo: -1,
        });
      } else {
        backToRanked();
      }
    },

    playAgain() {
      get().closeResult();
    },

    showHistory() {
      playSound('click');
      set({ historyVisible: true, historyLoading: true });
      refs.session?.getHistory();
    },

    closeHistory() {
      set({ historyVisible: false });
    },

    showLeaderboard() {
      playSound('click');
      set({ leaderboardVisible: true, leaderboardLoading: true });
      refs.session?.getLeaderboard(get().leaderboardPeriod);
    },

    setLeaderboardPeriod(period: LeaderboardPeriod) {
      set({ leaderboardPeriod: period, leaderboardLoading: true, leaderboardItems: [] });
      refs.session?.getLeaderboard(period);
    },

    closeLeaderboard() {
      set({ leaderboardVisible: false });
    },

    showToast(text: string) {
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      set({ toast: text });
      refs.toastTimer = setTimeout(() => set({ toast: null }), TOAST_MS);
    },

    clearToast() {
      set({ toast: null });
    },

    showNotice(notice: NoticeState | null) {
      set({ notice });
    },
  };
});

