export interface AvatarFrameShopItem {
  id: string
  frameId: string
  kenPrice: number
  isActive: boolean
  sortOrder: number
  owned: boolean
}

export interface CreateAvatarFrameShopItemsRequest {
  frameIds: string[]
  kenPrice: number
  isActive?: boolean
  sortOrder?: number
}

export interface CreateAvatarFrameShopItemsResult {
  created: AvatarFrameShopItem[]
  skipped: string[]
}

export interface UpdateAvatarFrameShopItemRequest {
  kenPrice?: number
  isActive?: boolean
  sortOrder?: number
}

export type AvatarFramePurchaseSource = 'purchase' | 'gift'

export interface AvatarFrameUserBrief {
  id: string
  username: string
  fullName?: string
}

export interface AdminAvatarFramePurchase {
  id: string
  frameId: string
  kenPrice: number
  source: AvatarFramePurchaseSource
  buyer: AvatarFrameUserBrief
  recipient?: AvatarFrameUserBrief
  createdAt: string
}

export interface AvatarFramePurchaseListParams {
  mode?: AvatarFramePurchaseSource
  search?: string
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface AvatarFramePurchaseTotals {
  count: number
  ken: number
  giftCount: number
  buyers: number
}

export interface AvatarFrameSalesRow {
  frameId: string
  count: number
  giftCount: number
  ken: number
}

export interface AvatarFramePurchaseStatsResult {
  today: AvatarFramePurchaseTotals
  thisMonth: AvatarFramePurchaseTotals
  range: AvatarFramePurchaseTotals
  topFrames: AvatarFrameSalesRow[]
}

export interface AvatarFramePurchaseStatsParams {
  from?: string
  to?: string
}

export interface AdminAvatarFrameTransfer {
  id: string
  frameId: string
  from: AvatarFrameUserBrief
  to: AvatarFrameUserBrief
  createdAt: string
}

export interface AvatarFrameTransferListParams {
  search?: string
  userId?: string
  limit?: number
  offset?: number
}

export type UserAvatarFrameSource = 'purchase' | 'gift' | 'transfer' | 'gift_code' | 'admin'

export interface AdminUserAvatarFrame {
  frameId: string
  source: UserAvatarFrameSource
  acquiredAt: string
  isEquipped: boolean
}

export interface AdminUserAvatarFrameStore {
  userId: string
  equippedFrameId: string | null
  vipActive: boolean
  total: number
  limit: number
  offset: number
  items: AdminUserAvatarFrame[]
}

export interface GrantUserAvatarFrameRequest {
  frameId: string
}
