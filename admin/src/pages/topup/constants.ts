import type { TopupBankSetting, TopupBonusTierSetting, TopupSetting, TopupTxStatus } from '@/types'

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
