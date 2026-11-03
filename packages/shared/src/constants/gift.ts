import type {
  GiftLeaderboardPeriod,
  GiftLeaderboardType,
  GiftSettings,
  GiftSource,
} from '../types/api/gift.type';
import type { GiftErrorKey } from '../types/lib.type';

export const GIFT_SOURCE = {
  chat: 'chat',
  profile: 'profile',
} as const satisfies Record<string, GiftSource>;

export const GIFT_LEADERBOARD_TYPE = {
  sender: 'sender',
  receiver: 'receiver',
} as const satisfies Record<string, GiftLeaderboardType>;

export const GIFT_LEADERBOARD_PERIOD = {
  week: 'week',
  month: 'month',
  all: 'all',
} as const satisfies Record<string, GiftLeaderboardPeriod>;

export const GIFT_LEADERBOARD_PERIODS: readonly GiftLeaderboardPeriod[] = [
  GIFT_LEADERBOARD_PERIOD.week,
  GIFT_LEADERBOARD_PERIOD.month,
  GIFT_LEADERBOARD_PERIOD.all,
];

export const GIFT_HISTORY_PAGE_SIZE = 20;
export const GIFT_LEADERBOARD_LIMIT = 50;
export const GIFT_LEADERBOARD_PODIUM_SIZE = 3;
export const GIFT_ANIMATION_DURATION_MS = 2_400;

export const DEFAULT_GIFT_SETTINGS: GiftSettings = {
  enabled: true,
  quantityOptions: [1, 5, 10, 99],
  quantityMax: 99,
  noteMaxLength: 100,
  confirmOverKen: 1000,
};

export const GIFT_ERROR_KEYS: Record<string, GiftErrorKey> = {
  GIFT_DISABLED: 'gift.errors.disabled',
  GIFT_NOT_FOUND: 'gift.errors.notFound',
  GIFT_SELF: 'gift.errors.self',
  GIFT_BLOCKED: 'gift.errors.blocked',
  GIFT_RECEIVER_UNAVAILABLE: 'gift.errors.receiverUnavailable',
  GIFT_INSUFFICIENT_KEN: 'gift.errors.insufficientKen',
  GIFT_INVALID_QUANTITY: 'gift.errors.invalidQuantity',
  GIFT_NOTE_TOO_LONG: 'gift.errors.noteTooLong',
  GIFT_REQUEST_CONFLICT: 'gift.errors.failed',
  RATE_LIMITED: 'gift.errors.rateLimited',
};
