import { toast } from '@ola/shared/lib';

export function readImageSize(
  url: string
): Promise<{ width: number; height: number }> {
  return new Promise((resolve, reject) => {
    const probe = new Image();
    probe.onload = () =>
      resolve({ width: probe.naturalWidth, height: probe.naturalHeight });
    probe.onerror = () => reject(new Error('decode failed'));
    probe.src = url;
  });
}

export async function validatedImageObjectUrl(
  file: File,
  minSize: number,
  messages: { tooSmall: string; error: string }
): Promise<string | null> {
  const url = URL.createObjectURL(file);
  try {
    const size = await readImageSize(url);
    if (Math.min(size.width, size.height) < minSize) {
      URL.revokeObjectURL(url);
      toast.error(messages.tooSmall);
      return null;
    }
    return url;
  } catch {
    URL.revokeObjectURL(url);
    toast.error(messages.error);
    return null;
  }
}
