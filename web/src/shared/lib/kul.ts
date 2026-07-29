const kulFiles = import.meta.glob('../../assets/icons/chat/kul/*.png', {
  eager: true,
  import: 'default',
}) as Record<string, string>;

export const KUL_IMAGES: string[] = Object.keys(kulFiles)
  .sort()
  .map((path) => kulFiles[path]!);

const KUL_TOKEN = /^\[kul:(\d{1,2})\]$/;

export function kulToken(index: number): string {
  return `[kul:${index}]`;
}

export function kulImageForText(
  text: string | undefined | null
): string | null {
  if (text == null) return null;
  const match = text.trim().match(KUL_TOKEN);
  if (match == null) return null;
  const index = Number(match[1]);
  if (index < 1 || index > KUL_IMAGES.length) return null;
  return KUL_IMAGES[index - 1] ?? null;
}
