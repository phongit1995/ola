import type { InstantWinKind, StepKind } from './constants.gen';

export interface ServerPlay {
  cards: number[];
  by: number;
}

export interface ServerStep {
  kind: StepKind;
  by: number;
  cards?: number[];
  chop?: boolean;
  place?: number;
  win?: InstantWinKind | string;
}

export interface ServerState {
  you: number;
  yourHand: number[];
  handCounts: number[];
  table?: ServerPlay | null;
  passed: boolean[];
  quit: boolean[];
  finishOrder: number[];
  turn: number;
  starter: number;
  require3s: boolean;
  instantWin?: InstantWinKind | string;
  moveCount: number;
  steps?: ServerStep[];
}

export interface FinalState {
  hands: number[][];
  table?: ServerPlay | null;
  passed: boolean[];
  quit: boolean[];
  finishOrder: number[];
  quitOrder?: number[];
  turn: number;
  starter: number;
  require3s: boolean;
  instantWin?: string;
  moveCount: number;
}

export type ServerMove = { type: 'play'; cards: number[] } | { type: 'pass' };

export function decodeServerState(raw: unknown): ServerState {
  const state = raw as Partial<ServerState> | null | undefined;
  if (!state || !Array.isArray(state.yourHand) || !Array.isArray(state.handCounts)) {
    throw new RangeError('invalid tien len state payload');
  }
  return {
    you: numberOr(state.you, 0),
    yourHand: state.yourHand.filter((card) => Number.isInteger(card)),
    handCounts: state.handCounts.map((count) => numberOr(count, 0)),
    table: state.table && Array.isArray(state.table.cards) ? { cards: state.table.cards, by: numberOr(state.table.by, 0) } : null,
    passed: Array.isArray(state.passed) ? state.passed.map(Boolean) : [],
    quit: Array.isArray(state.quit) ? state.quit.map(Boolean) : [],
    finishOrder: Array.isArray(state.finishOrder) ? state.finishOrder.filter((i) => Number.isInteger(i)) : [],
    turn: numberOr(state.turn, 0),
    starter: numberOr(state.starter, 0),
    require3s: Boolean(state.require3s),
    instantWin: state.instantWin,
    moveCount: numberOr(state.moveCount, 0),
    steps: Array.isArray(state.steps) ? (state.steps as ServerStep[]) : [],
  };
}

function numberOr(value: unknown, fallback: number): number {
  return typeof value === 'number' && Number.isFinite(value) ? value : fallback;
}
