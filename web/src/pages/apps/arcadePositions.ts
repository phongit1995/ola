import type { DragOffset } from '@hooks';
import {
  DEFAULT_DRAG_OFFSET,
  isDragOffset,
  readStoredJson,
  writeStoredJson,
} from '@lib';

export const ARCADE_BUBBLE_STORAGE_KEY = 'ola.arcade.bubble-position';
const MINIMIZE_POSITION_STORAGE_KEY = 'ola.arcade.minimize-position';

export function readMinimizeOffset(slug: string): DragOffset {
  const all = readStoredJson<Record<string, Partial<DragOffset>>>(
    MINIMIZE_POSITION_STORAGE_KEY
  );
  const parsed = all?.[slug];
  return isDragOffset(parsed) ? parsed : DEFAULT_DRAG_OFFSET;
}

export function storeMinimizeOffset(slug: string, offset: DragOffset) {
  const all =
    readStoredJson<Record<string, DragOffset>>(MINIMIZE_POSITION_STORAGE_KEY) ??
    {};
  all[slug] = offset;
  writeStoredJson(MINIMIZE_POSITION_STORAGE_KEY, all);
}
