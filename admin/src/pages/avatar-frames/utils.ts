import { AVATAR_FRAMES, avatarFrameById, type AvatarFrame } from '@ola/shared/lib/avatarFrame'

export function avatarFrameName(id: string): string {
  return avatarFrameById(id)?.name || `#${id}`
}

export function avatarFrameUrl(id: string): string | undefined {
  return avatarFrameById(id)?.url
}

export function matchesAvatarFrameQuery(frame: AvatarFrame, query: string): boolean {
  if (!query) return true
  return frame.id.includes(query) || frame.name.toLowerCase().includes(query)
}

export function filterAvatarFrames(query: string): readonly AvatarFrame[] {
  const q = query.trim().toLowerCase()
  if (!q) return AVATAR_FRAMES
  return AVATAR_FRAMES.filter((frame) => matchesAvatarFrameQuery(frame, q))
}
