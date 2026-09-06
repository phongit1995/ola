import { Image } from 'react-native';
import ImageResizer, { type ResizeFormat } from '@bam.tech/react-native-image-resizer';
import ReactNativeBlobUtil from 'react-native-blob-util';
import type { NativeUploadFile } from '@ola/shared/types';
import {
  MAX_UPLOAD_BYTES,
  MAX_UPLOAD_DIMENSION,
  UPLOAD_JPEG_QUALITY_STEPS,
  UPLOAD_MAX_DOWNSCALE_ROUNDS,
} from '@ola/shared/constants';
import {
  ImageTooLargeError,
  assertUploadSize,
  canUploadImageOriginal,
  initialUploadLongestSide,
  isGifImage,
  isMinUploadLongestSide,
  nextUploadLongestSide,
  preservesAlpha,
  withUploadExtension,
} from '@ola/shared/lib';

interface EncodedImage {
  uri: string;
  size: number;
}

async function fileSizeOf(uri: string): Promise<number | undefined> {
  try {
    const stat = await ReactNativeBlobUtil.fs.stat(uri.replace(/^file:\/\//, ''));
    const size = Number(stat.size);
    return Number.isFinite(size) ? size : undefined;
  } catch {
    return undefined;
  }
}

function dimensionsOf(uri: string): Promise<{ width: number; height: number } | undefined> {
  return new Promise((resolve) => {
    Image.getSize(
      uri,
      (width, height) => resolve({ width, height }),
      () => resolve(undefined)
    );
  });
}

async function describeUploadFile(file: NativeUploadFile): Promise<NativeUploadFile> {
  const size = file.size ?? (await fileSizeOf(file.uri));
  const dimensions =
    file.width != null && file.height != null
      ? { width: file.width, height: file.height }
      : await dimensionsOf(file.uri);
  return { ...file, size, width: dimensions?.width, height: dimensions?.height };
}

async function encodeAtLongestSide(
  uri: string,
  longest: number,
  format: ResizeFormat,
  quality: number,
): Promise<EncodedImage> {
  const result = await ImageResizer.createResizedImage(
    uri,
    longest,
    longest,
    format,
    quality,
    0,
    undefined,
    false,
    { mode: 'contain', onlyScaleDown: true },
  );
  return { uri: result.uri, size: result.size };
}

async function encodeJpegAtLongestSide(uri: string, longest: number): Promise<EncodedImage | null> {
  let output: EncodedImage | null = null;
  for (const quality of UPLOAD_JPEG_QUALITY_STEPS) {
    output = await encodeAtLongestSide(uri, longest, 'JPEG', Math.round(quality * 100));
    if (output.size <= MAX_UPLOAD_BYTES) return output;
  }
  return output;
}

function encodedUploadFile(file: NativeUploadFile, encoded: EncodedImage, extension: 'jpg' | 'png'): NativeUploadFile {
  return {
    uri: encoded.uri,
    name: withUploadExtension(file.name, extension),
    type: extension === 'png' ? 'image/png' : 'image/jpeg',
    size: encoded.size,
  };
}

export async function compressImageForUpload(file: NativeUploadFile): Promise<NativeUploadFile> {
  if (isGifImage(file)) {
    assertUploadSize(file.size ?? (await fileSizeOf(file.uri)));
    return file;
  }

  const described = await describeUploadFile(file);
  if (canUploadImageOriginal(described)) return described;

  let longest =
    described.width != null && described.height != null
      ? initialUploadLongestSide(described.width, described.height)
      : MAX_UPLOAD_DIMENSION;

  if (preservesAlpha(file.type)) {
    const png = await encodeAtLongestSide(file.uri, longest, 'PNG', 100);
    if (png.size <= MAX_UPLOAD_BYTES) return encodedUploadFile(file, png, 'png');
  }

  let smallest: EncodedImage | null = null;
  for (let round = 0; round < UPLOAD_MAX_DOWNSCALE_ROUNDS; round += 1) {
    const encoded = await encodeJpegAtLongestSide(file.uri, longest);
    if (encoded != null && (smallest == null || encoded.size < smallest.size)) smallest = encoded;
    if (encoded != null && encoded.size <= MAX_UPLOAD_BYTES) return encodedUploadFile(file, encoded, 'jpg');
    if (isMinUploadLongestSide(longest)) break;
    longest = nextUploadLongestSide(longest);
  }

  if (smallest == null) throw new Error('compress failed');
  if (smallest.size > MAX_UPLOAD_BYTES) throw new ImageTooLargeError();
  return encodedUploadFile(file, smallest, 'jpg');
}

export async function compressImagesForUpload(files: NativeUploadFile[]): Promise<NativeUploadFile[]> {
  const prepared: NativeUploadFile[] = [];
  for (const file of files) prepared.push(await compressImageForUpload(file));
  return prepared;
}
