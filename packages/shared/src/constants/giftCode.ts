import type { GiftCodeRewardType } from '../types/api/giftCode.type';
import type { GiftCodeErrorKey } from '../types/lib.type';

export const GIFT_CODE_MAX_LENGTH = 40;

export const GIFT_CODE_REWARD_TYPE = {
  vipDays: 'vip_days',
  vipIcon: 'vip_icon',
} as const satisfies Record<string, GiftCodeRewardType>;

export const VIP_ICON_SOURCE_GIFT_CODE = 'gift_code';

export const GIFT_CODE_EMAIL_NOT_VERIFIED_ERROR = 'GIFT_CODE_EMAIL_NOT_VERIFIED';

export const GIFT_CODE_ERROR_KEYS: Record<string, GiftCodeErrorKey> = {
  GIFT_CODE_INVALID: 'giftCode.errors.invalid',
  GIFT_CODE_NOT_STARTED: 'giftCode.errors.notStarted',
  GIFT_CODE_EXPIRED: 'giftCode.errors.expired',
  GIFT_CODE_SOLD_OUT: 'giftCode.errors.soldOut',
  GIFT_CODE_USED: 'giftCode.errors.used',
  GIFT_CODE_ALREADY_REDEEMED: 'giftCode.errors.alreadyRedeemed',
  GIFT_CODE_DEVICE_REDEEMED: 'giftCode.errors.deviceRedeemed',
  GIFT_CODE_ACCOUNT_TOO_NEW: 'giftCode.errors.accountTooNew',
  GIFT_CODE_PLATFORM_NOT_ALLOWED: 'giftCode.errors.platformNotAllowed',
  GIFT_CODE_TOO_MANY_ATTEMPTS: 'giftCode.errors.tooManyAttempts',
  GIFT_CODE_EMAIL_NOT_VERIFIED: 'giftCode.errors.emailNotVerified',
  GIFT_CODE_DEVICE_UNKNOWN: 'giftCode.errors.deviceUnknown',
  RATE_LIMITED: 'giftCode.errors.rateLimited',
};
