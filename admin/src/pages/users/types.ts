import type { AdminUserListItem } from '@/types'

export type ViolationState = 'active' | 'expired' | 'revoked'

export type UserLockFields = Pick<AdminUserListItem, 'isActive' | 'lockReason' | 'lockedUntil'>

export type UserFramePurchaseRole = 'self' | 'sent' | 'received'

export type UserFrameTransferDirection = 'in' | 'out'

export type UserFramesTab = 'owned' | 'purchases' | 'transfers'
