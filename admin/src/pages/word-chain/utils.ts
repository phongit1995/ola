import type { AppSetting, WordChainSetting } from '@/types'
import { settingValue } from '@/lib/appSetting'
import { DEFAULT_WORD_CHAIN_SETTING, WORD_CHAIN_SETTING_KEY } from './constants'

export function wordChainSetting(settings: AppSetting[] | undefined): WordChainSetting {
  return settingValue(settings, WORD_CHAIN_SETTING_KEY, DEFAULT_WORD_CHAIN_SETTING)
}
