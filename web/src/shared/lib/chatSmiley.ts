import {
  buildSmileyMap,
  buildSmileyPanel,
  buildSmileyRegex,
} from '@ola/shared/lib';
import { emojiImageForToken } from './emoji';

const smileyFiles = import.meta.glob('../../assets/icons/chat/smiley/*.png', {
  eager: true,
  import: 'default',
}) as Record<string, string>;

export const SMILEY_IMAGES: string[] = Object.keys(smileyFiles)
  .sort()
  .map((path) => smileyFiles[path]!);

export const SMILEY_PANEL: Array<{ image: string; code: string }> =
  buildSmileyPanel(SMILEY_IMAGES);

const SMILEY_MAP: Record<string, string> = buildSmileyMap(SMILEY_IMAGES);

export function smileyImageForCode(code: string): string | null {
  return SMILEY_MAP[code] ?? emojiImageForToken(code);
}

const SMILEY_REGEX = buildSmileyRegex(Object.keys(SMILEY_MAP));

export type SmileyVariant = 'smiley' | 'emoji';

export const SMILEY_IMG_CLASS =
  'inline-block h-[1.25em] w-auto align-text-bottom';
export const EMOJI_IMG_CLASS =
  'inline-block h-[1.15em] w-auto align-text-bottom';

export function smileyImgClass(variant: SmileyVariant): string {
  return variant === 'emoji' ? EMOJI_IMG_CLASS : SMILEY_IMG_CLASS;
}

export type SmileySegment =
  | { kind: 'text'; value: string }
  | { kind: 'image'; src: string; code: string; variant: SmileyVariant };

export function splitSmileys(text: string): SmileySegment[] {
  const segments: SmileySegment[] = [];
  let lastIndex = 0;
  SMILEY_REGEX.lastIndex = 0;
  let match = SMILEY_REGEX.exec(text);
  while (match != null) {
    const code = match[0];
    const smileySrc = SMILEY_MAP[code];
    const src = smileySrc ?? emojiImageForToken(code);
    if (src != null) {
      if (match.index > lastIndex) {
        segments.push({
          kind: 'text',
          value: text.slice(lastIndex, match.index),
        });
      }
      segments.push({
        kind: 'image',
        src,
        code,
        variant: smileySrc != null ? 'smiley' : 'emoji',
      });
      lastIndex = match.index + code.length;
    }
    match = SMILEY_REGEX.exec(text);
  }
  if (lastIndex < text.length) {
    segments.push({ kind: 'text', value: text.slice(lastIndex) });
  }
  return segments;
}
