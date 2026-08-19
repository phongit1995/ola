import { HAND_SIZE, type ComboKind } from './constants.gen';
import { isValidCard, rankOf, isTwo, sortHand } from './cards';

export interface Combo {
  kind: ComboKind;
  length: number;
  key: number;
}

export function detectCombo(cards: readonly number[]): Combo | null {
  const n = cards.length;
  if (n === 0 || n > HAND_SIZE) return null;
  const sorted = sortHand(cards);
  for (let i = 0; i < sorted.length; i += 1) {
    if (!isValidCard(sorted[i])) return null;
    if (i > 0 && sorted[i] === sorted[i - 1]) return null;
  }
  const top = sorted[n - 1];

  const sameRank = sorted.every((card) => rankOf(card) === rankOf(top));
  if (sameRank) {
    if (n === 1) return { kind: 'single', length: 1, key: top };
    if (n === 2) return { kind: 'pair', length: 2, key: top };
    if (n === 3) return { kind: 'triple', length: 3, key: top };
    if (n === 4) return { kind: 'quad', length: 4, key: top };
    return null;
  }

  if (n >= 3 && isStraight(sorted)) return { kind: 'straight', length: n, key: top };
  if (n >= 6 && n % 2 === 0 && isDoubleRun(sorted)) {
    return { kind: 'doubleRun', length: n / 2, key: top };
  }
  return null;
}

function isStraight(sorted: readonly number[]): boolean {
  for (let i = 0; i < sorted.length; i += 1) {
    if (isTwo(sorted[i])) return false;
    if (i > 0 && rankOf(sorted[i]) !== rankOf(sorted[i - 1]) + 1) return false;
  }
  return true;
}

function isDoubleRun(sorted: readonly number[]): boolean {
  for (let i = 0; i < sorted.length; i += 2) {
    if (rankOf(sorted[i]) !== rankOf(sorted[i + 1])) return false;
    if (isTwo(sorted[i])) return false;
    if (i > 0 && rankOf(sorted[i]) !== rankOf(sorted[i - 2]) + 1) return false;
  }
  return true;
}
