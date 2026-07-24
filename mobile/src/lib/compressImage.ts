import ImageResizer from '@bam.tech/react-native-image-resizer';
import type { NativeUploadFile } from '@ola/shared/lib';
import { MAX_UPLOAD_BYTES } from '@ola/shared/constants';

const MAX_DIMENSION = 1920;
const MIN_DIMENSION = 320;
const DIMENSION_STEP = 0.8;
const MAX_DOWNSCALE_ROUNDS = 12;
const QUALITY_STEPS = [90, 80, 70, 60, 50];

export class ImageTooLargeError extends Error {
  constructor() {
    super('image exceeds max upload size');
    this.name = 'ImageTooLargeError';
  }
}

function toJpegName(name: string): string {
  const base = name.replace(/\.[^./\\]+$/, '');
  return `${base === '' ? 'image' : base}.jpg`;
}

function isGif(file: NativeUploadFile): boolean {
  return file.type === 'image/gif' || /\.gif$/i.test(file.name);
}

interface EncodedImage {
  uri: string;
  size: number;
}

async function encodeAtDimension(uri: string, dimension: number): Promise<EncodedImage | null> {
  let output: EncodedImage | null = null;
  for (const quality of QUALITY_STEPS) {
    const result = await ImageResizer.createResizedImage(
      uri,
      dimension,
      dimension,
      'JPEG',
      quality,
      0,
      undefined,
      false,
      { mode: 'contain', onlyScaleDown: true },
    );
    output = { uri: result.uri, size: result.size };
    if (result.size <= MAX_UPLOAD_BYTES) return output;
  }
  return output;
}

export async function compressImageForUpload(file: NativeUploadFile): Promise<NativeUploadFile> {
  if (isGif(file)) return file;

  let dimension = MAX_DIMENSION;
  let smallest: EncodedImage | null = null;
  for (let round = 0; round < MAX_DOWNSCALE_ROUNDS; round += 1) {
    const encoded = await encodeAtDimension(file.uri, dimension);
    if (encoded != null && (smallest == null || encoded.size < smallest.size)) smallest = encoded;
    if (encoded != null && encoded.size <= MAX_UPLOAD_BYTES) {
      return { uri: encoded.uri, name: toJpegName(file.name), type: 'image/jpeg' };
    }
    if (dimension <= MIN_DIMENSION) break;
    dimension = Math.max(MIN_DIMENSION, Math.round(dimension * DIMENSION_STEP));
  }

  if (smallest == null) throw new Error('compress failed');
  if (smallest.size > MAX_UPLOAD_BYTES) throw new ImageTooLargeError();
  return { uri: smallest.uri, name: toJpegName(file.name), type: 'image/jpeg' };
}

export async function compressImagesForUpload(files: NativeUploadFile[]): Promise<NativeUploadFile[]> {
  const prepared: NativeUploadFile[] = [];
  for (const file of files) prepared.push(await compressImageForUpload(file));
  return prepared;
}
