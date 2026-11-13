import type { TFunction } from 'i18next';
import type { EggCategoryKind, EggGiftReward } from '../types/api/egg.type';
import { EGG_CATEGORY_KIND } from '../constants/egg';
import { formatKen } from './number';
import { vipName } from './vip';

export function eggRewardText(t: TFunction, type: EggCategoryKind, reward: EggGiftReward): string {
  if (type === EGG_CATEGORY_KIND.vipIcon && reward.vipTypeId != null) return vipName(reward.vipTypeId);
  if (reward.label) return reward.label;
  if (type === EGG_CATEGORY_KIND.ken && reward.kenAmount) return `${formatKen(reward.kenAmount)} Ken`;
  if (type === EGG_CATEGORY_KIND.vipDays && reward.vipDays) {
    return t('eggGame.gifts.vipDaysLabel', { days: reward.vipDays });
  }
  return '';
}
