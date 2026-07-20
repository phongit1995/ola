import type { BubblePosition } from './messageGroups';
import type { RoomFilters } from './types';

export const ROOM_CAPACITY = 200;

export const ROOM_COLORS = ['#ef5350', '#ec407a', '#5c6bc0', '#26a69a', '#7e57c2', '#ffa726'];

export const OWN_CORNERS: Record<BubblePosition, string> = {
  single: 'rounded-2xl',
  first: 'rounded-2xl rounded-br-none',
  middle: 'rounded-2xl rounded-tr-none rounded-br-none',
  last: 'rounded-2xl rounded-tr-none',
};

export const OTHER_CORNERS: Record<BubblePosition, string> = {
  single: 'rounded-2xl',
  first: 'rounded-2xl rounded-bl-none',
  middle: 'rounded-2xl rounded-tl-none rounded-bl-none',
  last: 'rounded-2xl rounded-tl-none',
};

export const FILTER_KEYS = [
  { key: 'showAll', labelKey: 'room.filterShowAll' },
  { key: 'media', labelKey: 'room.filterMedia' },
  { key: 'female', labelKey: 'room.filterFemale' },
  { key: 'male', labelKey: 'room.filterMale' },
  { key: 'flexible', labelKey: 'room.filterFlexible' },
] as const satisfies ReadonlyArray<{ key: keyof RoomFilters; labelKey: string }>;
