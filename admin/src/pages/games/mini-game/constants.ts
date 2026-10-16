import type { GameMatchMode, GameMatchReason, GameMatchStatus } from '@/types'

export const GAME_MATCH_STATUS_META: Record<GameMatchStatus, { label: string; color: string }> = {
  playing: { label: 'Đang chơi', color: 'blue' },
  finished: { label: 'Đã kết thúc', color: 'green' },
}

export const GAME_MATCH_REASON_META: Record<GameMatchReason, { label: string; color: string }> = {
  win: { label: 'Thắng thường', color: 'green' },
  forfeit: { label: 'Đầu hàng', color: 'orange' },
  timeout: { label: 'Hết giờ', color: 'volcano' },
  draw: { label: 'Hòa', color: 'geekblue' },
  disconnect: { label: 'Mất kết nối', color: 'red' },
  void: { label: 'Hủy trận (hoàn cược)', color: 'default' },
}

export const GAME_MATCH_MODE_LABEL: Record<GameMatchMode, string> = {
  queue: 'Ghép ngẫu nhiên',
  room: 'Phòng riêng',
}

export const GAME_ID_LABEL: Record<string, string> = {
  caro: 'Cờ Caro',
  'war-god': 'War God',
  'thirteen': 'Tiến Lên Miền Nam',
  'xiangqi': 'Cờ Tướng',
}

export const STATUS_OPTIONS = [
  { value: 'playing' as const, label: 'Đang chơi' },
  { value: 'finished' as const, label: 'Đã kết thúc' },
]

export const REASON_OPTIONS = (
  Object.keys(GAME_MATCH_REASON_META) as GameMatchReason[]
).map((reason) => ({ value: reason, label: GAME_MATCH_REASON_META[reason].label }))

export const MODE_OPTIONS = (Object.keys(GAME_MATCH_MODE_LABEL) as GameMatchMode[]).map((mode) => ({
  value: mode,
  label: GAME_MATCH_MODE_LABEL[mode],
}))

export const REASON_COLOR: Record<string, string> = {
  win: '#52c41a',
  forfeit: '#fa8c16',
  timeout: '#fa541c',
  draw: '#2f54eb',
  disconnect: '#f5222d',
  void: '#8c8c8c',
}

export const TAB_KEYS = ['list', 'history', 'levels'] as const
