import type { BubblePosition } from './messageGroups';

export const GROUP_GAP_MS = 5 * 60 * 1000;

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
