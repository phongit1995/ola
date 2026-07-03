export type MessagePrivacy = 'all' | 'friends' | 'nobody';
export type MeVisibility = 'all' | 'friends' | 'private';
export type CommentPrivacy = 'all' | 'friends';
export type FontSize = 'small' | 'medium' | 'large';

export interface UserSettings {
  messagePrivacy: MessagePrivacy;
  meVisibility: MeVisibility;
  commentPrivacy: CommentPrivacy;
  showOnline: boolean;
  showBirthday: boolean;
  notifMessage: boolean;
  notifSound: boolean;
  notifVibrate: boolean;
  fontSize: FontSize;
  wallpaperUrl: string;
}

export type UpdateSettingsRequest = Partial<UserSettings>;

export const DEFAULT_USER_SETTINGS: UserSettings = {
  messagePrivacy: 'all',
  meVisibility: 'all',
  commentPrivacy: 'all',
  showOnline: true,
  showBirthday: true,
  notifMessage: true,
  notifSound: true,
  notifVibrate: true,
  fontSize: 'medium',
  wallpaperUrl: '',
};
