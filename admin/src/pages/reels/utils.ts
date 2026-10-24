import type { CSSProperties } from 'react'
import {
  REEL_OVERLAY_FONT_RATIO,
  REEL_OVERLAY_STYLE,
  REEL_SOFT_BACKDROP,
} from '@ola/shared/constants/reel'
import {
  readableTextColor,
  reelBackgroundColors,
  resolveReelBackground,
  resolveReelFont,
} from '@ola/shared/lib/reel'
import type { ReelOverlay } from '@ola/shared/types'
import type { AdminReel } from '@/types'
import {
  REEL_EXCERPT_SEPARATOR,
  REEL_FONT_FACE,
  REEL_PLAIN_SHADOW,
} from './constants'

export function reelBackgroundCss(key: string | undefined): string {
  const background = resolveReelBackground(key)
  return background.kind === 'gradient'
    ? `linear-gradient(160deg, ${reelBackgroundColors(background).join(', ')})`
    : background.color
}

export function overlayBoxStyle(overlay: ReelOverlay): CSSProperties {
  const face = REEL_FONT_FACE[resolveReelFont(overlay.font)]
  return {
    position: 'absolute',
    left: `${overlay.x * 100}%`,
    top: `${overlay.y * 100}%`,
    width: 'max-content',
    maxWidth: `${overlay.w * 100}%`,
    transform: `translate(-50%, -50%) rotate(${overlay.rotation}deg)`,
    fontFamily: face.family,
    fontWeight: face.weight,
    fontSize: `${REEL_OVERLAY_FONT_RATIO * 100 * overlay.scale}cqw`,
    lineHeight: 1.35,
    textAlign: overlay.align,
  }
}

export function overlayTextStyle(overlay: ReelOverlay): CSSProperties {
  const base: CSSProperties = {
    padding: '0.12em 0.35em',
    borderRadius: '0.3em',
    boxDecorationBreak: 'clone',
    WebkitBoxDecorationBreak: 'clone',
    whiteSpace: 'pre-wrap',
    overflowWrap: 'anywhere',
  }
  if (overlay.style === REEL_OVERLAY_STYLE.solid) {
    return { ...base, backgroundColor: overlay.color, color: readableTextColor(overlay.color) }
  }
  if (overlay.style === REEL_OVERLAY_STYLE.soft) {
    return { ...base, backgroundColor: REEL_SOFT_BACKDROP, color: overlay.color }
  }
  return { ...base, color: overlay.color, textShadow: REEL_PLAIN_SHADOW }
}

export function reelExcerpt(reel: AdminReel): string {
  return reel.overlays
    .map((overlay) => overlay.text.trim())
    .filter((text) => text !== '')
    .join(REEL_EXCERPT_SEPARATOR)
}

export function canToggleReel(reel: AdminReel): boolean {
  return reel.state === 'live'
}

function formatMegabytes(bytes: number): string {
  return `${(bytes / 1024 / 1024).toFixed(1)} MB`
}

export function videoSummary(reel: AdminReel): string {
  const parts = [
    reel.duration ? `${reel.duration.toFixed(1)} giây` : null,
    reel.width && reel.height ? `${reel.width}×${reel.height}` : null,
    reel.size ? formatMegabytes(reel.size) : null,
  ].filter((part): part is string => part != null)
  return parts.length > 0 ? parts.join(REEL_EXCERPT_SEPARATOR) : '—'
}
