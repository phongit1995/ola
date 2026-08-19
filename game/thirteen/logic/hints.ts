import { rankOf } from './cards';
import { RANK_TWO } from './constants.gen';
import { canBeat } from './beats';
import { detectCombo, type Combo } from './combos';

export function enumeratePlays(hand: readonly number[], prev: Combo | null): number[][] {
  const plays: number[][] = [];
  const tryPlay = (cards: number[]): void => {
    const combo = detectCombo(cards);
    if (combo && canBeat(combo, prev)) plays.push(cards);
  };

  for (const card of hand) tryPlay([card]);

  const byRank = new Map<number, number[]>();
  for (const card of hand) {
    const rank = rankOf(card);
    const bucket = byRank.get(rank);
    if (bucket) bucket.push(card);
    else byRank.set(rank, [card]);
  }
  for (const cards of byRank.values()) {
    if (cards.length >= 2) tryPlay(cards.slice(0, 2));
    if (cards.length >= 3) tryPlay(cards.slice(0, 3));
    if (cards.length === 4) tryPlay(cards.slice(0, 4));
  }

  for (let start = 0; start < RANK_TWO; start += 1) {
    const run: number[] = [];
    for (let rank = start; rank < RANK_TWO; rank += 1) {
      const cards = byRank.get(rank);
      if (!cards || cards.length === 0) break;
      run.push(cards[0]);
      if (run.length >= 3) tryPlay([...run]);
    }
    const pairRun: number[] = [];
    for (let rank = start; rank < RANK_TWO; rank += 1) {
      const cards = byRank.get(rank);
      if (!cards || cards.length < 2) break;
      pairRun.push(cards[0], cards[1]);
      if (pairRun.length >= 6) tryPlay([...pairRun]);
    }
  }
  return plays;
}

export function hasAnyBeat(hand: readonly number[], prev: Combo | null): boolean {
  return enumeratePlays(hand, prev).length > 0;
}

export function playableCardSet(hand: readonly number[], prev: Combo | null): Set<number> {
  const playable = new Set<number>();
  for (const play of enumeratePlays(hand, prev)) {
    for (const card of play) playable.add(card);
  }
  return playable;
}
