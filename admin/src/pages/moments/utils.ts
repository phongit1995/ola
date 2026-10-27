import type { CSSProperties } from 'react'
import {
  MOMENT_OVERLAY_FONT_RATIO,
  MOMENT_OVERLAY_STYLE,
  MOMENT_SOFT_BACKDROP,
} from '@ola/shared/constants/moment'
import {
  readableTextColor,
  momentBackgroundColors,
  resolveMomentBackground,
  resolveMomentTextFace,
} from '@ola/shared/lib/moment'
import type { MomentOverlay } from '@ola/shared/types'
import { settingValue } from '@/lib/appSetting'
import { formatBytes, formatCount } from '@/lib/format'
import { APP_PLATFORMS, normalizePlatformRules, OPEN_PLATFORM_RULES } from '@/lib/platformRules'
import type {
  AdminMoment,
  AppSetting,
  MomentDisplaySetting,
  MomentMediaPurgeLog,
  MomentMediaPurgeSetting,
  MomentVideoSetting,
} from '@/types'
import {
  DEFAULT_MOMENT_MEDIA_PURGE_SETTING,
  DEFAULT_MOMENT_VIDEO_SETTING,
  MOMENT_DISPLAY_SETTING_KEY,
  MOMENT_VIDEO_SETTING_KEY,
  MOMENT_EXCERPT_SEPARATOR,
  MOMENT_FONT_FACE,
  MOMENT_HIDDEN_BY_LABEL,
  MOMENT_MEDIA_PURGE_SETTING_KEY,
  MOMENT_NO_COVER_LABEL,
  MOMENT_PLAIN_SHADOW,
  MOMENT_STATE_TAG,
  MOMENT_SWITCHLESS_STATES,
} from './constants'

export function momentBackgroundCss(key: string | undefined): string {
  const background = resolveMomentBackground(key)
  return background.kind === 'gradient'
    ? `linear-gradient(160deg, ${momentBackgroundColors(background).join(', ')})`
    : background.color
}

export function overlayBoxStyle(overlay: MomentOverlay): CSSProperties {
  const face = resolveMomentTextFace(overlay)
  const font = MOMENT_FONT_FACE[face.font]
  return {
    position: 'absolute',
    left: `${overlay.x * 100}%`,
    top: `${overlay.y * 100}%`,
    width: 'max-content',
    maxWidth: `${overlay.w * 100}%`,
    transform: `translate(-50%, -50%) rotate(${overlay.rotation}deg)`,
    fontFamily: font.family,
    fontWeight: face.bold ? font.boldWeight : font.weight,
    fontStyle: face.italic ? 'italic' : 'normal',
    fontSize: `${MOMENT_OVERLAY_FONT_RATIO * 100 * overlay.scale}cqw`,
    lineHeight: 1.35,
    textAlign: overlay.align,
  }
}

export function overlayTextStyle(overlay: MomentOverlay): CSSProperties {
  const base: CSSProperties = {
    padding: '0.12em 0.35em',
    borderRadius: '0.3em',
    boxDecorationBreak: 'clone',
    WebkitBoxDecorationBreak: 'clone',
    whiteSpace: 'pre-wrap',
    overflowWrap: 'anywhere',
  }
  if (overlay.style === MOMENT_OVERLAY_STYLE.solid) {
    return { ...base, backgroundColor: overlay.color, color: readableTextColor(overlay.color) }
  }
  if (overlay.style === MOMENT_OVERLAY_STYLE.soft) {
    return { ...base, backgroundColor: MOMENT_SOFT_BACKDROP, color: overlay.color }
  }
  return { ...base, color: overlay.color, textShadow: MOMENT_PLAIN_SHADOW }
}

export function momentExcerpt(moment: AdminMoment): string {
  return moment.overlays
    .map((overlay) => overlay.text.trim())
    .filter((text) => text !== '')
    .join(MOMENT_EXCERPT_SEPARATOR)
}

export function canToggleMoment(moment: AdminMoment): boolean {
  return moment.state === 'live' || moment.state === 'expired'
}

export function hasMomentSwitch(moment: AdminMoment): boolean {
  return !MOMENT_SWITCHLESS_STATES.includes(moment.state)
}

export function momentPageLabel(moment: AdminMoment): string | null {
  return moment.pageCount > 1 ? `Trang ${moment.position + 1}/${moment.pageCount}` : null
}

export function momentNoCoverLabel(moment: AdminMoment): string {
  return moment.state === 'processing' || moment.state === 'failed'
    ? MOMENT_STATE_TAG[moment.state].label
    : MOMENT_NO_COVER_LABEL
}

export function canPurgeMomentMedia(moment: AdminMoment): boolean {
  return moment.type !== 'text' && !moment.mediaPurged && moment.state !== 'processing'
}

export function momentHiddenByLabel(moment: AdminMoment): string | null {
  if (moment.enabled || moment.hiddenBy == null) return null
  return MOMENT_HIDDEN_BY_LABEL[moment.hiddenBy]
}

function formatMegabytes(bytes: number): string {
  return `${(bytes / 1024 / 1024).toFixed(1)} MB`
}

export function videoSummary(moment: AdminMoment): string {
  const parts = [
    moment.duration ? `${moment.duration.toFixed(1)} giây` : null,
    moment.width && moment.height ? `${moment.width}×${moment.height}` : null,
    moment.size ? formatMegabytes(moment.size) : null,
  ].filter((part): part is string => part != null)
  return parts.length > 0 ? parts.join(MOMENT_EXCERPT_SEPARATOR) : '—'
}

export function momentDisplaySetting(settings: AppSetting[] | undefined): MomentDisplaySetting {
  return normalizePlatformRules(settingValue(settings, MOMENT_DISPLAY_SETTING_KEY, OPEN_PLATFORM_RULES))
}

export function momentVideoSetting(settings: AppSetting[] | undefined): MomentVideoSetting {
  return settingValue(settings, MOMENT_VIDEO_SETTING_KEY, DEFAULT_MOMENT_VIDEO_SETTING)
}

export function disabledPlatformLabels(
  before: MomentDisplaySetting,
  after: MomentDisplaySetting,
): string[] {
  return APP_PLATFORMS.filter(({ key }) => before[key].enabled && !after[key].enabled).map(
    ({ label }) => label,
  )
}

export function momentPurgeSetting(settings: AppSetting[] | undefined): MomentMediaPurgeSetting {
  return settingValue(settings, MOMENT_MEDIA_PURGE_SETTING_KEY, DEFAULT_MOMENT_MEDIA_PURGE_SETTING)
}

export function hoursInDays(hours: number): string {
  const days = Math.floor(hours / 24)
  const rest = hours % 24
  if (days === 0) return `${rest} giờ`
  return rest === 0 ? `${days} ngày` : `${days} ngày ${rest} giờ`
}

export function momentPurgeResult(log: MomentMediaPurgeLog): string {
  const parts: string[] = []
  if (log.purged > 0 || log.files > 0) {
    const files = `xoá ${formatCount(log.files)} file, ${formatBytes(log.bytes)}`
    parts.push(log.purged > 0 ? `${files} của ${formatCount(log.purged)} khoảnh khắc` : files)
  }
  if (log.failed > 0) parts.push(`${formatCount(log.failed)} khoảnh khắc xoá lỗi, lượt sau thử lại`)
  if (log.message) parts.push(`lỗi: ${log.message}`)
  if (parts.length === 0) parts.push('không có file nào cần xoá')
  if (log.hasMore) parts.push('còn file, lượt sau chạy tiếp')
  return parts.join(MOMENT_EXCERPT_SEPARATOR)
}
