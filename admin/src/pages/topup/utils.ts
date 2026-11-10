import type { PlatformRules, TopupBankSetting, TopupSetting } from '@/types'
import { platformRulesOrMobile } from '@/lib/platformRules'
import { fillMemoTemplate } from '@ola/shared/lib/vietqr'
import { findBankByBin } from '@/lib/banks'
import { DEFAULT_BANK, TOPUP_MEMO_PREVIEW_USERNAME, TOPUP_SETTINGS_TAB_FIELDS, TOPUP_SETTINGS_TAB_ORDER } from './constants'
import type { TopupSettingsField, TopupSettingsFormValues, TopupTab } from './types'

export function formatThousands(value: number | string | undefined) {
  return `${value ?? ''}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
}

export function parseThousands(value: string | undefined) {
  return Number((value ?? '').replace(/\D/g, ''))
}

export function topupPlatforms(topup: TopupSetting): PlatformRules {
  return platformRulesOrMobile(topup.platforms, topup.enabledMobile)
}

export function parsePresetAmounts(raw: string[]): number[] {
  const amounts = raw
    .map((item) => Number(String(item).replace(/\D/g, '')))
    .filter((value) => Number.isFinite(value) && value > 0)
  return [...new Set(amounts)].sort((a, b) => a - b)
}

export function topupSettingsTabOf(field: unknown): TopupTab {
  return TOPUP_SETTINGS_TAB_ORDER.find((tab) => TOPUP_SETTINGS_TAB_FIELDS[tab].includes(field as TopupSettingsField)) ?? 'display'
}

export function sameSettingValue(a: unknown, b: unknown) {
  return JSON.stringify(a ?? null) === JSON.stringify(b ?? null)
}

export function topupSettingsFormValues(topup: TopupSetting, bank: TopupBankSetting): TopupSettingsFormValues {
  return {
    enabled: topup.enabled,
    platforms: topupPlatforms(topup),
    bankBin: bank.bankBin || undefined,
    accountNumber: bank.accountNumber,
    accountName: bank.accountName,
    memoTemplate: bank.memoTemplate,
    sieuthicodeSecret: bank.sieuthicodeSecret,
    discordWebhookUrl: bank.discordWebhookUrl,
    minAmount: topup.minAmount,
    stepAmount: topup.stepAmount,
    bonusTiers: topup.bonusTiers ?? [],
    presetAmounts: topup.presetAmounts.map(String),
  }
}

export function bankAccountLabel(bin: string | undefined, accountNumber: string) {
  const bankName = bin ? (findBankByBin(bin)?.name ?? bin) : 'chưa chọn ngân hàng'
  return `${accountNumber || '(trống)'} · ${bankName}`
}

export function topupMemoPreview(template: string | undefined) {
  return fillMemoTemplate((template ?? '').trim() || DEFAULT_BANK.memoTemplate, TOPUP_MEMO_PREVIEW_USERNAME)
}
