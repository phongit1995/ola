import type { RoomMessage } from '@/types'
import { REACTION_EMOJI } from './constants'

export function reactionLabel(type: string) {
  return REACTION_EMOJI[type] ?? type
}

export function isImageMessage(m: RoomMessage) {
  return m.type === 'image' || (m.imageUrl != null && m.imageUrl !== '')
}
