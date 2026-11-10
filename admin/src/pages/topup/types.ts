import type { PlatformRules, TopupBonusTierSetting } from '@/types'

export interface TopupSettingsFormValues {
  enabled: boolean
  platforms: PlatformRules
  bankBin?: string
  accountNumber: string
  accountName?: string
  memoTemplate?: string
  sieuthicodeSecret?: string
  discordWebhookUrl?: string
  minAmount: number
  stepAmount: number
  bonusTiers?: TopupBonusTierSetting[]
  presetAmounts: string[]
}

export type TopupTab = 'display' | 'bank' | 'amounts' | 'integrations'

export type TopupSettingsField = keyof TopupSettingsFormValues
