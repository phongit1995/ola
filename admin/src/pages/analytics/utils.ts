import type { AnalyticsPlatform, AnalyticsSetup, AnalyticsSource, AnalyticsSourceStatus } from '@/types'
import { CHART_PLATFORMS, EVENT_LABEL, PLATFORM_META, type ChartPlatform } from './constants'

const SOURCE_PLATFORMS: Record<AnalyticsSource, ChartPlatform[]> = {
  mobile: ['android', 'ios'],
  web: ['web'],
  all: ['android', 'ios', 'web'],
}

export function isChartPlatform(platform: string): platform is ChartPlatform {
  return (CHART_PLATFORMS as readonly string[]).includes(platform)
}

export function platformLabel(platform: string): string {
  return isChartPlatform(platform) ? PLATFORM_META[platform].label : platform
}

export function platformColor(platform: string): string {
  return isChartPlatform(platform) ? PLATFORM_META[platform].color : '#8c8c8c'
}

export function visiblePlatforms(filter: AnalyticsPlatform, sources: AnalyticsSourceStatus[]): ChartPlatform[] {
  const unavailable = sources
    .filter((source) => source.error)
    .flatMap((source) => SOURCE_PLATFORMS[source.source])
  const wanted = filter === 'all' ? CHART_PLATFORMS : [filter]
  return wanted.filter((platform) => !unavailable.includes(platform))
}

export function eventLabel(name: string): string | undefined {
  return EVENT_LABEL[name]
}

export function formatEngagement(seconds: number): string {
  const total = Math.round(seconds)
  if (total < 60) return `${total}s`
  const minutes = Math.floor(total / 60)
  const rest = total % 60
  return rest === 0 ? `${minutes}p` : `${minutes}p ${rest}s`
}

export function formatChartDate(date: string): string {
  const [, month, day] = date.split('-')
  return `${day}/${month}`
}

export function serviceAccountProject(clientEmail: string): string {
  const domain = clientEmail.split('@')[1] ?? ''
  return domain.replace(/\.iam\.gserviceaccount\.com$/, '')
}

export function hasPropertyIds(setup?: AnalyticsSetup): boolean {
  return Boolean(setup && (setup.mobilePropertyId || setup.webPropertyId))
}

export function isAnalyticsReady(setup?: AnalyticsSetup): boolean {
  return Boolean(setup?.credentialConfigured && hasPropertyIds(setup))
}
