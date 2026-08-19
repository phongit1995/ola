import { rankOf, isTwo } from './cards';
import type { Combo } from './combos';

export function canBeat(next: Combo, prev: Combo | null): boolean {
  if (!prev) return true;
  if (next.kind === prev.kind && next.length === prev.length) {
    return next.key > prev.key;
  }
  if (prev.kind === 'single' && isTwo(prev.key)) {
    return next.kind === 'quad' || (next.kind === 'doubleRun' && next.length >= 3);
  }
  if (prev.kind === 'pair' && isTwo(prev.key)) {
    return next.kind === 'quad' || (next.kind === 'doubleRun' && next.length >= 4);
  }
  if (prev.kind === 'quad') {
    return next.kind === 'doubleRun' && next.length >= 4;
  }
  if (prev.kind === 'doubleRun' && prev.length === 3) {
    return next.kind === 'quad' || (next.kind === 'doubleRun' && next.length >= 4);
  }
  return false;
}

export function isChop(next: Combo, prev: Combo | null): boolean {
  if (!prev) return false;
  if (next.kind === prev.kind && next.length === prev.length) return false;
  return canBeat(next, prev);
}

export function comboLabel(combo: Combo): string {
  switch (combo.kind) {
    case 'single':
      return 'Rác';
    case 'pair':
      return 'Đôi';
    case 'triple':
      return 'Sám cô';
    case 'quad':
      return 'Tứ quý';
    case 'straight':
      return `Sảnh ${combo.length}`;
    case 'doubleRun':
      return `${combo.length} đôi thông`;
    default: {
      const exhaustive: never = combo.kind;
      return exhaustive;
    }
  }
}

export { rankOf };
