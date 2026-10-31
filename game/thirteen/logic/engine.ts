import { rankOf } from './cards';
import { canBeat } from './beats';
import { detectCombo } from './combos';
import { DECK_SIZE, HAND_SIZE, RANK_TWO, THREE_OF_SPADES, type InstantWinKind } from './constants.gen';
import type { ServerMove, ServerPlay, ServerState, ServerStep } from './server-types';

const RANK_THREE = 0;
const TURN_START_DELAY_FIRST_MS = 4000;
const TURN_START_DELAY_BASE_MS = 400;
const TURN_START_DELAY_MAX_MS = 3000;

export interface EngineState {
  hands: number[][];
  table: ServerPlay | null;
  passed: boolean[];
  quit: boolean[];
  finishOrder: number[];
  turn: number;
  starter: number;
  require3s: boolean;
  instantWin?: InstantWinKind;
  moveCount: number;
  steps: ServerStep[];
}

export class MoveError extends Error {}

export function shuffledDeck(random: () => number): number[] {
  const deck = Array.from({ length: DECK_SIZE }, (_, i) => i);
  for (let i = deck.length - 1; i > 0; i -= 1) {
    const j = Math.floor(random() * (i + 1));
    [deck[i], deck[j]] = [deck[j], deck[i]];
  }
  return deck;
}

export function dealFromDeck(deck: readonly number[], playerCount: number): EngineState {
  const hands = Array.from({ length: playerCount }, (_, p) =>
    deck.slice(p * HAND_SIZE, (p + 1) * HAND_SIZE).sort((a, b) => a - b),
  );
  let starter = hands.findIndex((hand) => hand.includes(THREE_OF_SPADES));
  const require3s = starter >= 0;
  if (!require3s) {
    starter = 0;
    hands.forEach((hand, p) => {
      if (hand[0] < hands[starter][0]) starter = p;
    });
  }
  const state: EngineState = {
    hands,
    table: null,
    passed: hands.map(() => false),
    quit: hands.map(() => false),
    finishOrder: [],
    turn: starter,
    starter,
    require3s,
    moveCount: 0,
    steps: [{ kind: 'deal', by: -1 }],
  };
  applyInstantWins(state);
  return state;
}

export function newDeal(playerCount: number, random: () => number): EngineState {
  return dealFromDeck(shuffledDeck(random), playerCount);
}

export function instantWinKind(hand: readonly number[]): InstantWinKind | undefined {
  const counts = new Map<number, number>();
  for (const card of hand) counts.set(rankOf(card), (counts.get(rankOf(card)) ?? 0) + 1);
  const count = (rank: number) => counts.get(rank) ?? 0;
  if (count(RANK_TWO) === 4) return 'fourTwos';
  let dragon = true;
  for (let rank = RANK_THREE; rank < RANK_TWO; rank += 1) {
    if (count(rank) === 0) {
      dragon = false;
      break;
    }
  }
  if (dragon) return 'dragonStraight';
  let pairs = 0;
  for (const value of counts.values()) pairs += Math.floor(value / 2);
  if (pairs >= 6) return 'sixPairs';
  let run = 0;
  for (let rank = RANK_THREE; rank < RANK_TWO; rank += 1) {
    if (count(rank) >= 2) {
      run += 1;
      if (run >= 4) return 'fourPairRun';
    } else {
      run = 0;
    }
  }
  return undefined;
}

function applyInstantWins(state: EngineState): void {
  const n = state.hands.length;
  for (let i = 0; i < n; i += 1) {
    const p = (state.starter + i) % n;
    const win = instantWinKind(state.hands[p]);
    if (!win) continue;
    state.instantWin = win;
    state.finishOrder = Array.from({ length: n }, (_, j) => (p + j) % n);
    state.steps.push({ kind: 'instant', by: p, win });
    return;
  }
}

export function cloneState(state: EngineState): EngineState {
  return {
    ...state,
    hands: state.hands.map((hand) => [...hand]),
    table: state.table ? { cards: [...state.table.cards], by: state.table.by } : null,
    passed: [...state.passed],
    quit: [...state.quit],
    finishOrder: [...state.finishOrder],
    steps: [],
  };
}

const isActive = (state: EngineState, seat: number): boolean => seat >= 0 && seat < state.hands.length && !state.quit[seat];

const hasCards = (state: EngineState, seat: number): boolean => seat >= 0 && seat < state.hands.length && state.hands[seat].length > 0;

export function activeWithCards(state: EngineState): number[] {
  return state.hands.map((_, seat) => seat).filter((seat) => isActive(state, seat) && hasCards(state, seat));
}

function nextEligible(state: EngineState, from: number): number {
  const n = state.hands.length;
  for (let i = 1; i <= n; i += 1) {
    const seat = (from + i) % n;
    if (isActive(state, seat) && hasCards(state, seat) && !state.passed[seat]) return seat;
  }
  return -1;
}

function firstActiveFrom(state: EngineState, from: number): number {
  const n = state.hands.length;
  for (let i = 0; i < n; i += 1) {
    const seat = (from + i) % n;
    if (isActive(state, seat) && hasCards(state, seat)) return seat;
  }
  return -1;
}

function clearTrick(state: EngineState): void {
  state.table = null;
  state.passed = state.passed.map(() => false);
}

function advanceAfter(state: EngineState, actor: number): void {
  const next = nextEligible(state, actor);
  if (!state.table) {
    if (next >= 0) state.turn = next;
    return;
  }
  if (next < 0) {
    const by = state.table.by;
    clearTrick(state);
    state.steps.push({ kind: 'clear', by });
    const leader = firstActiveFrom(state, (by + 1) % state.hands.length);
    if (leader >= 0) state.turn = leader;
    return;
  }
  if (next === state.table.by) {
    clearTrick(state);
    state.steps.push({ kind: 'clear', by: next });
    state.turn = next;
    return;
  }
  state.turn = next;
}

export function checkMove(state: EngineState, seat: number, move: ServerMove): void {
  if (seat < 0 || seat >= state.hands.length) throw new MoveError('invalid player');
  if (state.instantWin) throw new MoveError('the round already ended');
  if (!isActive(state, seat) || !hasCards(state, seat)) throw new MoveError('player can no longer act');
  if (move.type === 'pass') {
    if (!state.table) throw new MoveError('the leader must play a combination');
    return;
  }
  if (move.cards.length === 0 || move.cards.length > HAND_SIZE) throw new MoveError('a play needs between 1 and 13 cards');
  if (new Set(move.cards).size !== move.cards.length) throw new MoveError('duplicate card in play');
  if (move.cards.some((card) => !state.hands[seat].includes(card))) throw new MoveError('card is not in hand');
  const combo = detectCombo(move.cards);
  if (!combo) throw new MoveError('invalid combination');
  if (state.require3s && !move.cards.includes(THREE_OF_SPADES)) {
    throw new MoveError('the first play must include the three of spades');
  }
  if (state.table) {
    const prev = detectCombo(state.table.cards);
    if (!prev || !canBeat(combo, prev)) throw new MoveError('this combination does not beat the table');
  }
}

export function applyMove(state: EngineState, seat: number, move: ServerMove): void {
  checkMove(state, seat, move);
  if (move.type === 'pass') {
    state.passed[seat] = true;
    state.steps.push({ kind: 'pass', by: seat });
    state.moveCount += 1;
    advanceAfter(state, seat);
    return;
  }
  const combo = detectCombo(move.cards)!;
  const prev = state.table ? detectCombo(state.table.cards) : null;
  const chop = prev != null && (combo.kind !== prev.kind || combo.length !== prev.length);
  const played = [...move.cards].sort((a, b) => a - b);
  state.hands[seat] = state.hands[seat].filter((card) => !played.includes(card));
  state.table = { cards: played, by: seat };
  state.require3s = false;
  state.steps.push({ kind: 'play', by: seat, cards: played, ...(chop ? { chop } : {}) });
  state.moveCount += 1;
  if (state.hands[seat].length === 0) {
    state.finishOrder.push(seat);
    state.steps.push({ kind: 'finish', by: seat, place: state.finishOrder.length });
  }
  const active = activeWithCards(state);
  if (active.length === 1) {
    state.finishOrder.push(active[0]);
    state.steps.push({ kind: 'finish', by: active[0], place: state.finishOrder.length });
    return;
  }
  advanceAfter(state, seat);
}

function tryApply(state: EngineState, seat: number, move: ServerMove): boolean {
  try {
    applyMove(state, seat, move);
    return true;
  } catch {
    return false;
  }
}

export function skipTurn(state: EngineState, seat: number): void {
  if (!isActive(state, seat) || !hasCards(state, seat)) return;
  if (!state.table) {
    const hand = state.hands[seat];
    const card = state.require3s && hand.includes(THREE_OF_SPADES) ? THREE_OF_SPADES : hand[0];
    if (tryApply(state, seat, { type: 'play', cards: [card] })) return;
  }
  if (tryApply(state, seat, { type: 'pass' })) return;
  state.passed[seat] = true;
  state.moveCount += 1;
  advanceAfter(state, seat);
}

export function isOver(state: EngineState): boolean {
  if (state.instantWin) return true;
  return activeWithCards(state).length <= 1;
}

export function winnerSeat(state: EngineState): number {
  if (state.finishOrder.length > 0) return state.finishOrder[0];
  const active = activeWithCards(state);
  return active.length === 1 ? active[0] : -1;
}

export function rankings(state: EngineState): number[] {
  const ranked: number[] = [];
  for (const seat of state.finishOrder) if (!ranked.includes(seat)) ranked.push(seat);
  state.hands.forEach((_, seat) => {
    if (!ranked.includes(seat) && isActive(state, seat)) ranked.push(seat);
  });
  state.hands.forEach((_, seat) => {
    if (!ranked.includes(seat)) ranked.push(seat);
  });
  return ranked;
}

export function viewFor(state: EngineState, seat: number): ServerState {
  return {
    you: seat,
    yourHand: [...state.hands[seat]],
    handCounts: state.hands.map((hand) => hand.length),
    table: state.table ? { cards: [...state.table.cards], by: state.table.by } : null,
    passed: [...state.passed],
    quit: [...state.quit],
    finishOrder: [...state.finishOrder],
    turn: state.turn,
    starter: state.starter,
    require3s: state.require3s,
    instantWin: state.instantWin,
    moveCount: state.moveCount,
    steps: state.steps.map((step) => ({ ...step, ...(step.cards ? { cards: [...step.cards] } : {}) })),
  };
}

export function turnStartDelayMs(steps: readonly ServerStep[], previousSeat: number): number {
  if (previousSeat < 0) return TURN_START_DELAY_FIRST_MS;
  let delay = TURN_START_DELAY_BASE_MS;
  for (const step of steps) {
    if (step.kind === 'play') delay += step.chop ? 900 : 500;
    else if (step.kind === 'clear') delay += 500;
    else if (step.kind === 'finish') delay += 600;
  }
  return Math.min(delay, TURN_START_DELAY_MAX_MS);
}
