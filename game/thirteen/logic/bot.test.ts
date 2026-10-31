import { describe, expect, it } from 'vitest';
import { chooseBotMove, planHand, type BotLevel } from './bot';
import { applyMove, isOver, newDeal, rankings } from './engine';

const card = (rank: number, suit: number): number => rank * 4 + suit;

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

function playOut(levels: BotLevel[], seed: number): number[] {
  const random = seeded(seed);
  const state = newDeal(levels.length, random);
  const played: number[] = [];
  let moves = 0;
  while (!isOver(state)) {
    if (moves > 400) throw new Error(`game did not finish seed=${seed}`);
    const seat = state.turn;
    const move = chooseBotMove(
      {
        seat,
        hand: state.hands[seat],
        table: state.table,
        require3s: state.require3s,
        handCounts: state.hands.map((hand) => hand.length),
        played,
      },
      levels[seat],
      random,
    );
    state.steps = [];
    applyMove(state, seat, move);
    if (move.type === 'play') played.push(...move.cards);
    moves += 1;
  }
  return rankings(state);
}

function winRate(levels: BotLevel[], seat: number, games: number): number {
  let wins = 0;
  for (let seed = 1; seed <= games; seed += 1) {
    const rotation = seed % levels.length;
    const seated = levels.map((_, i) => levels[(i + rotation) % levels.length]);
    const target = (seat - rotation + levels.length) % levels.length;
    if (playOut(seated, seed * 7919)[0] === target) wins += 1;
  }
  return wins / games;
}

describe('planHand', () => {
  it('keeps twos and quads apart and groups the rest into few combos', () => {
    const hand = [card(0, 0), card(1, 1), card(2, 2), card(3, 0), card(5, 0), card(5, 1), card(9, 0), card(9, 1), card(9, 2), card(9, 3), card(12, 0), card(12, 3), card(11, 2)];
    const plan = planHand(hand);
    expect(plan).toContainEqual([card(12, 0), card(12, 3)]);
    expect(plan).toContainEqual([card(9, 0), card(9, 1), card(9, 2), card(9, 3)]);
    expect(plan).toContainEqual([card(0, 0), card(1, 1), card(2, 2), card(3, 0)]);
    expect(plan.flat().sort((a, b) => a - b)).toEqual([...hand].sort((a, b) => a - b));
  });

  it('prefers a double run over a straight that strands pairs', () => {
    const hand = [card(3, 0), card(3, 1), card(4, 0), card(4, 1), card(5, 0), card(5, 1)];
    expect(planHand(hand)).toEqual([hand]);
  });
});

describe('chooseBotMove', () => {
  it('always makes a legal move and finishes every game at every level', () => {
    for (const levels of [['easy', 'easy'], ['normal', 'hard', 'easy'], ['hard', 'hard', 'normal', 'easy']] as BotLevel[][]) {
      for (let seed = 1; seed <= 100; seed += 1) {
        expect(playOut(levels, seed)).toHaveLength(levels.length);
      }
    }
  });

  it('dumps the whole hand when one play finishes it', () => {
    const hand = [card(4, 0), card(5, 1), card(6, 2)];
    const move = chooseBotMove({ seat: 0, hand, table: null, require3s: false, handCounts: [3, 9], played: [] }, 'normal', () => 0);
    expect(move).toEqual({ type: 'play', cards: hand });
  });

  it('chops a two when it can', () => {
    const quad = [card(4, 0), card(4, 1), card(4, 2), card(4, 3)];
    const move = chooseBotMove(
      { seat: 1, hand: [...quad, card(7, 0), card(9, 1), card(10, 2)], table: { cards: [card(12, 3)], by: 0 }, require3s: false, handCounts: [8, 7], played: [card(12, 3)] },
      'hard',
      () => 0.5,
    );
    expect(move).toEqual({ type: 'play', cards: quad });
  });

  it('leads with a pair instead of a single when an opponent holds one card', () => {
    const move = chooseBotMove(
      { seat: 0, hand: [card(2, 0), card(6, 1), card(6, 2), card(10, 0)], table: null, require3s: false, handCounts: [4, 1], played: [] },
      'normal',
      () => 0.5,
    );
    expect(move).toEqual({ type: 'play', cards: [card(6, 1), card(6, 2)] });
  });

  it('gets stronger with each level', () => {
    const games = 240;
    expect(winRate(['normal', 'easy', 'easy', 'easy'], 0, games)).toBeGreaterThan(0.4);
    expect(winRate(['hard', 'easy', 'easy', 'easy'], 0, games)).toBeGreaterThan(0.45);
    expect(winRate(['hard', 'normal'], 0, games)).toBeGreaterThan(0.52);
  }, 30000);
});
