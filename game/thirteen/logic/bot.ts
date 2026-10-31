import { rankOf } from './cards';
import { isChop } from './beats';
import { detectCombo, type Combo } from './combos';
import { DECK_SIZE, RANK_TWO } from './constants.gen';
import { hintPlays, legalPlays, type CandidatePlay } from './hints';
import type { ServerMove, ServerPlay } from './server-types';

export type BotLevel = 'easy' | 'normal' | 'hard';

export interface BotView {
  seat: number;
  hand: readonly number[];
  table: ServerPlay | null;
  require3s: boolean;
  handCounts: readonly number[];
  played: readonly number[];
}

const PASS: ServerMove = { type: 'pass' };
const EASY_PASS_CHANCE = 0.25;
const EASY_CHEAPEST_CHANCE = 0.6;
const EASY_LEAD_CHOICES = 3;
const NORMAL_HOLD_CHANCE = 0.6;
const NORMAL_SLIP_CHANCE = 0.3;
const NORMAL_SLIP_CHOICES = 3;

const play = (cards: readonly number[]): ServerMove => ({ type: 'play', cards: [...cards].sort((a, b) => a - b) });

function byRank(cards: readonly number[]): Map<number, number[]> {
  const groups = new Map<number, number[]>();
  for (const card of [...cards].sort((a, b) => a - b)) {
    const group = groups.get(rankOf(card));
    if (group) group.push(card);
    else groups.set(rankOf(card), [card]);
  }
  return groups;
}

function takeRuns(cards: readonly number[], width: number, minLength: number): { runs: number[][]; rest: number[] } {
  let rest = [...cards];
  const runs: number[][] = [];
  for (;;) {
    const groups = byRank(rest);
    let best: number[] = [];
    for (let start = 0; start < RANK_TWO; start += 1) {
      const run: number[] = [];
      for (let rank = start; rank < RANK_TWO && (groups.get(rank)?.length ?? 0) >= width; rank += 1) {
        run.push(...groups.get(rank)!.slice(0, width));
      }
      if (run.length > best.length) best = run;
    }
    if (best.length < minLength * width) return { runs, rest };
    runs.push(best);
    rest = rest.filter((card) => !best.includes(card));
  }
}

function sets(cards: readonly number[]): number[][] {
  return [...byRank(cards).values()];
}

function planScore(plan: readonly number[][]): number {
  const lowSingles = plan.filter((combo) => combo.length === 1 && rankOf(combo[0]) < 8).length;
  return plan.length * 10 + lowSingles;
}

export function planHand(hand: readonly number[]): number[][] {
  const twos = hand.filter((card) => rankOf(card) === RANK_TWO);
  const quads = sets(hand.filter((card) => rankOf(card) !== RANK_TWO)).filter((group) => group.length === 4);
  const fixed = [...(twos.length > 0 ? [twos] : []), ...quads];
  const rest = hand.filter((card) => rankOf(card) !== RANK_TWO && !quads.some((quad) => quad.includes(card)));

  const pairRuns = takeRuns(rest, 2, 3);
  const afterPairRuns = takeRuns(pairRuns.rest, 1, 3);
  const straightsFirst = takeRuns(rest, 1, 3);
  const setsFirst = sets(rest);
  const leftoverSingles = setsFirst.filter((group) => group.length === 1).flat();
  const singleRuns = takeRuns(leftoverSingles, 1, 3);

  const options = [
    [...pairRuns.runs, ...afterPairRuns.runs, ...sets(afterPairRuns.rest)],
    [...straightsFirst.runs, ...sets(straightsFirst.rest)],
    [...setsFirst.filter((group) => group.length > 1), ...singleRuns.runs, ...sets(singleRuns.rest)],
  ];
  const best = options.reduce((a, b) => (planScore(b) < planScore(a) ? b : a));
  return [...fixed, ...best];
}

const without = (hand: readonly number[], cards: readonly number[]): number[] => hand.filter((card) => !cards.includes(card));

const hasTwo = (cards: readonly number[]): boolean => cards.some((card) => rankOf(card) === RANK_TWO);

function isStrong(candidate: CandidatePlay): boolean {
  return hasTwo(candidate.cards) || candidate.combo.kind === 'quad' || candidate.combo.kind === 'doubleRun';
}

function unseenCards(view: BotView): number[] {
  const known = new Set([...view.hand, ...view.played]);
  return Array.from({ length: DECK_SIZE }, (_, card) => card).filter((card) => !known.has(card));
}

function bossChecker(view: BotView): (cards: readonly number[]) => boolean {
  const unseen = unseenCards(view);
  const maxOpponent = Math.max(0, ...view.handCounts.filter((_, seat) => seat !== view.seat));
  const cache = new Map<string, boolean>();
  return (cards) => {
    const key = [...cards].sort((a, b) => a - b).join(',');
    const cached = cache.get(key);
    if (cached != null) return cached;
    const combo = detectCombo(cards);
    const boss = combo != null && !legalPlays(unseen, combo, false).some((beat) => beat.cards.length <= maxOpponent);
    cache.set(key, boss);
    return boss;
  };
}

function easyMove(view: BotView, prev: Combo | null, random: () => number): ServerMove {
  const hints = hintPlays(view.hand, prev, view.require3s);
  if (!prev) return play(hints[Math.floor(random() * Math.min(EASY_LEAD_CHOICES, hints.length))]);
  if (hints.length === 0 || random() < EASY_PASS_CHANCE) return PASS;
  return play(random() < EASY_CHEAPEST_CHANCE ? hints[0] : hints[Math.floor(random() * hints.length)]);
}

interface Scored {
  candidate: CandidatePlay;
  breaks: number;
  score: number;
}

function smartMove(view: BotView, prev: Combo | null, plays: CandidatePlay[], hard: boolean, random: () => number): ServerMove {
  const opponents = view.handCounts.filter((count, seat) => seat !== view.seat && count > 0);
  const fewestOpponent = Math.min(...opponents);
  const planNow = planHand(view.hand).length;
  const urgent = fewestOpponent <= 2 || planNow <= (hard ? 3 : 2);
  const isBoss = hard ? bossChecker(view) : () => false;
  const pick = (scored: Scored[]): Scored => (!hard && random() < NORMAL_SLIP_CHANCE ? slip(scored, random) : lowest(scored));
  const controls = (cards: readonly number[]): boolean => {
    if (!isBoss(cards)) return false;
    const rest = planHand(without(view.hand, cards));
    return rest.filter((combo) => !isBoss(combo)).length <= 1;
  };

  if (!prev) {
    if (hard) {
      const plan = planHand(view.hand);
      const weak = plan.filter((combo) => !isBoss(combo));
      const boss = plan.find((combo) => isBoss(combo) && plays.some((p) => sameCards(p.cards, combo)));
      if (boss && weak.length <= 1) return play(boss);
    }
    const oneCardLeft = fewestOpponent === 1;
    const scored = plays.map((candidate): Scored => {
      const breaks = planHand(without(view.hand, candidate.cards)).length - (planNow - 1);
      const single = candidate.combo.kind === 'single';
      const score =
        breaks * 10 +
        (isStrong(candidate) && !urgent ? 30 : 0) +
        (oneCardLeft && single ? 40 - rankOf(candidate.combo.key) : rankOf(candidate.combo.key)) -
        candidate.cards.length * 0.5;
      return { candidate, breaks, score };
    });
    return play(pick(scored).candidate.cards);
  }

  const tableTwo = rankOf(prev.key) === RANK_TWO;
  const blockSingle = hard && prev.kind === 'single' && fewestOpponent === 1;
  const scored = plays.map((candidate): Scored => {
    const breaks = planHand(without(view.hand, candidate.cards)).length - (planNow - 1);
    const chop = isChop(candidate.combo, prev);
    let score = breaks * 10 + rankOf(candidate.combo.key);
    if (isStrong(candidate) && !tableTwo && !urgent) score += 25;
    if (chop && tableTwo) score -= 50;
    if (blockSingle) score -= candidate.combo.key / 2;
    if (hard && controls(candidate.cards)) score -= 40;
    return { candidate, breaks, score };
  });
  const best = pick(scored);
  const holding = !urgent && !tableTwo && (best.breaks >= 1 || isStrong(best.candidate));
  if (holding && !blockSingle && !(hard && controls(best.candidate.cards))) {
    if (hard || random() < NORMAL_HOLD_CHANCE) return PASS;
  }
  return play(best.candidate.cards);
}

function lowest(scored: Scored[]): Scored {
  return scored.reduce((a, b) => (b.score < a.score ? b : a));
}

function slip(scored: Scored[], random: () => number): Scored {
  const ranked = [...scored].sort((a, b) => a.score - b.score).slice(0, NORMAL_SLIP_CHOICES);
  return ranked[Math.floor(random() * ranked.length)];
}

function sameCards(a: readonly number[], b: readonly number[]): boolean {
  return a.length === b.length && a.every((card) => b.includes(card));
}

export function chooseBotMove(view: BotView, level: BotLevel, random: () => number): ServerMove {
  const prev = view.table ? detectCombo(view.table.cards) : null;
  const plays = legalPlays(view.hand, prev, view.require3s);
  if (plays.length === 0) return PASS;
  const finishing = plays.find((candidate) => candidate.cards.length === view.hand.length);
  if (finishing) return play(finishing.cards);
  if (level === 'easy') return easyMove(view, prev, random);
  return smartMove(view, prev, plays, level === 'hard', random);
}
