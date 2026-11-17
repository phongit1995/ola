import { settingValue } from '@/lib/appSetting'
import type { AppSetting, MeListItem, PostLimitSetting } from '@/types'
import { DEFAULT_ME_POST_LIMIT_SETTING, ME_HIDDEN_BY_LABEL, ME_POST_LIMIT_SETTING_KEY } from './constants'
import type { TriState } from './types'

export const triToBool = (v: TriState): boolean | undefined =>
  v === 'all' ? undefined : v === 'yes'

export function meHiddenByLabel(post: Pick<MeListItem, 'enabled' | 'hiddenBy'>): string | null {
  if (post.enabled || post.hiddenBy == null) return null
  return ME_HIDDEN_BY_LABEL[post.hiddenBy]
}

export function mePostLimitSetting(settings: AppSetting[] | undefined): PostLimitSetting {
  return settingValue(settings, ME_POST_LIMIT_SETTING_KEY, DEFAULT_ME_POST_LIMIT_SETTING)
}
