const EMOJI_TOKEN = /^\[e:(\d{1,2})\]$/;

export function emojiToken(index: number): string {
  return `[e:${index}]`;
}

export function isEmojiToken(text: string): boolean {
  return EMOJI_TOKEN.test(text);
}

export function emojiTokenIndex(token: string): number | null {
  const match = token.match(EMOJI_TOKEN);
  return match == null ? null : Number(match[1]);
}
