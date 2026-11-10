import type { PlatformRules } from './common'
import type { KenCounterparty } from './ken'

export interface TopupBankSetting {
  bankName: string
  bankBin: string
  accountNumber: string
  accountName: string
  memoTemplate: string
  sieuthicodeSecret: string
  discordWebhookUrl: string
}

export type TopupTxStatus =
  | 'PROCESSING'
  | 'CREDITED'
  | 'NO_MATCH'
  | 'BELOW_MIN'
  | 'SKIPPED_OUT'
  | 'SKIPPED_DISABLED'
  | 'FAILED'

export interface TopupTransaction {
  id: string
  providerTxId: string
  description: string
  amount: number
  type: string
  status: TopupTxStatus
  matchedUsername?: string
  kenAmount: number
  bonusKen: number
  bonusPercent: number
  kenTxId?: string
  note?: string
  user?: KenCounterparty
  createdAt: string
  updatedAt: string
}

export interface TopupTransactionListParams {
  status?: string
  type?: string
  search?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface TopupStatsTotals {
  count: number
  amount: number
  ken: number
}

export interface TopupStatsSeriesItem {
  date: string
  amount: number
  ken: number
  count: number
}

export interface TopupStatsResult {
  bucket: 'day' | 'month'
  today: TopupStatsTotals
  thisMonth: TopupStatsTotals
  range: TopupStatsTotals
  pending: TopupStatsTotals
  series: TopupStatsSeriesItem[]
}

export interface TopupStatsParams {
  from?: string
  to?: string
}

export interface TopupManualCreditResult {
  id: string
  status: string
  kenAmount: number
  bonusKen: number
  bonusPercent: number
  balanceAfter: number
  user: KenCounterparty
}

export interface TopupBonusTierSetting {
  minAmount: number
  percent: number
}

export interface TopupSetting {
  enabled: boolean
  enabledMobile?: boolean
  platforms?: PlatformRules
  minAmount: number
  stepAmount: number
  presetAmounts: number[]
  bonusTiers: TopupBonusTierSetting[]
}
