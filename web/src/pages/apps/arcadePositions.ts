import type { DragOffset } from './useDraggableOffset';

const BUBBLE_POSITION_STORAGE_KEY = 'ola.arcade.bubble-position';
const MINIMIZE_POSITION_STORAGE_KEY = 'ola.arcade.minimize-position';

export const DEFAULT_OFFSET: DragOffset = { x: 0, y: 0 };

function isOffset(
  value: Partial<DragOffset> | null | undefined
): value is DragOffset {
  return value != null && Number.isFinite(value.x) && Number.isFinite(value.y);
}

function readJson<T>(key: string): T | null {
  if (typeof window === 'undefined') return null;
  try {
    const raw = window.localStorage.getItem(key);
    return raw ? (JSON.parse(raw) as T) : null;
  } catch {
    return null;
  }
}

function writeJson(key: string, value: unknown) {
  try {
    window.localStorage.setItem(key, JSON.stringify(value));
  } catch {
    return;
  }
}

export function readBubbleOffset(): DragOffset {
  const parsed = readJson<Partial<DragOffset>>(BUBBLE_POSITION_STORAGE_KEY);
  return isOffset(parsed) ? parsed : DEFAULT_OFFSET;
}

export function storeBubbleOffset(offset: DragOffset) {
  writeJson(BUBBLE_POSITION_STORAGE_KEY, offset);
}

export function readMinimizeOffset(slug: string): DragOffset {
  const all = readJson<Record<string, Partial<DragOffset>>>(
    MINIMIZE_POSITION_STORAGE_KEY
  );
  const parsed = all?.[slug];
  return isOffset(parsed) ? parsed : DEFAULT_OFFSET;
}

export function storeMinimizeOffset(slug: string, offset: DragOffset) {
  const all =
    readJson<Record<string, DragOffset>>(MINIMIZE_POSITION_STORAGE_KEY) ?? {};
  all[slug] = offset;
  writeJson(MINIMIZE_POSITION_STORAGE_KEY, all);
}
