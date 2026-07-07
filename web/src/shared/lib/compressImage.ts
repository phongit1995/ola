const MAX_UPLOAD_BYTES = 2 * 1024 * 1024;
const MAX_DIMENSION = 1920;
const MIN_DIMENSION = 320;
const DIMENSION_STEP = 0.8;
const MAX_DOWNSCALE_ROUNDS = 12;
const QUALITY_STEPS = [0.9, 0.8, 0.7, 0.6, 0.5];
const PASSTHROUGH_TYPES = ['image/jpeg', 'image/png', 'image/webp'];
const HEIC_TYPES = ['image/heic', 'image/heif'];
const HEIC_CONVERT_QUALITY = 0.92;

export class ImageTooLargeError extends Error {
  constructor() {
    super('image exceeds max upload size');
    this.name = 'ImageTooLargeError';
  }
}

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

function isHeic(file: File): boolean {
  if (HEIC_TYPES.includes(file.type)) return true;
  return /\.hei[cf]$/i.test(file.name);
}

async function convertHeicToJpeg(file: File): Promise<File> {
  const { default: heic2any } = await import('heic2any');
  const converted = await heic2any({ blob: file, toType: 'image/jpeg', quality: HEIC_CONVERT_QUALITY });
  const blob = Array.isArray(converted) ? converted[0] : converted;
  if (blob == null) throw new Error('heic decode failed');
  return new File([blob], toJpegName(file.name), { type: 'image/jpeg' });
}

async function encodeAtDimensions(
  image: HTMLImageElement,
  width: number,
  height: number
): Promise<Blob | null> {
  const canvas = document.createElement('canvas');
  canvas.width = width;
  canvas.height = height;
  const ctx = canvas.getContext('2d');
  if (!ctx) throw new Error('canvas unavailable');
  ctx.drawImage(image, 0, 0, width, height);

  let output: Blob | null = null;
  for (const quality of QUALITY_STEPS) {
    output = await canvasToJpeg(canvas, quality);
    if (output != null && output.size <= MAX_UPLOAD_BYTES) return output;
  }
  return output;
}

export async function compressImageForUpload(file: File): Promise<File> {
  const source = isHeic(file) ? await convertHeicToJpeg(file) : file;

  if (!needsCompression(source)) {
    if (source.size > MAX_UPLOAD_BYTES) throw new ImageTooLargeError();
    return source;
  }

  const image = await loadImageFromFile(source);
  const initialScale = Math.min(
    1,
    MAX_DIMENSION / Math.max(image.naturalWidth, image.naturalHeight)
  );
  let width = Math.max(1, Math.round(image.naturalWidth * initialScale));
  let height = Math.max(1, Math.round(image.naturalHeight * initialScale));

  let smallest: Blob | null = null;
  for (let round = 0; round < MAX_DOWNSCALE_ROUNDS; round += 1) {
    const encoded = await encodeAtDimensions(image, width, height);
    if (encoded != null && (smallest == null || encoded.size < smallest.size)) smallest = encoded;
    if (encoded != null && encoded.size <= MAX_UPLOAD_BYTES) {
      return new File([encoded], toJpegName(source.name), { type: 'image/jpeg' });
    }
    if (width <= MIN_DIMENSION && height <= MIN_DIMENSION) break;
    width = Math.max(MIN_DIMENSION, Math.round(width * DIMENSION_STEP));
    height = Math.max(MIN_DIMENSION, Math.round(height * DIMENSION_STEP));
  }

  if (smallest == null) throw new Error('compress failed');
  if (smallest.size > MAX_UPLOAD_BYTES) throw new ImageTooLargeError();
  return new File([smallest], toJpegName(source.name), { type: 'image/jpeg' });
}

export function compressImagesForUpload(files: File[]): Promise<File[]> {
  return Promise.all(files.map((file) => compressImageForUpload(file)));
}
