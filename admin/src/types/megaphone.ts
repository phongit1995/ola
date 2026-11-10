import type { ListResult, PlatformRules } from './common'
import type { AdminGiftUserBrief } from './gift'
import type { MePenaltyRequest } from './me'
import type { PenaltyOutcome } from './report'

export interface MegaphoneSetting {
  enabled: boolean
  platforms: PlatformRules
  kenPrice: number
  maxLength: number
  displaySeconds: number
  cooldownSeconds: number
  dailyLimit: number
  liveMinutes: number
  gapSeconds: number
  repeatBaseSeconds: number
  messageWeight: number
  giftTiers: MegaphoneGiftTier[]
}

export interface MegaphoneGiftTier {
  minKen: number
  weight: number
}

export type MegaphoneStatus = 'active' | 'removed'

export type MegaphoneType = 'message' | 'gift'

export interface AdminMegaphone {
  id: string
  type: MegaphoneType
  sender: AdminGiftUserBrief
  content: string
  kenPrice: number
  showAt: string
  displaySeconds: number
  expiresAt: string
  status: MegaphoneStatus
  removedReason?: string
  removedAt?: string
  createdAt: string
}

export interface MegaphoneListParams {
  senderId?: string
  status?: MegaphoneStatus
  type?: MegaphoneType
  q?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface MegaphoneListResult extends ListResult<AdminMegaphone> {
  totalKen: number
}

export interface RemoveMegaphoneRequest {
  reason?: string
  penalty?: MePenaltyRequest
}

export interface RemoveMegaphoneResult {
  item: AdminMegaphone
  penalty?: PenaltyOutcome
}

export type ContentCheckReason = 'link' | 'banned_word'

export interface ContentCheckResult {
  blocked: boolean
  reason?: ContentCheckReason
  word?: string
}
