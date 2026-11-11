import { formatDateTime } from '@/lib/format'
import type {
  AdminAvatarFramePurchase,
  AdminAvatarFrameTransfer,
  AdminUserAvatarFrame,
  AdminUserVipIcon,
  ModerationLockStep,
  ReportAdminBrief,
  UserViolation,
} from '@/types'
import { KEN_TX_TYPE, LOCK_REASON_VIOLATIONS, VIP_ICON_SOURCE_LABEL } from './constants'
import type {
  UserFramePurchaseRole,
  UserFrameTransferDirection,
  UserLockFields,
  ViolationState,
} from './types'

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

export function isViolationLock(user: UserLockFields): boolean {
  return !user.isActive && user.lockReason === LOCK_REASON_VIOLATIONS
}

export function violationLockPeriod(lockedUntil?: string): string {
  if (!lockedUntil) return 'vĩnh viễn'
  const expired = new Date(lockedUntil).getTime() <= Date.now()
  const until = `đến ${formatDateTime(lockedUntil)}`
  return expired ? `${until} (đã hết hạn, mở khi đăng nhập lại)` : until
}

export function violationState(item: UserViolation, expireHours: number): ViolationState {
  if (item.revokedAt) return 'revoked'
  if (expireHours <= 0) return 'active'
  const expiresAt = new Date(item.createdAt).getTime() + expireHours * 3_600_000
  return expiresAt <= Date.now() ? 'expired' : 'active'
}

export function adminName(admin?: ReportAdminBrief): string {
  if (!admin) return '—'
  return admin.fullName || admin.username
}

export function unlockWarning(points: number, lockSteps: readonly ModerationLockStep[]): string {
  if (points === 0) return 'Tài khoản đăng nhập lại được ngay.'
  const reached = lockSteps.length > 0 && points >= lockSteps[0].points
  const next = reached
    ? 'lần bị cộng điểm tiếp theo sẽ khoá lại ngay'
    : 'bị cộng thêm điểm tới mốc khoá thì sẽ khoá lại'
  return `Tài khoản đăng nhập lại được ngay nhưng vẫn giữ ${points} điểm vi phạm, ${next}. Muốn bắt đầu lại từ 0 thì bấm thêm Xoá sạch điểm.`
}

export function clearViolationsWarning(points: number, locked: boolean): string {
  const base = `Gỡ toàn bộ vi phạm đang tính điểm (${points} điểm), điểm về 0. Lịch sử vẫn giữ, các dòng chuyển sang "Đã gỡ".`
  return locked ? `${base} Tài khoản vẫn bị khoá, bấm Mở khoá tài khoản nếu muốn mở.` : base
}

export function userFramePurchaseRole(item: AdminAvatarFramePurchase, userId: string): UserFramePurchaseRole {
  if (item.source !== 'gift' || !item.recipient) return 'self'
  return item.recipient.id === userId ? 'received' : 'sent'
}

export function userFrameTransferDirection(item: AdminAvatarFrameTransfer, userId: string): UserFrameTransferDirection {
  return item.to.id === userId ? 'in' : 'out'
}

export function revokeAvatarFrameNotes(item: AdminUserAvatarFrame): string[] {
  const notes: string[] = []
  if (item.isEquipped) notes.push('User đang đeo khung này, khung sẽ bị gỡ khỏi avatar.')
  if (item.source === 'purchase' || item.source === 'gift') notes.push('Khung được mua bằng KEN, thu hồi không hoàn KEN.')
  return notes
}
