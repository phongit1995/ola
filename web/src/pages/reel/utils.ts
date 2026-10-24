import type { CSSProperties } from 'react';
import {
  REEL_OVERLAY_FONT_RATIO,
  REEL_OVERLAY_STYLE,
  REEL_SOFT_BACKDROP,
  type ReelBackground,
} from '@constants';
import { readableTextColor, reelBackgroundColors, resolveReelFont } from '@lib';
import type { ReelOverlay } from '@app-types';
import { REEL_FONT_FACE, REEL_PLAIN_SHADOW } from './constants';

export function reelBackgroundCss(background: ReelBackground): string {
  return background.kind === 'gradient'
    ? `linear-gradient(160deg, ${reelBackgroundColors(background).join(', ')})`
    : background.color;
}

export function overlayFontStyle(overlay: ReelOverlay): CSSProperties {
  const face = REEL_FONT_FACE[resolveReelFont(overlay.font)];
  return {
    fontFamily: face.family,
    fontWeight: face.weight,
    fontSize: `${REEL_OVERLAY_FONT_RATIO * 100 * overlay.scale}cqw`,
    lineHeight: 1.35,
    textAlign: overlay.align,
  };
}

export function overlayBoxStyle(overlay: ReelOverlay): CSSProperties {
  return {
    ...overlayFontStyle(overlay),
    position: 'absolute',
    left: `${overlay.x * 100}%`,
    top: `${overlay.y * 100}%`,
    width: 'max-content',
    maxWidth: `${overlay.w * 100}%`,
    transform: `translate(-50%, -50%) rotate(${overlay.rotation}deg)`,
  };
}

export function overlayTextStyle(overlay: ReelOverlay): CSSProperties {
  const base: CSSProperties = {
    padding: '0.12em 0.35em',
    borderRadius: '0.3em',
    boxDecorationBreak: 'clone',
    WebkitBoxDecorationBreak: 'clone',
    whiteSpace: 'pre-wrap',
    overflowWrap: 'anywhere',
  };
  if (overlay.style === REEL_OVERLAY_STYLE.solid) {
    return {
      ...base,
      backgroundColor: overlay.color,
      color: readableTextColor(overlay.color),
    };
  }
  if (overlay.style === REEL_OVERLAY_STYLE.soft) {
    return { ...base, backgroundColor: REEL_SOFT_BACKDROP, color: overlay.color };
  }
  return { ...base, color: overlay.color, textShadow: REEL_PLAIN_SHADOW };
}
