import { emojiTokenIndex } from '@ola/shared/lib';
const emojiFiles = import.meta.glob('../../assets/icons/emoji/*.png', {
  eager: true,
  import: 'default',
}) as Record<string, string>;

export const EMOJI_IMAGES: string[] = Object.keys(emojiFiles)
  .sort()
  .map((path) => emojiFiles[path]!);

export function emojiImageForToken(token: string): string | null {
  const index = emojiTokenIndex(token);
  if (index == null || index < 1 || index > EMOJI_IMAGES.length) return null;
  return EMOJI_IMAGES[index - 1] ?? null;
}
