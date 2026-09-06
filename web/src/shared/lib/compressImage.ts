import {
  MAX_UPLOAD_BYTES,
  UPLOAD_JPEG_QUALITY_STEPS,
  UPLOAD_MAX_DOWNSCALE_ROUNDS,
} from '@ola/shared/constants';
import {
  ImageTooLargeError,
  assertUploadSize,
  canUploadImageOriginal,
  fitUploadDimensions,
  initialUploadLongestSide,
  isGifImage,
  isHeicImage,
  isMinUploadLongestSide,
  nextUploadLongestSide,
  preservesAlpha,
  withUploadExtension,
} from '@ola/shared/lib';

const HEIC_CONVERT_QUALITY = 0.92;

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

function canvasToBlob(
  canvas: HTMLCanvasElement,
  type: 'image/jpeg' | 'image/png',
  quality?: number
): Promise<Blob | null> {
  return new Promise((resolve) => canvas.toBlob(resolve, type, quality));
}

async function convertHeicToJpeg(file: File): Promise<File> {
  const { default: heic2any } = await import('heic2any');
  const converted = await heic2any({
    blob: file,
    toType: 'image/jpeg',
    quality: HEIC_CONVERT_QUALITY,
  });
  const blob = Array.isArray(converted) ? converted[0] : converted;
  if (blob == null) throw new Error('heic decode failed');
  return new File([blob], withUploadExtension(file.name, 'jpg'), {
    type: 'image/jpeg',
  });
}

function drawToCanvas(
  image: HTMLImageElement,
  longest: number
): HTMLCanvasElement {
  const { width, height } = fitUploadDimensions(
    image.naturalWidth,
    image.naturalHeight,
    longest
  );
  const canvas = document.createElement('canvas');
  canvas.width = width;
  canvas.height = height;
  const ctx = canvas.getContext('2d');
  if (!ctx) throw new Error('canvas unavailable');
  ctx.drawImage(image, 0, 0, width, height);
  return canvas;
}

async function encodeJpegAtLongestSide(
  image: HTMLImageElement,
  longest: number
): Promise<Blob | null> {
  const canvas = drawToCanvas(image, longest);
  let output: Blob | null = null;
  for (const quality of UPLOAD_JPEG_QUALITY_STEPS) {
    output = await canvasToBlob(canvas, 'image/jpeg', quality);
    if (output != null && output.size <= MAX_UPLOAD_BYTES) return output;
  }
  return output;
}

export async function compressImageForUpload(file: File): Promise<File> {
  if (isGifImage(file)) {
    assertUploadSize(file.size);
    return file;
  }
  const source = isHeicImage(file) ? await convertHeicToJpeg(file) : file;

  const image = await loadImageFromFile(source);
  if (
    canUploadImageOriginal({
      type: source.type,
      name: source.name,
      size: source.size,
      width: image.naturalWidth,
      height: image.naturalHeight,
    })
  ) {
    return source;
  }

  let longest = initialUploadLongestSide(
    image.naturalWidth,
    image.naturalHeight
  );

  if (preservesAlpha(source.type)) {
    const png = await canvasToBlob(drawToCanvas(image, longest), 'image/png');
    if (png != null && png.size <= MAX_UPLOAD_BYTES) {
      return new File([png], withUploadExtension(source.name, 'png'), {
        type: 'image/png',
      });
    }
  }

  let smallest: Blob | null = null;
  for (let round = 0; round < UPLOAD_MAX_DOWNSCALE_ROUNDS; round += 1) {
    const encoded = await encodeJpegAtLongestSide(image, longest);
    if (encoded != null && (smallest == null || encoded.size < smallest.size))
      smallest = encoded;
    if (encoded != null && encoded.size <= MAX_UPLOAD_BYTES) {
      return new File([encoded], withUploadExtension(source.name, 'jpg'), {
        type: 'image/jpeg',
      });
    }
    if (isMinUploadLongestSide(longest)) break;
    longest = nextUploadLongestSide(longest);
  }

  if (smallest == null) throw new Error('compress failed');
  if (smallest.size > MAX_UPLOAD_BYTES) throw new ImageTooLargeError();
  return new File([smallest], withUploadExtension(source.name, 'jpg'), {
    type: 'image/jpeg',
  });
}

export function compressImagesForUpload(files: File[]): Promise<File[]> {
  return Promise.all(files.map((file) => compressImageForUpload(file)));
}
