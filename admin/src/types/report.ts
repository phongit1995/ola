import type { ReportReason, ReportTargetType } from '@ola/shared/types'

export type ReportAlertChannel = 'discord' | 'telegram'

export interface ReportAlertChannelStatus {
  enabled?: boolean
  configured?: boolean
  hint?: string
  chatId?: string
}

export interface ReportAlertSettingStatus {
  adminUrl?: string
  discord?: ReportAlertChannelStatus
  telegram?: ReportAlertChannelStatus
}

export type ReportStatus = 'pending' | 'resolved' | 'dismissed'

export interface ReportUserBrief {
  id: string
  username: string
  fullName?: string
  avatar?: string
  isActive: boolean
}

export interface ReportAdminBrief {
  id: string
  username: string
  fullName?: string
}

export interface ReportSnapshot {
  username?: string
  fullName?: string
  avatar?: string
  text?: string
  imageUrls?: string[]
  audioUrl?: string
  videoUrl?: string
  fileUrl?: string
  sticker?: string
  messageType?: string
  momentType?: string
  sentAt?: string
}

export interface AdminReport {
  id: string
  targetType: ReportTargetType
  targetId: string
  contextId?: string
  reason: ReportReason
  note?: string
  snapshot?: ReportSnapshot
  status: ReportStatus
  reporter?: ReportUserBrief
  reportedUser?: ReportUserBrief
  handledBy?: ReportAdminBrief
  handledAt?: string
  handlerNote?: string
  sameTargetPending: number
  createdAt: string
}

export interface ReportListParams {
  status?: ReportStatus
  targetType?: ReportTargetType
  reportedUserId?: string
  q?: string
  limit?: number
  offset?: number
}

export interface ReportSummary {
  pending: number
}

export type PenaltySeverity = 'none' | 'violation' | 'deliberate'

export interface PenaltyOutcome {
  counted: boolean
  points: number
  total: number
  threshold: number
  locked: boolean
  lockedUntil?: string
}

export interface ReportPenaltyRequest {
  severity: PenaltySeverity
  contentRemoved: boolean
}

export interface UpdateReportStatusRequest {
  status: Exclude<ReportStatus, 'pending'>
  note?: string
  penalty?: ReportPenaltyRequest
}

export interface UpdateReportStatusResult {
  report: AdminReport
  affected: number
  penalty?: PenaltyOutcome
}
