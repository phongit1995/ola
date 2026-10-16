import type { MarriageItem } from '@/types'

export function daysBetween(fromIso: string, toIso?: string) {
  const from = new Date(fromIso).getTime()
  const to = toIso ? new Date(toIso).getTime() : Date.now()
  return Math.max(0, Math.floor((to - from) / 86_400_000))
}

export function divorcedByName(row: MarriageItem) {
  if (!row.divorcedBy) return null
  if (row.divorcedBy === row.userA.id) return row.userA.fullName || row.userA.username
  if (row.divorcedBy === row.userB.id) return row.userB.fullName || row.userB.username
  return row.divorcedBy.slice(0, 8)
}
