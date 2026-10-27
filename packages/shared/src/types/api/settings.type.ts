import type { ChatBotType } from '../client/chatBot.type';

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

export interface TopupBonusTier {
  minAmount: number;
  percent: number;
}

export interface TopupConfigResult {
  enabled: boolean;
  enabledMobile?: boolean;
  minAmount: number;
  stepAmount: number;
  presetAmounts: number[];
  bonusTiers?: TopupBonusTier[];
  bank?: TopupBankInfo;
}

export interface UsernameChangeTier {
  minLength: number;
  cost: number;
}

export interface ChatBotConfigResult {
  dailyLimit: number;
  bots: { type: ChatBotType; enabled: boolean }[];
}

export interface WordChainConfigResult {
  enabled: boolean;
  hintPrice: number;
  guessPrice: number;
  vipRequiredToView: boolean;
  vipRequiredToPlay: boolean;
}

export interface StoryConfigResult {
  enabled: boolean;
}

export interface MomentConfigResult {
  enabled: boolean;
  videoVipRequired?: boolean;
}

export interface UsernameChangeConfigResult {
  enabled: boolean;
  enabledMobile?: boolean;
  tiers: UsernameChangeTier[];
}

export interface AppConfigs {
  topup: TopupConfigResult;
  usernameChange: UsernameChangeConfigResult;
  wordChain: WordChainConfigResult;
  story: StoryConfigResult;
  chatBot: ChatBotConfigResult;
  moment: MomentConfigResult;
}

export interface AppConfigResult {
  version: string;
  notModified?: boolean;
  configs?: Partial<AppConfigs>;
}
