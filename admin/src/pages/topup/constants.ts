import type { TopupBankSetting, TopupBonusTierSetting, TopupSetting, TopupTxStatus } from '@/types'
import type { TopupSettingsField, TopupTab } from './types'

export const BONUS_PERCENT_MAX = 500

export const NEW_TIER: TopupBonusTierSetting = { minAmount: 100_000, percent: 10 }

export const DEFAULT_BANK: TopupBankSetting = {
  bankName: '',
  bankBin: '',
  accountNumber: '',
  accountName: '',
  memoTemplate: '@{username}',
  sieuthicodeSecret: '',
  discordWebhookUrl: '',
}

export const DEFAULT_TOPUP: TopupSetting = {
  enabled: true,
  minAmount: 10_000,
  stepAmount: 1_000,
  presetAmounts: [10_000, 20_000, 50_000, 100_000, 200_000, 500_000],
  bonusTiers: [],
}

export const STATUS_META: Record<TopupTxStatus, { label: string; color: string }> = {
  PROCESSING: { label: 'Đang xử lý', color: 'blue' },
  CREDITED: { label: 'Đã cộng', color: 'green' },
  NO_MATCH: { label: 'Sai nội dung', color: 'orange' },
  BELOW_MIN: { label: 'Dưới mức tối thiểu', color: 'orange' },
  SKIPPED_OUT: { label: 'Tiền ra', color: 'default' },
  SKIPPED_DISABLED: { label: 'Đang tắt nạp', color: 'default' },
  FAILED: { label: 'Lỗi', color: 'red' },
}

export const CREDITABLE_STATUSES: TopupTxStatus[] = [
  'PROCESSING',
  'NO_MATCH',
  'BELOW_MIN',
  'SKIPPED_DISABLED',
  'FAILED',
]

export const TOPUP_SETTINGS_TAB_ORDER: TopupTab[] = ['display', 'bank', 'amounts', 'integrations']

export const TOPUP_SETTINGS_TAB_FIELDS: Record<TopupTab, TopupSettingsField[]> = {
  display: ['enabled', 'platforms'],
  bank: ['bankBin', 'accountNumber', 'accountName', 'memoTemplate'],
  amounts: ['minAmount', 'stepAmount', 'presetAmounts', 'bonusTiers'],
  integrations: ['sieuthicodeSecret', 'discordWebhookUrl'],
}

export const TOPUP_SETTINGS_TAB_LABEL: Record<TopupTab, string> = {
  display: 'Hiển thị',
  bank: 'Tài khoản nhận tiền',
  amounts: 'Mệnh giá & thưởng',
  integrations: 'Tích hợp',
}

export const TOPUP_MEMO_PREVIEW_USERNAME = 'minhanh'
