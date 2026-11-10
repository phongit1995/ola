import type { ListResult, PlatformRules } from './common'

export type GiftCodeKind = 'shared' | 'unique'

export type GiftCodeStatus = 'running' | 'scheduled' | 'soldout' | 'expired' | 'off'

export type GiftCodeRewardType = 'vip_days' | 'vip_icon' | 'avatar_frame'

export type GiftCodeCodeStatus = 'unused' | 'used' | 'locked'

export type GiftCodePlatform = 'web' | 'android' | 'ios'

export type GiftCodeAttemptReason =
  | 'wrong'
  | 'disabled'
  | 'locked'
  | 'not_started'
  | 'expired'
  | 'sold_out'
  | 'used'
  | 'redeemed'
  | 'device'
  | 'young'
  | 'platform'
  | 'unverified'
  | 'no_device'
  | 'owned'

export type GiftCodeAttemptRange = '1h' | '24h' | '7d' | '30d'

export interface GiftCodeSetting {
  enabled: boolean
  platforms: PlatformRules
  requireEmailVerified: boolean
}

export interface GiftCodeReward {
  type: GiftCodeRewardType
  days?: number
  vipIconId?: number
  frameId?: string
}

export interface GiftCodeAdminBrief {
  id: string
  username: string
  fullName?: string
}

export interface GiftCodeUserBrief {
  id: string
  username: string
  fullName: string
  avatar: string
}

export interface GiftCodeCampaign {
  id: string
  name: string
  kind: GiftCodeKind
  code?: string
  codePrefix: string
  codeLength: number
  totalUses: number
  usedCount: number
  lockedCodes: number
  rewards: GiftCodeReward[]
  successMessage: string
  sendNotification: boolean
  minAccountAgeDays: number
  allowWeb: boolean
  allowAndroid: boolean
  allowIos: boolean
  onePerDevice: boolean
  startsAt: string | null
  endsAt: string
  enabled: boolean
  status: GiftCodeStatus
  createdBy?: GiftCodeAdminBrief
  updatedBy?: GiftCodeAdminBrief
  createdAt: string
  updatedAt: string
}

export interface GiftCodeCampaignRequest {
  name: string
  kind: GiftCodeKind
  code?: string
  codePrefix?: string
  codeLength?: number
  totalUses: number
  rewards: GiftCodeReward[]
  successMessage: string
  sendNotification: boolean
  minAccountAgeDays: number
  allowWeb: boolean
  allowAndroid: boolean
  allowIos: boolean
  onePerDevice: boolean
  startsAt: string | null
  endsAt: string
  enabled: boolean
}

export interface GiftCodeCampaignStats {
  running: number
  redeemedToday: number
  redeemedTotal: number
  vipDaysGiven: number
}

export interface GiftCodeCampaignListParams {
  search?: string
  status?: GiftCodeStatus
  kind?: GiftCodeKind
  limit?: number
  offset?: number
}

export interface GiftCodeCampaignListResult extends ListResult<GiftCodeCampaign> {
  stats: GiftCodeCampaignStats
}

export interface GiftCodeItem {
  id: string
  code: string
  status: GiftCodeCodeStatus
  user?: GiftCodeUserBrief
  usedAt?: string
  lockedAt?: string
  lockedBy?: GiftCodeAdminBrief
  lockReason?: string
}

export interface GiftCodeListParams {
  status?: GiftCodeCodeStatus
  search?: string
  limit?: number
  offset?: number
}

export interface GiftCodeListResult extends ListResult<GiftCodeItem> {
  counts: Record<GiftCodeCodeStatus, number>
}

export interface GiftCodeRedemption {
  id: string
  user: GiftCodeUserBrief
  code: string
  platform: GiftCodePlatform
  deviceName: string
  ipAddress: string
  rewards: GiftCodeReward[]
  createdAt: string
}

export interface GiftCodeRedemptionListParams {
  search?: string
  platform?: GiftCodePlatform
  limit?: number
  offset?: number
}

export interface GiftCodeAttemptParams {
  range?: GiftCodeAttemptRange
  search?: string
  reason?: GiftCodeAttemptReason
  limit?: number
  offset?: number
}

export interface GiftCodeAttemptSummary {
  failures: number
  wrongCodes: number
  blockedUsers: number
  multiAccountDevices: number
}

export interface GiftCodeAttemptUser {
  user: GiftCodeUserBrief
  deviceName: string
  platform: GiftCodePlatform
  failures: number
  topReason: GiftCodeAttemptReason
  recentCodes: string[]
  lastAt: string
  blockedUntil?: string
}

export interface GiftCodeAttemptDevice {
  deviceId: string
  deviceName: string
  platform: GiftCodePlatform
  accounts: GiftCodeUserBrief[]
  failures: number
  successes: number
  lastAt: string
}

export interface GiftCodeAttempt {
  id: string
  user: GiftCodeUserBrief
  codeInput: string
  reason: GiftCodeAttemptReason
  platform: GiftCodePlatform
  deviceName: string
  ipAddress: string
  createdAt: string
}
