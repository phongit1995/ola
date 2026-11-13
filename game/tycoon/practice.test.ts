import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';
import type { ErrorData, MatchFoundData, MatchOverData, StateData } from '../src/sdk';
import type { BotSetupItem } from './helpers/bot';
import { botMove, botRng } from './logic/bot';
import type { BotReply, BotRequest } from './logic/bot.worker';
import type { Move, TycoonView } from './logic/types';
import { BOT_DELAY_MS, createPracticeSession, type BotWorkerLike } from './practice';

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

class FakeWorker implements BotWorkerLike {
  requests: BotRequest[] = [];
  terminated = false;
  onmessage: ((event: MessageEvent<BotReply>) => void) | null = null;
  onerror: ((event: ErrorEvent) => void) | null = null;

  postMessage(request: BotRequest): void {
    this.requests.push(structuredClone(request));
  }

  terminate(): void {
    this.terminated = true;
  }

  reply(request: BotRequest, move: Move | null = solve(request)): void {
    this.onmessage?.({ data: { id: request.id, move } } as MessageEvent<BotReply>);
  }

  fail(): void {
    this.onerror?.({} as ErrorEvent);
  }
}

function solve({ state, seat, level, seed, count }: BotRequest): Move | null {
  return botMove(state, seat, level, botRng(seed, seat, count));
}

const HARD_BOTS = [
  { id: 'a', vip: 1, level: 'hard' as const },
  { id: 'b', vip: 2, level: 'hard' as const },
  { id: 'c', vip: 3, level: 'hard' as const },
];

function setup(seed = 7, bots: readonly BotSetupItem[] = BOTS, createBotWorker?: () => BotWorkerLike | null) {
  const session = createPracticeSession({
    user: { id: 'me', username: 'me' },
    bots,
    speed: () => 1,
    random: seeded(seed),
    createBotWorker,
  });
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

  it('gives every new session its own match id', () => {
    const first = setup();
    first.session.start();
    const second = setup();
    second.session.start();
    expect(first.found[0].matchId).not.toBe(second.found[0].matchId);
    first.session.disconnect();
    second.session.disconnect();
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
      else vi.advanceTimersByTime(Math.max(...Object.values(BOT_DELAY_MS)));
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

  describe('hard bot worker', () => {
    function hardSetup() {
      const workers: FakeWorker[] = [];
      const ctx = setup(7, HARD_BOTS, () => {
        const worker = new FakeWorker();
        workers.push(worker);
        return worker;
      });
      ctx.session.start();
      return { ...ctx, workers };
    }

    function untilBotRequest(ctx: ReturnType<typeof hardSetup>): BotRequest {
      for (let i = 0; i < 50; i++) {
        const deadline = ctx.session.idle();
        const request = ctx.workers[0]?.requests.at(-1);
        if (request) return request;
        vi.advanceTimersByTime(deadline > 0 ? 30_000 : 1_000);
      }
      throw new Error('no bot request');
    }

    it('ignores a stale reply and applies the fresh one after the think delay', () => {
      const ctx = hardSetup();
      const stale = untilBotRequest(ctx);
      const worker = ctx.workers[0];
      expect(ctx.workers).toHaveLength(1);
      expect(stale.seat).not.toBe(0);

      ctx.session.idle();
      expect(worker.terminated).toBe(true);
      expect(ctx.workers).toHaveLength(2);
      const fresh = ctx.workers[1].requests.at(-1)!;
      expect(fresh.id).not.toBe(stale.id);
      expect(fresh.count).toBe(stale.count);

      const seen = ctx.states.length;
      worker.reply(stale, { type: 'END_TURN' });
      ctx.workers[1].onmessage?.({ data: { id: stale.id, move: { type: 'END_TURN' } } } as MessageEvent<BotReply>);
      vi.advanceTimersByTime(5_000);
      expect(ctx.states).toHaveLength(seen);

      ctx.session.idle();
      const current = ctx.workers.at(-1)!;
      const live = current.requests.at(-1)!;
      const move = solve(live);
      current.reply(live, move);
      expect(ctx.states).toHaveLength(seen);
      vi.advanceTimersByTime(Object.values(BOT_DELAY_MS).reduce((a, b) => Math.max(a, b)));
      expect(ctx.states).toHaveLength(seen + 1);
      expect(ctx.states.at(-1)!.lastBy).toBe(live.seat);
      if (move) expect(ctx.states.at(-1)!.lastMove).toEqual(move);
    });

    it('falls back to the sync bot when the worker never answers', () => {
      const ctx = hardSetup();
      const request = untilBotRequest(ctx);
      const seen = ctx.states.length;
      vi.advanceTimersByTime(Object.values(BOT_DELAY_MS).reduce((a, b) => Math.max(a, b)) + 8_000);
      expect(ctx.workers[0].terminated).toBe(true);
      expect(ctx.states.length).toBeGreaterThan(seen);
      expect(ctx.states[seen].lastBy).toBe(request.seat);
    });

    it('drops replies after disconnect and terminates the worker', () => {
      const ctx = hardSetup();
      const request = untilBotRequest(ctx);
      const worker = ctx.workers[0];
      const seen = ctx.states.length;
      ctx.session.disconnect();
      expect(worker.terminated).toBe(true);
      worker.reply(request);
      vi.advanceTimersByTime(5_000);
      expect(ctx.states).toHaveLength(seen);
    });

    it('falls back to the sync bot for the rest of the session when the worker errors', () => {
      const ctx = hardSetup();
      const request = untilBotRequest(ctx);
      const worker = ctx.workers[0];
      const move = solve(request);
      const seen = ctx.states.length;
      worker.fail();
      expect(worker.terminated).toBe(true);
      vi.advanceTimersByTime(1_000);
      expect(ctx.states).toHaveLength(seen + 1);
      expect(ctx.states.at(-1)!.lastBy).toBe(request.seat);
      if (move) expect(ctx.states.at(-1)!.lastMove).toEqual(move);
      for (let i = 0; i < 200 && ctx.overs.length === 0; i++) {
        const deadline = ctx.session.idle();
        vi.advanceTimersByTime(deadline > 0 ? 30_000 : 1_000);
      }
      expect(ctx.workers).toHaveLength(1);
      expect(worker.requests).toHaveLength(1);
      expect(ctx.states.length).toBeGreaterThan(seen + 1);
    });

    it('uses the sync path when no worker can be created', () => {
      const ctx = setup(11, HARD_BOTS, () => null);
      ctx.session.start();
      for (let i = 0; i < 60; i++) {
        const deadline = ctx.session.idle();
        vi.advanceTimersByTime(deadline > 0 ? 30_000 : 1_000);
      }
      expect(ctx.states.some((s) => s.lastBy !== 0)).toBe(true);
    });
  });
});
