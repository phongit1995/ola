import type { GiftCodeReward, GiftCodeRewardType } from './giftCode'

export type RewardItemType = GiftCodeRewardType | 'ken'

export interface RewardItem extends Omit<GiftCodeReward, 'type'> {
  type: RewardItemType
  amount?: number
  amountMin?: number
  amountMax?: number
}
