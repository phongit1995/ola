import { describe, expect, it } from 'vitest';
import parity from '../../../server/internal/game/games/thirteen/testdata/parity.json';
import { detectCombo } from './combos';
import { legalPlays } from './hints';
import {
  applyMove,
  dealFromDeck,
  instantWinKind,
  isOver,
  MoveError,
  newDeal,
  rankings,
  skipTurn,
  turnStartDelayMs,
  viewFor,
  winnerSeat,
  type EngineState,
} from './engine';

const card = (rank: number, suit: number): number => rank * 4 + suit;

function fixedState(hands: number[][], starter: number, require3s = false): EngineState {
  return {
    hands: hands.map((hand) => [...hand]),
    table: null,
    passed: hands.map(() => false),
    quit: hands.map(() => false),
    finishOrder: [],
    turn: starter,
    starter,
    require3s,
    moveCount: 0,
    steps: [],
  };
}

const play = (state: EngineState, seat: number, ...cards: number[]) => applyMove(state, seat, { type: 'play', cards });
const pass = (state: EngineState, seat: number) => applyMove(state, seat, { type: 'pass' });

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

describe('engine parity with the server', () => {
  for (const test of parity.instantWins) {
    it(`instant win ${test.want || 'none'}`, () => {
      expect(instantWinKind(test.hand) ?? '').toBe(test.want);
    });
  }

  for (const deal of parity.deals) {
    it(`deal seed=${deal.seed} players=${deal.players} picks the same starter`, () => {
      const state = dealFromDeck(deal.hands.flat(), deal.players);
      expect(state.hands).toEqual(deal.hands.map((hand) => [...hand].sort((a, b) => a - b)));
      expect(state.starter).toBe(deal.starter);
      expect(state.turn).toBe(deal.starter);
    });
  }

  for (const deal of parity.ledDeals) {
    it(`led deal seed=${deal.seed} players=${deal.players} leader=${deal.leader} opens with the leader`, () => {
      const state = dealFromDeck(deal.hands.flat(), deal.players, deal.leader);
      expect(state.starter).toBe(deal.starter);
      expect(state.turn).toBe(deal.starter);
      expect(state.require3s).toBe(deal.require3s);
      expect(state.ledByWinner).toBe(true);
      expect(state.finishOrder).toEqual(deal.finishOrder);
    });
  }
});

describe('engine rules', () => {
  it('lets the previous winner open with any card while someone else holds the three of spades', () => {
    const deal = parity.deals.find((entry) => entry.players === 4)!;
    const leader = (deal.hands.findIndex((hand) => hand.includes(card(0, 0))) + 1) % 4;
    const state = dealFromDeck(deal.hands.flat(), 4, leader);
    expect(state).toMatchObject({ starter: leader, turn: leader, require3s: false, ledByWinner: true });
    expect(() => play(state, leader, state.hands[leader].at(-1)!)).not.toThrow();
    expect(viewFor(state, 0).ledByWinner).toBe(true);
  });

  it('falls back to the three of spades when the previous winner is not seated', () => {
    const deal = parity.deals.find((entry) => entry.players === 4)!;
    for (const leader of [-1, 4, 1.5]) {
      const state = dealFromDeck(deal.hands.flat(), 4, leader);
      expect(state).toMatchObject({ starter: deal.starter, require3s: true });
      expect(state.ledByWinner).toBeUndefined();
    }
  });

  it('checks instant wins starting from the previous winner', () => {
    const hands = [
      [0, 8, 10, 16, 18, 23, 24, 26, 31, 32, 34, 39, 40],
      [3, 6, 7, 14, 15, 22, 30, 38, 46, 48, 49, 50, 51],
      [1, 9, 11, 17, 19, 25, 27, 33, 35, 41, 42, 43, 47],
      [2, 4, 5, 12, 13, 20, 21, 28, 29, 36, 37, 44, 45],
    ];
    expect(dealFromDeck(hands.flat(), 4)).toMatchObject({ instantWin: 'fourTwos', finishOrder: [1, 2, 3, 0] });
    expect(dealFromDeck(hands.flat(), 4, 2)).toMatchObject({ instantWin: 'sixPairs', finishOrder: [3, 0, 1, 2] });
  });

  it('requires the three of spades on the first play and forbids the leader to pass', () => {
    const state = fixedState([[0, 10, 20], [5, 15, 25], [6, 16, 26]], 0, true);
    expect(() => play(state, 0, 10)).toThrow(MoveError);
    expect(() => pass(state, 0)).toThrow(MoveError);
    play(state, 0, 0);
    expect(state.require3s).toBe(false);
    expect(state.turn).toBe(1);
  });

  it('clears the trick when everyone passes and lets the trick winner lead', () => {
    const state = fixedState([[4, 10, 20], [5, 15, 25], [6, 16, 26], [7, 17, 27]], 0);
    play(state, 0, 4);
    play(state, 1, 5);
    pass(state, 2);
    pass(state, 3);
    pass(state, 0);
    expect(state.table).toBeNull();
    expect(state.turn).toBe(1);
    expect(state.passed.every((p) => !p)).toBe(true);
    expect(state.steps.at(-1)).toEqual({ kind: 'clear', by: 1 });
  });

  it('ranks finishers and ends when one player is left', () => {
    const state = fixedState([[4], [5, 15], [6, 16]], 0);
    play(state, 0, 4);
    expect(state.finishOrder).toEqual([0]);
    expect(isOver(state)).toBe(false);
    play(state, 1, 5);
    pass(state, 2);
    play(state, 1, 15);
    expect(isOver(state)).toBe(true);
    expect(winnerSeat(state)).toBe(0);
    expect(rankings(state)).toEqual([0, 1, 2]);
  });

  it('lets a finisher trick be beaten and hands the lead to the next seat when all pass', () => {
    const beaten = fixedState([[card(11, 0)], [card(11, 3), 15], [6, 16]], 0);
    play(beaten, 0, card(11, 0));
    play(beaten, 1, card(11, 3));
    pass(beaten, 2);
    expect(beaten.table).toBeNull();
    expect(beaten.turn).toBe(1);

    const cleared = fixedState([[card(11, 0)], [5, 15], [6, 16]], 0);
    play(cleared, 0, card(11, 0));
    pass(cleared, 1);
    pass(cleared, 2);
    expect(cleared.table).toBeNull();
    expect(cleared.turn).toBe(1);
  });

  it('flags chops', () => {
    const state = fixedState([[card(12, 3), 1], [card(4, 0), card(4, 1), card(4, 2), card(4, 3), 30]], 0);
    play(state, 0, card(12, 3));
    play(state, 1, card(4, 0), card(4, 1), card(4, 2), card(4, 3));
    expect(state.steps.find((step) => step.kind === 'play' && step.by === 1)?.chop).toBe(true);
  });

  it('auto plays the lowest card for a timed out leader and passes for a timed out follower', () => {
    const state = fixedState([[4, 10], [5, 15]], 0);
    skipTurn(state, 0);
    expect(state.table).toEqual({ cards: [4], by: 0 });
    skipTurn(state, 1);
    expect(state.table).toBeNull();
    expect(state.turn).toBe(0);
  });

  it('auto plays the three of spades when the opening leader times out', () => {
    const state = fixedState([[0, 3], [5, 15]], 0, true);
    skipTurn(state, 0);
    expect(state.table).toEqual({ cards: [0], by: 0 });
  });

  it('hides other hands in the player view', () => {
    const state = newDeal(4, seeded(7));
    const view = viewFor(state, 2);
    expect(view.you).toBe(2);
    expect(view.yourHand).toEqual(state.hands[2]);
    expect(view.handCounts).toEqual([13, 13, 13, 13]);
    expect(JSON.stringify(view)).not.toContain('"hands"');
  });

  it('waits longer for chops, clears and finishes before the next turn', () => {
    expect(turnStartDelayMs([], -1)).toBe(4000);
    expect(turnStartDelayMs([{ kind: 'pass', by: 1 }], 1)).toBe(400);
    expect(turnStartDelayMs([{ kind: 'play', by: 1, cards: [4], chop: true }, { kind: 'clear', by: 1 }], 1)).toBe(1800);
    expect(turnStartDelayMs(Array.from({ length: 9 }, () => ({ kind: 'finish' as const, by: 0 })), 0)).toBe(3000);
  });

  it('always terminates with full rankings under random legal play', () => {
    for (let seed = 1; seed <= 60; seed += 1) {
      for (const players of [2, 3, 4]) {
        const random = seeded(seed * 977 + players);
        const state = newDeal(players, random);
        let moves = 0;
        while (!isOver(state)) {
          expect(moves).toBeLessThan(500);
          const seat = state.turn;
          const plays = legalPlays(state.hands[seat], state.table ? detectCombo(state.table.cards) : null, state.require3s);
          const passing = state.table != null && (plays.length === 0 || random() < 0.33);
          state.steps = [];
          if (passing) pass(state, seat);
          else play(state, seat, ...plays[Math.floor(random() * plays.length)].cards);
          moves += 1;
        }
        expect(rankings(state)).toHaveLength(players);
        expect(new Set(rankings(state)).size).toBe(players);
      }
    }
  });
});
