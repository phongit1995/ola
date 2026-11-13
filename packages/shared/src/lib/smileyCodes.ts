export const SMILEY_ALIASES: string[][] = [
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

export function buildSmileyPanel<T>(images: readonly T[]): Array<{ image: T; code: string }> {
  return images.map((image, index) => ({ image, code: SMILEY_ALIASES[index]?.[0] ?? '' }));
}

export function buildSmileyMap<T>(images: readonly T[]): Record<string, T> {
  const map: Record<string, T> = {};
  images.forEach((image, index) => {
    for (const code of SMILEY_ALIASES[index] ?? []) {
      map[code] = image;
    }
  });
  return map;
}

function escapeRegExp(value: string): string {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

export function buildSmileyRegex(codes: readonly string[]): RegExp {
  const pattern = [...codes]
    .sort((a, b) => b.length - a.length)
    .map(escapeRegExp)
    .join('|');
  return new RegExp(`\\[e:\\d{1,2}\\]|${pattern}`, 'g');
}
