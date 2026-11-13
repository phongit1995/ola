import type { WheelSegmentKind } from '../types/api/wheel.type';

export const WHEEL_SEGMENT_KIND = {
  miss: 'miss',
  kenFixed: 'ken_fixed',
  kenRandom: 'ken_random',
  vipDays: 'vip_days',
  vipItem: 'vip_item',
  vipRandom: 'vip_random',
} as const satisfies Record<string, WheelSegmentKind>;
