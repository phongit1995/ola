import type { AdminReport } from '@/types'
import {
  REPORT_CONTENT_ACTION_LABEL,
  REPORT_EXCERPT_MAX,
  REPORT_TARGETS_WITHOUT_CONTEXT,
} from './constants'

export function reportExcerpt(report: AdminReport): string {
  const snapshot = report.snapshot
  if (snapshot == null) return '—'
  if (report.targetType === 'account') {
    return snapshot.fullName ? `${snapshot.fullName} (@${snapshot.username ?? ''})` : `@${snapshot.username ?? ''}`
  }
  const text = snapshot.text?.trim() ?? ''
  if (text !== '') {
    return text.length > REPORT_EXCERPT_MAX ? `${text.slice(0, REPORT_EXCERPT_MAX)}…` : text
  }
  if (snapshot.videoUrl) return '[Video]'
  if ((snapshot.imageUrls?.length ?? 0) > 0) return '[Ảnh]'
  if (snapshot.audioUrl) return '[Tin nhắn thoại]'
  if (snapshot.sticker) return '[Sticker]'
  if (snapshot.fileUrl) return '[Tệp]'
  return '—'
}

export function contentActionLabel(report: AdminReport): string | null {
  const label = REPORT_CONTENT_ACTION_LABEL[report.targetType]
  if (label == null) return null
  const needsContext = !REPORT_TARGETS_WITHOUT_CONTEXT.includes(report.targetType)
  return needsContext && !report.contextId ? null : label
}
