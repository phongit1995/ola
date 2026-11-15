import type { AppSetting, SocialLimitSetting } from '@/types'
import { DEFAULT_SOCIAL_LIMIT_SETTING, SOCIAL_LIMIT_SETTING_KEY } from './constants'

export function socialLimitSetting(settings: AppSetting[] | undefined): SocialLimitSetting {
  const stored = settings?.find((item) => item.key === SOCIAL_LIMIT_SETTING_KEY)?.value as
    | Partial<SocialLimitSetting>
    | undefined
  return {
    enabled: stored?.enabled ?? DEFAULT_SOCIAL_LIMIT_SETTING.enabled,
    normal: { ...DEFAULT_SOCIAL_LIMIT_SETTING.normal, ...stored?.normal },
    vip: { ...DEFAULT_SOCIAL_LIMIT_SETTING.vip, ...stored?.vip },
  }
}
