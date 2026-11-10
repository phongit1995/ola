import type { ReportReason, ReportTargetType } from '@ola/shared/types'
import type { PenaltySeverity, ReportAdminBrief } from './report'

export interface UsernameChangeItem {
  id: string
  user: { id: string; username: string; fullName?: string; avatar?: string }
  oldUsername: string
  newUsername: string
  cost: number
  actorType: 'user' | 'admin'
  actorId?: string
  actorUsername?: string
  actorFullName?: string
  createdAt: string
}

export interface UsernameChangeListParams {
  userId?: string
  q?: string
  actorType?: 'user' | 'admin'
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface AdminUserListItem {
  id: string
  username: string
  fullName?: string
  email?: string
  avatar?: string
  gender?: string
  ken: number
  isVip: boolean
  isActive: boolean
  lockedUntil?: string
  lockReason?: string
  emailVerified: boolean
  createdAt: string
  lastLoginAt?: string | null
}

export interface AdminUserDetail extends AdminUserListItem {
  phone?: string
  bio?: string
  dateOfBirth?: string
  vipUsed?: string
  vipEndTime?: string
  emailVerifiedAt?: string
  followerCount?: number
  followingCount?: number
  lastLoginIp?: string
  updatedAt?: string
}

export interface AdminUserSession {
  id: string
  deviceName?: string
  platform?: string
  appVersion?: string
  ipAddress?: string
  userAgent?: string
  isActive: boolean
  lastActiveAt?: string
  createdAt: string
  revokedAt?: string
}

export interface AdminUserVipIcon {
  instanceId: string
  typeId: number
  isLocked: boolean
  isUsing: boolean
  source?: string
  acquiredAt?: string
}

export interface GrantVipRequest {
  vipTypeId: number
}

export interface AddVipDaysRequest {
  action?: 'add' | 'subtract'
  days: number
}

export interface AddVipDaysResult {
  days: number
  vipEndTime: string
}

export interface UserListParams {
  q?: string
  ip?: string
  limit?: number
  offset?: number
  isActive?: boolean
  gender?: string
  vip?: boolean
  emailVerified?: boolean
  sortBy?: string
  sortDir?: string
}

export type ViolationSource = 'report' | 'me_hide' | 'megaphone_remove'

export interface UserViolation {
  id: string
  source: ViolationSource
  targetType: ReportTargetType
  targetId: string
  reportId?: string
  reason: ReportReason
  severity: PenaltySeverity
  points: number
  note?: string
  admin?: ReportAdminBrief
  revokedAt?: string
  revokedBy?: ReportAdminBrief
  createdAt: string
}

export interface ModerationLockStep {
  points: number
  hours: number
}

export interface UserViolationSummary {
  items: UserViolation[]
  total: number
  threshold: number
  expireHours: number
  lockSteps: ModerationLockStep[]
}

export interface ModerationSetting {
  deliberatePoints: number
  expireHours: number
  lockSteps: ModerationLockStep[]
}
