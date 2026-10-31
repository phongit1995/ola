import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';
import type { ErrorData, MatchFoundData, MatchOverData, StateData } from '../src/sdk';
import { createPracticeSession } from './practice';
import type { ServerMove, ServerState } from './logic/server-types';
import type { BotSetupItem } from './helpers/practice';

const USER = { id: 'u-me', username: 'test1', vipType: '3' };
const BOTS: BotSetupItem[] = [
  { id: 'a', vipType: '1', level: 'easy' },
  { id: 'b', vipType: '2', level: 'normal' },
  { id: 'c', vipType: '3', level: 'hard' },
];

function seeded(seed: number): () => number {
  let a = seed >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function setup(seed: number, bots = BOTS) {
  const session = createPracticeSession({ user: USER, bots, random: seeded(seed) });
  const found: MatchFoundData<ServerState>[] = [];
  const states: StateData<ServerState, ServerMove>[] = [];
  const overs: MatchOverData<ServerState>[] = [];
  const errors: ErrorData[] = [];
  session.onMatchFound((data) => found.push(data));
  session.onState((data) => states.push(data));
  session.onMatchOver((data) => overs.push(data));
  session.onError((data) => errors.push(data));
  return { session, found, states, overs, errors };
}

function currentTurn(t: ReturnType<typeof setup>): number {
  return t.states.at(-1)?.turn ?? t.found.at(-1)!.turn;
}

describe('practice session', () => {
  beforeEach(() => vi.useFakeTimers());
  afterEach(() => vi.useRealTimers());

  it('deals a hidden-hand match with the user in seat 0 and the bots after', () => {
    const t = setup(1);
    t.session.joinQueue();
    const match = t.found[0];
    expect(match.you).toBe(0);
    expect(match.players.map((p) => p.id)).toEqual(['u-me', 'bot-1', 'bot-2', 'bot-3']);
    expect(match.players.map((p) => p.name)).toEqual(['test1', 'Máy 1', 'Máy 2', 'Máy 3']);
    expect(match.state.yourHand).toHaveLength(13);
    expect(match.state.handCounts).toEqual([13, 13, 13, 13]);
    expect(match.state.steps?.[0]).toEqual({ kind: 'deal', by: -1 });
  });

  it('lets bots play on their own and rejects moves out of turn or illegal ones', () => {
    let seed = 1;
    let t = setup(seed);
    t.session.joinQueue();
    while (t.found[0].turn === 0 || t.found[0].state.instantWin) {
      seed += 1;
      t = setup(seed);
      t.session.joinQueue();
    }
    t.session.sendMove(t.found[0].matchId, { type: 'pass' });
    expect(t.errors.at(-1)?.code).toBe('NOT_YOUR_TURN');
    while (currentTurn(t) !== 0 && t.overs.length === 0) vi.advanceTimersByTime(500);
    expect(t.states.some((state) => state.lastBy !== 0)).toBe(true);
    if (t.overs.length > 0) return;
    const hand = t.states.at(-1)!.state.yourHand;
    t.session.sendMove(t.found[0].matchId, { type: 'play', cards: [hand[0], hand[hand.length - 1]] });
    expect(t.errors.at(-1)?.code).toBe('INVALID_MOVE');
  });

  it('auto moves for the user when the 30 second clock runs out and plays every game to the end', () => {
    for (const seed of [3, 4, 5]) {
      const t = setup(seed, BOTS.slice(0, seed - 2));
      t.session.joinQueue();
      for (let i = 0; i < 2000 && t.overs.length === 0; i += 1) vi.advanceTimersByTime(1000);
      expect(t.overs).toHaveLength(1);
      const over = t.overs[0];
      const players = seed - 1;
      expect(over.rankings).toHaveLength(players);
      expect(new Set(over.rankings!.map((entry) => entry.userId)).size).toBe(players);
      expect(over.rankings!.map((entry) => entry.place)).toEqual(Array.from({ length: players }, (_, i) => i + 1));
      expect(over.winnerId).toBe(over.rankings![0].userId);
      if (!over.state.instantWin) expect(t.states.some((state) => state.lastBy === 0 && state.autoMoved)).toBe(true);
    }
  });

  it('starts a fresh deal on replay and stops every timer on forfeit', () => {
    const t = setup(8);
    t.session.joinQueue();
    t.session.joinQueue();
    expect(t.found).toHaveLength(2);
    expect(t.found[1].matchId).not.toBe(t.found[0].matchId);
    t.session.forfeit(t.found[1].matchId);
    const before = t.states.length;
    vi.advanceTimersByTime(120_000);
    expect(t.states).toHaveLength(before);
    expect(t.overs).toHaveLength(0);
  });

  it('echoes the user chat and lets a bot answer', () => {
    const t = setup(9);
    const chats: string[] = [];
    t.session.onChat((data) => chats.push(`${data.userId}:${data.text}`));
    t.session.joinQueue();
    t.session.sendChat(t.found[0].matchId, 'chào cả nhà');
    vi.advanceTimersByTime(2000);
    expect(chats).toContain('u-me:chào cả nhà');
    expect(chats.some((line) => line.startsWith('bot-'))).toBe(true);
  });
});
