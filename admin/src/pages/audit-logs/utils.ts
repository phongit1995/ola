import type { AdminAuditLog } from '@/types'
import { KEN_ADJUST_ROUTE, RESOURCE_LABELS } from './constants'

export function resourceLabel(resource: string) {
  return RESOURCE_LABELS[resource] ?? resource
}

export function detailBody(log: AdminAuditLog): Record<string, unknown> | undefined {
  const body = log.detail?.body
  return typeof body === 'object' && body != null ? (body as Record<string, unknown>) : undefined
}

export function actionLabel(log: AdminAuditLog): string | undefined {
  const route = log.route ?? ''
  if (route.endsWith(KEN_ADJUST_ROUTE)) {
    const body = detailBody(log)
    const verb = body?.action === 'deduct' ? 'Trừ Ken' : 'Tặng Ken'
    const amount = body?.amount
    return typeof amount === 'number' ? `${verb} (${amount.toLocaleString('vi-VN')})` : verb
  }
  if (route.endsWith('/users/:id/vips')) return 'Tặng VIP'
  if (route.endsWith('/users/:id/username')) return 'Đổi username'
  if (route.endsWith('/users/:id/password')) return 'Reset mật khẩu'
  if (route.endsWith('/users/:id/status')) return 'Đổi trạng thái tài khoản'
  if (log.method === 'DELETE' && route.endsWith('/users/:id')) return 'Xoá người dùng'
  return undefined
}

export function hasDetail(detail?: Record<string, unknown>) {
  return detail != null && Object.keys(detail).length > 0
}
