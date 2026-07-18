import type { TFunction } from 'i18next';
import { ApiError } from './apiError';
import { formatKen } from './number';
import type { VipPackageItem } from '../types';

export type BuyVipMode = 'buy' | 'give' | 'giveDays' | 'extend';

type BuyErrorKey =
  | 'vip.buy.errInsufficientKen'
  | 'vip.buy.errItemUnavailable'
  | 'vip.buy.errPackageUnavailable'
  | 'vip.buy.errReceiverNotFound'
  | 'vip.buy.errGiftSelf'
  | 'vip.buy.errBlocked'
  | 'vip.buy.errWrongPassword';

const BUY_ERROR_KEYS: Record<string, BuyErrorKey> = {
  'insufficient ken balance': 'vip.buy.errInsufficientKen',
  'vip shop item not found': 'vip.buy.errItemUnavailable',
  'vip package not found': 'vip.buy.errPackageUnavailable',
  'receiver not found': 'vip.buy.errReceiverNotFound',
  'cannot gift to yourself': 'vip.buy.errGiftSelf',
  'cannot gift to blocked user': 'vip.buy.errBlocked',
  'invalid transfer password': 'vip.buy.errWrongPassword',
};

export function vipPackageLabel(t: TFunction, pkg: VipPackageItem): string {
  return t('vip.buy.kenPrice', { ken: formatKen(pkg.kenPrice), days: pkg.days });
}

export function vipBuyErrorText(t: TFunction, error: unknown): string {
  if (error instanceof ApiError) {
    const key = BUY_ERROR_KEYS[error.message];
    if (key != null) return t(key);
  }
  return t('vip.buy.failed');
}

export interface VipConfirmInput {
  mode: BuyVipMode;
  selectedPackage: VipPackageItem | null;
  vipName: string;
  shopItemKenPrice: number;
  receiver: string;
}

export function vipConfirmMessage(t: TFunction, input: VipConfirmInput): string {
  const days = input.selectedPackage?.days ?? 0;
  const ken = formatKen(input.selectedPackage?.kenPrice ?? 0);
  switch (input.mode) {
    case 'buy':
      return t('vip.buy.confirmBuyIcon', {
        name: input.vipName,
        ken: formatKen(input.shopItemKenPrice),
      });
    case 'give':
      return t('vip.buy.confirmGiveIcon', { name: input.vipName, receiver: input.receiver });
    case 'giveDays':
      return t('vip.buy.confirmGiveDays', { days, ken, receiver: input.receiver });
    case 'extend':
    default:
      return t('vip.buy.confirmExtend', { days, ken });
  }
}
