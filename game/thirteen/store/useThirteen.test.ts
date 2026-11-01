import { afterEach, describe, expect, it, vi } from 'vitest';
import type {
  LeaderboardData,
  MatchFoundData,
  MatchHistoryData,
  MatchOverData,
  OpponentReconnectedData,
  PlayerInfo,
  RoomInfo,
  RoomStateData,
  SpectateJoinedData,
  StateData,
  UserInfoData,
} from '../../src/sdk';

const sessionHandlers = vi.hoisted(() => new Map<string, Set<(data: unknown) => void>>());
const sessionCalls = vi.hoisted(() => [] as Array<[string, unknown[]]>);

vi.mock('../../src/sdk', () => {
  const session = new Proxy(
    {},
    {
      get: (_target, key: string) => {
        if (key === 'then') return undefined;
        if (key.startsWith('on')) {
          return (handler: (data: unknown) => void) => {
            const handlers = sessionHandlers.get(key) ?? new Set();
            handlers.add(handler);
            sessionHandlers.set(key, handlers);
            return () => handlers.delete(handler);
          };
        }
        return (...args: unknown[]) => {
          sessionCalls.push([key, args]);
        };
      },
    },
  );
  const bridge = new Proxy({}, { get: () => () => undefined });
  return { bridge, joinGame: vi.fn(() => Promise.resolve(session)) };
});

import { RECORD_REQUEST_TIMEOUT_MS, useThirteen } from './useThirteen';

const emit = (event: string, data: unknown): void => {
  sessionHandlers.get(event)?.forEach((handler) => handler(data));
};

const connect = async (): Promise<void> => {
  useThirteen.getState().init();
  await vi.waitFor(() => expect(sessionHandlers.get('onMatchOver')?.size).toBe(1));
};

const players: PlayerInfo[] = [
  { id: 'me', name: 'Bạn' },
  { id: 'opp', name: 'Đối thủ' },
];
const me = { id: 'me', name: 'Bạn' } as UserInfoData;

const serverState = (turn: number, steps: unknown[] = []) => ({
  you: 0,
  yourHand: [8, 12],
  handCounts: [2, 1],
  passed: [false, false],
  quit: [false, false],
  finishOrder: [],
  turn,
  starter: 0,
  require3s: false,
  moveCount: steps.length,
  steps,
});

const originalState = useThirteen.getState();

const waitingRoom: RoomStateData = {
  roomId: 'room-1',
  ownerId: 'me',
  youId: 'me',
  bet: 0,
  locked: false,
  maxPlayers: 4,
  members: [{ id: 'me', name: 'Bạn', owner: true, ready: true }],
};

afterEach(() => {
  useThirteen.getState().dispose();
  sessionHandlers.clear();
  sessionCalls.length = 0;
  vi.useRealTimers();
  vi.unstubAllGlobals();
  useThirteen.setState(originalState, true);
});

describe('Thirteen result navigation', () => {
  it('clears the waiting room when the player leaves after a match', () => {
    useThirteen.setState({ phase: 'table', room: waitingRoom, matchId: 'match-1', result: { rankings: [], reason: 'win' } });

    useThirteen.getState().closeResult(false);

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', room: null, matchId: '', result: null });
  });

  it('returns room players to the waiting room for another round', () => {
    useThirteen.setState({ phase: 'table', room: waitingRoom, matchId: 'match-1', result: { rankings: [], reason: 'win' } });

    useThirteen.getState().closeResult(true);

    expect(useThirteen.getState()).toMatchObject({ phase: 'room', room: waitingRoom, matchId: '', result: null });
  });
});

describe('Thirteen match over', () => {
  const overFor = (matchId: string): MatchOverData<unknown> => ({
    matchId,
    winnerId: 'me',
    reason: 'win',
    rankings: [
      { userId: 'me', place: 1 },
      { userId: 'opp', place: 2 },
    ],
  });

  it('shows the result of the match that just ended', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-a', players, user: me });

    emit('onMatchOver', overFor('match-a'));
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState().result?.winnerId).toBe('me');
  });

  it('drops a late result once the next match has started', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-b', players, user: me });

    emit('onMatchOver', overFor('match-b'));
    const next: MatchFoundData = {
      matchId: 'match-c',
      gameId: 'thirteen',
      players,
      you: 0,
      state: serverState(0),
      turn: 0,
      deadline: Date.now() + 30_000,
      resumed: true,
    };
    emit('onMatchFound', next);
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState()).toMatchObject({ matchId: 'match-c', result: null });
  });

  it('cancels a pending result when the player leaves the table', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-d', players, user: me });

    emit('onMatchOver', overFor('match-d'));
    useThirteen.getState().confirmExitNow();
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', result: null });
  });

  it('ignores the result that arrives after the player left the table', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-e', players, user: me });

    useThirteen.getState().confirmExitNow();
    emit('onMatchOver', overFor('match-e'));
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', result: null });
  });

  it('shows the result once the server brings the player back to the match they left', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-g', players, user: me });

    useThirteen.getState().confirmExitNow();
    const resumed: MatchFoundData = {
      matchId: 'match-g',
      gameId: 'thirteen',
      players,
      you: 0,
      state: serverState(1),
      turn: 1,
      deadline: Date.now() + 30_000,
      resumed: true,
    };
    emit('onMatchFound', resumed);
    emit('onMatchOver', overFor('match-g'));
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState()).toMatchObject({ phase: 'table', matchId: 'match-g' });
    expect(useThirteen.getState().result?.winnerId).toBe('me');
  });
});

describe('Thirteen opponent reconnect', () => {
  it('re-arms the turn clock with the deadline from the server', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', players, you: 0, turn: 1, deadlineAt: 0 });
    const reconnected: OpponentReconnectedData = { userId: 'opp', turn: 1, deadline: Date.now() + 20_000 };

    emit('onOpponentReconnected', reconnected);

    await vi.waitFor(() => expect(useThirteen.getState().deadlineAt).toBeGreaterThan(performance.now() + 19_000));
  });

  it('keeps the clock when the reconnect belongs to another turn', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', players, you: 0, turn: 0, deadlineAt: 123 });

    emit('onOpponentReconnected', { userId: 'opp', turn: 1, deadline: Date.now() + 20_000 });
    await new Promise((resolve) => setTimeout(resolve, 0));

    expect(useThirteen.getState().deadlineAt).toBe(123);
  });

  it('applies the reconnect deadline after the running animation catches up', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-f', players, you: 0, turn: 0, deadlineAt: 0 });
    const opponentPlayed: StateData = {
      matchId: 'match-f',
      state: serverState(1, [{ kind: 'play', by: 1, cards: [5] }]),
      turn: 1,
      deadline: Date.now() + 30_000,
      lastBy: 1,
    };

    emit('onState', opponentPlayed);
    emit('onOpponentReconnected', { userId: 'opp', turn: 1, deadline: Date.now() + 50_000 });
    await vi.advanceTimersByTimeAsync(1_000);

    expect(useThirteen.getState().turn).toBe(1);
    expect(useThirteen.getState().deadlineAt - performance.now()).toBeGreaterThan(45_000);
  });
});

describe('Thirteen opening lead', () => {
  it('marks the previous winner opening the deal until the first card lands', async () => {
    await connect();
    vi.useFakeTimers();
    emit('onMatchFound', {
      matchId: 'match-led',
      gameId: 'thirteen',
      players,
      you: 0,
      state: { ...serverState(0), ledByWinner: true },
      turn: 0,
      deadline: Date.now() + 30_000,
      resumed: true,
    } satisfies MatchFoundData);
    await vi.advanceTimersByTimeAsync(0);
    expect(useThirteen.getState().openingLead).toBe(true);

    emit('onState', {
      matchId: 'match-led',
      state: { ...serverState(1, [{ kind: 'play', by: 0, cards: [8] }]), ledByWinner: true },
      turn: 1,
      deadline: Date.now() + 30_000,
      lastBy: 0,
    } satisfies StateData);
    await vi.advanceTimersByTimeAsync(2_000);
    expect(useThirteen.getState()).toMatchObject({ turn: 1, openingLead: false });
  });

  it('drops the mark when the previous winner leaves before opening', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-quit', players, you: 0, turn: 1, openingLead: true });
    emit('onState', {
      matchId: 'match-quit',
      state: { ...serverState(0), starter: 1, quit: [false, true], ledByWinner: true },
      turn: 0,
      deadline: Date.now() + 30_000,
      lastBy: 1,
      autoMoved: true,
    } satisfies StateData);
    await vi.advanceTimersByTimeAsync(1_000);
    expect(useThirteen.getState()).toMatchObject({ turn: 0, openingLead: false });
  });

  it('leaves the opening unmarked on a three of spades deal', async () => {
    await connect();
    vi.useFakeTimers();
    emit('onMatchFound', {
      matchId: 'match-3s',
      gameId: 'thirteen',
      players,
      you: 0,
      state: { ...serverState(0), require3s: true },
      turn: 0,
      deadline: Date.now() + 30_000,
      resumed: true,
    } satisfies MatchFoundData);
    await vi.advanceTimersByTimeAsync(0);
    expect(useThirteen.getState()).toMatchObject({ require3s: true, openingLead: false });
  });
});

describe('Thirteen first finisher', () => {
  it('keeps following the table after playing the last cards', async () => {
    await connect();
    vi.useFakeTimers();
    const table3: PlayerInfo[] = [...players, { id: 'third', name: 'Người thứ ba' }];
    useThirteen.setState({ phase: 'table', matchId: 'match-win', players: table3, you: 0, turn: 0, hand: [20, 25, 31], movePending: true });

    emit('onState', {
      matchId: 'match-win',
      state: {
        you: 0,
        yourHand: null,
        handCounts: [0, 10, 6],
        table: { cards: [20, 25, 31], by: 0 },
        passed: [false, false, false],
        quit: [false, false, false],
        finishOrder: [0],
        turn: 1,
        starter: 0,
        require3s: false,
        moveCount: 9,
        steps: [
          { kind: 'play', by: 0, cards: [20, 25, 31] },
          { kind: 'finish', by: 0, place: 1 },
        ],
      },
      turn: 1,
      deadline: Date.now() + 30_000,
      lastBy: 0,
    } satisfies StateData);
    await vi.advanceTimersByTimeAsync(3_000);

    expect(useThirteen.getState()).toMatchObject({ hand: [], handCounts: [0, 10, 6], finishOrder: [0], turn: 1, movePending: false, animating: false });
  });
});

describe('Thirteen room after a match', () => {
  const found = (matchId: string): MatchFoundData => ({
    matchId,
    gameId: 'thirteen',
    players,
    you: 0,
    state: serverState(0),
    turn: 0,
    deadline: Date.now() + 30_000,
    resumed: true,
  });
  const over = (matchId: string): MatchOverData<unknown> => ({
    matchId,
    winnerId: 'opp',
    reason: 'win',
    rankings: [
      { userId: 'opp', place: 1 },
      { userId: 'me', place: 2 },
    ],
  });

  it('sends a player the server dropped from the room back to the lobby', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'room', room: waitingRoom, user: me });
    emit('onMatchFound', found('match-r1'));
    emit('onMatchOver', over('match-r1'));
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState().room).toBeNull();
    useThirteen.getState().closeResult(true);
    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', room: null });
  });

  it('keeps the room for members the server confirms after the match', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'room', room: waitingRoom, user: me });
    emit('onMatchFound', found('match-r2'));
    emit('onMatchOver', over('match-r2'));
    emit('onRoomState', { ...waitingRoom, afterMatchId: 'match-r2' });
    await vi.advanceTimersByTimeAsync(700);

    useThirteen.getState().closeResult(true);
    expect(useThirteen.getState()).toMatchObject({ phase: 'room', room: { roomId: waitingRoom.roomId } });
  });

  it('tells the players when the owner closed the room during the match', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'room', room: waitingRoom, user: me });
    emit('onMatchFound', found('match-r3'));
    emit('onMatchOver', over('match-r3'));
    emit('onRoomClosed', { roomId: waitingRoom.roomId, reason: 'owner_left' });
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState()).toMatchObject({ phase: 'table', room: null });
    expect(useThirteen.getState().notice).not.toBeNull();
    expect(useThirteen.getState().result).not.toBeNull();
  });
});

describe('Thirteen connecting screen', () => {
  it('explains a failed player load instead of spinning forever', async () => {
    await connect();

    emit('onError', { code: 'USER_INFO_FAILED', message: 'failed to load user info' });

    expect(useThirteen.getState()).toMatchObject({
      phase: 'connecting',
      notice: 'Không tải được thông tin người chơi. Hãy thoát ra rồi mở lại trò chơi.',
      toast: null,
    });
  });
});

describe('Thirteen selection after an automatic move', () => {
  it('drops selected cards the server played for the player when the clock ran out', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-auto', players, you: 0, turn: 0, hand: [8, 12, 20], selected: [8, 20] });

    emit('onState', {
      matchId: 'match-auto',
      state: { ...serverState(1, [{ kind: 'play', by: 0, cards: [8] }]), yourHand: [12, 20], handCounts: [2, 1] },
      turn: 1,
      deadline: Date.now() + 30_000,
      lastBy: 0,
      autoMoved: true,
    } satisfies StateData);
    await vi.advanceTimersByTimeAsync(1_000);

    expect(useThirteen.getState()).toMatchObject({ hand: [12, 20], selected: [20] });
  });
});

describe('Thirteen table the server no longer has', () => {
  it('returns to the waiting room when the match ended while the player was away', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', matchId: 'match-gone', players, you: 0, turn: 1, room: waitingRoom, movePending: true });

    emit('onRoomState', waitingRoom);
    emit('onRoomSync', { roomId: waitingRoom.roomId });

    expect(useThirteen.getState()).toMatchObject({ phase: 'room', room: waitingRoom, matchId: '', movePending: false });
    expect(useThirteen.getState().notice).toBe('Bạn mất kết nối quá lâu nên đã rời ván đấu.');
  });

  it('returns to the lobby when the room is gone as well', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', matchId: 'match-gone', players, you: 0, turn: 1, room: waitingRoom });

    emit('onRoomSync', {});

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', room: null, matchId: '' });
  });

  it('keeps the table while the result of that match is on its way', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'table', matchId: 'match-done', players, you: 0, user: me, room: waitingRoom });

    emit('onMatchOver', { matchId: 'match-done', winnerId: 'me', reason: 'win', rankings: [{ userId: 'me', place: 1 }, { userId: 'opp', place: 2 }] });
    emit('onRoomSync', {});
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState()).toMatchObject({ phase: 'table', notice: null });
    expect(useThirteen.getState().result?.winnerId).toBe('me');
  });
});

describe('Thirteen online events during practice', () => {
  const practiceBots = [{ id: 'bot-1', vipType: '1', level: 'easy' as const }];

  it('stays at the practice table when kicked from the online room', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', practice: practiceBots, room: waitingRoom, matchId: 'practice-1' });

    emit('onRoomKicked', { roomId: waitingRoom.roomId, byUserId: 'owner' });

    expect(useThirteen.getState()).toMatchObject({ phase: 'table', practice: practiceBots, room: null, notice: null });
  });

  it('stays at the practice table when the online room closes', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', practice: practiceBots, room: waitingRoom, matchId: 'practice-1' });

    emit('onRoomClosed', { roomId: waitingRoom.roomId, reason: 'owner_left' });

    expect(useThirteen.getState()).toMatchObject({ phase: 'table', practice: practiceBots, room: null, notice: null });
  });

  it('keeps the connection error out of the practice table', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', practice: practiceBots, matchId: 'practice-1' });

    emit('onConnectionError', new Error('offline'));

    expect(useThirteen.getState().notice).toBeNull();
  });

  it('still reports the connection error outside practice', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby' });

    emit('onConnectionError', new Error('offline'));

    expect(useThirteen.getState().notice).toBe('Không thể kết nối máy chủ trò chơi. Hãy thử lại sau.');
  });

  it('only leaves the waiting room for a kick from that room', async () => {
    await connect();
    useThirteen.setState({ phase: 'room', room: waitingRoom });

    emit('onRoomKicked', { roomId: 'another-room', byUserId: 'owner' });
    expect(useThirteen.getState()).toMatchObject({ phase: 'room', room: waitingRoom, notice: null });

    emit('onRoomKicked', { roomId: waitingRoom.roomId, byUserId: 'owner' });
    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', room: null, notice: 'Bạn đã bị mời khỏi bàn' });
  });
});

describe('Thirteen history and leaderboard', () => {
  const callsOf = (method: string) => sessionCalls.filter(([key]) => key === method).map(([, args]) => args);
  const historyEntry = { id: 'm1', playedAt: 1, opponentId: 'opp', opponentName: 'opp', bet: 0, outcome: 'win', kenDelta: 0 } as const;
  const board = (period: LeaderboardData['period'], username: string): LeaderboardData => ({
    period,
    from: 1_000,
    to: 2_000,
    items: [{ rank: 1, userId: username, username, ken: 0, wins: 3, losses: 1 }],
  });

  it('loads the history when opened from the lobby', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby' });

    useThirteen.getState().openHistory();
    expect(callsOf('getHistory')).toHaveLength(1);
    expect(useThirteen.getState()).toMatchObject({ overlay: 'history', history: { loading: true, error: null } });

    emit('onHistory', { items: [historyEntry] } satisfies MatchHistoryData);
    expect(useThirteen.getState().history).toEqual({ items: [historyEntry], loading: false, error: null });
  });

  it('turns a silent server into a retryable error', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'lobby' });

    useThirteen.getState().openHistory();
    await vi.advanceTimersByTimeAsync(RECORD_REQUEST_TIMEOUT_MS);
    expect(useThirteen.getState().history).toMatchObject({ loading: false, error: 'Máy chủ chưa trả lời, hãy thử lại.' });

    useThirteen.getState().retryHistory();
    expect(callsOf('getHistory')).toHaveLength(2);
    expect(useThirteen.getState().history).toMatchObject({ loading: true, error: null });
  });

  it('shows the server error instead of an empty list', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby' });

    useThirteen.getState().openHistory();
    emit('onHistory', { items: [], error: 'Không thể tải lịch sử đấu' } satisfies MatchHistoryData);

    expect(useThirteen.getState().history).toEqual({ items: [], loading: false, error: 'Máy chủ đang bận, hãy thử lại sau ít phút.' });
  });

  it('keeps only the answer for the period on screen', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby' });

    useThirteen.getState().openLeaderboard();
    useThirteen.getState().setLeaderboardPeriod('month');
    expect(callsOf('getLeaderboard')).toEqual([['day'], ['month']]);

    emit('onLeaderboard', board('day', 'late-day'));
    expect(useThirteen.getState().leaderboard).toMatchObject({ period: 'month', loading: true, items: [] });

    emit('onLeaderboard', board('month', 'month-top'));
    expect(useThirteen.getState().leaderboard).toMatchObject({ period: 'month', from: 1_000, loading: false, error: null });
    expect(useThirteen.getState().leaderboard.items[0]?.username).toBe('month-top');
  });

  it('only opens from the lobby', async () => {
    await connect();
    useThirteen.setState({ phase: 'table' });

    useThirteen.getState().openHistory();
    useThirteen.getState().openLeaderboard();

    expect(useThirteen.getState().overlay).toBeNull();
    expect(sessionCalls).toHaveLength(0);
  });

  it('closes when the player is pulled into a room or a match', async () => {
    await connect();
    vi.useFakeTimers();
    useThirteen.setState({ phase: 'lobby' });
    useThirteen.getState().openHistory();

    emit('onRoomState', waitingRoom);
    expect(useThirteen.getState()).toMatchObject({ phase: 'room', overlay: null, history: { loading: false } });

    useThirteen.setState({ phase: 'lobby', room: null });
    useThirteen.getState().openLeaderboard();
    emit('onMatchFound', {
      matchId: 'match-r',
      gameId: 'thirteen',
      players,
      you: 0,
      state: serverState(0),
      turn: 0,
      deadline: Date.now() + 30_000,
      resumed: true,
    } satisfies MatchFoundData);
    expect(useThirteen.getState()).toMatchObject({ phase: 'table', overlay: null });

    await vi.advanceTimersByTimeAsync(RECORD_REQUEST_TIMEOUT_MS);
    expect(useThirteen.getState().leaderboard.error).toBeNull();
  });
});

describe('Thirteen spectating', () => {
  const watchedPlayers: PlayerInfo[] = [
    { id: 'p1', name: 'Một' },
    { id: 'p2', name: 'Hai' },
    { id: 'p3', name: 'Ba' },
  ];
  const playingRoom: RoomInfo = { id: 'room-w', owner: 'Một', bet: 0, locked: false, players: 3, maxPlayers: 3, status: 'playing', matchId: 'match-w' };
  const spectatorState = (turn: number, handCounts: number[], steps: unknown[] = []) => ({
    you: -1,
    yourHand: [],
    handCounts,
    passed: [false, false, false],
    quit: [false, false, false],
    finishOrder: [],
    turn,
    starter: 0,
    require3s: false,
    moveCount: steps.length,
    steps,
  });
  const joined = (matchId = 'match-w'): SpectateJoinedData => ({
    matchId,
    gameId: 'thirteen',
    players: watchedPlayers,
    state: spectatorState(1, [10, 12, 13]),
    turn: 1,
    deadline: Date.now() + 30_000,
    spectators: 1,
  });
  const calls = (name: string) => sessionCalls.filter(([key]) => key === name).map(([, args]) => args);

  const startWatching = async (): Promise<void> => {
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });
    useThirteen.getState().watchRoom(playingRoom);
    emit('onSpectateJoined', joined());
    await vi.waitFor(() => expect(useThirteen.getState().handCounts).toEqual([10, 12, 13]));
  };

  it('opens the watched table without a seat or a hand', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });

    useThirteen.getState().watchRoom(playingRoom);
    expect(calls('roomWatch')).toEqual([['room-w']]);
    expect(calls('spectateJoin')).toEqual([['match-w']]);
    expect(useThirteen.getState()).toMatchObject({ watchPendingId: 'match-w', watchingRoomId: 'room-w' });

    emit('onSpectateJoined', joined());
    await vi.waitFor(() => expect(useThirteen.getState().handCounts).toEqual([10, 12, 13]));
    expect(useThirteen.getState()).toMatchObject({
      phase: 'table',
      spectating: true,
      watchPendingId: '',
      matchId: 'match-w',
      you: -1,
      hand: [],
      turn: 1,
    });
  });

  it('does not watch private or waiting rooms', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });

    useThirteen.getState().watchRoom({ ...playingRoom, locked: true });
    useThirteen.getState().watchRoom({ ...playingRoom, status: 'waiting', matchId: undefined });

    expect(calls('spectateJoin')).toEqual([]);
  });

  it('ignores a spectate snapshot nobody asked for', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });

    emit('onSpectateJoined', joined('match-other'));
    await new Promise((resolve) => setTimeout(resolve, 0));

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', spectating: false });
    expect(calls('spectateLeave')).toEqual([['match-other']]);
  });

  it('gives the seat back when the snapshot arrives after the player started practising', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });
    useThirteen.getState().watchRoom(playingRoom);
    useThirteen.setState({ practice: [] });

    emit('onSpectateJoined', joined());

    expect(useThirteen.getState()).toMatchObject({ spectating: false, watchPendingId: '' });
    expect(calls('spectateLeave')).toEqual([['match-w']]);
  });

  it('leaves the stale table when rejoining is refused', async () => {
    await startWatching();

    emit('onError', { code: 'SPECTATE_FULL', message: 'spectator slots are full' });

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', spectating: false, notice: 'Bàn này đã đủ người xem' });
  });

  it('follows plays from every seat', async () => {
    await startWatching();
    vi.useFakeTimers();

    emit('onState', {
      matchId: 'match-w',
      state: { ...spectatorState(2, [10, 10, 13], [{ kind: 'play', by: 1, cards: [20, 21] }]), table: { cards: [20, 21], by: 1 } },
      turn: 2,
      deadline: Date.now() + 30_000,
      lastBy: 1,
    } satisfies StateData);
    await vi.advanceTimersByTimeAsync(1_000);

    expect(useThirteen.getState()).toMatchObject({ turn: 2, handCounts: [10, 10, 13], table: { cards: [20, 21], by: 1 } });
  });

  const watchedWaitingRoom = (memberCount = 3): RoomStateData => ({
    roomId: 'room-w',
    ownerId: 'p1',
    youId: '',
    bet: 0,
    locked: false,
    maxPlayers: 4,
    watcher: true,
    afterMatchId: 'match-w',
    members: watchedPlayers.slice(0, memberCount).map((p, i) => ({ id: p.id, name: p.name, owner: i === 0, ready: false })),
  });

  let watchedMatches = 0;
  const watchUntilWaitingRoom = async (): Promise<string> => {
    watchedMatches += 1;
    const matchId = `match-room-${watchedMatches}`;
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });
    useThirteen.getState().watchRoom({ ...playingRoom, matchId });
    emit('onSpectateJoined', joined(matchId));
    await vi.waitFor(() => expect(useThirteen.getState()).toMatchObject({ spectating: true, matchId }));
    vi.useFakeTimers();
    vi.stubGlobal('window', globalThis);
    emit('onMatchOver', { matchId, winnerId: 'p2', reason: 'win', rankings: [{ userId: 'p2', place: 1 }], kenDelta: 0 });
    emit('onSpectateLeft', { matchId, reason: 'match_over' });
    emit('onRoomUpsert', { room: { ...playingRoom, status: 'waiting', matchId: undefined } });
    emit('onRoomState', { ...watchedWaitingRoom(), afterMatchId: matchId });
    await vi.advanceTimersByTimeAsync(700);
    return matchId;
  };

  it('moves to the waiting room when the watched match ends', async () => {
    const matchId = await watchUntilWaitingRoom();

    expect(useThirteen.getState()).toMatchObject({
      phase: 'room',
      spectating: false,
      matchId: '',
      result: null,
      room: null,
      watchingRoomId: 'room-w',
      watchedRoom: { roomId: 'room-w', watcher: true },
    });
    expect(calls('spectateLeave')).toEqual([[matchId]]);
  });

  it('watches the next match the room starts', async () => {
    const finished = await watchUntilWaitingRoom();
    sessionCalls.length = 0;

    emit('onRoomUpsert', { room: { ...playingRoom, matchId: finished } });
    expect(calls('spectateJoin')).toEqual([]);

    emit('onRoomUpsert', { room: { ...playingRoom, matchId: 'match-2' } });
    expect(calls('spectateJoin')).toEqual([['match-2']]);

    emit('onSpectateJoined', joined('match-2'));
    await vi.advanceTimersByTimeAsync(10);
    expect(useThirteen.getState()).toMatchObject({ phase: 'table', spectating: true, matchId: 'match-2', watchingRoomId: 'room-w' });
  });

  it('goes back to the lobby when the watched room breaks up', async () => {
    await watchUntilWaitingRoom();

    emit('onRoomClosed', { roomId: 'room-w', reason: 'owner_left' });

    expect(useThirteen.getState()).toMatchObject({
      phase: 'lobby',
      watchingRoomId: '',
      watchedRoom: null,
      notice: null,
      toast: 'Bàn bạn đang xem đã giải tán.',
    });
    expect(calls('roomUnwatch')).toEqual([[]]);
  });

  it('goes straight back to the lobby when the room is gone by the end of the match', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });
    useThirteen.getState().watchRoom({ ...playingRoom, matchId: 'match-gone' });
    emit('onSpectateJoined', joined('match-gone'));
    await vi.waitFor(() => expect(useThirteen.getState()).toMatchObject({ spectating: true, matchId: 'match-gone' }));
    vi.useFakeTimers();
    vi.stubGlobal('window', globalThis);

    emit('onRoomRemoved', { roomId: 'room-w' });
    expect(useThirteen.getState()).toMatchObject({ phase: 'table', spectating: true, watchingRoomId: '' });

    emit('onMatchOver', { matchId: 'match-gone', winnerId: 'p2', reason: 'win', rankings: [{ userId: 'p2', place: 1 }], kenDelta: 0 });
    await vi.advanceTimersByTimeAsync(700);

    expect(useThirteen.getState()).toMatchObject({
      phase: 'lobby',
      spectating: false,
      matchId: '',
      result: null,
      notice: null,
      toast: 'Ván đấu bạn đang xem đã kết thúc.',
    });
    expect(calls('spectateLeave')).toEqual([['match-gone']]);
  });

  it('takes a free seat in the watched room', async () => {
    await watchUntilWaitingRoom();

    useThirteen.getState().joinWatchedRoom();
    expect(calls('joinRoom')).toEqual([['room-w']]);

    emit('onRoomState', { ...watchedWaitingRoom(), watcher: undefined, youId: me.id, afterMatchId: undefined });

    expect(useThirteen.getState()).toMatchObject({ phase: 'room', watchingRoomId: '', watchedRoom: null, room: { roomId: 'room-w', youId: me.id } });
    expect(calls('roomUnwatch')).toEqual([[]]);
  });

  it('follows the room again after the connection comes back', async () => {
    await watchUntilWaitingRoom();
    sessionCalls.length = 0;

    emit('onConnectionChange', false);
    emit('onConnectionChange', true);

    expect(calls('roomWatch')).toEqual([['room-w']]);
    expect(calls('listRooms')).toEqual([[]]);
  });

  it('stops following the room when leaving the waiting room', async () => {
    await watchUntilWaitingRoom();

    useThirteen.getState().stopWatching();

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', watchingRoomId: '', watchedRoom: null });
    expect(calls('roomUnwatch')).toEqual([[]]);
  });

  it('keeps the viewers list of the table being watched', async () => {
    await connect();
    useThirteen.setState({ phase: 'lobby', user: me });
    useThirteen.getState().watchRoom(playingRoom);
    const viewers = [{ id: 'v1', name: 'Lan' }, { id: me.id, name: me.username }];

    emit('onSpectators', { matchId: 'match-w', spectators: viewers });
    emit('onSpectateJoined', joined());
    emit('onSpectators', { matchId: 'match-other', spectators: [] });

    await vi.waitFor(() => expect(useThirteen.getState().spectating).toBe(true));
    expect(useThirteen.getState().spectators).toEqual({ matchId: 'match-w', spectators: viewers });

    useThirteen.getState().stopWatching();
    expect(useThirteen.getState().spectators).toBeNull();
  });

  it('leaves without the forfeit prompt', async () => {
    await startWatching();

    useThirteen.getState().requestExit();

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', spectating: false, confirmExit: false });
    expect(calls('spectateLeave')).toEqual([['match-w']]);
    expect(calls('forfeit')).toEqual([]);
  });

  it('shows players who is watching their own table', async () => {
    await connect();
    useThirteen.setState({ phase: 'table', matchId: 'match-p', user: me });

    emit('onSpectators', { matchId: 'match-p', spectators: [{ id: 'v1', name: 'Lan' }] });

    expect(useThirteen.getState().spectators).toEqual({ matchId: 'match-p', spectators: [{ id: 'v1', name: 'Lan' }] });
  });

  it('rejoins the watched match after the connection comes back', async () => {
    await startWatching();
    sessionCalls.length = 0;

    emit('onConnectionChange', false);
    emit('onConnectionChange', true);

    expect(calls('spectateJoin')).toEqual([['match-w']]);
  });

  it('returns to the lobby when the watched match is already gone', async () => {
    await startWatching();

    emit('onError', { code: 'MATCH_NOT_FOUND', message: 'match not found' });

    expect(useThirteen.getState()).toMatchObject({ phase: 'lobby', spectating: false, notice: 'Ván đấu bạn đang xem đã kết thúc.' });
  });

  it('never sends chat or reactions as a spectator', async () => {
    await startWatching();

    useThirteen.getState().sendChat('xin chào');
    useThirteen.getState().sendReaction('LIKE');

    expect(calls('sendChat')).toEqual([]);
    expect(calls('sendReaction')).toEqual([]);
  });
});
