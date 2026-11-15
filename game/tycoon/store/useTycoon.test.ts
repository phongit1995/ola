import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';
import type { MatchFoundData, MatchOverData, PlayerInfo, SpectateJoinedData, StateData, UserInfoData } from '../../src/sdk';
import { ARCADE_ATTENTION_REASON } from '@ola/shared/constants';
import { applyMove, newGame } from '../logic/engine';
import type { GameState, Move, TycoonView } from '../logic/types';
import { viewFor } from '../logic/view';

const sessionHandlers = vi.hoisted(() => new Map<string, Set<(data: unknown) => void>>());
const sessionCalls = vi.hoisted(() => [] as Array<[string, unknown[]]>);
const bridgeCalls = vi.hoisted(() => [] as Array<[string, unknown[]]>);
const walks = vi.hoisted(() => [] as Array<{ seat: number; from: number; count: number; dir?: number; commit: () => void }>);

vi.mock('../../src/sdk', async () => {
  const actual = { ...(await import('../../src/sdk/protocol')), ...(await import('../../src/sdk/progression')) };
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
  const bridge = new Proxy({}, { get: (_target, key: string) => (...args: unknown[]) => void bridgeCalls.push([key, args]) });
  return { ...actual, bridge, joinGame: vi.fn(() => Promise.resolve(session)) };
});

vi.mock('../fx/boardFx', () =>
  Object.fromEntries(
    [
      ['walkPawn', (walk: (typeof walks)[number]) => {
        walks.push(walk);
        walk.commit();
        return Promise.resolve();
      }],
      ...['clearMovingPawns', 'rollDice', 'revealDiceTotal', 'policeWhistle', 'landOnTile', 'payMoney', 'stampDeed', 'tileCallout', 'buildHouse', 'sellHouse', 'celebrateFestival', 'travelWiggle', 'shakeDeck', 'flyCardIn', 'flyCardBack', 'jailDoorClose', 'jailDoorOpen', 'bankruptSeat', 'debtAlarm', 'flipRound', 'showTurnBanner', 'celebrateResult', 'winBanner'].map((name) => [name, () => Promise.resolve()]),
    ],
  ),
);
vi.mock('../fx/runtime', () => ({ setTempo: () => undefined, sleep: () => Promise.resolve() }));
vi.mock('../audio', () => ({ playSound: () => undefined, setSoundEnabled: () => undefined }));

import { useTycoon } from './useTycoon';

const emit = (event: string, data: unknown): void => {
  sessionHandlers.get(event)?.forEach((handler) => handler(data));
};

const calls = (name: string) => sessionCalls.filter(([key]) => key === name).map(([, args]) => args);

const players: PlayerInfo[] = [
  { id: 'me', name: 'test5' },
  { id: 'p2', name: 'test2' },
  { id: 'p3', name: 'test3' },
];

const originalState = useTycoon.getState();
let matchCount = 0;
let currentMatch = 'm0';

function startOn(seat: number): GameState {
  const state = newGame(7, players.length);
  state.turn = seat;
  return state;
}

function view(state: GameState, seat: number): TycoonView {
  return { ...viewFor(state, seat), startedAt: Date.now() };
}

async function connect(): Promise<void> {
  useTycoon.getState().init();
  await vi.waitFor(() => expect(sessionHandlers.get('onMatchOver')?.size).toBeGreaterThan(0));
  emit('onUserInfo', { id: 'me', username: 'test5', ken: 1000 } as UserInfoData);
}

async function startMatch(state: GameState, deadline = Date.now() + 30_000, bet?: number): Promise<void> {
  emit('onMatchFound', { matchId: currentMatch, gameId: 'tycoon', players, you: 0, state: view(state, 0), turn: state.turn, deadline, bet } satisfies MatchFoundData<TycoonView>);
  await vi.waitFor(() => expect(useTycoon.getState().replaying).toBe(false));
}

function sendState(state: GameState, lastBy: number, lastMove: Move, deadline = Date.now() + 30_000): void {
  emit('onState', { matchId: currentMatch, state: view(state, 0), turn: state.turn, deadline, lastBy, lastMove } satisfies StateData<TycoonView, Move>);
}

describe('useTycoon online session', () => {
  beforeEach(() => {
    sessionHandlers.clear();
    sessionCalls.length = 0;
    bridgeCalls.length = 0;
    walks.length = 0;
    matchCount += 1;
    currentMatch = `m${matchCount}`;
  });

  afterEach(() => {
    useTycoon.getState().dispose();
    useTycoon.setState(originalState, true);
  });

  it('becomes ready with the server profile', async () => {
    await connect();
    expect(useTycoon.getState().online).toBe('ready');
    expect(useTycoon.getState().profile?.username).toBe('test5');
  });

  it('enters the match and uses the server deadline on my turn', async () => {
    await connect();
    const deadline = Date.now() + 25_000;
    await startMatch(startOn(0), deadline);
    const s = useTycoon.getState();
    expect(s.boardMode).toBe('playing');
    expect(s.practice).toBe(false);
    expect(s.myTurn).toBe(true);
    expect(s.deadline).toBe(deadline);
  });

  it('only changes the board when the server sends a state', async () => {
    await connect();
    const first = startOn(0);
    await startMatch(first);
    useTycoon.getState().sendMove({ type: 'ROLL' });
    expect(calls('sendMove')).toEqual([[currentMatch, { type: 'ROLL' }]]);
    expect(useTycoon.getState().view?.moveCount).toBe(first.moveCount);
    expect(useTycoon.getState().movePending).toBe(true);

    const next = applyMove(first, 0, { type: 'ROLL' });
    sendState(next, 0, { type: 'ROLL' });
    await vi.waitFor(() => expect(useTycoon.getState().view?.moveCount).toBe(next.moveCount));
    expect(useTycoon.getState().movePending).toBe(false);
  });

  it('walks the pawn tile by tile for card moves and jail, never jumping', async () => {
    await connect();
    const first = startOn(1);
    await startMatch(first);
    const next = { ...first, moveCount: first.moveCount + 1, steps: [
      { kind: 'teleport', by: 1, from: 4, to: 31, passedGo: false },
      { kind: 'teleport', by: 2, from: 29, to: 8 },
      { kind: 'teleport', by: 2, from: 4, to: 8 },
      { kind: 'teleport', by: 1, from: 20, to: 8 },
    ] } as GameState;
    sendState(next, 1, { type: 'CARD_ACK' });
    await vi.waitFor(() => expect(walks).toHaveLength(4));
    expect(walks.map(({ seat, from, count, dir }) => ({ seat, from, count, dir }))).toEqual([
      { seat: 1, from: 4, count: 27, dir: 1 },
      { seat: 2, from: 29, count: 11, dir: 1 },
      { seat: 2, from: 4, count: 4, dir: 1 },
      { seat: 1, from: 20, count: 12, dir: -1 },
    ]);
  });

  it('sends batched moves one by one and stops on an error', async () => {
    await connect();
    await startMatch(startOn(0));
    useTycoon.getState().sendMoves([{ type: 'ROLL' }, { type: 'END_TURN' }]);
    expect(calls('sendMove')).toHaveLength(1);

    const state = startOn(0);
    state.moveCount += 1;
    sendState(state, 0, { type: 'ROLL' });
    await vi.waitFor(() => expect(calls('sendMove')).toHaveLength(2));
    expect(calls('sendMove')[1]).toEqual([currentMatch, { type: 'END_TURN' }]);

    useTycoon.getState().sendMoves([{ type: 'ROLL' }, { type: 'END_TURN' }]);
    emit('onError', { code: 'INVALID_MOVE', message: 'tycoon:wrong_phase' });
    expect(useTycoon.getState().movePending).toBe(false);
    expect(useTycoon.getState().toast).toBe('Chưa đến lúc làm việc này');
  });

  it('collects match chat and reactions with an unread dot', async () => {
    await connect();
    await startMatch(startOn(1));
    emit('onChat', { matchId: currentMatch, userId: 'p2', name: 'test2', text: 'chào', sentAt: 1 });
    emit('onChat', { matchId: 'other', userId: 'p3', name: 'test3', text: 'lạc', sentAt: 2 });
    expect(useTycoon.getState().matchChat.map((m) => m.text)).toEqual(['chào']);
    expect(useTycoon.getState().chatUnread).toBe(true);
    useTycoon.getState().openSheet({ kind: 'chat' });
    expect(useTycoon.getState().chatUnread).toBe(false);

    emit('onReaction', { matchId: currentMatch, userId: 'p3', type: 'HAHA', sentAt: 3 });
    expect(useTycoon.getState().reactionFx).toMatchObject({ seat: 2, type: 'HAHA' });

    useTycoon.getState().sendMatchChat('  ok  ');
    useTycoon.getState().sendReaction('LIKE');
    expect(calls('sendChat')).toEqual([[currentMatch, 'ok']]);
    expect(calls('sendReaction')).toEqual([[currentMatch, 'LIKE']]);
  });

  it('builds the result from server rankings', async () => {
    await connect();
    const state = startOn(1);
    await startMatch(state);
    const over = { ...state, finished: true, winner: 1, endReason: 'rounds' as const };
    emit('onMatchOver', {
      matchId: currentMatch,
      reason: 'win',
      state: view(over, 0),
      rankings: [
        { userId: 'p2', place: 1 },
        { userId: 'me', place: 2 },
        { userId: 'p3', place: 3 },
      ],
      expGains: [{ userId: 'me', exp: 35 }],
    } satisfies MatchOverData<TycoonView>);
    await vi.waitFor(() => expect(useTycoon.getState().result).not.toBeNull());
    const result = useTycoon.getState().result!;
    expect(result.rows.map((row) => row.seat)).toEqual([1, 0, 2]);
    expect(result.myPlace).toBe(2);
    expect(result.exp).toBe(35);
    expect(result.kenDelta).toBeUndefined();
    expect(result.rows.every((row) => row.kenDelta === undefined)).toBe(true);
  });

  it('shows the bet in the match and KEN for every row of a bet result', async () => {
    await connect();
    const state = startOn(1);
    await startMatch(state, Date.now() + 30_000, 1000);
    expect(useTycoon.getState().matchBet).toBe(1000);
    expect(useTycoon.getState().betFloat).toBeGreaterThan(0);
    const over = { ...state, finished: true, winner: 1, endReason: 'rounds' as const };
    emit('onMatchOver', {
      matchId: currentMatch,
      winnerId: 'p2',
      reason: 'win',
      state: view(over, 0),
      bet: 1000,
      payout: 2850,
      kenDelta: 1850,
      rankings: [
        { userId: 'p2', place: 1 },
        { userId: 'me', place: 2 },
        { userId: 'p3', place: 3 },
      ],
    } satisfies MatchOverData<TycoonView>);
    await vi.waitFor(() => expect(useTycoon.getState().result).not.toBeNull());
    const result = useTycoon.getState().result!;
    expect(result.kenDelta).toBe(-1000);
    expect(result.rows.map((row) => row.kenDelta)).toEqual([1850, -1000, -1000]);
  });

  it('asks the host for attention on chat from others only', async () => {
    await connect();
    await startMatch(startOn(1));
    const chatAttention = () => bridgeCalls.filter(([key, args]) => key === 'attention' && (args[0] as { reason: string }).reason === ARCADE_ATTENTION_REASON.NewChat);
    emit('onChat', { matchId: currentMatch, userId: 'me', name: 'test5', text: 'mình', sentAt: 1 });
    expect(chatAttention()).toHaveLength(0);
    emit('onChat', { matchId: currentMatch, userId: 'p2', name: 'test2', text: 'chào', sentAt: 2 });
    expect(chatAttention()).toHaveLength(1);
  });

  it('keeps the board and result when ROOM_SYNC follows a MATCH_OVER on reconnect', async () => {
    await connect();
    const state = startOn(1);
    await startMatch(state);
    const over = { ...state, finished: true, winner: 1, endReason: 'rounds' as const };
    emit('onMatchOver', { matchId: currentMatch, reason: 'win', state: view(over, 0), rankings: [{ userId: 'p2', place: 1 }, { userId: 'me', place: 2 }, { userId: 'p3', place: 3 }] } satisfies MatchOverData<TycoonView>);
    emit('onRoomSync', { roomId: '' });
    await vi.waitFor(() => expect(useTycoon.getState().result).not.toBeNull());
    expect(useTycoon.getState().notice).toBeNull();
    expect(useTycoon.getState().roomsOpen).toBe(false);
    expect(useTycoon.getState().boardMode).toBe('playing');
  });

  it('still drops a player who was away too long', async () => {
    await connect();
    await startMatch(startOn(1));
    emit('onRoomSync', { roomId: '' });
    expect(useTycoon.getState().boardMode).not.toBe('playing');
    expect(useTycoon.getState().notice?.title).toBe('Đã rời ván');
  });

  it('counts spectators for players too', async () => {
    await connect();
    await startMatch(startOn(1));
    emit('onSpectators', { matchId: currentMatch, spectators: [{ id: 'w1', name: 'w1' }, { id: 'w2', name: 'w2' }] });
    expect(useTycoon.getState().spectators).toBe(2);
    emit('onSpectators', { matchId: 'other', spectators: [] });
    expect(useTycoon.getState().spectators).toBe(2);
  });
});

describe('useTycoon practice', () => {
  afterEach(() => {
    useTycoon.getState().dispose();
    useTycoon.setState(originalState, true);
  });

  it('opens the board again for a second bot game in the same session', async () => {
    const bots = [{ id: 'a', vip: 1, level: 'normal' as const }];
    useTycoon.getState().startGame(bots);
    await vi.waitFor(() => expect(useTycoon.getState().boardMode).toBe('playing'));
    const first = useTycoon.getState().matchId;
    useTycoon.getState().startGame(bots);
    await vi.waitFor(() => expect(useTycoon.getState().boardMode).toBe('playing'));
    expect(useTycoon.getState().matchId).not.toBe(first);
  });
});

describe('useTycoon spectating', () => {
  beforeEach(() => {
    sessionHandlers.clear();
    sessionCalls.length = 0;
    matchCount += 1;
    currentMatch = `m${matchCount}`;
  });

  afterEach(() => {
    useTycoon.getState().dispose();
    useTycoon.setState(originalState, true);
  });

  it('watches a match read-only and leaves without forfeiting', async () => {
    await connect();
    expect(useTycoon.getState().watchMatch(currentMatch)).toBe(true);
    expect(calls('spectateJoin')).toEqual([[currentMatch]]);
    const state = startOn(0);
    emit('onSpectateJoined', { matchId: currentMatch, gameId: 'tycoon', players, state: view(state, -1), turn: 0, deadline: Date.now() + 30_000, spectators: 2 } satisfies SpectateJoinedData<TycoonView>);
    await vi.waitFor(() => expect(useTycoon.getState().replaying).toBe(false));
    const s = useTycoon.getState();
    expect(s.spectating).toBe(true);
    expect(s.you).toBe(-1);
    expect(s.myTurn).toBe(false);
    expect(s.spectators).toBe(2);

    emit('onConnectionChange', true);
    expect(calls('spectateJoin')).toEqual([[currentMatch], [currentMatch]]);
    emit('onSpectateJoined', { matchId: currentMatch, gameId: 'tycoon', players, state: view(state, -1), turn: 0, deadline: Date.now() + 30_000, spectators: 3 } satisfies SpectateJoinedData<TycoonView>);
    await vi.waitFor(() => expect(useTycoon.getState().spectators).toBe(3));
    expect(calls('spectateLeave')).toEqual([]);

    useTycoon.getState().forfeitMatch();
    expect(useTycoon.getState().notice).toBeNull();
    emit('onSpectateLeft', { matchId: currentMatch, reason: 'match_over' });
    expect(useTycoon.getState().spectating).toBe(true);

    useTycoon.getState().exitMatch();
    expect(calls('spectateLeave')).toEqual([[currentMatch]]);
    expect(calls('forfeit')).toEqual([]);
    expect(useTycoon.getState().boardMode).toBe('idle');
    expect(useTycoon.getState().roomsOpen).toBe(true);
  });

  it('marks the result as a spectator result', async () => {
    await connect();
    useTycoon.getState().watchMatch(currentMatch);
    const state = startOn(0);
    emit('onSpectateJoined', { matchId: currentMatch, gameId: 'tycoon', players, state: view(state, -1), turn: 0, deadline: 0, spectators: 1 } satisfies SpectateJoinedData<TycoonView>);
    await vi.waitFor(() => expect(useTycoon.getState().replaying).toBe(false));
    const over = { ...state, finished: true, winner: 2, endReason: 'rounds' as const };
    emit('onMatchOver', { matchId: currentMatch, reason: 'win', state: view(over, -1), rankings: [{ userId: 'p3', place: 1 }, { userId: 'me', place: 2 }, { userId: 'p2', place: 3 }] } satisfies MatchOverData<TycoonView>);
    await vi.waitFor(() => expect(useTycoon.getState().result).not.toBeNull());
    expect(useTycoon.getState().result).toMatchObject({ spectator: true, myPlace: 0 });
  });
});
