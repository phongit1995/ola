import type { ImageSourcePropType } from 'react-native';
import { KUL_IMAGES } from './kulImages';

export { KUL_IMAGES };

const KUL_TOKEN = /^\[kul:(\d{1,2})\]$/;

export function kulToken(index: number): string {
  return `[kul:${index}]`;
}

export function kulImageForText(text: string | undefined | null): ImageSourcePropType | null {
  if (text == null) return null;
  const match = text.trim().match(KUL_TOKEN);
  if (match == null) return null;
  const index = Number(match[1]);
  if (index < 1 || index > KUL_IMAGES.length) return null;
  return KUL_IMAGES[index - 1] ?? null;
}

const STICKER_PREFIX = 'kul:';

export function stickerImageForCode(code: string | undefined | null): ImageSourcePropType | null {
  if (code == null || code === '' || !code.startsWith(STICKER_PREFIX)) return null;
  const index = Number(code.slice(STICKER_PREFIX.length));
  if (!Number.isFinite(index) || index < 1 || index > KUL_IMAGES.length) return null;
  return KUL_IMAGES[index - 1] ?? null;
}
