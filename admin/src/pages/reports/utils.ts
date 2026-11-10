import type { AdminReport, ModerationLockStep } from '@/types'
import {
  MODERATION_HOURS_MAX,
  MODERATION_POINTS_MAX,
  MODERATION_POINTS_MIN,
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

export function moderationPointsRules(label: string) {
  return [
    { required: true, message: `Nhập ${label}` },
    {
      type: 'number' as const,
      min: MODERATION_POINTS_MIN,
      max: MODERATION_POINTS_MAX,
      message: `Từ ${MODERATION_POINTS_MIN} đến ${MODERATION_POINTS_MAX} điểm`,
    },
  ]
}

export function moderationHoursRules(label: string) {
  return [
    { required: true, message: `Nhập ${label}` },
    {
      type: 'number' as const,
      min: 0,
      max: MODERATION_HOURS_MAX,
      message: `Từ 0 đến ${MODERATION_HOURS_MAX} giờ`,
    },
  ]
}

export function moderationLockStepsProblem(steps: readonly ModerationLockStep[] | undefined): string | null {
  if (steps == null || steps.length === 0) return 'Cần ít nhất 1 mốc khoá'
  for (let i = 1; i < steps.length; i += 1) {
    if (steps[i].points <= steps[i - 1].points) return 'Điểm của các mốc phải tăng dần'
  }
  if (steps.slice(0, -1).some((step) => step.hours === 0)) return 'Mốc khoá vĩnh viễn (0 giờ) phải là mốc cuối cùng'
  return null
}
