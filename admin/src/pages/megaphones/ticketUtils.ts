import { formatDateTime } from '@/lib/format'
import type { AdminMegaphoneTicketBrief } from '@/types'
import { MEGAPHONE_TICKET_SOURCE_LABEL } from './constants'

const HOUR_MS = 60 * 60 * 1000
const DAY_MS = 24 * HOUR_MS

export interface TicketTimeLeft {
  text: string
  soon: boolean
}

export function ticketSourceText(ticket: AdminMegaphoneTicketBrief): string {
  const label = MEGAPHONE_TICKET_SOURCE_LABEL[ticket.source] ?? ticket.source
  return ticket.sourceName ? `${label}: ${ticket.sourceName}` : label
}

export function ticketExpiryText(ticket: AdminMegaphoneTicketBrief): string {
  return ticket.expiresAt ? formatDateTime(ticket.expiresAt) : 'Không hạn'
}

export function ticketTimeLeft(expiresAt: string | undefined, now = Date.now()): TicketTimeLeft | null {
  if (!expiresAt) return null
  const ms = new Date(expiresAt).getTime() - now
  if (ms <= 0) return null
  if (ms < HOUR_MS) return { text: 'Còn dưới 1 giờ', soon: true }
  if (ms < DAY_MS) return { text: `Còn ${Math.floor(ms / HOUR_MS)} giờ`, soon: true }
  const days = Math.floor(ms / DAY_MS)
  const hours = Math.floor((ms % DAY_MS) / HOUR_MS)
  return { text: hours > 0 ? `Còn ${days} ngày ${hours} giờ` : `Còn ${days} ngày`, soon: false }
}
