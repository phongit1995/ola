import type { WordChainCode, WordChainMessageType, WordChainSetting } from '@/types'

export const WORD_CHAIN_SETTING_KEY = 'word_chain'

export const DEFAULT_WORD_CHAIN_SETTING: WordChainSetting = {
  enabled: true,
  hintPrice: 500,
  guessPrice: 500,
  vipRequiredToView: false,
  vipRequiredToPlay: false,
}

export const WORD_CHAIN_PRICE_MAX = 10_000_000

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

export const TAB_KEYS = ['history', 'wins', 'purchases', 'settings'] as const
