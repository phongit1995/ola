import dayjs, { type Dayjs } from 'dayjs'
import utc from 'dayjs/plugin/utc'
import type { CheckinBox, CheckinGift, CheckinGiftOption, CheckinMonth, CheckinRewardItem, CheckinSlot } from '@/types'
import {
  CHECKIN_MIN_WEIGHT,
  CHECKIN_TASK_META,
  CHECKIN_MONTH_FORMAT,
  CHECKIN_TOTAL_WEIGHT,
  CHECKIN_UPCOMING_MONTHS,
  CHECKIN_VN_UTC_OFFSET_MINUTES,
} from './constants'
import type {
  CheckinItemFormValue,
  CheckinMonthOption,
  CheckinMonthStatus,
  CheckinGiftFormValue,
  CheckinOptionFormValue,
  CheckinSlotFormValues,
} from './types'

dayjs.extend(utc)

export function vnNow(): Dayjs {
  return dayjs().utcOffset(CHECKIN_VN_UTC_OFFSET_MINUTES)
}

export function vnTime(value: string): Dayjs {
  return dayjs(value).utcOffset(CHECKIN_VN_UTC_OFFSET_MINUTES)
}

const TASK_META_BY_CODE: Partial<Record<string, { label: string; costsKen: boolean }>> = CHECKIN_TASK_META

export function checkinTaskLabel(code: string): string {
  return TASK_META_BY_CODE[code]?.label ?? code
}

export function checkinTaskCostsKen(code: string): boolean {
  return TASK_META_BY_CODE[code]?.costsKen ?? false
}

export function monthKey(date: Dayjs): string {
  return date.format(CHECKIN_MONTH_FORMAT)
}

export function monthStart(month: string): Dayjs {
  return dayjs(`${month}-01`)
}

export function monthLabel(month: string): string {
  const start = monthStart(month)
  return `Tháng ${start.month() + 1}/${start.year()}`
}

export function monthShortLabel(month: string): string {
  return `tháng ${monthStart(month).month() + 1}`
}

export function daysInMonth(month: string): number {
  return monthStart(month).daysInMonth()
}

function monthStatus(month: string, item: CheckinMonth | undefined, today: Dayjs): CheckinMonthStatus {
  if (!item) return 'missing'
  const current = monthKey(today)
  if (month < current) return 'past'
  if (!item.publishedAt) return 'draft'
  if (month === current) return 'running'
  return 'upcoming'
}

export function buildMonthOptions(months: CheckinMonth[], today: Dayjs): CheckinMonthOption[] {
  const byMonth = new Map(months.map((item) => [item.month, item]))
  const previous = monthKey(today.subtract(1, 'month'))
  const keys = new Set<string>([monthKey(today)])
  for (let i = 1; i <= CHECKIN_UPCOMING_MONTHS; i++) keys.add(monthKey(today.add(i, 'month')))
  if (byMonth.has(previous)) keys.add(previous)
  months.forEach((item) => {
    if (item.month > previous) keys.add(item.month)
  })
  return [...keys].sort().map((month) => ({ month, status: monthStatus(month, byMonth.get(month), today) }))
}

export function slotBox(slot: CheckinSlot): CheckinBox {
  if (slot.gifts.length === 0) return 'none'
  return slot.featured ? 'big' : 'normal'
}

export function optionsTotal(options: { weight?: number }[] | undefined): number {
  return (options ?? []).reduce((sum, option) => sum + (option.weight ?? 0), 0)
}

function largestIndex(weights: number[], skip: number): number {
  return weights.reduce((best, weight, index) => (index !== skip && (best < 0 || weight > weights[best]) ? index : best), -1)
}

export function rebalanceOptions<T extends { weight?: number }>(options: T[], index: number, target: number): T[] {
  if (options.length === 0) return options
  if (options.length === 1) return [{ ...options[0], weight: CHECKIN_TOTAL_WEIGHT }]
  const weights = options.map((option) => Math.max(CHECKIN_MIN_WEIGHT, Math.round(option.weight ?? CHECKIN_MIN_WEIGHT)))
  const maxTarget = CHECKIN_TOTAL_WEIGHT - (options.length - 1) * CHECKIN_MIN_WEIGHT
  weights[index] = Math.min(Math.max(Math.round(target), CHECKIN_MIN_WEIGHT), maxTarget)
  const order = weights.map((_, i) => i).filter((i) => i !== index).sort((a, b) => weights[b] - weights[a])
  let excess = weights.reduce((sum, weight) => sum + weight, 0) - CHECKIN_TOTAL_WEIGHT
  for (const i of order) {
    if (excess <= 0) break
    const take = Math.min(weights[i] - CHECKIN_MIN_WEIGHT, excess)
    weights[i] -= take
    excess -= take
  }
  if (excess < 0) weights[largestIndex(weights, index)] -= excess
  return options.map((option, i) => ({ ...option, weight: weights[i] }))
}

export function fillOptionsTotal<T extends { weight?: number }>(options: T[]): T[] {
  if (options.length === 0) return options
  const missing = CHECKIN_TOTAL_WEIGHT - optionsTotal(options)
  if (missing <= 0) return options
  const target = largestIndex(options.map((option) => option.weight ?? 0), -1)
  return options.map((option, i) => (i === target ? { ...option, weight: (option.weight ?? 0) + missing } : option))
}

export function lockedThroughSlot(detail: CheckinMonth, today: Dayjs): number {
  const current = monthKey(today)
  if (detail.month < current) return detail.slotCount
  if (detail.month > current || !detail.publishedAt) return 0
  const published = vnTime(detail.publishedAt)
  const firstDay = monthKey(published) === current ? published.date() : 1
  return Math.min(Math.max(today.date() - firstDay + 1, 0), detail.slotCount)
}

export function swapSlots(slots: CheckinSlot[], from: number, to: number): CheckinSlot[] {
  const source = slots[from - 1]
  const target = slots[to - 1]
  return [
    { ...structuredClone(target), slot: from },
    { ...structuredClone(source), slot: to },
  ]
}

function itemToForm(item: CheckinRewardItem): CheckinItemFormValue {
  return { ...item, expiresInDays: item.expiresInDays ?? null, kenRandom: (item.amountMax ?? 0) > 0 }
}

export function slotToForm(slot: CheckinSlot): CheckinSlotFormValues {
  return {
    enabled: slot.gifts.length > 0,
    gifts: slot.gifts.map((gift) => ({ options: gift.options.map((option) => ({ ...itemToForm(option), weight: option.weight })) })),
    featured: slot.featured,
    requireVip: slot.requireVip,
    task: slot.task,
  }
}

function expiry(item: CheckinItemFormValue): Pick<CheckinRewardItem, 'expiresInDays'> {
  return (item.expiresInDays ?? 0) > 0 ? { expiresInDays: item.expiresInDays ?? undefined } : {}
}

function cleanItem(item: CheckinItemFormValue): CheckinRewardItem[] {
  switch (item.type) {
    case 'vip_days':
      return (item.days ?? 0) > 0 ? [{ type: item.type, days: item.days }] : []
    case 'vip_icon':
      return [{ type: item.type, ...((item.vipIconId ?? 0) > 0 ? { vipIconId: item.vipIconId } : {}), ...expiry(item) }]
    case 'avatar_frame':
      return [{ type: item.type, ...(item.frameId ? { frameId: item.frameId } : {}), ...expiry(item) }]
    case 'megaphone_ticket':
      return (item.count ?? 0) > 0 ? [{ type: item.type, count: item.count, ...expiry(item) }] : []
    case 'ken':
      if (item.kenRandom) {
        return (item.amountMax ?? 0) > 0 ? [{ type: item.type, amountMin: item.amountMin ?? 0, amountMax: item.amountMax }] : []
      }
      return (item.amount ?? 0) > 0 ? [{ type: item.type, amount: item.amount }] : []
    default:
      return []
  }
}

function cleanOption(option: CheckinOptionFormValue): CheckinGiftOption[] {
  return cleanItem(option).map((item) => ({ ...item, weight: option.weight ?? 0 }))
}

function cleanGift(gift: CheckinGiftFormValue): CheckinGift[] {
  const options = (gift.options ?? []).flatMap(cleanOption)
  return options.length > 0 ? [{ options }] : []
}

export function formToSlot(slot: number, values: CheckinSlotFormValues, updatedAt?: string): CheckinSlot {
  const gifts = values.enabled ? (values.gifts ?? []).flatMap(cleanGift) : []
  if (gifts.length === 0) return { slot, gifts, featured: false, requireVip: false, task: null, updatedAt }
  return { slot, gifts, featured: values.featured, requireVip: values.requireVip, task: values.task, updatedAt }
}
