import type { TFunction } from 'i18next';
import { formatKen, vipName } from '@lib';
import type {
  WheelPlayerOption,
  WheelPlayerSegment,
  WheelSegmentKind,
} from '@app-types';
import {
  rewardKenRandomUrl,
  rewardMissUrl,
  rewardVipDaysUrl,
  rewardVipRandomUrl,
  spinCoinUrl,
} from './spinWheelAssets';

export interface RewardVisual {
  icon: string | null;
  vipTypeId: number | null;
  iconClass: string;
}

export interface GiftOptionVisual {
  text: string;
  vipTypeId: number | null;
  iconUrl: string | null;
}

export function formatRewardKen(amount: number): string {
  if (amount >= 10000) {
    const k = amount / 1000;
    return `${Number.isInteger(k) ? k : k.toFixed(1)}K`;
  }
  return formatKen(amount);
}

export function isKenKind(kind: WheelSegmentKind): boolean {
  return kind === 'ken_fixed' || kind === 'ken_random';
}

export function isVipDaysKind(kind: WheelSegmentKind): boolean {
  return kind === 'vip_days';
}

export function isVipItemKind(kind: WheelSegmentKind): boolean {
  return kind === 'vip_item' || kind === 'vip_random';
}

export function rewardKindIcon(kind: WheelSegmentKind): string {
  switch (kind) {
    case 'ken_fixed':
      return spinCoinUrl;
    case 'ken_random':
      return rewardKenRandomUrl;
    case 'vip_random':
      return rewardVipRandomUrl;
    case 'miss':
      return rewardMissUrl;
    default:
      return rewardVipDaysUrl;
  }
}

function rewardIconClass(kind: WheelSegmentKind): string {
  if (kind === 'ken_fixed') return 'w-[44%]';
  if (kind === 'ken_random') return 'w-[54%]';
  if (kind === 'vip_random') return 'w-[60%]';
  if (kind === 'miss') return 'w-[52%]';
  return 'w-[58%]';
}

export function giftOptionVisual(
  t: TFunction,
  option: WheelPlayerOption
): GiftOptionVisual {
  if (typeof option.vipTypeId === 'number') {
    return {
      text: option.label !== '' ? option.label : vipName(option.vipTypeId),
      vipTypeId: option.vipTypeId,
      iconUrl: null,
    };
  }
  if (typeof option.vipDays === 'number') {
    return {
      text: t('wheelGame.vipDays', { n: option.vipDays }),
      vipTypeId: null,
      iconUrl: rewardVipDaysUrl,
    };
  }
  if (typeof option.kenAmount === 'number') {
    return {
      text: `${formatRewardKen(option.kenAmount)} KEN`,
      vipTypeId: null,
      iconUrl: spinCoinUrl,
    };
  }
  return { text: option.label, vipTypeId: null, iconUrl: rewardVipRandomUrl };
}

export function rewardVisual(segment: WheelPlayerSegment): RewardVisual {
  if (isVipItemKind(segment.kind) && typeof segment.vipTypeId === 'number') {
    return { icon: null, vipTypeId: segment.vipTypeId, iconClass: '' };
  }
  return {
    icon: rewardKindIcon(segment.kind),
    vipTypeId: null,
    iconClass: rewardIconClass(segment.kind),
  };
}
