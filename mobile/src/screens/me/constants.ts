import type { MeFeedFilter } from '@ola/shared/types';
import type { MeTab } from './types';

export const TAB_FILTER: Record<MeTab, MeFeedFilter | undefined> = {
  community: undefined,
  personal: 'following',
  clan: 'clan',
};
