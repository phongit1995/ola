import type { RoomImagePurgeResult, RoomMessage } from '@/types'
import { REACTION_EMOJI } from './constants'
import { formatBytes, formatCount } from '@/lib/format'

export function reactionLabel(type: string) {
  return REACTION_EMOJI[type] ?? type
}

export function isImageMessage(m: RoomMessage) {
  return m.type === 'image' || (m.imageUrl != null && m.imageUrl !== '')
}

export function roomPurgeResultText(result: RoomImagePurgeResult): string {
  const done = `Đã xoá ${formatCount(result.files)} ảnh, giải phóng ${formatBytes(result.bytes)}`
  if (result.failed === 0) return done
  return `${done}. Còn ${formatCount(result.failed)} ảnh chưa xoá được, bấm tính lại rồi xoá tiếp`
}
