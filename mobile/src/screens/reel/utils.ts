import type { TextStyle, ViewStyle } from 'react-native';
import {
  REEL_OVERLAY_FONT_RATIO,
  REEL_OVERLAY_STYLE,
  REEL_SOFT_BACKDROP,
} from '@ola/shared/constants';
import { readableTextColor, resolveReelFont } from '@ola/shared/lib';
import type { ReelOverlay } from '@ola/shared/types';
import {
  REEL_FONT_FACE,
  REEL_OVERLAY_LINE_HEIGHT,
  REEL_PLAIN_SHADOW,
} from './constants';

export interface GradientPoints {
  start: { x: number; y: number };
  end: { x: number; y: number };
}

export function gradientPoints(angleDeg: number): GradientPoints {
  const radians = (angleDeg * Math.PI) / 180;
  const dx = Math.sin(radians) / 2;
  const dy = -Math.cos(radians) / 2;
  return {
    start: { x: 0.5 - dx, y: 0.5 - dy },
    end: { x: 0.5 + dx, y: 0.5 + dy },
  };
}

export function overlayFontSize(overlay: ReelOverlay, canvasWidth: number): number {
  return canvasWidth * REEL_OVERLAY_FONT_RATIO * overlay.scale;
}

export function overlayTextStyle(overlay: ReelOverlay, canvasWidth: number): TextStyle {
  const fontSize = overlayFontSize(overlay, canvasWidth);
  const color =
    overlay.style === REEL_OVERLAY_STYLE.solid ? readableTextColor(overlay.color) : overlay.color;
  return {
    ...REEL_FONT_FACE[resolveReelFont(overlay.font)],
    ...(overlay.style === REEL_OVERLAY_STYLE.plain ? REEL_PLAIN_SHADOW : null),
    color,
    fontSize,
    lineHeight: fontSize * REEL_OVERLAY_LINE_HEIGHT,
    textAlign: overlay.align,
  };
}

export function overlayBubbleStyle(overlay: ReelOverlay, canvasWidth: number): ViewStyle {
  const fontSize = overlayFontSize(overlay, canvasWidth);
  const backgroundColor =
    overlay.style === REEL_OVERLAY_STYLE.solid
      ? overlay.color
      : overlay.style === REEL_OVERLAY_STYLE.soft
        ? REEL_SOFT_BACKDROP
        : undefined;
  return {
    backgroundColor,
    borderRadius: fontSize * 0.3,
    paddingHorizontal: fontSize * 0.35,
    paddingVertical: fontSize * 0.12,
  };
}
