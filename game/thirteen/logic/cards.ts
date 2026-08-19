import { DECK_SIZE, RANK_TWO } from './constants.gen';

export const SUIT_SPADE = 0;
export const SUIT_CLUB = 1;
export const SUIT_DIAMOND = 2;
export const SUIT_HEART = 3;

const RANK_LABELS = ['3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A', '2'] as const;
const SUIT_SYMBOLS = ['♠', '♣', '♦', '♥'] as const;

export function rankOf(card: number): number {
  return Math.floor(card / 4);
}

export function suitOf(card: number): number {
  return card % 4;
}

export function isValidCard(card: number): boolean {
  return Number.isInteger(card) && card >= 0 && card < DECK_SIZE;
}

export function isTwo(card: number): boolean {
  return rankOf(card) === RANK_TWO;
}

export function isRedSuit(card: number): boolean {
  const suit = suitOf(card);
  return suit === SUIT_DIAMOND || suit === SUIT_HEART;
}

export function rankLabel(card: number): string {
  return RANK_LABELS[rankOf(card)] ?? '?';
}

export function suitSymbol(card: number): string {
  return SUIT_SYMBOLS[suitOf(card)] ?? '?';
}

export function cardLabel(card: number): string {
  return `${rankLabel(card)}${suitSymbol(card)}`;
}

export function sortHand(cards: readonly number[]): number[] {
  return [...cards].sort((a, b) => a - b);
}
