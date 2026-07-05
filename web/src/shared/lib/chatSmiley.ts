import { emojiImageForToken } from './emoji';

const smileyFiles = import.meta.glob('../../assets/icons/chat/smiley/*.png', {
  eager: true,
  import: 'default',
}) as Record<string, string>;

export const SMILEY_IMAGES: string[] = Object.keys(smileyFiles)
  .sort()
  .map((path) => smileyFiles[path]!);

const SMILEY_ALIASES: string[][] = [
  [':-)', ':)'],
  [':-P', ':-p', ':p', ':P'],
  ['>:D<'],
  [':-))', ':))'],
  [':">'],
  ['B-)', 'b-)', 'B)', 'b)'],
  [':-X', ':-x', ':X', ':x'],
  [':-*', ':*'],
  [':-|', ':|'],
  [':-D', ':-d', ':D', ':d'],
  [';-)', ';)'],
  ['|-)', '|)'],
  ['(:|'],
  [':-/'],
  [':-<', ':<'],
  [':-&', ':&'],
  [':-(', ':('],
  [':-B', ':-b', ':B', ':b'],
  [':-O', ':-o', ':O', ':o'],
  [':-h', ':-H', ':h', ':H'],
  [':-S', ':-s', ':S', ':s'],
  [':-?', ':?'],
  [':-((', ':(('],
  ['=(('],
  ['=;'],
  [':-W', ':-w', ':W', ':w'],
  ['X-(', 'x-(', 'X(', 'x('],
  ['>:)'],
  [';))'],
  ['>:P'],
  ['/:)'],
  ['<3'],
  ['(*)'],
  ['@;-', '@};-'],
  ['(y)', '(Y)'],
  ['(n)', '(N)'],
  ['^_^'],
  [':v'],
  [':3'],
  ['=))'],
  ['@@'],
  ['@)'],
  [':’('],
  ['O:)', 'o:)', '0:)'],
  ['>:O', '>:o', '>:0'],
];

export const SMILEY_PANEL: Array<{ image: string; code: string }> = SMILEY_IMAGES.map(
  (image, index) => ({ image, code: SMILEY_ALIASES[index]?.[0] ?? '' })
);

const SMILEY_MAP: Record<string, string> = (() => {
  const map: Record<string, string> = {};
  SMILEY_IMAGES.forEach((image, index) => {
    for (const code of SMILEY_ALIASES[index] ?? []) {
      map[code] = image;
    }
  });
  return map;
})();

export function smileyImageForCode(code: string): string | null {
  return SMILEY_MAP[code] ?? emojiImageForToken(code);
}

function escapeRegExp(value: string): string {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

const SMILEY_PATTERN = Object.keys(SMILEY_MAP)
  .sort((a, b) => b.length - a.length)
  .map(escapeRegExp)
  .join('|');

const SMILEY_REGEX = new RegExp(`\\[e:\\d{1,2}\\]|${SMILEY_PATTERN}`, 'g');

export type SmileyVariant = 'smiley' | 'emoji';

export const SMILEY_IMG_CLASS = 'inline-block h-[1.25em] w-auto align-text-bottom';
export const EMOJI_IMG_CLASS = 'inline-block h-[1.15em] w-auto align-text-bottom';

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
        segments.push({ kind: 'text', value: text.slice(lastIndex, match.index) });
      }
      segments.push({ kind: 'image', src, code, variant: smileySrc != null ? 'smiley' : 'emoji' });
      lastIndex = match.index + code.length;
    }
    match = SMILEY_REGEX.exec(text);
  }
  if (lastIndex < text.length) {
    segments.push({ kind: 'text', value: text.slice(lastIndex) });
  }
  return segments;
}
