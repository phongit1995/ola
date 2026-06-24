import type { PenResult, PenSide, PenStatus } from '@/types'

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
