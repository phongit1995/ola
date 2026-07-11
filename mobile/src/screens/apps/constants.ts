import type { ParseKeys } from 'i18next';

export type AppItemAction =
  | 'notifications'
  | 'egg'
  | 'pen'
  | 'wheel'
  | 'profile'
  | 'vip'
  | 'ken'
  | 'media'
  | 'settings';

export interface AppItem {
  icon: number;
  titleKey: ParseKeys;
  action: AppItemAction;
  subtitleKey?: 'home.appGameSubtitle' | 'home.appMallSubtitle';
}

export const APP_ITEMS: AppItem[] = [
  {
    icon: require('../../assets/icons/apps/notify.png'),
    titleKey: 'home.apps.notifications',
    action: 'notifications',
  },
  { icon: require('../../assets/icons/apps/egg.png'), titleKey: 'home.apps.egg', action: 'egg' },
  { icon: require('../../assets/icons/apps/pen.webp'), titleKey: 'home.apps.pen', action: 'pen' },
  {
    icon: require('../../assets/icons/apps/wheel.webp'),
    titleKey: 'home.apps.wheel',
    action: 'wheel',
  },
  {
    icon: require('../../assets/icons/apps/personal.png'),
    titleKey: 'home.apps.profile',
    action: 'profile',
  },
  { icon: require('../../assets/icons/apps/vip.png'), titleKey: 'home.apps.vip', action: 'vip' },
  { icon: require('../../assets/icons/apps/ken.png'), titleKey: 'home.apps.ken', action: 'ken' },
  {
    icon: require('../../assets/icons/apps/media.png'),
    titleKey: 'home.apps.photos',
    action: 'media',
  },
  {
    icon: require('../../assets/icons/apps/setting.png'),
    titleKey: 'home.apps.settings',
    action: 'settings',
  },
];
