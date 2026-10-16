import dayjs from 'dayjs'

export function isoDaysAgo(days: number): string {
  return dayjs().subtract(days, 'day').format('YYYY-MM-DD')
}

export function toIsoRange(from: string, to: string): { from?: string; to?: string } {
  return {
    from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
    to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
  }
}
