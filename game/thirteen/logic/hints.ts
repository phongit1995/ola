import { rankOf } from './cards';
import { RANK_TWO, THREE_OF_SPADES } from './constants.gen';
import { canBeat, isChop } from './beats';
import { detectCombo, type Combo } from './combos';

export interface CandidatePlay {
  cards: number[];
  combo: Combo;
}

function subsets(cards: readonly number[], size: number): number[][] {
  if (size === 0) return [[]];
  const out: number[][] = [];
  cards.forEach((card, i) => {
    for (const rest of subsets(cards.slice(i + 1), size - 1)) out.push([card, ...rest]);
  });
  return out;
}

function groupByRank(hand: readonly number[]): Map<number, number[]> {
  const byRank = new Map<number, number[]>();
  for (const card of [...hand].sort((a, b) => a - b)) {
    const bucket = byRank.get(rankOf(card));
    if (bucket) bucket.push(card);
    else byRank.set(rankOf(card), [card]);
  }
  return byRank;
}

function candidateCards(hand: readonly number[]): number[][] {
  const byRank = groupByRank(hand);
  const out: number[][] = hand.map((card) => [card]);
  for (const cards of byRank.values()) {
    for (let size = 2; size <= cards.length; size += 1) out.push(...subsets(cards, size));
  }
  for (let start = 0; start < RANK_TWO; start += 1) {
    const low: number[] = [];
    const lowPairs: number[] = [];
    let pairsOpen = true;
    for (let rank = start; rank < RANK_TWO; rank += 1) {
      const cards = byRank.get(rank);
      if (!cards) break;
      if (low.length >= 2) for (const top of cards) out.push([...low, top]);
      if (pairsOpen && cards.length >= 2) {
        if (lowPairs.length >= 4) for (const top of subsets(cards, 2)) out.push([...lowPairs, ...top]);
        lowPairs.push(cards[0], cards[1]);
      } else {
        pairsOpen = false;
      }
      low.push(cards[0]);
    }
  }
  return out;
}

export function legalPlays(hand: readonly number[], prev: Combo | null, require3s: boolean): CandidatePlay[] {
  const plays: CandidatePlay[] = [];
  for (const cards of candidateCards(hand)) {
    if (require3s && !cards.includes(THREE_OF_SPADES)) continue;
    const combo = detectCombo(cards);
    if (combo && canBeat(combo, prev)) plays.push({ cards, combo });
  }
  return plays;
}

export function enumeratePlays(hand: readonly number[], prev: Combo | null, require3s = false): number[][] {
  return legalPlays(hand, prev, require3s).map((play) => play.cards);
}

export function hasAnyBeat(hand: readonly number[], prev: Combo | null, require3s = false): boolean {
  return legalPlays(hand, prev, require3s).length > 0;
}

function lowestRank(cards: readonly number[]): number {
  return Math.min(...cards.map(rankOf));
}

function hintShape(play: CandidatePlay, leading: boolean): string {
  const { kind, length, key } = play.combo;
  const low = lowestRank(play.cards);
  if (leading && (kind === 'straight' || kind === 'doubleRun')) return `${kind}:${low}`;
  return `${kind}:${length}:${rankOf(key)}:${low}`;
}

export function hintPlays(hand: readonly number[], prev: Combo | null, require3s = false): number[][] {
  const plays = legalPlays(hand, prev, require3s).sort((a, b) =>
    prev
      ? Number(isChop(a.combo, prev)) - Number(isChop(b.combo, prev)) ||
        a.combo.key - b.combo.key ||
        a.cards.length - b.cards.length
      : lowestRank(a.cards) - lowestRank(b.cards) || b.cards.length - a.cards.length || a.combo.key - b.combo.key,
  );
  const seen = new Set<string>();
  const unique: number[][] = [];
  for (const play of plays) {
    const shape = hintShape(play, prev == null);
    if (seen.has(shape)) continue;
    seen.add(shape);
    unique.push([...play.cards].sort((a, b) => a - b));
  }
  return unique;
}
