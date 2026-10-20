import type { BubblePosition } from '@ola/shared/types';

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

export const ROOM_BROWSE_LIMIT = 50;
