const files = import.meta.glob('../../assets/icons/smiley/smiley_*.png', {
  eager: true,
  query: '?url',
  import: 'default',
}) as Record<string, string>;

export interface Smiley {
  index: number;
  code: string;
  src: string;
}

export function smileyCode(index: number): string {
  return `:ola${index}:`;
}

export const SMILEYS: Smiley[] = Object.entries(files)
  .map(([path, src]) => {
    const index = Number(path.match(/smiley_(\d+)\.png$/)?.[1] ?? 0);
    return { index, code: smileyCode(index), src };
  })
  .filter((item) => item.index > 0)
  .sort((a, b) => a.index - b.index);

const byIndex = new Map(SMILEYS.map((item) => [item.index, item.src]));

export function smileyImage(token: string): string | null {
  const match = token.match(/^:ola(\d{1,2}):$/);
  if (match == null) return null;
  return byIndex.get(Number(match[1])) ?? null;
}
