import type { ReportReason } from '@ola/shared/types'
import type { PenaltyOutcome, PenaltySeverity } from './report'

export interface MeAuthor {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface MeImage {
  url: string
  width?: number
  height?: number
  mimeType?: string
}

export interface MeCheckIn {
  name: string
  address?: string
  lat?: number
  lng?: number
  action?: string
  actionIcon?: string
}

export type MeHiddenBy = 'owner' | 'admin' | 'clan'

export interface MeListItem {
  id: string
  content?: string
  images: MeImage[]
  checkIn?: MeCheckIn
  sticker?: string
  visibility: string
  enabled: boolean
  hiddenBy?: MeHiddenBy
  hiddenAt?: string
  likeCount: number
  dislikeCount: number
  commentCount: number
  author?: MeAuthor
  createdAt: string
}

export interface MeDetail {
  id: string
  content?: string
  images: MeImage[]
  mentions?: string[]
  checkIn?: MeCheckIn
  sticker?: string
  visibility: string
  enabled: boolean
  hiddenBy?: MeHiddenBy
  hiddenAt?: string
  likeCount: number
  dislikeCount: number
  commentCount: number
  author?: MeAuthor
  createdAt: string
  updatedAt: string
}

export interface MeComment {
  id: string
  postId: string
  content: string
  author?: MeAuthor
  createdAt: string
}

export interface MeListParams {
  q?: string
  limit?: number
  offset?: number
  authorId?: string
  enabled?: boolean
  visibility?: string
  hasImages?: boolean
  hasCheckin?: boolean
  sortBy?: string
  sortDir?: string
}

export interface MePenaltyRequest {
  reason: ReportReason
  severity: PenaltySeverity
  note?: string
}

export interface MeStatusResult extends MeDetail {
  penalty?: PenaltyOutcome
}
