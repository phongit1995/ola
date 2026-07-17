import type { MeFeedFilter, PostVisibility } from '@ola/shared/types';
import type { MeTab } from './types';

export const TAB_FILTER: Record<MeTab, MeFeedFilter | undefined> = {
  community: undefined,
  personal: 'following',
  clan: 'clan',
};

export const COMPOSER_MAX_IMAGES = 5;

export const COMPOSER_PRIVACY_OPTIONS: PostVisibility[] = ['public', 'friend', 'private'];
