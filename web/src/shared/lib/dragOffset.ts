import type { DragOffset } from '@hooks';

export const DEFAULT_DRAG_OFFSET: DragOffset = { x: 0, y: 0 };

export function isDragOffset(
  value: Partial<DragOffset> | null | undefined
): value is DragOffset {
  return value != null && Number.isFinite(value.x) && Number.isFinite(value.y);
}

export function readStoredJson<T>(key: string): T | null {
  if (typeof window === 'undefined') return null;
  try {
    const raw = window.localStorage.getItem(key);
    return raw ? (JSON.parse(raw) as T) : null;
  } catch {
    return null;
  }
}

export function writeStoredJson(key: string, value: unknown) {
  try {
    window.localStorage.setItem(key, JSON.stringify(value));
  } catch {
    return;
  }
}

export function readDragOffset(key: string): DragOffset {
  const parsed = readStoredJson<Partial<DragOffset>>(key);
  return isDragOffset(parsed) ? parsed : DEFAULT_DRAG_OFFSET;
}

export function storeDragOffset(key: string, offset: DragOffset) {
  writeStoredJson(key, offset);
}
