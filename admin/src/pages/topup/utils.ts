import type { PlatformRules, TopupSetting } from '@/types'
import { platformRulesOrMobile } from '@/lib/platformRules'

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
