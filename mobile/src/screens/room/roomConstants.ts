import type { BubblePosition } from './messageGroups';

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

const LIST_PADDING = 12 * 2;
const AVATAR_WITH_GAP = 32 + 8;
const BUBBLE_PADDING = 14 * 2;

export function roomBubbleTextMaxWidth(windowWidth: number, isOwn: boolean): number {
  const rowWidth = (windowWidth - LIST_PADDING) * (isOwn ? 0.8 : 0.85);
  return Math.floor(rowWidth - AVATAR_WITH_GAP - BUBBLE_PADDING) - 2;
}

export const ROOM_BROWSE_LIMIT = 50;
