import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, vi } from 'vitest';
import { START_BOARD } from '../logic/constants.gen';

const sdkMocks = vi.hoisted(() => ({
  joinGame: vi.fn(),
  bridge: {
    onHost: vi.fn(() => vi.fn()),
    ready: vi.fn(),
    gameOver: vi.fn(),
    turnChanged: vi.fn(),
    attention: vi.fn(),
    refreshUser: vi.fn(),
    exit: vi.fn(),
  },
}));

const audioMocks = vi.hoisted(() => ({
  playSound: vi.fn(),
  setSoundEnabled: vi.fn(),
}));

const localGameMocks = vi.hoisted(() => ({
  applyLocalMove: vi.fn(),
}));

vi.mock('../../src/sdk', () => {
  class GameAuthenticationRequiredError extends Error {}
  class GameAuthenticationExpiredError extends Error {}
  return {
    ...sdkMocks,
    GameAuthenticationRequiredError,
    GameAuthenticationExpiredError,
    GAME_ERROR_CODE: {
      AlreadyInRoom: 'ALREADY_IN_ROOM',
      BetNotAllowed: 'BET_NOT_ALLOWED',
      WrongPassword: 'WRONG_PASSWORD',
      RoomNotFound: 'ROOM_NOT_FOUND',
      OwnRoom: 'OWN_ROOM',
      RoomBusy: 'ROOM_BUSY',
      RoomCreateFailed: 'ROOM_CREATE_FAILED',
      RoomFull: 'ROOM_FULL',
      RoomJoinFailed: 'ROOM_JOIN_FAILED',
      RoomLeaveFailed: 'ROOM_LEAVE_FAILED',
      RoomListFailed: 'ROOM_LIST_FAILED',
      RoomMemberNotFound: 'ROOM_MEMBER_NOT_FOUND',
      RoomMismatch: 'ROOM_MISMATCH',
      RoomNotReady: 'ROOM_NOT_READY',
      RoomStartFailed: 'ROOM_START_FAILED',
      NotRoomOwner: 'NOT_ROOM_OWNER',
      InvalidBet: 'INVALID_BET',
      InvalidPassword: 'INVALID_PASSWORD',
      InsufficientKen: 'INSUFFICIENT_KEN',
      ChatRateLimited: 'CHAT_RATE_LIMITED',
      ChatTooLong: 'CHAT_TOO_LONG',
      InvalidChat: 'INVALID_CHAT',
      InvalidReaction: 'INVALID_REACTION',
      RoomNotFull: 'ROOM_NOT_FULL',
      NotRoomMember: 'NOT_ROOM_MEMBER',
      InvalidMove: 'INVALID_MOVE',
      MatchMismatch: 'MATCH_MISMATCH',
      NoMatch: 'NO_MATCH',
      NotYourTurn: 'NOT_YOUR_TURN',
      ReactionRateLimited: 'REACTION_RATE_LIMITED',
      StateSaveFailed: 'STATE_SAVE_FAILED',
      UnknownGame: 'UNKNOWN_GAME',
    },
  };
});

vi.mock('../audio', () => audioMocks);

vi.mock('../logic/local-game', async () => {
  const actual = await vi.importActual<typeof import('../logic/local-game')>('../logic/local-game');
  return { ...actual, applyLocalMove: localGameMocks.applyLocalMove };
});

type Handler = (data: any) => void;

class FakeSession {
  readonly listeners = new Map<string, Set<Handler>>();
  readonly disconnect = vi.fn();
  readonly listRooms = vi.fn();
  readonly getHistory = vi.fn();
  readonly getLeaderboard = vi.fn();
  readonly createRoom = vi.fn();
  readonly joinRoom = vi.fn();
  readonly setRoomReady = vi.fn();
  readonly startRoom = vi.fn();
  readonly leaveRoom = vi.fn();
  readonly kickRoomMember = vi.fn();
  readonly sendMove = vi.fn();
  readonly sendChat = vi.fn();
  readonly sendRoomChat = vi.fn();
  readonly sendReaction = vi.fn();
  readonly forfeit = vi.fn();

  emit(type: string, data?: any): void {
    this.listeners.get(type)?.forEach((handler) => handler(data));
  }

  private on(type: string, handler: Handler): () => void {
    let handlers = this.listeners.get(type);
    if (!handlers) {
      handlers = new Set();
      this.listeners.set(type, handlers);
    }
    handlers.add(handler);
    return () => handlers?.delete(handler);
  }

  onUserInfo = (handler: Handler) => this.on('userInfo', handler);
  onRoomList = (handler: Handler) => this.on('roomList', handler);
  onRoomUpsert = (handler: Handler) => this.on('roomUpsert', handler);
  onRoomRemoved = (handler: Handler) => this.on('roomRemoved', handler);
  onRoomState = (handler: Handler) => this.on('roomState', handler);
  onRoomSync = (handler: Handler) => this.on('roomSync', handler);
  onRoomClosed = (handler: Handler) => this.on('roomClosed', handler);
  onRoomKicked = (handler: Handler) => this.on('roomKicked', handler);
  onMatchFound = (handler: Handler) => this.on('matchFound', handler);
  onState = (handler: Handler) => this.on('state', handler);
  onMatchOver = (handler: Handler) => this.on('matchOver', handler);
  onChat = (handler: Handler) => this.on('chat', handler);
  onReaction = (handler: Handler) => this.on('reaction', handler);
  onError = (handler: Handler) => this.on('error', handler);
  onHistory = (handler: Handler) => this.on('history', handler);
  onLeaderboard = (handler: Handler) => this.on('leaderboard', handler);
  onOpponentDisconnected = (handler: Handler) => this.on('opponentDisconnected', handler);
  onOpponentReconnected = (handler: Handler) => this.on('opponentReconnected', handler);
  onConnectionChange = (handler: Handler) => this.on('connectionChange', handler);
  onConnectionError = (handler: Handler) => this.on('connectionError', handler);
}

const USER = { id: 'me', username: 'Tôi', vipDays: 0, ken: 1000 };

function serverState(board: readonly number[] = START_BOARD, steps: any[] = []) {
  return {
    board: [...board],
    moveCount: 0,
    halfmoveClock: 0,
    history: [],
    historyChecks: [],
    lastFrom: steps[0]?.from ?? -1,
    lastTo: steps[0]?.to ?? -1,
    check: steps.some((step) => step.kind === 'check'),
    steps,
  };
}

function matchFound(matchId = 'match-1', deadline = Date.now() + 30_000) {
  return {
    matchId,
    gameId: 'xiangqi',
    players: [
      { id: 'me', name: 'Tôi' },
      { id: 'op', name: 'Đối thủ' },
    ],
    you: 0,
    state: serverState(),
    turn: 0,
    deadline,
    bet: 10,
  };
}

function waitingRoom(afterMatchId?: string) {
  return {
    roomId: 'room-1',
    ownerId: 'me',
    youId: 'me',
    bet: 10,
    locked: false,
    members: [
      { id: 'me', name: 'Tôi', owner: true, ready: false },
      { id: 'op', name: 'Đối thủ', owner: false, ready: false },
    ],
    afterMatchId,
  };
}

let useXiangqi: typeof import('./useXiangqi')['useXiangqi'];
let initialState: ReturnType<typeof useXiangqi.getState>;

async function connect(session: FakeSession): Promise<void> {
  sdkMocks.joinGame.mockResolvedValueOnce(session);
  const init = useXiangqi.getState().init();
  await vi.advanceTimersByTimeAsync(0);
  session.emit('userInfo', USER);
  await init;
}

beforeAll(async () => {
  const values = new Map<string, string>();
  vi.stubGlobal('localStorage', {
    getItem: (key: string) => values.get(key) ?? null,
    setItem: (key: string, value: string) => values.set(key, value),
  });
  ({ useXiangqi } = await import('./useXiangqi'));
  initialState = useXiangqi.getState();
});

beforeEach(() => {
  vi.useFakeTimers();
  vi.setSystemTime(new Date('2026-08-24T00:00:00Z'));
  sdkMocks.joinGame.mockReset();
  Object.values(sdkMocks.bridge).forEach((mock) => mock.mockClear());
  audioMocks.playSound.mockReset();
  audioMocks.setSoundEnabled.mockReset();
  localGameMocks.applyLocalMove.mockReset();
  useXiangqi.setState(initialState, true);
});

afterEach(() => {
  useXiangqi.getState().dispose();
  useXiangqi.setState(initialState, true);
  vi.useRealTimers();
});

afterAll(() => {
  vi.unstubAllGlobals();
});

describe('Xiangqi online integration state', () => {
  it('restores an authoritative reconnected deadline after the old turn expired', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', { ...matchFound('match-deadline', Date.now() + 500), turn: 1 });
    session.emit('opponentDisconnected', { graceDeadline: Date.now() + 60_000, userId: 'op' });

    await vi.advanceTimersByTimeAsync(750);
    expect(useXiangqi.getState().turnExpired).toBe(true);

    sdkMocks.bridge.turnChanged.mockClear();
    session.emit('opponentReconnected', { userId: 'op', turn: 1, deadline: Date.now() + 30_000 });
    session.emit('opponentReconnected', { userId: 'op', turn: 1, deadline: Date.now() + 30_000 });

    expect(useXiangqi.getState()).toMatchObject({ myTurn: false, turnExpired: false, timerLeftMs: 30_000 });
    expect(sdkMocks.bridge.turnChanged).toHaveBeenCalledOnce();
  });

  it('announces the server move played for us after our clock ran out', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound('match-auto', Date.now() + 500));

    await vi.advanceTimersByTimeAsync(750);
    expect(useXiangqi.getState()).toMatchObject({ turnExpired: true, myTurn: true });

    const autoBoard = [...START_BOARD];
    autoBoard[9] = autoBoard[0];
    autoBoard[0] = 0;
    session.emit('state', {
      matchId: 'match-auto',
      state: serverState(autoBoard, [{ kind: 'move', from: 0, to: 9 }]),
      turn: 1,
      deadline: Date.now() + 60_000,
      lastBy: 0,
      autoMoved: true,
    });

    expect(useXiangqi.getState()).toMatchObject({
      board: autoBoard,
      myTurn: false,
      turnExpired: false,
      toast: 'Hết giờ — hệ thống đã đi thay bạn',
    });
  });

  it('announces the server move even when it lands before the local clock hits zero', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound('match-auto-early', Date.now() + 500));

    // The 250 ms tick has not run past the deadline yet, so turnExpired is still
    // false when the server-played move arrives.
    await vi.advanceTimersByTimeAsync(400);
    expect(useXiangqi.getState().turnExpired).toBe(false);

    session.emit('state', {
      matchId: 'match-auto-early',
      state: serverState(),
      turn: 1,
      deadline: Date.now() + 60_000,
      lastBy: 0,
      autoMoved: true,
    });

    expect(useXiangqi.getState().toast).toBe('Hết giờ — hệ thống đã đi thay bạn');
  });

  it('stays quiet when our own in-time move is echoed back after the local clock expired', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound('match-late-echo', Date.now() + 500));
    useXiangqi.getState().tapSquare(0);
    useXiangqi.getState().tapSquare(9);
    expect(session.sendMove).toHaveBeenCalledWith('match-late-echo', { from: 0, to: 9 });

    await vi.advanceTimersByTimeAsync(750);
    expect(useXiangqi.getState().turnExpired).toBe(true);

    session.emit('state', {
      matchId: 'match-late-echo',
      state: serverState(),
      turn: 1,
      deadline: Date.now() + 60_000,
      lastBy: 0,
    });

    expect(useXiangqi.getState()).toMatchObject({ myTurn: false, turnExpired: false, toast: null });
  });

  it('shows a technical abort as a refunded no-result instead of a loss', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound('match-aborted'));

    session.emit('matchOver', {
      matchId: 'match-aborted',
      winnerId: '',
      reason: 'aborted',
      state: serverState(),
      bet: 10,
    });
    await vi.advanceTimersByTimeAsync(3_000);

    expect(useXiangqi.getState().result).toMatchObject({
      matchId: 'match-aborted',
      outcome: 'draw',
      kenDelta: null,
      reasonText: 'Trận bị hủy do lỗi hệ thống · cược đã được hoàn',
    });
  });

  it('stays quiet when the opponent is the one the server moved for', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', { ...matchFound('match-auto-op', Date.now() + 500), turn: 1 });

    await vi.advanceTimersByTimeAsync(750);
    expect(useXiangqi.getState().turnExpired).toBe(true);

    session.emit('state', {
      matchId: 'match-auto-op',
      state: serverState(),
      turn: 0,
      deadline: Date.now() + 60_000,
      lastBy: 1,
      autoMoved: true,
    });

    expect(useXiangqi.getState()).toMatchObject({ myTurn: true, turnExpired: false, toast: null });
  });

  it('keeps an active local turn playable until control passes to the disconnected opponent', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound('match-away'));
    const graceDeadline = Date.now() + 60_000;
    session.emit('opponentDisconnected', { graceDeadline, userId: 'op' });

    expect(useXiangqi.getState().oppAway).toBeNull();
    useXiangqi.getState().tapSquare(0);
    expect(useXiangqi.getState().selected).toBe(0);
    useXiangqi.getState().tapSquare(9);
    expect(session.sendMove).toHaveBeenCalledWith('match-away', { from: 0, to: 9 });

    session.emit('state', {
      matchId: 'match-away',
      state: serverState(),
      turn: 1,
      deadline: Date.now() + 30_000,
      lastBy: 0,
    });
    expect(useXiangqi.getState()).toMatchObject({ myTurn: false, oppAway: graceDeadline });
  });

  it('preserves the closing board and delayed result across the following room snapshot', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('roomState', waitingRoom());
    session.emit('matchFound', matchFound());
    session.emit('roomState', { ...waitingRoom(), roomId: 'stale-room' });
    session.emit('roomClosed', { roomId: 'stale-room', reason: 'owner_left' });
    expect(useXiangqi.getState()).toMatchObject({ boardMode: 'playing' });
    expect(useXiangqi.getState().roomWaiting?.roomId).toBe('room-1');
    useXiangqi.getState().openChat();
    useXiangqi.getState().showNotice({ title: 'Thoát', body: 'Thoát?', okLabel: 'Thoát', onOk: vi.fn() });
    const finalBoard = [...START_BOARD];
    finalBoard[9] = finalBoard[0];
    finalBoard[0] = 0;

    session.emit('matchOver', {
      matchId: 'match-1',
      winnerId: 'me',
      reason: 'win',
      state: serverState(finalBoard, [{ kind: 'move', from: 0, to: 9 }]),
      bet: 10,
    });
    expect(useXiangqi.getState()).toMatchObject({ chatOpen: false, notice: null });
    session.emit('matchFound', { ...matchFound(), resumed: true });
    session.emit('state', {
      matchId: 'match-1',
      state: serverState(),
      turn: 0,
      deadline: Date.now() + 30_000,
      lastBy: 1,
    });
    expect(useXiangqi.getState()).toMatchObject({ board: finalBoard, myTurn: false });
    useXiangqi.getState().tapSquare(27);
    useXiangqi.getState().tapSquare(36);
    expect(session.sendMove).not.toHaveBeenCalled();
    session.emit('roomState', { ...waitingRoom('other-match'), roomId: 'wrong-post-match-room' });
    expect(useXiangqi.getState().roomWaiting?.roomId).toBe('room-1');
    session.emit('roomState', waitingRoom('match-1'));

    expect(useXiangqi.getState()).toMatchObject({ boardMode: 'playing', board: finalBoard, result: null });
    useXiangqi.getState().setReady(true);
    useXiangqi.getState().createRoom(0, '');
    expect(session.setRoomReady).not.toHaveBeenCalled();
    expect(session.createRoom).not.toHaveBeenCalled();
    session.emit('roomClosed', { roomId: 'room-1', reason: 'owner_left' });
    expect(useXiangqi.getState()).toMatchObject({ roomWaiting: null, boardMode: 'playing', result: null });

    await vi.advanceTimersByTimeAsync(1100);
    expect(useXiangqi.getState().result).toMatchObject({ matchId: 'match-1', outcome: 'win' });
  });

  it('accepts a buffered reconnect result before ROOM_STATE and keeps it out of bot mode', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('roomSync', {});
    session.emit('connectionChange', true);
    const finalBoard = [...START_BOARD];
    finalBoard[9] = finalBoard[0];
    finalBoard[0] = 0;

    session.emit('matchOver', {
      matchId: 'buffered-match',
      winnerId: 'op',
      reason: 'timeout',
      state: serverState(finalBoard, [{ kind: 'move', from: 0, to: 9 }]),
    });
    session.emit('matchOver', {
      matchId: 'stale-buffered-match',
      winnerId: 'me',
      reason: 'timeout',
      state: serverState(),
    });
    expect(useXiangqi.getState()).toMatchObject({ board: finalBoard });
    expect(useXiangqi.getState().result).toMatchObject({ matchId: 'buffered-match', outcome: 'lose' });
    session.emit('roomState', waitingRoom('buffered-match'));

    expect(useXiangqi.getState()).toMatchObject({ boardMode: 'idle', board: finalBoard });
    expect(useXiangqi.getState().result).toMatchObject({ matchId: 'buffered-match', outcome: 'lose' });

    useXiangqi.getState().closeResult();
    useXiangqi.getState().leaveRoom();
    session.emit('matchOver', {
      matchId: 'late-idle-match',
      winnerId: 'op',
      reason: 'timeout',
      state: serverState(),
    });
    expect(useXiangqi.getState().result).toBeNull();
    useXiangqi.getState().startBotGame('medium', 0);
    session.emit('matchOver', {
      matchId: 'stale-online-match',
      winnerId: 'op',
      reason: 'timeout',
      state: serverState(),
    });
    expect(useXiangqi.getState()).toMatchObject({ gameMode: 'bot', result: null });
  });

  it('restores the authoritative bet for a buffered reconnect draw', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('roomSync', {});
    session.emit('connectionChange', true);

    session.emit('matchOver', {
      matchId: 'buffered-draw',
      winnerId: '',
      reason: 'draw',
      state: serverState(),
      bet: 250,
    });

    expect(useXiangqi.getState()).toMatchObject({
      bet: 250,
      result: { matchId: 'buffered-draw', outcome: 'draw' },
    });
  });

  it('does not replay stale closing steps or delay external match endings', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound());
    audioMocks.playSound.mockClear();

    session.emit('matchOver', {
      matchId: 'match-1',
      winnerId: 'me',
      reason: 'timeout',
      state: serverState(START_BOARD, [
        { kind: 'move', from: 0, to: 9 },
        { kind: 'capture', from: 0, to: 9 },
        { kind: 'check', from: 0, to: 9 },
      ]),
    });

    expect(useXiangqi.getState().result).toMatchObject({ matchId: 'match-1', outcome: 'win' });
    expect(audioMocks.playSound).toHaveBeenCalledTimes(1);
    expect(audioMocks.playSound).toHaveBeenCalledWith('win');
    expect(useXiangqi.getState()).toMatchObject({ lastFrom: -1, lastTo: -1, checkSeq: 0 });
  });

  it('does not let bot forfeit overwrite a valid result during its reveal delay', async () => {
    const session = new FakeSession();
    await connect(session);
    useXiangqi.getState().startBotGame('medium', 0);
    const board = [...START_BOARD];
    board[36] = board[27];
    board[27] = 0;
    localGameMocks.applyLocalMove.mockReturnValueOnce({
      captured: 0,
      checked: true,
      state: {
        ...serverState(board),
        moveCount: 1,
        lastFrom: 27,
        lastTo: 36,
        result: { winner: 0, reason: 'checkmate' },
      },
    });
    useXiangqi.getState().showNotice({ title: 'Ván mới', body: 'Chơi lại?', okLabel: 'Chơi', onOk: vi.fn() });

    useXiangqi.getState().tapSquare(27);
    useXiangqi.getState().tapSquare(36);
    useXiangqi.getState().forfeitMatch();

    expect(useXiangqi.getState().notice).toBeNull();
    await vi.advanceTimersByTimeAsync(1100);
    expect(useXiangqi.getState().result).toMatchObject({ outcome: 'win' });
  });

  it('returns from ranked to a visible lobby after an online result', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound());
    session.emit('matchOver', {
      matchId: 'match-1',
      winnerId: 'op',
      reason: 'forfeit',
      state: serverState(),
    });

    useXiangqi.getState().closeResult();
    useXiangqi.getState().closeRanked();

    expect(useXiangqi.getState()).toMatchObject({ boardMode: 'idle', rankedVisible: false, lobbyVisible: true });
  });

  it('clears stale room state and exposes request errors for retry', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('roomState', waitingRoom());
    const refreshedRoom = waitingRoom('already-dismissed-match');
    refreshedRoom.members[1]!.ready = true;
    session.emit('roomState', refreshedRoom);
    expect(useXiangqi.getState().roomWaiting?.members[1]?.ready).toBe(true);
    session.emit('error', { code: 'NOT_ROOM_MEMBER', message: '' });
    expect(useXiangqi.getState()).toMatchObject({ roomWaiting: null, boardMode: 'idle', rankedVisible: true });

    useXiangqi.getState().showHistory();
    session.emit('history', { items: [], error: 'History unavailable' });
    expect(useXiangqi.getState()).toMatchObject({ historyLoading: false, historyError: 'History unavailable' });
    useXiangqi.getState().retryHistory();
    expect(useXiangqi.getState()).toMatchObject({ historyLoading: true, historyError: null });
    expect(session.getHistory).toHaveBeenCalledTimes(2);

    useXiangqi.getState().showLeaderboard();
    session.emit('leaderboard', { period: 'day', from: 0, to: 0, items: [], error: 'Rank unavailable' });
    expect(useXiangqi.getState()).toMatchObject({ leaderboardLoading: false, leaderboardError: 'Rank unavailable' });
    useXiangqi.getState().retryLeaderboard();
    expect(useXiangqi.getState()).toMatchObject({ leaderboardLoading: true, leaderboardError: null });
    expect(session.getLeaderboard).toHaveBeenCalledTimes(2);
  });

  it('disconnects a timed-out session before a clean retry', async () => {
    const first = new FakeSession();
    sdkMocks.joinGame.mockResolvedValueOnce(first);
    const init = useXiangqi.getState().init();
    await vi.advanceTimersByTimeAsync(8000);
    await init;

    expect(first.disconnect).toHaveBeenCalledOnce();
    expect(useXiangqi.getState()).toMatchObject({ lobbyPhase: 'error', userInfo: null });

    const second = new FakeSession();
    sdkMocks.joinGame.mockResolvedValueOnce(second);
    useXiangqi.getState().retryConnect();
    await vi.advanceTimersByTimeAsync(0);
    second.emit('userInfo', USER);
    await vi.advanceTimersByTimeAsync(0);

    expect(sdkMocks.joinGame).toHaveBeenCalledTimes(2);
    expect(useXiangqi.getState().lobbyPhase).toBe('ready');
  });

  it('cancels a pending result reveal and resets to reconnectable idle state on dispose', async () => {
    const session = new FakeSession();
    await connect(session);
    session.emit('matchFound', matchFound());
    session.emit('matchOver', {
      matchId: 'match-1',
      winnerId: 'me',
      reason: 'win',
      state: serverState(START_BOARD, [{ kind: 'move', from: 0, to: 9 }]),
    });

    useXiangqi.getState().dispose();
    await vi.advanceTimersByTimeAsync(1100);

    expect(useXiangqi.getState()).toMatchObject({ boardMode: 'idle', lobbyPhase: 'loading', result: null });
    expect(session.disconnect).toHaveBeenCalled();
  });

  it('cancels a StrictMode-style pending connection and ignores its stale handlers', async () => {
    const first = new FakeSession();
    sdkMocks.joinGame.mockResolvedValueOnce(first);
    const firstInit = useXiangqi.getState().init();
    await vi.advanceTimersByTimeAsync(0);

    useXiangqi.getState().dispose();

    const second = new FakeSession();
    sdkMocks.joinGame.mockResolvedValueOnce(second);
    const secondInit = useXiangqi.getState().init();
    await vi.advanceTimersByTimeAsync(0);
    second.emit('userInfo', { ...USER, id: 'second-user', username: 'Mới' });
    await Promise.all([firstInit, secondInit]);

    first.emit('userInfo', { ...USER, id: 'stale-user', username: 'Cũ' });
    expect(first.disconnect).toHaveBeenCalled();
    expect(useXiangqi.getState().userInfo?.id).toBe('second-user');
  });
});
