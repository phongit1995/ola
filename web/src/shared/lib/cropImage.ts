import type { Area } from 'react-easy-crop';

function loadImage(src: string): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const image = new Image();
    image.onload = () => resolve(image);
    image.onerror = () => reject(new Error('decode failed'));
    image.src = src;
  });
}

const MAX_OUTPUT_WIDTH = 1920;

export async function getCroppedImageFile(
  src: string,
  area: Area,
  fileName = 'cover.jpg'
): Promise<File> {
  const image = await loadImage(src);
  const sx = Math.max(0, Math.round(area.x));
  const sy = Math.max(0, Math.round(area.y));
  const sw = Math.min(Math.round(area.width), image.naturalWidth - sx);
  const sh = Math.min(Math.round(area.height), image.naturalHeight - sy);
  if (sw <= 0 || sh <= 0) throw new Error('invalid crop area');
  const scale = sw > MAX_OUTPUT_WIDTH ? MAX_OUTPUT_WIDTH / sw : 1;
  const width = Math.max(1, Math.round(sw * scale));
  const height = Math.max(1, Math.round(sh * scale));
  const canvas = document.createElement('canvas');
  canvas.width = width;
  canvas.height = height;
  const ctx = canvas.getContext('2d');
  if (!ctx) throw new Error('canvas unavailable');
  ctx.drawImage(image, sx, sy, sw, sh, 0, 0, width, height);
  const blob = await new Promise<Blob | null>((resolve) =>
    canvas.toBlob(resolve, 'image/jpeg', 0.92)
  );
  if (!blob) throw new Error('crop failed');
  return new File([blob], fileName, { type: 'image/jpeg' });
}
