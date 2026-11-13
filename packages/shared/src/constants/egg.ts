import type { EggCategoryKind } from '../types/api/egg.type';

export const EGG_CATEGORY_KIND = {
  nothing: 'nothing',
  vipIcon: 'vip_icon',
  ken: 'ken',
  vipDays: 'vip_days',
} as const satisfies Record<string, EggCategoryKind>;
