import type { TextStyle, ViewStyle } from 'react-native';
import {
  MOMENT_OVERLAY_FONT_RATIO,
  MOMENT_OVERLAY_STYLE,
  MOMENT_SOFT_BACKDROP,
} from '@ola/shared/constants';
import { readableTextColor, resolveMomentTextFace } from '@ola/shared/lib';
import type { MomentOverlay } from '@ola/shared/types';
import {
  MOMENT_FONT_FACE,
  MOMENT_OVERLAY_LINE_HEIGHT,
  MOMENT_PLAIN_SHADOW,
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

export function overlayFontSize(overlay: MomentOverlay, canvasWidth: number): number {
  return canvasWidth * MOMENT_OVERLAY_FONT_RATIO * overlay.scale;
}

export function overlayTextStyle(overlay: MomentOverlay, canvasWidth: number): TextStyle {
  const fontSize = overlayFontSize(overlay, canvasWidth);
  const color =
    overlay.style === MOMENT_OVERLAY_STYLE.solid ? readableTextColor(overlay.color) : overlay.color;
  const face = resolveMomentTextFace(overlay);
  return {
    ...MOMENT_FONT_FACE[face.font][face.bold ? 'bold' : 'regular'],
    fontStyle: face.italic ? 'italic' : 'normal',
    ...(overlay.style === MOMENT_OVERLAY_STYLE.plain ? MOMENT_PLAIN_SHADOW : null),
    color,
    fontSize,
    lineHeight: fontSize * MOMENT_OVERLAY_LINE_HEIGHT,
    textAlign: overlay.align,
  };
}

export function overlayBubbleStyle(overlay: MomentOverlay, canvasWidth: number): ViewStyle {
  const fontSize = overlayFontSize(overlay, canvasWidth);
  const backgroundColor =
    overlay.style === MOMENT_OVERLAY_STYLE.solid
      ? overlay.color
      : overlay.style === MOMENT_OVERLAY_STYLE.soft
        ? MOMENT_SOFT_BACKDROP
        : undefined;
  return {
    backgroundColor,
    borderRadius: fontSize * 0.3,
    paddingHorizontal: fontSize * 0.35,
    paddingVertical: fontSize * 0.12,
  };
}
