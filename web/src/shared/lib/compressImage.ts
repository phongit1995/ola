const MAX_UPLOAD_BYTES = 2 * 1024 * 1024;
const MAX_DIMENSION = 1920;
const QUALITY_STEPS = [0.9, 0.8, 0.7, 0.6, 0.5];
const PASSTHROUGH_TYPES = ['image/jpeg', 'image/png', 'image/webp'];

function needsCompression(file: File): boolean {
  if (file.type === 'image/gif') return false;
  if (PASSTHROUGH_TYPES.includes(file.type) && file.size <= MAX_UPLOAD_BYTES) return false;
  return true;
}

function loadImageFromFile(file: Blob): Promise<HTMLImageElement> {
  const url = URL.createObjectURL(file);
  return new Promise((resolve, reject) => {
    const image = new Image();
    image.onload = () => {
      URL.revokeObjectURL(url);
      resolve(image);
    };
    image.onerror = () => {
      URL.revokeObjectURL(url);
      reject(new Error('decode failed'));
    };
    image.src = url;
  });
}

function canvasToJpeg(canvas: HTMLCanvasElement, quality: number): Promise<Blob | null> {
  return new Promise((resolve) => canvas.toBlob(resolve, 'image/jpeg', quality));
}

function toJpegName(name: string): string {
  const base = name.replace(/\.[^./\\]+$/, '');
  return `${base === '' ? 'image' : base}.jpg`;
}

export async function compressImageForUpload(file: File): Promise<File> {
  if (!needsCompression(file)) return file;

  const image = await loadImageFromFile(file);
  const scale = Math.min(1, MAX_DIMENSION / Math.max(image.naturalWidth, image.naturalHeight));

  const canvas = document.createElement('canvas');
  canvas.width = Math.max(1, Math.round(image.naturalWidth * scale));
  canvas.height = Math.max(1, Math.round(image.naturalHeight * scale));
  const ctx = canvas.getContext('2d');
  if (!ctx) throw new Error('canvas unavailable');
  ctx.drawImage(image, 0, 0, canvas.width, canvas.height);

  let output: Blob | null = null;
  for (const quality of QUALITY_STEPS) {
    output = await canvasToJpeg(canvas, quality);
    if (output != null && output.size <= MAX_UPLOAD_BYTES) break;
  }
  if (output == null) throw new Error('compress failed');

  return new File([output], toJpegName(file.name), { type: 'image/jpeg' });
}
