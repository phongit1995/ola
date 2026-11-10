import type { PlatformRule, VipDayTransferSetting, VipPurchaseKind, VipPurchaseMode } from '@/types'

export const VIP_DAY_TRANSFER_SETTING_KEY = 'vip_day_transfer'
export const VIP_DAY_TRANSFER_RATE_MAX = 1000
export const VIP_DAY_TRANSFER_MIN_DAYS_MAX = 36500

const HIDDEN_PLATFORM: PlatformRule = { enabled: false, disableVersions: [] }

export const DEFAULT_VIP_DAY_TRANSFER_SETTING: VipDayTransferSetting = {
  platforms: { web: HIDDEN_PLATFORM, android: HIDDEN_PLATFORM, ios: HIDDEN_PLATFORM },
  rate: 3,
  minSenderDays: 10,
}

export const VIP_DAY_TRANSFER_SOURCE_META: Record<string, { label: string; color: string }> = {
  day_transfer_out: { label: 'Chuyển đi', color: 'volcano' },
  day_transfer_in: { label: 'Nhận', color: 'green' },
}

export const PURCHASE_KIND_META: Record<VipPurchaseKind, { label: string; color: string }> = {
  package: { label: 'Gói ngày VIP', color: 'gold' },
  icon: { label: 'Icon VIP', color: 'purple' },
}

export const PURCHASE_MODE_META: Record<VipPurchaseMode, { label: string; color: string }> = {
  self: { label: 'Tự mua', color: 'blue' },
  gift: { label: 'Được tặng', color: 'green' },
}
