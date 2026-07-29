import type { Area } from 'react-easy-crop';

const MAX_OUTPUT_WIDTH = 1920;

function loadImage(src: string): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const image = new Image();
    image.onload = () => resolve(image);
    image.onerror = () => reject(new Error('decode failed'));
    image.src = src;
  });
}

function rotatedBoundingBox(width: number, height: number, rotation: number) {
  const rad = (rotation * Math.PI) / 180;
  return {
    width: Math.abs(Math.cos(rad) * width) + Math.abs(Math.sin(rad) * height),
    height: Math.abs(Math.sin(rad) * width) + Math.abs(Math.cos(rad) * height),
  };
}

export async function getCroppedImageFile(
  src: string,
  area: Area,
  rotation = 0,
  fileName = 'cover.jpg'
): Promise<File> {
  const image = await loadImage(src);
  const box = rotatedBoundingBox(
    image.naturalWidth,
    image.naturalHeight,
    rotation
  );

  const rotated = document.createElement('canvas');
  rotated.width = Math.round(box.width);
  rotated.height = Math.round(box.height);
  const rctx = rotated.getContext('2d');
  if (!rctx) throw new Error('canvas unavailable');
  rctx.translate(rotated.width / 2, rotated.height / 2);
  rctx.rotate((rotation * Math.PI) / 180);
  rctx.drawImage(image, -image.naturalWidth / 2, -image.naturalHeight / 2);

  const sx = Math.max(0, Math.round(area.x));
  const sy = Math.max(0, Math.round(area.y));
  const sw = Math.min(Math.round(area.width), rotated.width - sx);
  const sh = Math.min(Math.round(area.height), rotated.height - sy);
  if (sw <= 0 || sh <= 0) throw new Error('invalid crop area');

  const scale = sw > MAX_OUTPUT_WIDTH ? MAX_OUTPUT_WIDTH / sw : 1;
  const width = Math.max(1, Math.round(sw * scale));
  const height = Math.max(1, Math.round(sh * scale));

  const out = document.createElement('canvas');
  out.width = width;
  out.height = height;
  const octx = out.getContext('2d');
  if (!octx) throw new Error('canvas unavailable');
  octx.drawImage(rotated, sx, sy, sw, sh, 0, 0, width, height);

  const blob = await new Promise<Blob | null>((resolve) =>
    out.toBlob(resolve, 'image/jpeg', 0.92)
  );
  if (!blob) throw new Error('crop failed');
  return new File([blob], fileName, { type: 'image/jpeg' });
}
