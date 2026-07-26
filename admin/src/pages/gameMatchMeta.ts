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
}

export function gameLabel(gameId: string, names?: Record<string, string>) {
  return names?.[gameId] ?? GAME_ID_LABEL[gameId] ?? gameId
}
