import type { BuyVipMode } from '@ola/shared/types';

export const DEFAULT_VIP_ID = 4;

export const VIP_PAGE_SIZE = 100;

export const RECEIVER_SEARCH_DEBOUNCE_MS = 350;

export const RECEIVER_SEARCH_LIMIT = 30;

export const MODE_ORDER: BuyVipMode[] = ['buy', 'give', 'giveDays', 'transferDays', 'extend'];

export const MODE_TITLE = {
  buy: 'vip.buy.titleBuy',
  give: 'vip.buy.titleGive',
  giveDays: 'vip.buy.titleGiveDays',
  transferDays: 'vip.buy.titleTransferDays',
  extend: 'vip.buy.titleExtend',
} as const;

export const MODE_ACTION = {
  buy: 'vip.buyVip',
  give: 'vip.buy.actionGive',
  giveDays: 'vip.buy.actionGive',
  transferDays: 'vip.buy.actionTransferDays',
  extend: 'vip.extendVip',
} as const;

export const MODE_TAB = {
  buy: 'vip.buy.modeBuy',
  give: 'vip.buy.modeGive',
  giveDays: 'vip.buy.modeGiveDays',
  transferDays: 'vip.buy.modeTransferDays',
  extend: 'vip.buy.modeExtend',
} as const;
