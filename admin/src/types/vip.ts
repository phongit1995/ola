import type { PlatformRules } from './common'

export interface VipPurchaseHistory {
  id: string
  packageName: string
  days: number
  kenPrice: number
  kenBalanceAfter: number
  vipEndTime: string
  source: string
  createdAt: string
}

export interface VipPackage {
  id: string
  name: string
  days: number
  kenPrice: number
  isActive: boolean
  sortOrder: number
}

export interface CreateVipPackageRequest {
  name: string
  days: number
  kenPrice: number
  isActive?: boolean
  sortOrder?: number
}

export interface UpdateVipPackageRequest {
  name?: string
  days?: number
  kenPrice?: number
  isActive?: boolean
  sortOrder?: number
}

export interface VipShopItem {
  id: string
  vipTypeId: number
  kenPrice: number
  isActive: boolean
  sortOrder: number
}

export interface CreateVipShopItemRequest {
  vipTypeId: number
  kenPrice: number
  isActive?: boolean
  sortOrder?: number
}

export interface UpdateVipShopItemRequest {
  kenPrice?: number
  isActive?: boolean
  sortOrder?: number
}

export interface AdminVipTransfer {
  id: string
  fromUserId: string
  fromUsername: string
  fromFullName: string
  toUserId: string
  toUsername: string
  toFullName: string
  vipIconId: number
  createdAt: string
}

export interface VipTransferListParams {
  q?: string
  userId?: string
  limit?: number
  offset?: number
}

export type VipPurchaseKind = 'package' | 'icon'

export type VipPurchaseMode = 'self' | 'gift'

export interface VipPurchaseUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface AdminVipPurchase {
  id: string
  kind: VipPurchaseKind
  source: string
  name: string
  vipIconId?: number
  days: number
  kenPaid: number
  vipEndTime?: string
  user?: VipPurchaseUser
  giver?: VipPurchaseUser
  createdAt: string
}

export interface VipPurchaseListParams {
  kind?: VipPurchaseKind
  mode?: VipPurchaseMode
  search?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface VipPurchaseTotals {
  count: number
  ken: number
  packageCount: number
  packageKen: number
  iconCount: number
  iconKen: number
  giftCount: number
  buyers: number
}

export interface VipPurchaseSeriesItem {
  date: string
  packageKen: number
  iconKen: number
  count: number
}

export interface VipPurchaseBreakdownItem {
  kind: VipPurchaseKind
  name: string
  vipIconId?: number
  count: number
  giftCount: number
  ken: number
}

export interface VipPurchaseStatsResult {
  bucket: 'day' | 'month'
  today: VipPurchaseTotals
  thisMonth: VipPurchaseTotals
  range: VipPurchaseTotals
  activeVipUsers: number
  series: VipPurchaseSeriesItem[]
  breakdown: VipPurchaseBreakdownItem[]
}

export interface VipPurchaseStatsParams {
  from?: string
  to?: string
}

export interface VipDayTransferSetting {
  platforms: PlatformRules
  rate: number
  minSenderDays: number
}

export interface AdminVipDayTransfer {
  id: string
  source: string
  name: string
  days: number
  vipEndTime: string
  user?: VipPurchaseUser
  createdAt: string
}

export interface VipDayTransferListParams {
  search?: string
  limit: number
  offset: number
}

export interface VipDayTransferListResult {
  total: number
  limit: number
  offset: number
  items: AdminVipDayTransfer[]
}
