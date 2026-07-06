const emojiFiles = import.meta.glob('../../assets/icons/emoji/*.png', {
  eager: true,
  import: 'default',
}) as Record<string, string>;

export const EMOJI_IMAGES: string[] = Object.keys(emojiFiles)
  .sort()
  .map((path) => emojiFiles[path]!);

const EMOJI_TOKEN = /^\[e:(\d{1,2})\]$/;

export function emojiToken(index: number): string {
  return `[e:${index}]`;
}

export function isEmojiToken(text: string): boolean {
  return EMOJI_TOKEN.test(text);
}

export function emojiImageForToken(token: string): string | null {
  const match = token.match(EMOJI_TOKEN);
  if (match == null) return null;
  const index = Number(match[1]);
  if (index < 1 || index > EMOJI_IMAGES.length) return null;
  return EMOJI_IMAGES[index - 1] ?? null;
}
