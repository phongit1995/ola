export type GiftCodeRewardType = 'vip_days' | 'vip_icon' | 'avatar_frame';

export interface GiftCodeReward {
  type: GiftCodeRewardType | (string & {});
  days?: number;
  vipIconId?: number;
  frameId?: string;
}

export interface RedeemGiftCodeResult {
  message: string;
  rewards: GiftCodeReward[];
}

export interface GiftCodeAppConfig {
  enabled: boolean;
  requireEmailVerified: boolean;
}
