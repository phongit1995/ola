import dayjs from 'dayjs'
import { vipName } from '@/lib/vipCatalog'
import { avatarFrameName } from '@/pages/avatar-frames/utils'
import type { GiftCodeCampaign, GiftCodeCampaignRequest, GiftCodeReward } from '@/types'
import {
  GIFT_CODE_ALPHABET,
  GIFT_CODE_DEFAULT_LENGTH,
  GIFT_CODE_DEFAULT_MESSAGE,
  GIFT_CODE_RANDOM_SHARED_LENGTH,
  GIFT_CODE_REWARD_PLACEHOLDER,
  GIFT_CODE_SAMPLE_SEED,
} from './constants'
import type { GiftCodeFormValues } from './types'

export function normalizeGiftCode(raw: string): string {
  return raw.replace(/\s+/g, '').toUpperCase()
}

export function randomGiftCode(length = GIFT_CODE_RANDOM_SHARED_LENGTH): string {
  const bytes = new Uint32Array(length)
  crypto.getRandomValues(bytes)
  return Array.from(bytes, (n) => GIFT_CODE_ALPHABET[n % GIFT_CODE_ALPHABET.length]).join('')
}

export function sampleGiftCode(prefix: string, length: number): string {
  const body = GIFT_CODE_SAMPLE_SEED.repeat(2).slice(0, length || GIFT_CODE_DEFAULT_LENGTH)
  return normalizeGiftCode(prefix) + body
}

export function rewardsText(rewards: GiftCodeReward[], withIconNames = false): string {
  const days = rewards.reduce((sum, r) => sum + (r.type === 'vip_days' ? r.days ?? 0 : 0), 0)
  const icons = rewards.filter((r) => r.type === 'vip_icon' && r.vipIconId)
  const frames = rewards.filter((r) => r.type === 'avatar_frame' && r.frameId)
  const parts: string[] = []
  if (days > 0) parts.push(`${days} ngày VIP`)
  if (withIconNames) {
    icons.forEach((r) => parts.push(`icon ${vipName(r.vipIconId ?? 0)}`))
  } else if (icons.length === 1) {
    parts.push('icon VIP')
  } else if (icons.length > 1) {
    parts.push(`${icons.length} icon VIP`)
  }
  if (withIconNames) {
    frames.forEach((r) => parts.push(`khung ${avatarFrameName(r.frameId ?? '')}`))
  } else if (frames.length === 1) {
    parts.push('khung avatar')
  } else if (frames.length > 1) {
    parts.push(`${frames.length} khung avatar`)
  }
  return parts.join(' và ')
}

export function successMessagePreview(template: string, rewards: GiftCodeReward[]): string {
  const message = template.trim() || GIFT_CODE_DEFAULT_MESSAGE
  return message.split(GIFT_CODE_REWARD_PLACEHOLDER).join(rewardsText(rewards))
}

function cleanReward(r: GiftCodeFormValues['rewards'][number]): GiftCodeReward[] {
  switch (r.type) {
    case 'vip_days':
      return (r.days ?? 0) > 0 ? [{ type: r.type, days: r.days }] : []
    case 'vip_icon':
      return (r.vipIconId ?? 0) > 0 ? [{ type: r.type, vipIconId: r.vipIconId }] : []
    case 'avatar_frame':
      return r.frameId ? [{ type: r.type, frameId: r.frameId }] : []
    default:
      return []
  }
}

export function cleanRewards(rewards: GiftCodeFormValues['rewards'] | undefined): GiftCodeReward[] {
  return (rewards ?? []).flatMap(cleanReward)
}

export function formToRequest(values: GiftCodeFormValues): GiftCodeCampaignRequest {
  const platforms = new Set(values.platforms ?? [])
  const shared = values.kind === 'shared'
  return {
    name: values.name.trim(),
    kind: values.kind,
    code: shared ? normalizeGiftCode(values.code ?? '') : undefined,
    codePrefix: shared ? undefined : normalizeGiftCode(values.codePrefix ?? ''),
    codeLength: shared ? undefined : values.codeLength,
    totalUses: values.totalUses,
    rewards: cleanRewards(values.rewards),
    successMessage: (values.successMessage ?? '').trim(),
    sendNotification: values.sendNotification,
    minAccountAgeDays: values.minAccountAgeDays ?? 0,
    allowWeb: platforms.has('web'),
    allowAndroid: platforms.has('android'),
    allowIos: platforms.has('ios'),
    onePerDevice: values.onePerDevice,
    startsAt: values.startsAt ? values.startsAt.toISOString() : null,
    endsAt: values.endsAt ? values.endsAt.toISOString() : '',
    enabled: values.enabled,
  }
}

export function campaignToForm(campaign: GiftCodeCampaign, clone = false): GiftCodeFormValues {
  const platforms: GiftCodeFormValues['platforms'] = []
  if (campaign.allowWeb) platforms.push('web')
  if (campaign.allowAndroid) platforms.push('android')
  if (campaign.allowIos) platforms.push('ios')
  return {
    name: clone ? `${campaign.name} (bản sao)` : campaign.name,
    kind: campaign.kind,
    code: clone ? '' : campaign.code ?? '',
    codePrefix: campaign.codePrefix,
    codeLength: campaign.codeLength || GIFT_CODE_DEFAULT_LENGTH,
    totalUses: campaign.totalUses,
    rewards: campaign.rewards.map((r) => ({ type: r.type, days: r.days, vipIconId: r.vipIconId, frameId: r.frameId })),
    successMessage: campaign.successMessage,
    sendNotification: campaign.sendNotification,
    minAccountAgeDays: campaign.minAccountAgeDays,
    platforms,
    onePerDevice: campaign.onePerDevice,
    startsAt: clone || !campaign.startsAt ? null : dayjs(campaign.startsAt),
    endsAt: clone ? null : dayjs(campaign.endsAt),
    enabled: clone ? true : campaign.enabled,
  }
}

export const GIFT_CODE_EMPTY_FORM: GiftCodeFormValues = {
  name: '',
  kind: 'shared',
  code: '',
  codePrefix: '',
  codeLength: GIFT_CODE_DEFAULT_LENGTH,
  totalUses: 100,
  rewards: [{ type: 'vip_days', days: 7 }],
  successMessage: '',
  sendNotification: true,
  minAccountAgeDays: 1,
  platforms: ['web', 'android'],
  onePerDevice: true,
  startsAt: null,
  endsAt: null,
  enabled: true,
}

function csvCell(value: string | number | null | undefined): string {
  const text = value == null ? '' : String(value)
  return /[",\n]/.test(text) ? `"${text.replace(/"/g, '""')}"` : text
}

export function downloadCsv(fileName: string, header: string[], rows: (string | number | null | undefined)[][]) {
  const body = [header, ...rows].map((row) => row.map(csvCell).join(',')).join('\n')
  const blob = new Blob([String.fromCharCode(0xfeff), body], { type: 'text/csv;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const link = document.createElement('a')
  link.href = url
  link.download = fileName
  link.click()
  URL.revokeObjectURL(url)
}

export function csvFileName(name: string, suffix: string): string {
  const slug = name
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/đ/gi, 'd')
    .replace(/[^a-zA-Z0-9]+/g, '-')
    .replace(/^-|-$/g, '')
    .toLowerCase()
  return `${slug || 'gift-code'}-${suffix}-${dayjs().format('YYYYMMDD-HHmm')}.csv`
}
