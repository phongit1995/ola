import type { PenResult, PenSide, PenStatus, PenUserStatsSortBy } from '@/types'

export const PEN_STATUS_META: Record<PenStatus, { label: string; color: string }> = {
  open: { label: 'Đang chờ', color: 'blue' },
  settled: { label: 'Đã xử lý', color: 'green' },
  cancelled: { label: 'Đã huỷ', color: 'default' },
}

export const PEN_RESULT_META: Record<PenResult, { label: string; color: string }> = {
  saved: { label: 'Cản phá (thủ môn thắng)', color: 'volcano' },
  goal: { label: 'Vào gôn (người sút thắng)', color: 'green' },
}

export const PEN_SIDE_LABEL: Record<PenSide, string> = {
  left: 'Trái',
  right: 'Phải',
}

export const STATUS_OPTIONS = [
  { value: 'open' as const, label: 'Đang chờ' },
  { value: 'settled' as const, label: 'Đã xử lý' },
  { value: 'cancelled' as const, label: 'Đã huỷ' },
]

export const RESULT_OPTIONS = [
  { value: 'saved' as const, label: 'Cản phá' },
  { value: 'goal' as const, label: 'Vào gôn' },
]

export const USER_STATS_SORTS: PenUserStatsSortBy[] = ['staked', 'netKen', 'shots', 'catches']

export const RESULT_COLOR: Record<PenResult, { label: string; color: string }> = {
  saved: { label: 'Cản phá (thủ môn thắng)', color: '#fa541c' },
  goal: { label: 'Vào gôn (người sút thắng)', color: '#52c41a' },
}
