import type { CSSProperties } from 'react';
import {
  MOMENT_OVERLAY_FONT_RATIO,
  MOMENT_OVERLAY_STYLE,
  MOMENT_SOFT_BACKDROP,
  type MomentBackground,
} from '@constants';
import { readableTextColor, momentBackgroundColors, resolveMomentTextFace } from '@lib';
import type { MomentOverlay } from '@app-types';
import { MOMENT_FONT_FACE, MOMENT_PLAIN_SHADOW, MOMENT_TURN_PERSPECTIVE_PX } from './constants';

export function momentBackgroundCss(background: MomentBackground): string {
  return background.kind === 'gradient'
    ? `linear-gradient(160deg, ${momentBackgroundColors(background).join(', ')})`
    : background.color;
}

export function overlayFontStyle(overlay: MomentOverlay): CSSProperties {
  const face = resolveMomentTextFace(overlay);
  const font = MOMENT_FONT_FACE[face.font];
  return {
    fontFamily: font.family,
    fontWeight: face.bold ? font.boldWeight : font.weight,
    fontStyle: face.italic ? 'italic' : 'normal',
    fontSize: `${MOMENT_OVERLAY_FONT_RATIO * 100 * overlay.scale}cqw`,
    lineHeight: 1.35,
    textAlign: overlay.align,
  };
}

export function overlayBoxStyle(overlay: MomentOverlay): CSSProperties {
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

export function overlayTextStyle(overlay: MomentOverlay): CSSProperties {
  const base: CSSProperties = {
    padding: '0.12em 0.35em',
    borderRadius: '0.3em',
    boxDecorationBreak: 'clone',
    WebkitBoxDecorationBreak: 'clone',
    whiteSpace: 'pre-wrap',
    overflowWrap: 'anywhere',
  };
  if (overlay.style === MOMENT_OVERLAY_STYLE.solid) {
    return {
      ...base,
      backgroundColor: overlay.color,
      color: readableTextColor(overlay.color),
    };
  }
  if (overlay.style === MOMENT_OVERLAY_STYLE.soft) {
    return { ...base, backgroundColor: MOMENT_SOFT_BACKDROP, color: overlay.color };
  }
  return { ...base, color: overlay.color, textShadow: MOMENT_PLAIN_SHADOW };
}

const SELECTION_BAR_GAP = 24;
const SELECTION_BAR_HEIGHT = 40;
const SELECTION_BAR_MARGIN = 8;

export function selectionBarTop(
  box: Pick<DOMRect, 'top' | 'bottom'>,
  canvas: Pick<DOMRect, 'top' | 'height'>
): number {
  const below = box.bottom - canvas.top + SELECTION_BAR_GAP;
  if (below + SELECTION_BAR_HEIGHT <= canvas.height - SELECTION_BAR_MARGIN) return below;
  const above = box.top - canvas.top - SELECTION_BAR_GAP - SELECTION_BAR_HEIGHT;
  return Math.max(SELECTION_BAR_MARGIN, above);
}

export function momentTurnStyle(offset: number): CSSProperties | undefined {
  if (offset === 0) return undefined;
  const edge = offset < 0 ? 50 : -50;
  return {
    transform: `perspective(${MOMENT_TURN_PERSPECTIVE_PX}px) translateX(${offset * 100 + edge}%) rotateY(${offset * 90}deg) translateX(${-edge}%)`,
    visibility: Math.abs(offset) >= 1 ? 'hidden' : undefined,
  };
}
