import type { ImageSourcePropType } from 'react-native';
import { EMOJI_IMAGES } from './emojiImages';

export { EMOJI_IMAGES };

const EMOJI_TOKEN = /^\[e:(\d{1,2})\]$/;

export function emojiToken(index: number): string {
  return `[e:${index}]`;
}

export function isEmojiToken(text: string): boolean {
  return EMOJI_TOKEN.test(text);
}

export function emojiImageForToken(token: string): ImageSourcePropType | null {
  const match = token.match(EMOJI_TOKEN);
  if (match == null) return null;
  const index = Number(match[1]);
  if (index < 1 || index > EMOJI_IMAGES.length) return null;
  return EMOJI_IMAGES[index - 1] ?? null;
}
