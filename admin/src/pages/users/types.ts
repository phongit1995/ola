import type { AdminUserListItem } from '@/types'

export type ViolationState = 'active' | 'expired' | 'revoked'

export type UserLockFields = Pick<AdminUserListItem, 'isActive' | 'lockReason' | 'lockedUntil'>
