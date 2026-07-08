import { formatKen } from '@lib';
import type { WheelSegmentKind } from '@app-types';
import {
  rewardKenRandomUrl,
  rewardMissUrl,
  rewardVipDaysUrl,
  rewardVipRandomUrl,
  spinCoinUrl,
} from './spinWheelAssets';

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
