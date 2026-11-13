import type { TFunction } from 'i18next';
import type { ImageSourcePropType } from 'react-native';
import { vipName, formatRewardKen, isVipItemKind } from '@ola/shared/lib';
import type {
  WheelPlayerOption,
  WheelPlayerSegment,
  WheelSegmentKind,
} from '@ola/shared/types';
import { wheelAssets } from './spinWheelAssets';
import { WHEEL_SEGMENT_KIND } from '@ola/shared/constants';

export interface RewardVisual {
  icon: ImageSourcePropType | null;
  vipTypeId: number | null;
  widthFraction: number;
}

export interface GiftOptionVisual {
  text: string;
  vipTypeId: number | null;
  icon: ImageSourcePropType | null;
}

export function rewardKindIcon(kind: WheelSegmentKind): ImageSourcePropType {
  switch (kind) {
    case WHEEL_SEGMENT_KIND.kenFixed:
      return wheelAssets.spinCoin;
    case WHEEL_SEGMENT_KIND.kenRandom:
      return wheelAssets.rewardKenRandom;
    case WHEEL_SEGMENT_KIND.vipRandom:
      return wheelAssets.rewardVipRandom;
    case WHEEL_SEGMENT_KIND.miss:
      return wheelAssets.rewardMiss;
    default:
      return wheelAssets.rewardVipDays;
  }
}

function rewardIconWidthFraction(kind: WheelSegmentKind): number {
  if (kind === WHEEL_SEGMENT_KIND.kenFixed) return 0.44;
  if (kind === WHEEL_SEGMENT_KIND.kenRandom) return 0.54;
  if (kind === WHEEL_SEGMENT_KIND.vipRandom) return 0.6;
  if (kind === WHEEL_SEGMENT_KIND.miss) return 0.52;
  return 0.58;
}

export function giftOptionVisual(t: TFunction, option: WheelPlayerOption): GiftOptionVisual {
  if (typeof option.vipTypeId === 'number') {
    return {
      text: option.label !== '' ? option.label : vipName(option.vipTypeId),
      vipTypeId: option.vipTypeId,
      icon: null,
    };
  }
  if (typeof option.vipDays === 'number') {
    return {
      text: t('wheelGame.vipDays', { n: option.vipDays }),
      vipTypeId: null,
      icon: wheelAssets.rewardVipDays,
    };
  }
  if (typeof option.kenAmount === 'number') {
    return {
      text: `${formatRewardKen(option.kenAmount)} KEN`,
      vipTypeId: null,
      icon: wheelAssets.spinCoin,
    };
  }
  return { text: option.label, vipTypeId: null, icon: wheelAssets.rewardVipRandom };
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
