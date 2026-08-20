export type MessagePrivacy = 'all' | 'friends';
export type MeVisibility = 'all' | 'friends';
export type CommentPrivacy = 'all' | 'friends';
export type FontSize = 'small' | 'medium' | 'large';

export interface UserSettings {
  messagePrivacy: MessagePrivacy;
  meVisibility: MeVisibility;
  commentPrivacy: CommentPrivacy;
  showBirthday: boolean;
  showInterested: boolean;
  notifMessage: boolean;
  notifSound: boolean;
  soundGame: boolean;
  soundKen: boolean;
  fontSize: FontSize;
  wallpaperUrl: string;
}

export type UpdateSettingsRequest = Partial<UserSettings>;

export interface TopupBankInfo {
  bankName: string;
  bankBin: string;
  accountNumber: string;
  accountName: string;
  memoTemplate: string;
}

export interface TopupConfigResult {
  enabled: boolean;
  minAmount: number;
  stepAmount: number;
  presetAmounts: number[];
  kenPerVnd: number;
  bank?: TopupBankInfo;
}

export interface UsernameChangeTier {
  minLength: number;
  cost: number;
}

export interface UsernameChangeConfigResult {
  enabled: boolean;
  tiers: UsernameChangeTier[];
}
