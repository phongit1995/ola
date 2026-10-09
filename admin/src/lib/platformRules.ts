import type { AppPlatform, PlatformRule, PlatformRules } from '@/types'

export const PLATFORM_VERSION_PATTERN = /^\d{1,6}(\.\d{1,6}){0,3}$/

export const DISABLE_VERSIONS_MAX = 50

export const APP_PLATFORMS: { key: AppPlatform; label: string; versioned: boolean }[] = [
  { key: 'web', label: 'Web', versioned: false },
  { key: 'android', label: 'Android', versioned: true },
  { key: 'ios', label: 'iOS', versioned: true },
]

const OPEN_RULE: PlatformRule = { enabled: true, disableVersions: [] }

export const OPEN_PLATFORM_RULES: PlatformRules = {
  web: OPEN_RULE,
  android: OPEN_RULE,
  ios: OPEN_RULE,
}

type StoredPlatformRules = Partial<Record<AppPlatform, Partial<PlatformRule>>>

function normalizeRule(value: Partial<PlatformRule> | undefined): PlatformRule {
  return {
    enabled: value?.enabled ?? true,
    disableVersions: Array.isArray(value?.disableVersions) ? value.disableVersions : [],
  }
}

export function normalizePlatformRules(value: StoredPlatformRules | undefined): PlatformRules {
  return {
    web: normalizeRule(value?.web),
    android: normalizeRule(value?.android),
    ios: normalizeRule(value?.ios),
  }
}

function cleanVersions(versions: string[] | undefined): string[] {
  const seen = new Set<string>()
  return (versions ?? [])
    .map((version) => version.trim())
    .filter((version) => {
      if (version === '' || seen.has(version)) return false
      seen.add(version)
      return true
    })
}

function cleanRule(rule: Partial<PlatformRule> | undefined, versioned: boolean): PlatformRule {
  return {
    enabled: rule?.enabled === true,
    disableVersions: versioned ? cleanVersions(rule?.disableVersions) : [],
  }
}

export function cleanPlatformRules(values: StoredPlatformRules | undefined): PlatformRules {
  return {
    web: cleanRule(values?.web, false),
    android: cleanRule(values?.android, true),
    ios: cleanRule(values?.ios, true),
  }
}

function versionKey(version: string): string {
  const parts = version.split('.').map(Number)
  while (parts.length > 1 && parts[parts.length - 1] === 0) parts.pop()
  return parts.join('.')
}

export function validateDisableVersions(_: unknown, versions: string[] | undefined) {
  const cleaned = cleanVersions(versions)
  const invalid = cleaned.find((version) => !PLATFORM_VERSION_PATTERN.test(version))
  if (invalid) return Promise.reject(new Error(`"${invalid}" không đúng dạng 1.0.0`))
  if (cleaned.length > DISABLE_VERSIONS_MAX) {
    return Promise.reject(new Error(`Tối đa ${DISABLE_VERSIONS_MAX} bản`))
  }
  const seen = new Map<string, string>()
  for (const version of cleaned) {
    const first = seen.get(versionKey(version))
    if (first) return Promise.reject(new Error(`"${version}" trùng với "${first}"`))
    seen.set(versionKey(version), version)
  }
  return Promise.resolve()
}
