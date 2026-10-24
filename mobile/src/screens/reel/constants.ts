import { Platform, type TextStyle } from 'react-native';
import type { ReelFontKey } from '@ola/shared/constants';

export const REEL_ASPECT_RATIO = 9 / 16;
export const REEL_GRADIENT_ANGLE_DEG = 160;
export const REEL_OVERLAY_LINE_HEIGHT = 1.35;
export const REEL_TRAY_CARD_WIDTH = 90;
export const REEL_TRAY_CARD_HEIGHT = 160;
export const REEL_GRID_COLUMNS = 3;
export const REEL_BACKDROP_BLUR = 24;

export const REEL_FONT_FACE: Record<ReelFontKey, Pick<TextStyle, 'fontFamily' | 'fontWeight'>> = {
  sans: { fontWeight: '600' },
  serif: { fontFamily: Platform.select({ ios: 'Georgia', default: 'serif' }), fontWeight: '600' },
  bold: { fontWeight: '800' },
};

export const REEL_PLAIN_SHADOW: Pick<
  TextStyle,
  'textShadowColor' | 'textShadowOffset' | 'textShadowRadius'
> = {
  textShadowColor: 'rgba(0, 0, 0, 0.45)',
  textShadowOffset: { width: 0, height: 1 },
  textShadowRadius: 3,
};
