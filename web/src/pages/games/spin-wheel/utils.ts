import type { CSSProperties } from 'react';
import type { TFunction } from 'i18next';
import {
  formatRewardKen,
  isVipItemKind,
  vipName,
  WHEEL_LABEL_RADIUS,
  wheelPolar,
} from '@lib';
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
import { WHEEL_SEGMENT_KIND } from '@constants';

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

export function rewardKindIcon(kind: WheelSegmentKind): string {
  switch (kind) {
    case WHEEL_SEGMENT_KIND.kenFixed:
      return spinCoinUrl;
    case WHEEL_SEGMENT_KIND.kenRandom:
      return rewardKenRandomUrl;
    case WHEEL_SEGMENT_KIND.vipRandom:
      return rewardVipRandomUrl;
    case WHEEL_SEGMENT_KIND.miss:
      return rewardMissUrl;
    default:
      return rewardVipDaysUrl;
  }
}

function rewardIconClass(kind: WheelSegmentKind): string {
  if (kind === WHEEL_SEGMENT_KIND.kenFixed) return 'w-[44%]';
  if (kind === WHEEL_SEGMENT_KIND.kenRandom) return 'w-[54%]';
  if (kind === WHEEL_SEGMENT_KIND.vipRandom) return 'w-[60%]';
  if (kind === WHEEL_SEGMENT_KIND.miss) return 'w-[52%]';
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

export function labelStyle(index: number, angle: number): CSSProperties {
  const point = wheelPolar(index * angle, WHEEL_LABEL_RADIUS);
  return {
    left: `${point.x}%`,
    top: `${point.y}%`,
    transform: 'translate(-50%, -50%)',
  };
}
