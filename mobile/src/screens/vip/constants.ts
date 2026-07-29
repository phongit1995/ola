import type { BuyVipMode } from '@ola/shared/types';

export const DEFAULT_VIP_ID = 4;

export const MOCK_KEN_BALANCE = 12_345;

export const VIP_PAGE_SIZE = 100;

export const RECEIVER_SEARCH_DEBOUNCE_MS = 350;

export const RECEIVER_SEARCH_LIMIT = 30;

export const MODE_ORDER: BuyVipMode[] = ['buy', 'give', 'giveDays', 'extend'];

export const PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;

export const MODE_TITLE = {
  buy: 'vip.buy.titleBuy',
  give: 'vip.buy.titleGive',
  giveDays: 'vip.buy.titleGiveDays',
  extend: 'vip.buy.titleExtend',
} as const;

export const MODE_ACTION = {
  buy: 'vip.buyVip',
  give: 'vip.buy.actionGive',
  giveDays: 'vip.buy.actionGive',
  extend: 'vip.extendVip',
} as const;

export const MODE_TAB = {
  buy: 'vip.buy.modeBuy',
  give: 'vip.buy.modeGive',
  giveDays: 'vip.buy.modeGiveDays',
  extend: 'vip.buy.modeExtend',
} as const;
