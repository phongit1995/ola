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
  | 'social'
  | 'settings'
  | 'remove-account'
  | 'logout';

export interface AppItem {
  icon: number;
  titleKey: ParseKeys;
  action: AppItemAction;
  subtitleKey?: 'home.appGameSubtitle' | 'home.appMallSubtitle';
}

export const GAME_ITEMS: AppItem[] = [
  {
    icon: require('@assets/icons/apps/egg.png'),
    titleKey: 'home.apps.egg',
    action: 'egg',
  },
  {
    icon: require('@assets/icons/apps/pen.webp'),
    titleKey: 'home.apps.pen',
    action: 'pen',
  },
  {
    icon: require('@assets/icons/apps/wheel.webp'),
    titleKey: 'home.apps.wheel',
    action: 'wheel',
  },
];

export const PERSONAL_ITEMS: AppItem[] = [
  {
    icon: require('@assets/icons/apps/notify.png'),
    titleKey: 'home.apps.notifications',
    action: 'notifications',
  },
  {
    icon: require('@assets/icons/apps/personal.png'),
    titleKey: 'home.apps.profile',
    action: 'profile',
  },
  {
    icon: require('@assets/icons/apps/vip-crown.webp'),
    titleKey: 'home.apps.vip',
    action: 'vip',
  },
  {
    icon: require('@assets/icons/apps/ken.png'),
    titleKey: 'home.apps.ken',
    action: 'ken',
  },
  {
    icon: require('@assets/icons/apps/media.png'),
    titleKey: 'home.apps.photos',
    action: 'media',
  },
  {
    icon: require('@assets/icons/social/social-menu-light.png'),
    titleKey: 'home.apps.social',
    action: 'social',
  },
  {
    icon: require('@assets/icons/apps/setting.png'),
    titleKey: 'home.apps.settings',
    action: 'settings',
  },
  {
    icon: require('@assets/icons/apps/delete-account.png'),
    titleKey: 'home.apps.removeAccount',
    action: 'remove-account',
  },
  {
    icon: require('@assets/icons/apps/logout.png'),
    titleKey: 'home.logout',
    action: 'logout',
  },
];
