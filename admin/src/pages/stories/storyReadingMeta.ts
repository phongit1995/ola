import { settingValue } from '@/lib/appSetting'
import type { AppSetting, StoryReadingSetting } from '@/types'

export const STORY_READING_SETTING_KEY = 'story_reading'

export const DEFAULT_STORY_READING_SETTING: StoryReadingSetting = {
  enabled: true,
  freeChaptersPerDay: 10,
  commentUnlockMinChars: 20,
}

export const STORY_FREE_CHAPTERS_MAX = 1000
export const STORY_UNLOCK_CHARS_MIN = 1
export const STORY_UNLOCK_CHARS_MAX = 500

export function storyReadingSetting(settings: AppSetting[] | undefined): StoryReadingSetting {
  return settingValue(settings, STORY_READING_SETTING_KEY, DEFAULT_STORY_READING_SETTING)
}
