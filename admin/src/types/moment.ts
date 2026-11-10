import type { MomentHiddenBy, MomentOverlay, MomentReactionCount, MomentType, MomentVisibility } from '@ola/shared/types'
import type { PlatformRules } from './common'
import type { MeAuthor } from './me'

export type AdminMomentState = 'live' | 'processing' | 'failed' | 'expired' | 'deleted'

export interface AdminMoment {
  id: string
  type: MomentType
  position: number
  pageCount: number
  background?: string
  overlays: MomentOverlay[]
  mediaUrl?: string
  thumbUrl?: string
  width?: number
  height?: number
  duration?: number
  size?: number
  mimeType?: string
  visibility: MomentVisibility
  status: string
  state: AdminMomentState
  enabled: boolean
  mediaPurged: boolean
  hiddenBy?: MomentHiddenBy
  hiddenAt?: string
  purgedAt?: string
  viewerCount: number | null
  reactionCount: number
  reactions: MomentReactionCount[]
  commentCount: number
  reportCount: number
  pendingReportCount: number
  author?: MeAuthor
  createdAt: string
  expiresAt: string
  deletedAt?: string
}

export interface AdminMomentDetail extends AdminMoment {
  pages: AdminMoment[]
}

export interface MomentMediaPurgeSetting {
  enabled: boolean
  afterHours: number
}

export type MomentDisplaySetting = PlatformRules

export interface MomentVideoSetting {
  vipRequired: boolean
}

export type MomentMediaPurgeTrigger = 'auto' | 'manual'

export type MomentMediaPurgeStatus = 'success' | 'partial' | 'failed'

export interface MomentMediaPurgeLog {
  id: string
  trigger: MomentMediaPurgeTrigger
  status: MomentMediaPurgeStatus
  message?: string
  afterHours: number
  cutoff: string
  purged: number
  files: number
  bytes: number
  failed: number
  hasMore: boolean
  startedAt: string
  finishedAt: string
  durationMs: number
}

export interface MomentMediaPurgeTotals {
  moments: number
  files: number
  bytes: number
}

export interface MomentMediaPurgeLogs {
  running: boolean
  last: MomentMediaPurgeLog | null
  items: MomentMediaPurgeLog[]
  total: number
  totals: MomentMediaPurgeTotals
}

export interface MomentMediaPurgeRunResult {
  started: boolean
}

export interface AdminMomentListParams {
  q?: string
  authorId?: string
  type?: MomentType
  visibility?: MomentVisibility
  state?: AdminMomentState
  enabled?: boolean
  hasPendingReports?: boolean
  sortBy?: string
  sortDir?: string
  limit?: number
  offset?: number
}

export interface AdminMomentViewer {
  user: MeAuthor
  viewedAt: string
  reactions?: MomentReactionCount[]
}

export interface AdminMomentComment {
  id: string
  user: MeAuthor
  content: string
  createdAt: string
}

export type { MomentReactionCount }
