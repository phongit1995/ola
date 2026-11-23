import { POST_VISIBILITY } from '@ola/shared/constants';
import type { MeFeedFilter, PostVisibility } from '@ola/shared/types';
import type { MeTab } from './types';

export const TAB_FILTER: Record<MeTab, MeFeedFilter | undefined> = {
  community: undefined,
  personal: 'following',
  clan: 'clan',
};

export const COMPOSER_MAX_IMAGES = 5;

export const COMPOSER_PRIVACY_OPTIONS: PostVisibility[] = [
  POST_VISIBILITY.public,
  POST_VISIBILITY.profile,
  POST_VISIBILITY.friend,
  POST_VISIBILITY.private,
];

export const VISITORS_PAGE_SIZE = 40;

export const LIKERS_PAGE_SIZE = 30;
