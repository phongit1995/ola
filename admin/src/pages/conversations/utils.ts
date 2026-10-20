import type { AdminConversationItem, AdminConversationMessage, ConversationUserBrief } from '@/types'

interface MessageMeta {
  url?: string
  fileName?: string
  callType?: string
  callStatus?: string
  durationSeconds?: number
}

function stringField(value: unknown) {
  return typeof value === 'string' && value !== '' ? value : undefined
}

// File and video metadata are stored without server-side validation, so a link must not open javascript: or data: URLs.
function httpUrl(value: unknown) {
  const raw = stringField(value)
  if (raw == null) return undefined
  try {
    const url = new URL(raw)
    return url.protocol === 'https:' || url.protocol === 'http:' ? url.href : undefined
  } catch {
    return undefined
  }
}

export function messageMeta(message: AdminConversationMessage): MessageMeta {
  if (!message.metadata) return {}
  let parsed: unknown
  try {
    parsed = JSON.parse(message.metadata)
  } catch {
    return {}
  }
  if (typeof parsed !== 'object' || parsed == null || Array.isArray(parsed)) return {}
  const raw = parsed as Record<string, unknown>
  return {
    url: httpUrl(raw.url),
    fileName: stringField(raw.fileName),
    callType: stringField(raw.callType),
    callStatus: stringField(raw.callStatus),
    durationSeconds:
      typeof raw.durationSeconds === 'number' && Number.isFinite(raw.durationSeconds) && raw.durationSeconds > 0
        ? Math.floor(raw.durationSeconds)
        : undefined,
  }
}

const CALL_STATUS_LABEL: Record<string, string> = {
  ringing: 'đang đổ chuông',
  active: 'đang gọi',
  ended: 'đã kết thúc',
  missed: 'nhỡ',
  declined: 'bị từ chối',
}

function formatDuration(seconds: number) {
  const m = Math.floor(seconds / 60)
  const s = seconds % 60
  return `${m}:${String(s).padStart(2, '0')}`
}

export function callLabel(meta: MessageMeta) {
  const kind = meta.callType === 'video' ? '📹 Cuộc gọi video' : '📞 Cuộc gọi thoại'
  if (meta.durationSeconds && meta.durationSeconds > 0) return `${kind} · ${formatDuration(meta.durationSeconds)}`
  return meta.callStatus ? `${kind} · ${CALL_STATUS_LABEL[meta.callStatus] ?? meta.callStatus}` : kind
}

export function userLabel(user?: ConversationUserBrief) {
  if (!user) return 'Không rõ'
  return user.fullName ? `${user.fullName} (@${user.username})` : `@${user.username}`
}

export function conversationTitle(item: AdminConversationItem) {
  if (item.otherUser) return userLabel(item.otherUser)
  return item.name || (item.type === 'group' ? 'Nhóm chưa đặt tên' : 'Hội thoại')
}
