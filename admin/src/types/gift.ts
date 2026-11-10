import type { GiftAnimationSetting } from '@ola/shared/types'
import type { ListResult, PlatformRules } from './common'

export interface AdminGift {
  id: string
  name: string
  nameEn: string
  imageUrl: string
  kenPrice: number
  charmPoints: number
  isActive: boolean
  sortOrder: number
  animation: GiftAnimationSetting
  senderCharmPercent: number
  announceEnabled: boolean
  createdAt: string
  updatedAt: string
}

export interface CreateGiftRequest {
  name: string
  nameEn?: string
  imageUrl: string
  kenPrice: number
  charmPoints: number
  isActive?: boolean
  sortOrder?: number
  animation?: GiftAnimationSetting
  senderCharmPercent?: number
  announceEnabled?: boolean
}

export type UpdateGiftRequest = Partial<CreateGiftRequest>

export interface AdminGiftUserBrief {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface AdminGiftTransaction {
  id: string
  sender: AdminGiftUserBrief
  receiver: AdminGiftUserBrief
  giftId: string
  giftName: string
  giftImageUrl: string
  quantity: number
  unitPrice: number
  totalKen: number
  charmPoints: number
  senderCharmPoints: number
  source: 'chat' | 'profile'
  note?: string
  createdAt: string
}

export interface GiftTransactionListParams {
  userId?: string
  senderId?: string
  receiverId?: string
  giftId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface GiftTransactionListResult extends ListResult<AdminGiftTransaction> {
  totalKen: number
  totalCharm: number
}

export interface GiftSetting {
  enabled: boolean
  platforms: PlatformRules
  quantityOptions: number[]
  quantityMax: number
  noteMaxLength: number
  confirmOverKen: number
}
