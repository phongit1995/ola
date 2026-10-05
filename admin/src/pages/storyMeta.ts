import { settingValue } from '@/lib/appSetting'
import type { AppSetting, StoryPlatform, StoryPlatformRule, StorySetting } from '@/types'

export const STORY_SETTING_KEY = 'story'

export const STORY_VERSION_PATTERN = /^\d{1,6}(\.\d{1,6}){0,3}$/

export const STORY_DISABLE_VERSIONS_MAX = 50

const OPEN_RULE: StoryPlatformRule = { enabled: true, disableVersions: [] }

export const DEFAULT_STORY_SETTING: StorySetting = {
  web: OPEN_RULE,
  android: OPEN_RULE,
  ios: OPEN_RULE,
}

export const STORY_PLATFORMS: { key: StoryPlatform; label: string; versioned: boolean }[] = [
  { key: 'web', label: 'Web', versioned: false },
  { key: 'android', label: 'Android', versioned: true },
  { key: 'ios', label: 'iOS', versioned: true },
]

function normalizeRule(value: Partial<StoryPlatformRule> | undefined): StoryPlatformRule {
  return {
    enabled: value?.enabled ?? true,
    disableVersions: Array.isArray(value?.disableVersions) ? value.disableVersions : [],
  }
}

export function storySetting(settings: AppSetting[] | undefined): StorySetting {
  const value = settingValue(settings, STORY_SETTING_KEY, DEFAULT_STORY_SETTING)
  return {
    web: normalizeRule(value.web),
    android: normalizeRule(value.android),
    ios: normalizeRule(value.ios),
  }
}
