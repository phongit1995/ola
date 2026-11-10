import type { ChatBotType } from '@ola/shared/types'
import type { ReportAdminBrief } from './report'

export type PushAudience = 'all' | 'vip' | 'user'

export type PushCampaignStatus = 'queued' | 'sending' | 'done' | 'failed'

export interface PushCampaign {
  id: string
  audience: PushAudience
  targetUser?: { id: string; username: string; fullName?: string; avatar?: string }
  title: string
  body: string
  status: PushCampaignStatus
  totalDevices: number
  successCount: number
  failureCount: number
  error?: string
  createdBy?: ReportAdminBrief
  startedAt?: string
  finishedAt?: string
  createdAt: string
}

export interface CreatePushCampaignRequest {
  audience: PushAudience
  username?: string
  title: string
  body: string
}

export interface PushAudienceCount {
  users: number
  devices: number
}

export type { ChatBotType }
