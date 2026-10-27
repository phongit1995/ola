const dateTimeFormatter = new Intl.DateTimeFormat('vi-VN', {
  day: '2-digit',
  month: '2-digit',
  year: 'numeric',
  hour: '2-digit',
  minute: '2-digit',
})

const dateFormatter = new Intl.DateTimeFormat('vi-VN', {
  day: '2-digit',
  month: '2-digit',
  year: 'numeric',
})

export function formatDate(value?: string | null): string {
  if (!value) return '—'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return '—'
  return dateFormatter.format(date)
}

export function formatDateTime(value?: string | null): string {
  if (!value) return '—'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return '—'
  return dateTimeFormatter.format(date)
}

export function formatCount(value: number): string {
  return value.toLocaleString('vi-VN')
}

export function formatDuration(ms: number): string {
  if (ms < 1000) return '< 1 giây'
  const seconds = Math.round(ms / 1000)
  if (seconds < 60) return `${seconds} giây`
  const minutes = Math.floor(seconds / 60)
  const rest = seconds % 60
  return rest === 0 ? `${minutes} phút` : `${minutes} phút ${rest} giây`
}

const BYTE_UNITS = ['B', 'KB', 'MB', 'GB', 'TB']

export function formatBytes(bytes: number): string {
  let value = bytes
  let unit = 0
  while (value >= 1024 && unit < BYTE_UNITS.length - 1) {
    value /= 1024
    unit += 1
  }
  return `${value.toLocaleString('vi-VN', { maximumFractionDigits: unit === 0 ? 0 : 1 })} ${BYTE_UNITS[unit]}`
}

export function formatKen(value: number): string {
  return `${formatCount(value)} KEN`
}

export const kenNumberInputProps = {
  formatter: (value?: string | number) =>
    value === undefined || value === '' ? '' : `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, '.'),
  parser: (value?: string) =>
    (value ? Number(value.replace(/\./g, '')) : undefined) as unknown as number,
}
