import { settingValue } from '@/lib/appSetting'
import { OPEN_PLATFORM_RULES, normalizePlatformRules } from '@/lib/platformRules'
import type { AppSetting, StorySetting } from '@/types'

export const STORY_SETTING_KEY = 'story'

export function storySetting(settings: AppSetting[] | undefined): StorySetting {
  return normalizePlatformRules(settingValue(settings, STORY_SETTING_KEY, OPEN_PLATFORM_RULES))
}
