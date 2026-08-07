import { RELATIONSHIP_STATUS } from '@constants';
import type { RelationshipInfo } from '@app-types';
import type { ProfileSecondary } from './types';

export const DEFAULT_COVER_COLOR = '#33691e';

export const PROFILE_POSTS_LIMIT = 30;
export const FOLLOWING_FETCH_LIMIT = 12;

export const INPUT_CLASS =
  'w-full bg-transparent text-sm text-black/87 outline-none placeholder:text-ola-error';

export const PHONE_PATTERN = /^[0-9+\-() ]{6,20}$/;

export const NO_RELATIONSHIP: RelationshipInfo = {
  status: RELATIONSHIP_STATUS.none,
  isFollowing: false,
  followsMe: false,
};

export const EMPTY_SECONDARY: ProfileSecondary = {
  media: [],
  following: [],
  posts: [],
  loading: false,
};
