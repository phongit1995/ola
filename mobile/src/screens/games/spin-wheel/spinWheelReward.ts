import type { ImageSourcePropType } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import type { WheelPlayerSegment, WheelSegmentKind } from '@ola/shared/types';
import { wheelAssets } from './spinWheelAssets';

export interface RewardVisual {
  icon: ImageSourcePropType | null;
  vipTypeId: number | null;
  widthFraction: number;
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

export function rewardKindIcon(kind: WheelSegmentKind): ImageSourcePropType {
  switch (kind) {
    case 'ken_fixed':
      return wheelAssets.spinCoin;
    case 'ken_random':
      return wheelAssets.rewardKenRandom;
    case 'vip_random':
      return wheelAssets.rewardVipRandom;
    case 'miss':
      return wheelAssets.rewardMiss;
    default:
      return wheelAssets.rewardVipDays;
  }
}

function rewardIconWidthFraction(kind: WheelSegmentKind): number {
  if (kind === 'ken_fixed') return 0.44;
  if (kind === 'ken_random') return 0.54;
  if (kind === 'vip_random') return 0.6;
  if (kind === 'miss') return 0.52;
  return 0.58;
}

export function rewardVisual(segment: WheelPlayerSegment): RewardVisual {
  if (isVipItemKind(segment.kind) && typeof segment.vipTypeId === 'number') {
    return { icon: null, vipTypeId: segment.vipTypeId, widthFraction: 0 };
  }
  return {
    icon: rewardKindIcon(segment.kind),
    vipTypeId: null,
    widthFraction: rewardIconWidthFraction(segment.kind),
  };
}
