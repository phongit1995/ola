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
};
