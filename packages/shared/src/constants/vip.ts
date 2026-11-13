import type { BuyVipMode } from '../types/client/vipPurchase.type';

export const BUY_VIP_DEFAULT_TYPE_ID = 4;
export const VIP_STORE_PAGE_SIZE = 100;

export const BUY_VIP_MODE_ORDER: readonly BuyVipMode[] = [
  'buy',
  'give',
  'giveDays',
  'transferDays',
  'extend',
];

export const BUY_VIP_MODE_TITLE = {
  buy: 'vip.buy.titleBuy',
  give: 'vip.buy.titleGive',
  giveDays: 'vip.buy.titleGiveDays',
  transferDays: 'vip.buy.titleTransferDays',
  extend: 'vip.buy.titleExtend',
} as const satisfies Record<BuyVipMode, string>;

export const BUY_VIP_MODE_ACTION = {
  buy: 'vip.buyVip',
  give: 'vip.buy.actionGive',
  giveDays: 'vip.buy.actionGive',
  transferDays: 'vip.buy.actionTransferDays',
  extend: 'vip.extendVip',
} as const satisfies Record<BuyVipMode, string>;

export const BUY_VIP_MODE_TAB = {
  buy: 'vip.buy.modeBuy',
  give: 'vip.buy.modeGive',
  giveDays: 'vip.buy.modeGiveDays',
  transferDays: 'vip.buy.modeTransferDays',
  extend: 'vip.buy.modeExtend',
} as const satisfies Record<BuyVipMode, string>;
