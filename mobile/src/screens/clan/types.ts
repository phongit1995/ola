import type { Post } from '@ola/shared/types';

export type StaffConfirm =
  | { type: 'deletePost'; post: Post }
  | { type: 'deleteByUser'; post: Post }
  | { type: 'ban'; post: Post };
