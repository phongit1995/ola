export type AnalyticsPlatform = 'all' | 'android' | 'ios' | 'web'

export type AnalyticsSource = 'mobile' | 'web' | 'all'

export type AnalyticsRanking = 'screens' | 'countries' | 'events'

export interface AnalyticsSettingValue {
  mobilePropertyId: string
  webPropertyId: string
}

export interface AnalyticsSetup extends AnalyticsSettingValue {
  credentialConfigured: boolean
  clientEmail: string
}

export interface AnalyticsSourceStatus {
  source: AnalyticsSource
  propertyId: string
  error?: string
}

export interface AnalyticsTotals {
  activeUsers: number
  newUsers: number
  sessions: number
  views: number
  avgEngagementSeconds: number
  usersSummed: boolean
}

export interface AnalyticsPlatformRow {
  platform: string
  activeUsers: number
  newUsers: number
  sessions: number
  views: number
}

export interface AnalyticsTimePoint {
  date: string
  android: number
  ios: number
  web: number
  newUsers: number
  sessions: number
}

export interface AnalyticsNamedRow {
  name: string
  count: number
  users: number
}

export interface AnalyticsVersionRow {
  platform: string
  version: string
  users: number
}

export interface AnalyticsOverview {
  setup: AnalyticsSetup
  sources: AnalyticsSourceStatus[]
  from: string
  to: string
  fetchedAt?: string
  totals: AnalyticsTotals
  platforms: AnalyticsPlatformRow[]
  timeseries: AnalyticsTimePoint[]
  screens: AnalyticsNamedRow[]
  countries: AnalyticsNamedRow[]
  appVersions: AnalyticsVersionRow[]
  events: AnalyticsNamedRow[]
  approximateRankings: AnalyticsRanking[]
}

export interface AnalyticsRealtimeMinute {
  minutesAgo: number
  activeUsers: number
  eventCount: number
}

export interface AnalyticsRealtime {
  sources: AnalyticsSourceStatus[]
  activeUsers: number
  eventCount: number
  eventsTruncated: boolean
  usersSummed: boolean
  platforms: { platform: string; activeUsers: number }[]
  minutes: AnalyticsRealtimeMinute[]
  events: AnalyticsNamedRow[]
  countries: AnalyticsNamedRow[]
  fetchedAt?: string
}

export interface AnalyticsQueryParams {
  from: string
  to: string
  platform: AnalyticsPlatform
  refresh?: boolean
}
