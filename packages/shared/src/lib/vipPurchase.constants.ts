import type { BuyErrorKey, VipDayTransferErrorKey } from '../types/lib.type';

export const VIP_DAY_TRANSFER_SOURCES: readonly string[] = ['day_transfer_out', 'day_transfer_in'];

export const VIP_DAY_TRANSFER_RATE_CHANGED = 'vip day transfer rate changed';

export const VIP_DAY_TRANSFER_CONFIG_ERRORS: readonly string[] = [
  'vip day transfer is disabled',
  'invalid vip day transfer amount',
  VIP_DAY_TRANSFER_RATE_CHANGED,
];

export const VIP_BUY_ERROR_KEYS: Record<string, BuyErrorKey> = {
  'insufficient ken balance': 'vip.buy.errInsufficientKen',
  'vip shop item not found': 'vip.buy.errItemUnavailable',
  'vip package not found': 'vip.buy.errPackageUnavailable',
  'receiver not found': 'vip.buy.errReceiverNotFound',
  'cannot gift to yourself': 'vip.buy.errGiftSelf',
  'cannot gift to blocked user': 'vip.buy.errBlocked',
  'invalid transfer password': 'vip.buy.errWrongPassword',
};

export const VIP_DAY_TRANSFER_ERROR_KEYS: Record<string, VipDayTransferErrorKey> = {
  'vip day transfer is disabled': 'vip.buy.errDayTransferDisabled',
  'invalid vip day transfer amount': 'vip.buy.errDayTransferInvalid',
  'not enough vip days to transfer': 'vip.buy.errDayTransferNotEnough',
  [VIP_DAY_TRANSFER_RATE_CHANGED]: 'vip.buy.errDayTransferRateChanged',
  'receiver not found': 'vip.buy.errReceiverNotFound',
  'cannot gift to yourself': 'vip.buy.errGiftSelf',
  'cannot gift to blocked user': 'vip.buy.errBlocked',
  'invalid transfer password': 'vip.buy.errWrongPassword',
};
