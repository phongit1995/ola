import type { TFunction } from 'i18next';
import {
  AVATAR_FRAME_SOURCE_GIFT_CODE,
  GIFT_CODE_ERROR_KEYS,
  GIFT_CODE_MAX_LENGTH,
  GIFT_CODE_REWARD_TYPE,
  VIP_ICON_SOURCE_GIFT_CODE,
} from '../constants/giftCode';
import type { OwnedAvatarFrame } from '../types/api/avatarFrame.type';
import type { GiftCodeReward } from '../types/api/giftCode.type';
import type { VipIconInstance } from '../types/api/vip.type';
import { ApiError } from './apiError';
import { vipName } from './vip';

export function normalizeGiftCodeInput(value: string): string {
  return value.replace(/\s+/g, '').toUpperCase().slice(0, GIFT_CODE_MAX_LENGTH);
}

export function giftCodeErrorText(t: TFunction, error: unknown): string {
  if (error instanceof ApiError) {
    const key = error.code != null ? GIFT_CODE_ERROR_KEYS[error.code] : undefined;
    if (key != null) return t(key);
    if (error.status === 429) return t('giftCode.errors.rateLimited');
  }
  return t('giftCode.errors.failed');
}

export function giftCodeRewardText(t: TFunction, reward: GiftCodeReward): string | null {
  if (reward.type === GIFT_CODE_REWARD_TYPE.vipDays && reward.days != null) {
    return t('giftCode.rewardVipDays', { count: reward.days });
  }
  if (reward.type === GIFT_CODE_REWARD_TYPE.vipIcon && reward.vipIconId != null) {
    return t('giftCode.rewardVipIcon', { name: vipName(reward.vipIconId) });
  }
  if (reward.type === GIFT_CODE_REWARD_TYPE.avatarFrame && reward.frameId != null) {
    return t('giftCode.rewardAvatarFrame');
  }
  return null;
}

export function isVipIconTransferable(icon: Pick<VipIconInstance, 'source'>): boolean {
  return icon.source !== VIP_ICON_SOURCE_GIFT_CODE;
}

export function isAvatarFrameTransferable(frame: Pick<OwnedAvatarFrame, 'source'>): boolean {
  return frame.source !== AVATAR_FRAME_SOURCE_GIFT_CODE;
}
