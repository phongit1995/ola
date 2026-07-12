import type { RelationshipInfo } from '@app-types';
import type { ProfileSecondary } from './types';

export const DEFAULT_COVER_COLOR = '#33691e';

export const COVER_ASPECT = 16 / 9;

export const AVATAR_ASPECT = 1;

export const MIN_AVATAR_SOURCE = 100;

export const INPUT_CLASS =
  'w-full bg-transparent text-sm text-black/87 outline-none placeholder:text-[#e34545]';

export const PHONE_PATTERN = /^[0-9+\-() ]{6,20}$/;

export const NO_RELATIONSHIP: RelationshipInfo = { status: 'none', isFollowing: false, followsMe: false };

export const EMPTY_SECONDARY: ProfileSecondary = { media: [], following: [], posts: [], loading: false };
