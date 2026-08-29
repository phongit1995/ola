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
import { BOT_DIFFICULTY_LABEL, chooseBotMove, type BotDifficulty } from '../logic/bot';
import { applyLocalMove, createLocalGame, type LocalGameResult, type LocalGameState } from '../logic/local-game';
import { errorText } from '../helpers/errorText';
import { avatarIconUrl, botAvatarIconUrl } from '../helpers/player';
import { playSound, setSoundEnabled } from '../audio';

export type LobbyPhase = 'loading' | 'connecting' | 'error' | 'ready';
export type BoardMode = 'idle' | 'pregame' | 'playing';
export type XiangqiGameMode = 'online' | 'bot';
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
  avatar: string;
  level?: number;
}

export interface MatchResultState {
  matchId: string;
  outcome: 'win' | 'lose' | 'draw';
  kenDelta: number | null;
  reasonText: string;
  expGained: number | null;
  expBefore: number;
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
  gameMode: XiangqiGameMode;
  botSetupVisible: boolean;
  botDifficulty: BotDifficulty;
  botPlayerSide: number;
  botThinking: boolean;

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
  historyError: string | null;
  leaderboardVisible: boolean;
  leaderboardItems: LeaderboardEntry[];
  leaderboardPeriod: LeaderboardPeriod;
  leaderboardLoading: boolean;
  leaderboardError: string | null;

  init(): Promise<void>;
  dispose(): void;
  retryConnect(): void;
  toggleSound(): void;
  exitGame(): void;
  openBotSetup(): void;
  closeBotSetup(): void;
  startBotGame(difficulty: BotDifficulty, playerSide: number): void;
  restartBotGame(): void;

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
  retryHistory(): void;
  closeHistory(): void;
  showLeaderboard(): void;
  retryLeaderboard(): void;
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
const REQUEST_TIMEOUT_MS = 8000;
const CHAT_RESTORE_CODES = new Set(['CHAT_TOO_LONG', 'CHAT_RATE_LIMITED', 'INVALID_CHAT']);
const STALE_ROOM_CODES = new Set(['NOT_ROOM_MEMBER', 'ROOM_NOT_FOUND', 'ROOM_MISMATCH']);

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
    connectCancel: null as (() => void) | null,
    connectRun: 0,
    hostKenOff: null as (() => void) | null,
    user: null as UserInfoData | null,
    match: null as MatchFoundData<ServerState> | null,
    matchBet: 0,
    serverState: null as ServerState | null,
    handledMatchIds: new Set<string>(),
    exitingMatchId: null as string | null,
    pendingResultMatchId: null as string | null,
    acceptBufferedResult: false,
    opponentAwayDeadline: null as number | null,
    checkSignaledMoveCount: -1,
    roomConnectionLost: false,
    timer: 0 as ReturnType<typeof setInterval> | 0,
    announceTimer: 0 as ReturnType<typeof setTimeout> | 0,
    toastTimer: 0 as ReturnType<typeof setTimeout> | 0,
    resultTimer: 0 as ReturnType<typeof setTimeout> | 0,
    botTimer: 0 as ReturnType<typeof setTimeout> | 0,
    historyTimer: 0 as ReturnType<typeof setTimeout> | 0,
    leaderboardTimer: 0 as ReturnType<typeof setTimeout> | 0,
    transientTimers: new Set<ReturnType<typeof setTimeout>>(),
    botGame: null as LocalGameState | null,
    botRun: 0,
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

  const cancelResultReveal = (clearPending = true) => {
    if (refs.resultTimer) clearTimeout(refs.resultTimer);
    refs.resultTimer = 0;
    if (clearPending) refs.pendingResultMatchId = null;
  };

  const cancelBotTurn = () => {
    if (refs.botTimer) clearTimeout(refs.botTimer);
    refs.botTimer = 0;
  };

  const clearHistoryTimer = () => {
    if (refs.historyTimer) clearTimeout(refs.historyTimer);
    refs.historyTimer = 0;
  };

  const clearLeaderboardTimer = () => {
    if (refs.leaderboardTimer) clearTimeout(refs.leaderboardTimer);
    refs.leaderboardTimer = 0;
  };

  const scheduleTransient = (handler: () => void, delay: number) => {
    const timer = setTimeout(() => {
      refs.transientTimers.delete(timer);
      handler();
    }, delay);
    refs.transientTimers.add(timer);
  };

  const clearTransientTimers = () => {
    refs.transientTimers.forEach((timer) => clearTimeout(timer));
    refs.transientTimers.clear();
  };

  const resultInteractionBlocked = () =>
    refs.resultTimer !== 0 || refs.pendingResultMatchId != null || get().result != null;

  const botResultText = (result: LocalGameResult, humanSide: number): string => {
    const won = result.winner === humanSide;
    switch (result.reason) {
      case 'checkmate':
        return won ? 'Chiếu bí! Bạn thắng máy' : 'Máy đã chiếu bí';
      case 'stalemate':
        return won ? 'Máy hết nước đi' : 'Bạn hết nước đi';
      case 'perpetual':
        return won ? 'Máy chiếu dai — phạm luật lặp thế' : 'Bạn chiếu dai — phạm luật lặp thế';
      case 'halfmove':
        return 'Ván hòa — 60 nước không ăn quân';
      case 'repetition':
        return 'Ván hòa — lặp thế 3 lần';
    }
  };

  const finishBotGame = (result: LocalGameResult, immediate = false, reasonOverride?: string) => {
    cancelBotTurn();
    cancelResultReveal();
    const humanSide = refs.botGame ? get().botPlayerSide : SIDE_RED;
    const outcome: MatchResultState['outcome'] = result.winner == null ? 'draw' : result.winner === humanSide ? 'win' : 'lose';
    set({
      botThinking: false,
      myTurn: false,
      movePending: false,
      selected: null,
      hints: [],
      turnExpired: false,
      chatOpen: false,
      notice: null,
    });
    const matchSeq = get().matchSeq;
    const reveal = () => {
      refs.resultTimer = 0;
      if (get().gameMode !== 'bot' || get().matchSeq !== matchSeq) return;
      playSound(outcome === 'draw' ? 'place' : outcome === 'win' ? 'win' : 'lose');
      set({
        result: {
          matchId: `bot-${matchSeq}`,
          outcome,
          kenDelta: 0,
          reasonText: reasonOverride ?? botResultText(result, humanSide),
          expGained: null,
          expBefore: 0,
        },
      });
    };
    if (immediate) reveal();
    else refs.resultTimer = setTimeout(reveal, RESULT_REVEAL_MS);
  };

  const applyBotGameMove = (side: number, from: number, to: number) => {
    const game = refs.botGame;
    if (!game || get().gameMode !== 'bot') return;
    let applied: ReturnType<typeof applyLocalMove>;
    try {
      applied = applyLocalMove(game, side, from, to);
    } catch {
      set({ movePending: false });
      get().showToast(side === get().botPlayerSide ? 'Nước đi không hợp lệ' : 'Máy không tìm được nước đi hợp lệ');
      return;
    }
    refs.botGame = applied.state;
    const nextSide = applied.state.moveCount % 2;
    const humanTurn = nextSide === get().botPlayerSide;
    set((state) => ({
      board: applied.state.board,
      pieces: advancePieces(state.pieces, applied.state.board, from, to),
      lastFrom: from,
      lastTo: to,
      selected: null,
      hints: [],
      movePending: false,
      botThinking: false,
      myTurn: humanTurn,
      checkSeq: applied.checked ? state.checkSeq + 1 : state.checkSeq,
    }));
    playSound(applied.captured !== EMPTY ? 'capture' : 'place');
    if (applied.checked) playSound('check');
    if (applied.state.result) {
      finishBotGame(applied.state.result);
      return;
    }
    if (humanTurn) announce('ĐẾN LƯỢT BẠN');
    else scheduleBotTurn();
  };

  function scheduleBotTurn() {
    cancelBotTurn();
    const game = refs.botGame;
    if (!game || game.result || get().gameMode !== 'bot') return;
    const botSide = 1 - get().botPlayerSide;
    if (game.moveCount % 2 !== botSide) return;
    const run = refs.botRun;
    const difficulty = get().botDifficulty;
    const delay = difficulty === 'easy' ? 360 : difficulty === 'medium' ? 520 : 680;
    set({ botThinking: true, myTurn: false, selected: null, hints: [] });
    refs.botTimer = setTimeout(() => {
      refs.botTimer = 0;
      if (run !== refs.botRun || get().gameMode !== 'bot' || refs.botGame !== game) return;
      const move = chooseBotMove(game.board, botSide, difficulty);
      if (!move) {
        const terminal = game.check ? 'checkmate' : 'stalemate';
        finishBotGame({ winner: get().botPlayerSide, reason: terminal });
        return;
      }
      applyBotGameMove(botSide, move.from, move.to);
    }, delay);
  }

  const startLocalBotGame = (difficulty: BotDifficulty, requestedSide: number) => {
    cancelBotTurn();
    cancelResultReveal();
    stopTimer();
    refs.botRun++;
    refs.botGame = createLocalGame();
    refs.match = null;
    refs.serverState = null;
    refs.exitingMatchId = null;
    refs.acceptBufferedResult = false;
    refs.opponentAwayDeadline = null;
    const playerSide = requestedSide === 1 ? 1 : SIDE_RED;
    const matchSeq = get().matchSeq + 1;
    const username = get().userInfo?.username || 'Bạn';
    set({
      gameMode: 'bot',
      botSetupVisible: false,
      botDifficulty: difficulty,
      botPlayerSide: playerSide,
      botThinking: false,
      boardMode: 'playing',
      lobbyVisible: false,
      rankedVisible: false,
      historyVisible: false,
      leaderboardVisible: false,
      roomWaiting: null,
      board: [...START_BOARD],
      pieces: buildPieces([...START_BOARD]),
      lastFrom: -1,
      lastTo: -1,
      selected: null,
      hints: [],
      checkSeq: 0,
      me: {
        id: get().userInfo?.id ?? 'local-player',
        name: username,
        side: playerSide,
        avatar: avatarIconUrl(get().userInfo?.vipType),
        level: get().userInfo?.level,
      },
      op: {
        id: 'local-bot',
        name: `Máy · ${BOT_DIFFICULTY_LABEL[difficulty]}`,
        side: 1 - playerSide,
        avatar: botAvatarIconUrl(difficulty),
      },
      myTurn: playerSide === SIDE_RED,
      movePending: false,
      deadline: 0,
      timerLeftMs: 0,
      turnExpired: false,
      turnAnnounce: null,
      bet: 0,
      matchSeq,
      oppAway: null,
      messages: [],
      chatOpen: false,
      chatUnread: false,
      reactionFloats: [],
      result: null,
      notice: null,
    });
    playSound('place');
    if (playerSide === SIDE_RED) announce('ĐẾN LƯỢT BẠN');
    else scheduleBotTurn();
  };

  const leaveBotToLobby = () => {
    cancelBotTurn();
    cancelResultReveal();
    refs.botRun++;
    refs.botGame = null;
    refs.match = null;
    refs.serverState = null;
    refs.exitingMatchId = null;
    refs.acceptBufferedResult = false;
    refs.opponentAwayDeadline = null;
    set({
      gameMode: 'online',
      botThinking: false,
      botSetupVisible: false,
      boardMode: 'idle',
      lobbyVisible: true,
      rankedVisible: false,
      selected: null,
      hints: [],
      movePending: false,
      turnExpired: false,
      turnAnnounce: null,
      me: null,
      op: null,
      result: null,
      notice: null,
    });
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
    set({
      myTurn,
      deadline,
      timerLeftMs: left,
      turnExpired: deadline > 0 && left === 0,
      // The server pauses only when the disconnected opponent owns the turn.
      // Let the local player finish an already-running turn before locking.
      oppAway: myTurn ? null : refs.opponentAwayDeadline,
    });
    bridge.turnChanged({ yourTurn: myTurn, deadline });
    if (!silent) announce(myTurn ? 'ĐẾN LƯỢT BẠN' : 'ĐẾN LƯỢT ĐỐI THỦ');
  };

  const backToRanked = () => {
    cancelBotTurn();
    refs.match = null;
    refs.serverState = null;
    refs.botGame = null;
    refs.exitingMatchId = null;
    refs.acceptBufferedResult = false;
    refs.opponentAwayDeadline = null;
    stopTimer();
    cancelResultReveal();
    set({
      gameMode: 'online',
      botThinking: false,
      boardMode: 'idle',
      roomWaiting: null,
      rankedVisible: true,
      lobbyVisible: false,
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
      notice: null,
    });
    refs.session?.listRooms();
  };

  const enterWaitingRoom = (room: RoomStateData) => {
    const current = get();
    const resultMatchId = current.result?.matchId ?? null;
    const pendingMatchId = refs.pendingResultMatchId;
    const followsPendingResult =
      pendingMatchId != null && (room.afterMatchId == null || room.afterMatchId === pendingMatchId);
    const followsVisibleResult =
      resultMatchId != null && (room.afterMatchId == null || room.afterMatchId === resultMatchId);
    const hasTrackedOutcome = pendingMatchId != null || resultMatchId != null;
    // Ordinary room updates must never tear down a live match. A post-match
    // snapshot is accepted only for the outcome currently being revealed.
    if (refs.match && current.boardMode === 'playing' && !hasTrackedOutcome) return;
    if (hasTrackedOutcome && room.afterMatchId != null && !followsPendingResult && !followsVisibleResult) return;
    cancelBotTurn();
    refs.match = null;
    refs.serverState = null;
    refs.botGame = null;
    refs.opponentAwayDeadline = null;
    stopTimer();
    const preserveOutcome = current.result != null || followsPendingResult;
    set({
      roomWaiting: room,
      gameMode: 'online',
      botThinking: false,
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
    // OnConnect sends USER_INFO, an optional buffered MATCH_OVER, then ROOM_SYNC.
    // Keep this narrow window open only for that reconnect sequence.
    refs.acceptBufferedResult = true;
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
        refs.acceptBufferedResult = false;
        if (data.roomId) return;
        set({ roomWaiting: null, notice: null });
        if (resultInteractionBlocked()) return;
        if (get().boardMode === 'pregame') backToRanked();
      }),
    );
    target.onRoomClosed(
      guard((data) => {
        if (get().roomWaiting?.roomId !== data.roomId) return;
        set({ roomWaiting: null, notice: null });
        get().showToast('Bàn đã đóng');
        if (!resultInteractionBlocked() && get().boardMode !== 'playing') backToRanked();
      }),
    );
    target.onRoomKicked(
      guard((data) => {
        if (get().roomWaiting?.roomId !== data.roomId) return;
        set({ roomWaiting: null, notice: null });
        get().showToast('Bạn đã bị mời khỏi bàn');
        bridge.attention({ reason: ARCADE_ATTENTION_REASON.RoomKicked });
        if (!resultInteractionBlocked() && get().boardMode !== 'playing') backToRanked();
      }),
    );

    target.onMatchFound(
      guard((data: MatchFoundData<ServerState>) => {
        if (refs.handledMatchIds.has(`over:${data.matchId}`)) return;
        if (!data.resumed && !rememberMatchId(`found:${data.matchId}`)) return;
        let serverState: ServerState;
        try {
          serverState = decodeServerState(data.state);
        } catch {
          return;
        }
        cancelBotTurn();
        refs.botRun++;
        refs.botGame = null;
        refs.match = data;
        refs.matchBet = data.bet ?? get().roomWaiting?.bet ?? 0;
        refs.serverState = serverState;
        refs.exitingMatchId = null;
        refs.acceptBufferedResult = false;
        refs.opponentAwayDeadline = null;
        refs.checkSignaledMoveCount = serverState.check ? serverState.moveCount : -1;
        cancelResultReveal();
        const you = data.you;
        const players = data.players ?? [];
        const meInfo = players[you];
        const opInfo = players[1 - you];
        set({
          gameMode: 'online',
          botSetupVisible: false,
          botThinking: false,
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
          me: meInfo
            ? {
                id: meInfo.id,
                name: meInfo.name,
                side: you,
                avatar: avatarIconUrl(meInfo.vipType),
                level: meInfo.level ?? refs.user?.level,
              }
            : null,
          op: opInfo
            ? {
                id: opInfo.id,
                name: opInfo.name,
                side: 1 - you,
                avatar: avatarIconUrl(opInfo.vipType),
                level: opInfo.level,
              }
            : null,
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
        // state.check is authoritative. Steps are intentionally absent after a
        // restored snapshot and may also be stripped by compatible servers.
        // The flag describes the standing position, so a re-delivered snapshot
        // of the same move must not replay the check banner and sound.
        const inCheckNow = serverState.check || steps.some((step) => step.kind === 'check');
        const checked = inCheckNow && serverState.moveCount !== refs.checkSignaledMoveCount;
        if (checked) refs.checkSignaledMoveCount = serverState.moveCount;
        const autoMoved = data.autoMoved === true && data.lastBy === refs.match.you;
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
        if (autoMoved) get().showToast('Hết giờ — hệ thống đã đi thay bạn');
      }),
    );

    target.onMatchOver(
      guard((data: MatchOverData<ServerState>) => {
        const currentMatchId = refs.match?.matchId ?? null;
        const exiting = refs.exitingMatchId === data.matchId;
        const bufferedReconnectResult =
          get().boardMode === 'idle' &&
          currentMatchId == null &&
          refs.acceptBufferedResult &&
          refs.pendingResultMatchId == null &&
          get().result == null;
        if (
          get().gameMode !== 'online' ||
          (!exiting && currentMatchId !== data.matchId && !bufferedReconnectResult)
        ) {
          return;
        }
        if (bufferedReconnectResult) refs.acceptBufferedResult = false;
        if (!rememberMatchId(`over:${data.matchId}`)) return;
        refs.opponentAwayDeadline = null;
        refs.match = null;
        stopTimer();
        cancelResultReveal();
        let finalState: ServerState | null = null;
        try {
          finalState = decodeServerState(data.state);
        } catch {
          finalState = null;
        }
        // Timeout/forfeit/disconnect snapshots retain the preceding move's steps.
        // Replaying those steps here would animate and sound the same move twice.
        const hasClosingMove = data.reason === 'win' || data.reason === 'draw';
        const finalSteps = hasClosingMove ? (finalState?.steps ?? []) : [];
        if (finalState) {
          const state = finalState;
          const checked = hasClosingMove && (state.check || finalSteps.some((step) => step.kind === 'check'));
          set((prev) => ({
            board: state.board,
            pieces: hasClosingMove
              ? advancePieces(prev.pieces, state.board, state.lastFrom, state.lastTo)
              : buildPieces(state.board),
            lastFrom: hasClosingMove ? state.lastFrom : prev.lastFrom,
            lastTo: hasClosingMove ? state.lastTo : prev.lastTo,
            checkSeq: checked ? prev.checkSeq + 1 : prev.checkSeq,
          }));
          if (finalSteps.some((step) => step.kind === 'capture')) playSound('capture');
          else if (finalSteps.some((step) => step.kind === 'move')) playSound('place');
          if (checked) playSound('check');
        }
        const myId = refs.user?.id;
        // A technical abort refunds the escrow, so it must render neutrally
        // instead of taking the bet off the loser's side.
        const draw = data.reason === 'draw' || data.reason === 'aborted';
        const won = !draw && data.winnerId != null && data.winnerId === myId;
        const bet = data.bet ?? refs.matchBet;
        refs.matchBet = bet;
        const winnerPayout = data.payout ?? bet * 2;
        const winnerNet = data.kenDelta ?? winnerPayout - bet;
        const kenDelta = draw ? null : bet === 0 ? 0 : won ? winnerNet : -bet;
        const expGained = data.expGains?.find((gain) => gain.userId === myId)?.exp ?? null;
        const expBefore = refs.user?.exp ?? 0;
        const reasonText = (() => {
          switch (data.reason) {
            case 'forfeit':
              return won ? 'Đối thủ đầu hàng' : 'Bạn đã đầu hàng';
            case 'timeout':
              return won ? 'Đối thủ hết giờ' : 'Bạn hết giờ suy nghĩ';
            case 'disconnect':
              return won ? 'Đối thủ mất kết nối' : 'Bạn mất kết nối quá lâu';
            case 'aborted':
              return 'Trận bị hủy do lỗi hệ thống · cược đã được hoàn';
            case 'draw':
              return drawReasonText(finalState);
            default:
              return winReasonText(finalState, won);
          }
        })();
        bridge.gameOver({ matchId: data.matchId, winnerId: data.winnerId, reason: data.reason, won });
        bridge.refreshUser();
        set({
          bet,
          myTurn: false,
          movePending: false,
          turnExpired: false,
          selected: null,
          hints: [],
          oppAway: null,
          chatOpen: false,
          notice: null,
        });
        if (exiting) {
          refs.exitingMatchId = null;
          backToRanked();
          return;
        }
        const matchSeq = get().matchSeq;
        const reveal = () => {
          refs.resultTimer = 0;
          if (get().matchSeq !== matchSeq) {
            if (refs.pendingResultMatchId === data.matchId) refs.pendingResultMatchId = null;
            return;
          }
          if (refs.pendingResultMatchId === data.matchId) refs.pendingResultMatchId = null;
          playSound(draw ? 'place' : won ? 'win' : 'lose');
          set({
            result: {
              matchId: data.matchId,
              outcome: draw ? 'draw' : won ? 'win' : 'lose',
              kenDelta,
              reasonText,
              expGained,
              expBefore,
            },
          });
        };
        if (hasClosingMove && finalSteps.length > 0) {
          refs.pendingResultMatchId = data.matchId;
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
        scheduleTransient(() => {
          set((state) => ({ reactionFloats: state.reactionFloats.filter((item) => item.seq !== float.seq) }));
        }, 2600);
      }),
    );

    target.onError(
      guard((data) => {
        const message = errorText(data.code);
        set({ roomActionPending: null, movePending: false });
        // Give the rejected draft back instead of silently eating what was typed.
        if (CHAT_RESTORE_CODES.has(data.code) && refs.lastChatText) {
          set({ chatRestore: refs.lastChatText });
          refs.lastChatText = '';
        }
        if (STALE_ROOM_CODES.has(data.code) && get().roomWaiting && !refs.match) {
          set({ roomWaiting: null });
          get().showToast(message);
          if (resultInteractionBlocked()) return;
          backToRanked();
          return;
        }
        get().showToast(message);
      }),
    );

    target.onHistory(
      guard((data) => {
        clearHistoryTimer();
        const message = data.error?.trim() || null;
        set({ historyItems: message ? [] : data.items ?? [], historyLoading: false, historyError: message });
        if (message) get().showToast(message);
      }),
    );

    target.onLeaderboard(
      guard((data) => {
        if (data.period !== get().leaderboardPeriod) return;
        clearLeaderboardTimer();
        const message = data.error?.trim() || null;
        set({ leaderboardItems: message ? [] : data.items ?? [], leaderboardLoading: false, leaderboardError: message });
        if (message) get().showToast(message);
      }),
    );

    target.onOpponentDisconnected(guard((data) => {
      if (resultInteractionBlocked()) return;
      refs.opponentAwayDeadline = data.graceDeadline;
      set({ oppAway: get().myTurn ? null : data.graceDeadline });
      bridge.attention({ reason: ARCADE_ATTENTION_REASON.OpponentDisconnected });
    }));
    target.onOpponentReconnected(guard((data) => {
      if (resultInteractionBlocked()) return;
      const previous = get();
      refs.opponentAwayDeadline = null;
      set({ oppAway: null });
      if (
        previous.gameMode === 'online' &&
        previous.boardMode === 'playing' &&
        Number.isInteger(data?.turn) &&
        typeof data?.deadline === 'number' &&
        Number.isFinite(data.deadline)
      ) {
        const turn = data!.turn!;
        const myTurn = turn === (refs.match?.you ?? 0);
        const alreadyApplied =
          previous.oppAway == null &&
          previous.myTurn === myTurn &&
          previous.deadline === data.deadline &&
          !previous.turnExpired;
        if (!alreadyApplied) applyTurn(turn, data.deadline, true);
      }
    }));

    target.onConnectionChange(
      guard((connected: boolean) => {
        if (!connected) {
          refs.acceptBufferedResult = false;
          if (get().boardMode === 'pregame') refs.roomConnectionLost = true;
          if (get().lobbyPhase === 'ready') get().showToast('Mất kết nối, đang thử lại...');
          return;
        }
        refs.acceptBufferedResult = true;
        if (refs.roomConnectionLost) {
          refs.roomConnectionLost = false;
          if (get().boardMode === 'pregame') {
            get().showToast('Kết nối bị gián đoạn, bạn đã rời bàn');
            backToRanked();
          }
        }
        if (get().rankedVisible) target.listRooms();
      }),
    );
  };

  const connectToServer = (): Promise<void> => {
    if (refs.connectPromise) return refs.connectPromise;
    if (refs.session && get().lobbyPhase === 'ready') return Promise.resolve();
    const run = ++refs.connectRun;
    set({ lobbyPhase: 'connecting', lobbyError: '' });
    let task!: Promise<void>;
    task = (async () => {
      let session: Session | null = null;
      try {
        session = await joinGame<ServerState, ServerMove>(GAME_ID);
        if (run !== refs.connectRun) {
          session.disconnect();
          return;
        }
        const connectedSession = session;
        refs.session = connectedSession;
        wireSession(connectedSession);
        await new Promise<void>((resolve, reject) => {
          let timeout: ReturnType<typeof setTimeout> | 0 = 0;
          let offInfo: () => void = () => {};
          let offErr: () => void = () => {};
          let cancel = () => {};
          const cleanup = () => {
            if (timeout) clearTimeout(timeout);
            timeout = 0;
            offInfo();
            offErr();
            if (refs.connectCancel === cancel) refs.connectCancel = null;
          };
          cancel = () => {
            cleanup();
            reject(new Error('cancelled'));
          };
          refs.connectCancel = cancel;
          offInfo = connectedSession.onUserInfo(() => {
            cleanup();
            resolve();
          });
          offErr = connectedSession.onConnectionError((error) => {
            if (
              !(error instanceof GameAuthenticationRequiredError) &&
              !(error instanceof GameAuthenticationExpiredError)
            ) {
              return;
            }
            cleanup();
            reject(error);
          });
          timeout = setTimeout(() => {
            cleanup();
            reject(new Error('timeout'));
          }, REQUEST_TIMEOUT_MS);
        });
      } catch (error) {
        session?.disconnect();
        if (refs.session === session) refs.session = null;
        if (run !== refs.connectRun) return;
        refs.user = null;
        const message =
          error instanceof GameAuthenticationRequiredError || error instanceof GameAuthenticationExpiredError
            ? 'Phiên đăng nhập hết hạn, hãy mở lại game'
            : 'Không kết nối được máy chủ';
        set({ lobbyPhase: 'error', lobbyError: message, userInfo: null });
        throw error;
      } finally {
        if (refs.connectPromise === task) refs.connectPromise = null;
      }
    })();
    refs.connectPromise = task;
    return task;
  };

  const requestHistory = () => {
    clearHistoryTimer();
    set({ historyLoading: true, historyError: null });
    const session = refs.session;
    if (!session) {
      const message = 'Chưa kết nối được máy chủ';
      set({ historyLoading: false, historyError: message });
      get().showToast(message);
      return;
    }
    session.getHistory();
    refs.historyTimer = setTimeout(() => {
      refs.historyTimer = 0;
      if (!get().historyLoading) return;
      const message = 'Không tải được lịch sử, hãy thử lại';
      set({ historyLoading: false, historyError: message });
      get().showToast(message);
    }, REQUEST_TIMEOUT_MS);
  };

  const requestLeaderboard = (period: LeaderboardPeriod) => {
    clearLeaderboardTimer();
    set({ leaderboardLoading: true, leaderboardError: null });
    const session = refs.session;
    if (!session) {
      const message = 'Chưa kết nối được máy chủ';
      set({ leaderboardLoading: false, leaderboardError: message });
      get().showToast(message);
      return;
    }
    session.getLeaderboard(period);
    refs.leaderboardTimer = setTimeout(() => {
      refs.leaderboardTimer = 0;
      if (!get().leaderboardLoading || get().leaderboardPeriod !== period) return;
      const message = 'Không tải được bảng xếp hạng, hãy thử lại';
      set({ leaderboardLoading: false, leaderboardError: message });
      get().showToast(message);
    }, REQUEST_TIMEOUT_MS);
  };

  return {
    lobbyVisible: true,
    lobbyPhase: 'loading',
    lobbyError: '',
    userInfo: null,
    ken: 0,
    soundOn: localStorage.getItem(SOUND_KEY) !== '0',
    gameMode: 'online',
    botSetupVisible: false,
    botDifficulty: 'medium',
    botPlayerSide: SIDE_RED,
    botThinking: false,

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
    historyError: null,
    leaderboardVisible: false,
    leaderboardItems: [],
    leaderboardPeriod: 'day',
    leaderboardLoading: false,
    leaderboardError: null,

    async init() {
      setSoundEnabled(get().soundOn);
      refs.hostKenOff?.();
      refs.hostKenOff = bridge.onHost(ARCADE_BRIDGE_EVENT.KenUpdated, (data) => {
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

    dispose() {
      refs.connectRun++;
      refs.connectCancel?.();
      refs.connectCancel = null;
      refs.connectPromise = null;
      const session = refs.session;
      refs.session = null;
      session?.disconnect();
      refs.hostKenOff?.();
      refs.hostKenOff = null;
      refs.user = null;
      refs.match = null;
      refs.matchBet = 0;
      refs.serverState = null;
      refs.botGame = null;
      refs.exitingMatchId = null;
      refs.acceptBufferedResult = false;
      refs.opponentAwayDeadline = null;
      refs.roomConnectionLost = false;
      refs.lastChatText = '';
      refs.handledMatchIds.clear();
      refs.botRun++;
      stopTimer();
      cancelBotTurn();
      cancelResultReveal();
      clearHistoryTimer();
      clearLeaderboardTimer();
      clearTransientTimers();
      if (refs.announceTimer) clearTimeout(refs.announceTimer);
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      refs.announceTimer = 0;
      refs.toastTimer = 0;
      set({
        lobbyVisible: true,
        lobbyPhase: 'loading',
        lobbyError: '',
        userInfo: null,
        gameMode: 'online',
        botSetupVisible: false,
        botThinking: false,
        rankedVisible: false,
        roomActionPending: null,
        roomWaiting: null,
        boardMode: 'idle',
        selected: null,
        hints: [],
        me: null,
        op: null,
        myTurn: false,
        movePending: false,
        deadline: 0,
        timerLeftMs: 0,
        turnExpired: false,
        turnAnnounce: null,
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
        historyLoading: false,
        historyError: null,
        leaderboardVisible: false,
        leaderboardLoading: false,
        leaderboardError: null,
      });
    },

    retryConnect() {
      if (refs.connectPromise) return;
      refs.session?.disconnect();
      refs.session = null;
      refs.user = null;
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

    openBotSetup() {
      if (get().boardMode !== 'idle' || resultInteractionBlocked()) return;
      playSound('click');
      set({ botSetupVisible: true });
    },

    closeBotSetup() {
      set({ botSetupVisible: false });
    },

    startBotGame(difficulty: BotDifficulty, playerSide: number) {
      if (get().boardMode !== 'idle' || resultInteractionBlocked()) return;
      startLocalBotGame(difficulty, playerSide);
    },

    restartBotGame() {
      if (get().gameMode !== 'bot' || resultInteractionBlocked()) return;
      get().showNotice({
        title: 'Ván mới',
        body: 'Bàn cờ hiện tại sẽ được xếp lại từ đầu.',
        okLabel: 'Ván mới',
        onOk: () => startLocalBotGame(get().botDifficulty, get().botPlayerSide),
      });
    },

    playRanked() {
      if (resultInteractionBlocked()) return;
      playSound('click');
      set({ rankedVisible: true, lobbyVisible: false });
      refs.session?.listRooms();
    },

    closeRanked() {
      set({ rankedVisible: false, lobbyVisible: true });
    },

    refreshRooms() {
      refs.session?.listRooms();
    },

    createRoom(bet: number, password: string) {
      if (get().roomActionPending || resultInteractionBlocked()) return;
      set({ roomActionPending: 'creating' });
      refs.session?.createRoom(bet, password);
    },

    joinRoom(roomId: string, password: string) {
      if (get().roomActionPending || resultInteractionBlocked()) return;
      set({ roomActionPending: 'joining' });
      refs.session?.joinRoom(roomId, password);
    },

    setReady(ready: boolean) {
      const room = get().roomWaiting;
      if (!room || resultInteractionBlocked()) return;
      playSound('click');
      refs.session?.setRoomReady(room.roomId, ready);
    },

    startMatch() {
      const room = get().roomWaiting;
      if (!room || get().roomActionPending || resultInteractionBlocked()) return;
      set({ roomActionPending: 'starting' });
      refs.session?.startRoom(room.roomId);
      scheduleTransient(() => {
        if (get().roomActionPending === 'starting') set({ roomActionPending: null });
      }, 4000);
    },

    leaveRoom() {
      if (resultInteractionBlocked()) return;
      const room = get().roomWaiting;
      refs.session?.leaveRoom(room?.roomId);
      backToRanked();
    },

    kickOpponent() {
      const room = get().roomWaiting;
      if (!room || resultInteractionBlocked()) return;
      const guest = room.members.find((member) => member.id !== room.ownerId);
      if (guest) refs.session?.kickRoomMember(room.roomId, guest.id);
    },

    tapSquare(idx: number) {
      const { boardMode, gameMode, botPlayerSide, myTurn, movePending, board, selected, hints, deadline } = get();
      if (boardMode !== 'playing' || !myTurn || movePending || resultInteractionBlocked()) return;
      if (gameMode === 'online' && deadline > 0 && Date.now() >= deadline) {
        set({ turnExpired: true, selected: null, hints: [] });
        return;
      }
      const mySide = gameMode === 'bot' ? botPlayerSide : refs.match?.you ?? SIDE_RED;
      const piece = board[idx];
      if (selected != null && hints.includes(idx)) {
        set({ movePending: true, hints: [], selected: null });
        if (gameMode === 'bot') applyBotGameMove(mySide, selected, idx);
        else if (refs.match) refs.session?.sendMove(refs.match.matchId, { from: selected, to: idx });
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
      if (resultInteractionBlocked()) return;
      if (get().gameMode === 'bot') {
        get().showNotice({
          title: 'Bỏ cuộc',
          body: 'Bạn muốn nhận thua ván đấu với máy này?',
          okLabel: 'Bỏ cuộc',
          danger: true,
          onOk: () => {
            get().showNotice(null);
            finishBotGame({ winner: 1 - get().botPlayerSide, reason: 'checkmate' }, true, 'Bạn đã bỏ cuộc');
          },
        });
        return;
      }
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
      if (resultInteractionBlocked()) return;
      if (get().gameMode === 'bot') {
        get().showNotice({
          title: 'Thoát luyện tập',
          body: 'Rời ván đấu với máy và quay về sảnh?',
          okLabel: 'Thoát',
          danger: true,
          onOk: leaveBotToLobby,
        });
        return;
      }
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
          refs.exitingMatchId = match.matchId;
          refs.session?.forfeit(match.matchId, true);
          get().showNotice(null);
        },
      });
    },

    openChat() {
      if (resultInteractionBlocked()) return;
      set({ chatOpen: true, chatUnread: false });
    },

    closeChat() {
      set({ chatOpen: false });
    },

    sendChatText(text: string) {
      if (resultInteractionBlocked()) return;
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
      if (resultInteractionBlocked()) return;
      const match = refs.match;
      if (!match) return;
      refs.session?.sendReaction(match.matchId, type);
    },

    closeResult() {
      cancelResultReveal();
      if (get().gameMode === 'bot') {
        leaveBotToLobby();
        return;
      }
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
      if (get().gameMode === 'bot') {
        startLocalBotGame(get().botDifficulty, get().botPlayerSide);
        return;
      }
      get().closeResult();
    },

    showHistory() {
      playSound('click');
      set({ historyVisible: true });
      requestHistory();
    },

    retryHistory() {
      requestHistory();
    },

    closeHistory() {
      clearHistoryTimer();
      set({ historyVisible: false, historyLoading: false });
    },

    showLeaderboard() {
      playSound('click');
      set({ leaderboardVisible: true });
      requestLeaderboard(get().leaderboardPeriod);
    },

    retryLeaderboard() {
      requestLeaderboard(get().leaderboardPeriod);
    },

    setLeaderboardPeriod(period: LeaderboardPeriod) {
      set({ leaderboardPeriod: period, leaderboardItems: [] });
      requestLeaderboard(period);
    },

    closeLeaderboard() {
      clearLeaderboardTimer();
      set({ leaderboardVisible: false, leaderboardLoading: false });
    },

    showToast(text: string) {
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      set({ toast: text });
      refs.toastTimer = setTimeout(() => set({ toast: null }), TOAST_MS);
    },

    clearToast() {
      if (refs.toastTimer) clearTimeout(refs.toastTimer);
      refs.toastTimer = 0;
      set({ toast: null });
    },

    showNotice(notice: NoticeState | null) {
      set({ notice });
    },
  };
});
