import type { ImageSourcePropType } from 'react-native';

export type DailyCheckinImageKind =
  | 'menu'
  | 'task'
  | 'box'
  | 'boxBig'
  | 'boxMissed'
  | 'boxOpened'
  | 'boxBigOpened'
  | 'vipBadge'
  | 'vipDays'
  | 'ken';

export const DAILY_CHECKIN_IMAGES: Record<DailyCheckinImageKind, ImageSourcePropType> = {
  menu: require('@shared-assets/daily-checkin/menu.webp'),
  task: require('@shared-assets/daily-checkin/task.webp'),
  box: require('@shared-assets/daily-checkin/box.webp'),
  boxBig: require('@shared-assets/daily-checkin/box-big.webp'),
  boxMissed: require('@shared-assets/daily-checkin/box-missed.webp'),
  boxOpened: require('@shared-assets/daily-checkin/box-opened.webp'),
  boxBigOpened: require('@shared-assets/daily-checkin/box-big-opened.webp'),
  vipBadge: require('@assets/icons/apps/vip-crown.webp'),
  vipDays: require('@assets/icons/apps/vip-crown.webp'),
  ken: require('@assets/icons/apps/ken.png'),
};
