import { afterEach, describe, expect, it, vi } from 'vitest';
import type { MatchFoundData, MatchOverData, OpponentReconnectedData, PlayerInfo, RoomStateData, StateData, UserInfoData } from '../../src/sdk';

const sessionHandlers = vi.hoisted(() => new Map<string, Set<(data: unknown) => void>>());

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
        return () => undefined;
      },
    },
  );
  const bridge = new Proxy({}, { get: () => () => undefined });
  return { bridge, joinGame: vi.fn(() => Promise.resolve(session)) };
});

import { useThirteen } from './useThirteen';

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
