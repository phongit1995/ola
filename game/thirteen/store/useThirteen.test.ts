import { afterEach, describe, expect, it, vi } from 'vitest';
import type {
  LeaderboardData,
  MatchFoundData,
  MatchHistoryData,
  MatchOverData,
  OpponentReconnectedData,
  PlayerInfo,
  RoomStateData,
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
