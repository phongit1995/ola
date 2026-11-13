import type { PostReaction } from '../types/api/me.type';

export const EDIT_WINDOW_MS = 60 * 60 * 1000;

export const ME_ERROR_CODE = {
  postHiddenByAdmin: 'ME_POST_HIDDEN_BY_ADMIN',
} as const;
export const MAX_VIEWED_PROFILES = 30;
export const MAX_HIDDEN_POSTS = 500;
export const MAX_BLOCKED_AUTHORS = 500;

export const POST_REACTION = {
  like: 'like',
  dislike: 'dislike',
} as const satisfies Record<string, PostReaction>;
