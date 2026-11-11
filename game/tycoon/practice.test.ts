import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';
import type { ErrorData, MatchFoundData, MatchOverData, StateData } from '../src/sdk';
import type { Move, TycoonView } from './logic/types';
import { createPracticeSession } from './practice';

const BOTS = [
  { id: 'a', vip: 1, level: 'normal' as const },
  { id: 'b', vip: 2, level: 'normal' as const },
  { id: 'c', vip: 3, level: 'normal' as const },
];

function seeded(seed: number): () => number {
  let x = seed;
  return () => {
    x = (x * 1103515245 + 12345) % 2 ** 31;
    return x / 2 ** 31;
  };
}

function setup(seed = 7) {
  const session = createPracticeSession({ user: { id: 'me', username: 'me' }, bots: BOTS, speed: () => 1, random: seeded(seed) });
  const found: MatchFoundData<TycoonView>[] = [];
  const states: StateData<TycoonView, Move>[] = [];
  const overs: MatchOverData<TycoonView>[] = [];
  const errors: ErrorData[] = [];
  session.onMatchFound((data) => found.push(data));
  session.onState((data) => states.push(data));
  session.onMatchOver((data) => overs.push(data));
  session.onError((data) => errors.push(data));
  return { session, found, states, overs, errors };
}

describe('practice session', () => {
  beforeEach(() => {
    vi.useFakeTimers();
  });
  afterEach(() => {
    vi.useRealTimers();
  });

  it('starts a match without leaking rng or decks', () => {
    const { session, found } = setup();
    session.start();
    expect(found).toHaveLength(1);
    expect(found[0].players).toHaveLength(4);
    expect(found[0].you).toBe(0);
    expect(found[0].state).not.toHaveProperty('rng');
    expect(found[0].state).not.toHaveProperty('chanceDeck');
    expect(found[0].state.chanceLeft).toBeGreaterThan(0);
  });

  it('reports rule errors with the server prefix', () => {
    const { session, found, errors, states } = setup();
    session.start();
    session.sendMove(found[0].matchId, { type: 'END_TURN' });
    expect(states).toHaveLength(0);
    expect(errors).toEqual([{ code: 'INVALID_MOVE', message: 'tycoon:wrong_phase' }]);
  });

  it('plays a whole match when the client keeps calling idle', () => {
    const { session, found, states, overs } = setup(11);
    session.start();
    let seen = 0;
    for (let i = 0; i < 20000 && overs.length === 0; i++) {
      const deadline = session.idle();
      if (deadline > 0) vi.advanceTimersByTime(30_000);
      else vi.advanceTimersByTime(1_000);
      expect(states.length).toBeGreaterThan(seen);
      seen = states.length;
    }
    expect(overs).toHaveLength(1);
    expect(overs[0].matchId).toBe(found[0].matchId);
    expect(overs[0].rankings).toHaveLength(4);
    expect(overs[0].state.finished).toBe(true);
    expect(states.some((s) => s.autoMoved)).toBe(true);
  });

  it('forfeit ends the match with the human last', () => {
    const { session, found, overs } = setup();
    session.start();
    session.forfeit(found[0].matchId);
    expect(overs).toHaveLength(1);
    expect(overs[0].reason).toBe('forfeit');
    expect(overs[0].rankings?.at(-1)?.userId).toBe('me');
  });
});
