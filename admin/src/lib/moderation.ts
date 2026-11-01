import type {
  AppSetting,
  ModerationLockStep,
  ModerationSetting,
  PenaltyOutcome,
  PenaltySeverity,
  ReportReason,
  ReportTargetType,
} from '@/types'
import { settingValue } from './appSetting'
import { formatDateTime } from './format'

export const REPORT_TARGET_LABEL: Record<ReportTargetType, string> = {
  account: 'Tài khoản',
  post: 'Bài đăng Me',
  comment: 'Bình luận Me',
  story_comment: 'Bình luận truyện',
  message: 'Tin nhắn 1-1',
  room_message: 'Tin nhắn phòng',
  moment: 'Khoảnh khắc',
}

export const REPORT_REASON_LABEL: Record<ReportReason, string> = {
  spam: 'Spam / quảng cáo',
  sensitive: 'Nội dung nhạy cảm',
  scam: 'Lừa đảo',
  harassment: 'Quấy rối / xúc phạm',
  other: 'Khác',
}

export const MODERATION_SETTING_KEY = 'moderation'

export const DEFAULT_MODERATION_SETTING: ModerationSetting = {
  deliberatePoints: 3,
  expireHours: 0,
  lockSteps: [
    { points: 2, hours: 12 },
    { points: 3, hours: 0 },
  ],
}

const HOURS_PER_DAY = 24

export const VIOLATION_POINTS = 1

export const PENALTY_SEVERITIES: readonly PenaltySeverity[] = ['none', 'violation', 'deliberate']

export const DEFAULT_PENALTY_SEVERITY: PenaltySeverity = 'none'

export const PENALTY_SEVERITY_TAG: Record<PenaltySeverity, { label: string; color: string }> = {
  none: { label: 'Không tính điểm', color: 'default' },
  violation: { label: 'Vi phạm', color: 'orange' },
  deliberate: { label: 'Cố tình vi phạm', color: 'red' },
}

export function moderationSetting(settings: AppSetting[] | undefined): ModerationSetting {
  return settingValue(settings, MODERATION_SETTING_KEY, DEFAULT_MODERATION_SETTING)
}

export function penaltySeverityLabel(severity: PenaltySeverity, deliberatePoints: number): string {
  const name = PENALTY_SEVERITY_TAG[severity].label
  if (severity === 'none') return name
  const points = severity === 'deliberate' ? deliberatePoints : VIOLATION_POINTS
  return `${name} (+${points} điểm)`
}

export function penaltySeverityOptions(deliberatePoints: number) {
  return PENALTY_SEVERITIES.map((value) => ({
    value,
    label: penaltySeverityLabel(value, deliberatePoints),
  }))
}

export function lockDurationLabel(hours: number): string {
  if (hours === 0) return 'vĩnh viễn'
  if (hours % HOURS_PER_DAY === 0) return `${hours / HOURS_PER_DAY} ngày`
  return `${hours} giờ`
}

export function lockStepsLabel(steps: readonly ModerationLockStep[]): string {
  return steps.map((step) => `${step.points} điểm → khoá ${lockDurationLabel(step.hours)}`).join(', ')
}

export function penaltyOutcomeText(outcome: PenaltyOutcome): string {
  if (!outcome.counted) return 'nội dung này đã được tính vi phạm trước đó'
  if (outcome.locked) {
    const period = outcome.lockedUntil ? `đến ${formatDateTime(outcome.lockedUntil)}` : 'vĩnh viễn'
    return `tài khoản đã tự bị khoá (đang có ${outcome.total} điểm) ${period}`
  }
  const added = outcome.points > 0 ? `+${outcome.points} điểm` : 'không tính điểm'
  return `${added}, hiện ${outcome.total}/${outcome.threshold}`
}

export function withPenaltyOutcome(text: string, outcome?: PenaltyOutcome): string {
  return outcome ? `${text} — ${penaltyOutcomeText(outcome)}` : text
}
