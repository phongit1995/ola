const files = import.meta.glob('../../assets/stickers/kul/*.png', {
  eager: true,
  query: '?url',
  import: 'default',
}) as Record<string, string>;

export interface KulSticker {
  index: number;
  src: string;
}

export const KUL_STICKERS: KulSticker[] = Object.entries(files)
  .map(([path, src]) => ({ index: Number(path.match(/kul(\d+)\.png$/)?.[1] ?? 0), src }))
  .filter((item) => item.index > 0)
  .sort((a, b) => a.index - b.index);

const byIndex = new Map(KUL_STICKERS.map((item) => [item.index, item.src]));

export const STICKER_PREFIX = 'kul:';

export function kulCode(index: number): string {
  return `${STICKER_PREFIX}${index}`;
}

export function stickerImage(code: string | null | undefined): string | null {
  if (code == null || code === '') return null;
  if (!code.startsWith(STICKER_PREFIX)) return null;
  return byIndex.get(Number(code.slice(STICKER_PREFIX.length))) ?? null;
}
