import type { ImageSourcePropType } from 'react-native';
import { EMOJI_IMAGES } from './emojiImages';
import { emojiTokenIndex } from '@ola/shared/lib';

export { EMOJI_IMAGES };

export function emojiImageForToken(token: string): ImageSourcePropType | null {
  const index = emojiTokenIndex(token);
  if (index == null || index < 1 || index > EMOJI_IMAGES.length) return null;
  return EMOJI_IMAGES[index - 1] ?? null;
}
