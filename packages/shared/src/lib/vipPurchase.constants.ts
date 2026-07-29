import type { BuyErrorKey } from '../types/lib.type';

export const VIP_BUY_ERROR_KEYS: Record<string, BuyErrorKey> = {
  'insufficient ken balance': 'vip.buy.errInsufficientKen',
  'vip shop item not found': 'vip.buy.errItemUnavailable',
  'vip package not found': 'vip.buy.errPackageUnavailable',
  'receiver not found': 'vip.buy.errReceiverNotFound',
  'cannot gift to yourself': 'vip.buy.errGiftSelf',
  'cannot gift to blocked user': 'vip.buy.errBlocked',
  'invalid transfer password': 'vip.buy.errWrongPassword',
};
