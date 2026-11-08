export type GiftCodeRewardType = 'vip_days' | 'vip_icon';

export interface GiftCodeReward {
  type: GiftCodeRewardType | (string & {});
  days?: number;
  vipIconId?: number;
}

export interface RedeemGiftCodeResult {
  message: string;
  rewards: GiftCodeReward[];
}

export interface GiftCodeAppConfig {
  enabled: boolean;
  requireEmailVerified: boolean;
}
