import type { UserSettings } from '../types/api/settings.type';

export const DEFAULT_USER_SETTINGS: UserSettings = {
  messagePrivacy: 'all',
  meVisibility: 'all',
  commentPrivacy: 'all',
  showBirthday: true,
  showInterested: true,
  notifMessage: true,
  notifSound: true,
  soundGame: true,
  soundKen: true,
  fontSize: 'medium',
  wallpaperUrl: '',
  giftWallPrivacy: 0,
  avatarFrameStorePrivacy: 0,
};

export const VIP_PRIVACY_KEYS = ['privacyPublic', 'privacyFriends', 'privacyPrivate'] as const;

export const VIP_PRIVACY_DISPLAY = ['privacyPrivate', 'privacyFriends', 'privacyPublic'] as const;
