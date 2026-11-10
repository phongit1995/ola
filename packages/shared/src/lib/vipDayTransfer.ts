import type { TFunction } from 'i18next';
import { ApiError } from './apiError';
import type { VipDayTransferConfig } from '../types/api/vip.type';
import { VIP_DAY_TRANSFER_ERROR_KEYS, VIP_DAY_TRANSFER_SOURCES } from './vipPurchase.constants';

const DAY_MS = 86_400_000;

export function vipDayTransferReceiverDays(config: VipDayTransferConfig, senderDays: number): number {
  if (senderDays < config.minSenderDays) return 0;
  return Math.ceil(senderDays / config.rate);
}

export function vipDayTransferMaxSenderDays(vipEndTime?: string | null): number {
  if (vipEndTime == null || vipEndTime === '') return 0;
  const end = new Date(vipEndTime).getTime();
  if (Number.isNaN(end)) return 0;
  return Math.max(0, Math.floor((end - Date.now()) / DAY_MS));
}

export function parseVipDayTransferDays(text: string): number {
  const trimmed = text.trim();
  return /^\d{1,5}$/.test(trimmed) ? Number(trimmed) : 0;
}

export function vipDayTransferInputError(
  t: TFunction,
  config: VipDayTransferConfig,
  senderDays: number,
  vipEndTime?: string | null,
): string | null {
  if (senderDays <= 0) return t('vip.buy.needTransferDays');
  if (senderDays < config.minSenderDays) {
    return t('vip.buy.errTransferDaysMin', { days: config.minSenderDays });
  }
  if (senderDays > vipDayTransferMaxSenderDays(vipEndTime)) {
    return t('vip.buy.errTransferDaysTooMany');
  }
  return null;
}

export function vipDayTransferErrorText(t: TFunction, error: unknown): string {
  if (error instanceof ApiError) {
    const key = VIP_DAY_TRANSFER_ERROR_KEYS[error.message];
    if (key != null) return t(key);
  }
  return t('vip.buy.transferDaysFailed');
}

export function isVipDayTransferSource(source: string): boolean {
  return VIP_DAY_TRANSFER_SOURCES.includes(source);
}
