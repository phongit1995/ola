import type { AdminUserVipIcon } from '@/types'
import { KEN_TX_TYPE, VIP_ICON_SOURCE_LABEL } from './constants'

export function kenTypeLabel(type: string): string {
  return KEN_TX_TYPE[type] ?? type
}

export function vipDaysLeft(vipEndTime?: string): number | null {
  if (!vipEndTime) return null
  const end = new Date(vipEndTime).getTime()
  if (Number.isNaN(end)) return null
  const diff = end - Date.now()
  return diff <= 0 ? 0 : Math.ceil(diff / 86_400_000)
}

export function vipIconSourceLabel(source?: string): string {
  if (!source) return ''
  return VIP_ICON_SOURCE_LABEL[source] ?? source
}

export function deleteWarning(item: AdminUserVipIcon): string {
  const notes: string[] = []
  if (item.isUsing) notes.push('user đang đeo icon này, xoá xong sẽ thành chưa dùng VIP')
  if (item.isLocked) notes.push('user đã khoá icon này')
  if (item.source === 'purchase' || item.source === 'icon') {
    notes.push('icon này do user bỏ Ken ra mua, hệ thống không hoàn Ken')
  }
  if (notes.length === 0) return 'Thao tác này không thể hoàn tác từ trang quản trị.'
  return `Lưu ý: ${notes.join('; ')}.`
}
