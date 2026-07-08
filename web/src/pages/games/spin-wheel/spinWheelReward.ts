import type { WheelSegmentKind } from '@app-types';
import { rewardMissUrl, rewardVipDaysUrl, spinCoinUrl } from './spinWheelAssets';

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
  if (isKenKind(kind)) return spinCoinUrl;
  if (kind === 'miss') return rewardMissUrl;
  return rewardVipDaysUrl;
}
