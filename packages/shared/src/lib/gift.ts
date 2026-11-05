import type { TFunction } from 'i18next';
import { GIFT_ERROR_KEYS, GIFT_INCOMING_RECENT_MS } from '../constants/gift';
import type { Gift, GiftMessageMetadata } from '../types/api/gift.type';
import { ApiError } from './apiError';

export function giftTotalKen(gift: Pick<Gift, 'kenPrice'>, quantity: number): number {
  return gift.kenPrice * quantity;
}

export function canAffordGift(balance: number, gift: Pick<Gift, 'kenPrice'>, quantity: number): boolean {
  return balance >= giftTotalKen(gift, quantity);
}

export function clampGiftQuantity(quantity: number, max: number): number {
  if (!Number.isFinite(quantity)) return 1;
  return Math.min(Math.max(Math.trunc(quantity), 1), Math.max(max, 1));
}

export function giftDisplayName(
  gift: Pick<Gift, 'name' | 'nameEn'>,
  language: string
): string {
  if (language.startsWith('en') && gift.nameEn != null && gift.nameEn !== '') {
    return gift.nameEn;
  }
  return gift.name;
}

export function isRecentGift(createdAt: string | undefined, now: number): boolean {
  const time = createdAt != null ? Date.parse(createdAt) : NaN;
  return !Number.isNaN(time) && now - time <= GIFT_INCOMING_RECENT_MS;
}

export function parseGiftMessageMetadata(
  metadata?: string | null,
  content?: string | null
): GiftMessageMetadata | null {
  if (metadata == null || metadata === '') return null;
  try {
    const parsed: unknown = JSON.parse(metadata);
    if (parsed == null || typeof parsed !== 'object' || Array.isArray(parsed)) return null;
    const meta = parsed as Partial<GiftMessageMetadata>;
    if (typeof meta.giftName !== 'string' || typeof meta.imageUrl !== 'string') return null;
    if (typeof meta.quantity !== 'number' || meta.quantity < 1) return null;
    return {
      transactionId: typeof meta.transactionId === 'string' ? meta.transactionId : '',
      giftId: typeof meta.giftId === 'string' ? meta.giftId : '',
      giftName: meta.giftName,
      giftNameEn: typeof meta.giftNameEn === 'string' ? meta.giftNameEn : undefined,
      imageUrl: meta.imageUrl,
      quantity: meta.quantity,
      charmPoints: typeof meta.charmPoints === 'number' ? meta.charmPoints : 0,
      note: content?.trim() || undefined,
    };
  } catch {
    return null;
  }
}

export function giftMessagePreview(metadata?: string | null): string {
  const gift = parseGiftMessageMetadata(metadata);
  return gift != null ? `🎁 ${gift.giftName} ×${gift.quantity}` : '🎁';
}

export function giftErrorText(t: TFunction, error: unknown): string {
  if (error instanceof ApiError) {
    const key = (error.code != null ? GIFT_ERROR_KEYS[error.code] : undefined) ?? GIFT_ERROR_KEYS[error.message];
    if (key != null) return t(key);
  }
  return t('gift.errors.failed');
}
