import type { VipPurchaseKind, VipPurchaseMode } from '@/types'

export const PACKAGE_PAGE_SIZE = 50

export const PURCHASE_KIND_META: Record<VipPurchaseKind, { label: string; color: string }> = {
  package: { label: 'Gói ngày VIP', color: 'gold' },
  icon: { label: 'Icon VIP', color: 'purple' },
}

export const PURCHASE_MODE_META: Record<VipPurchaseMode, { label: string; color: string }> = {
  self: { label: 'Tự mua', color: 'blue' },
  gift: { label: 'Được tặng', color: 'green' },
}
