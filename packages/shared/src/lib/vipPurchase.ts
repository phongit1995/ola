import type { TFunction } from 'i18next';
import { ApiError } from './apiError';
import { formatKen } from './number';
import type { VipPackageItem } from '../types/api/vip.type';
import type { VipConfirmInput } from '../types/client/vipPurchase.type';
import { VIP_BUY_ERROR_KEYS } from './vipPurchase.constants';

export type {
  BuyVipMode,
  VipConfirmInput,
} from '../types/client/vipPurchase.type';

export function vipPackageLabel(t: TFunction, pkg: VipPackageItem): string {
  return t('vip.buy.kenPrice', { ken: formatKen(pkg.kenPrice), days: pkg.days });
}

export function vipBuyErrorText(t: TFunction, error: unknown): string {
  if (error instanceof ApiError) {
    const key = VIP_BUY_ERROR_KEYS[error.message];
    if (key != null) return t(key);
  }
  return t('vip.buy.failed');
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

const ONE_DAY_MS = 86_400_000;
const ONE_HOUR_MS = 3_600_000;
const ONE_MINUTE_MS = 60_000;

export function vipRemainingText(
  t: TFunction,
  vipEndTime: string | null,
  remainingDays: number | null,
  now: number
): string {
  const daysText =
    remainingDays != null && remainingDays > 0
      ? t('vip.daysLeft', { count: remainingDays })
      : t('vip.noVip');
  if (vipEndTime == null) return daysText;
  const diffMs = new Date(vipEndTime).getTime() - now;
  if (Number.isNaN(diffMs)) return daysText;
  if (diffMs <= 0) return t('vip.expired');
  if (diffMs >= ONE_DAY_MS) return t('vip.daysLeft', { count: Math.ceil(diffMs / ONE_DAY_MS) });
  const hours = Math.floor(diffMs / ONE_HOUR_MS);
  const minutes = Math.floor((diffMs % ONE_HOUR_MS) / ONE_MINUTE_MS);
  if (hours >= 1) {
    return minutes > 0
      ? t('vip.hoursMinutesLeft', { hours, minutes })
      : t('vip.hoursLeft', { count: hours });
  }
  if (minutes >= 1) return t('vip.minutesLeft', { count: minutes });
  return t('vip.expiringSoon');
}
