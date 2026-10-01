import { settingValue } from '@/lib/appSetting'
import type { AppSetting, WordChainCode, WordChainMessageType, WordChainSetting } from '@/types'

export const WORD_CHAIN_SETTING_KEY = 'word_chain'

export const DEFAULT_WORD_CHAIN_SETTING: WordChainSetting = {
  enabled: true,
  hintPrice: 500,
}

export const WORD_CHAIN_HINT_PRICE_MAX = 10_000_000

export function wordChainSetting(settings: AppSetting[] | undefined): WordChainSetting {
  return settingValue(settings, WORD_CHAIN_SETTING_KEY, DEFAULT_WORD_CHAIN_SETTING)
}

export const CODE_META: Record<WordChainCode, { label: string; color: string }> = {
  ok: { label: 'Đúng', color: 'green' },
  win: { label: 'Thắng', color: 'gold' },
  mismatch: { label: 'Sai âm đầu', color: 'red' },
  repeated: { label: 'Từ đã dùng', color: 'red' },
  not_in_dict: { label: 'Không có trong từ điển', color: 'red' },
  invalid_format: { label: 'Sai định dạng', color: 'orange' },
}

export const BOT_TYPE_LABEL: Record<WordChainMessageType, string> = {
  move: 'Nối từ',
  win: 'Báo thắng',
  game_started: 'Mở ván mới',
  session_started: 'Mở phiên',
  wrong_answer: 'Báo sai',
}
