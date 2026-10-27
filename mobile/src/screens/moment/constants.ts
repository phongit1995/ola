import { Platform, type TextStyle } from 'react-native';
import type { MomentFontKey } from '@ola/shared/constants';

export const MOMENT_ASPECT_RATIO = 9 / 16;
export const MOMENT_GRADIENT_ANGLE_DEG = 160;
export const MOMENT_OVERLAY_LINE_HEIGHT = 1.35;
export const MOMENT_TRAY_CARD_WIDTH = 90;
export const MOMENT_TRAY_CARD_HEIGHT = 160;
export const MOMENT_BACKDROP_BLUR = 24;
export const MOMENT_TURN_PERSPECTIVE = 3;
export const MOMENT_TURN_FLING_VELOCITY = 600;

type MomentFontFace = Pick<TextStyle, 'fontFamily' | 'fontWeight'>;

const SERIF_FAMILY = Platform.select({ ios: 'Georgia', default: 'serif' });
const MONO_FAMILY = Platform.select({ ios: 'Courier New', default: 'monospace' });

export const MOMENT_FONT_FACE: Record<MomentFontKey, { regular: MomentFontFace; bold: MomentFontFace }> = {
  sans: { regular: { fontWeight: '600' }, bold: { fontWeight: '800' } },
  serif: {
    regular: { fontFamily: SERIF_FAMILY, fontWeight: '600' },
    bold: { fontFamily: SERIF_FAMILY, fontWeight: '800' },
  },
  mono: { regular: { fontFamily: MONO_FAMILY }, bold: { fontFamily: MONO_FAMILY, fontWeight: '700' } },
  hand: { regular: { fontFamily: 'DancingScript-Regular' }, bold: { fontFamily: 'DancingScript-Bold' } },
  round: { regular: { fontFamily: 'Baloo2-Regular' }, bold: { fontFamily: 'Baloo2-ExtraBold' } },
  art: { regular: { fontFamily: 'Lobster-Regular' }, bold: { fontFamily: 'Lobster-Regular' } },
};

export const MOMENT_PLAIN_SHADOW: Pick<
  TextStyle,
  'textShadowColor' | 'textShadowOffset' | 'textShadowRadius'
> = {
  textShadowColor: 'rgba(0, 0, 0, 0.45)',
  textShadowOffset: { width: 0, height: 1 },
  textShadowRadius: 3,
};
