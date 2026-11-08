import type { AvatarFrameHistoryTone } from '@lib';

export const FRAME_TILE_AVATAR_SIZE = 72;
export const FRAME_PREVIEW_AVATAR_SIZE = 120;
export const FRAME_THUMB_SIZE = 40;
export const LOAD_MORE_THRESHOLD_PX = 300;
export const PEER_FRAME_THUMB_SIZE = 56;

export const FRAME_INPUT_CLASS =
  'mt-1 w-full rounded border border-black/12 bg-white px-3 py-2 text-base text-black/87 outline-none placeholder:text-black/38 focus:border-ola-primary';

export const FRAME_HISTORY_TONE_CLASS: Record<AvatarFrameHistoryTone, string> = {
  debit: 'text-ola-error',
  credit: 'text-ola-primary-ink',
  neutral: 'text-black/54',
};
