import { launchImageLibrary } from 'react-native-image-picker';
import ImageCropPicker from 'react-native-image-crop-picker';
import { toast } from '@ola/shared/lib';
import type { NativeUploadFile } from '@ola/shared/lib';
import { MIN_IMAGE_SOURCE } from '@ola/shared/constants';
import { compressImageForUpload } from './compressImage';

export const AVATAR_OUTPUT = 800;

export const COVER_OUTPUT = { width: 1600, height: 900 };

export interface PickedImage {
  file: NativeUploadFile;
  width: number;
  height: number;
}

export interface CroppedImage {
  file: NativeUploadFile;
  sourceWidth: number;
  sourceHeight: number;
}

function withFileScheme(path: string): string {
  if (path.startsWith('file://') || path.startsWith('content://')) return path;
  return `file://${path}`;
}

async function toCompressedUploadFile(file: NativeUploadFile): Promise<NativeUploadFile> {
  try {
    return await compressImageForUpload(file);
  } catch {
    return file;
  }
}

function isPickerCancel(err: unknown): boolean {
  return (
    typeof err === 'object' &&
    err != null &&
    'code' in err &&
    (err as { code?: string }).code === 'E_PICKER_CANCELLED'
  );
}

export async function pickCroppedImage(width: number, height: number): Promise<CroppedImage | null> {
  try {
    const image = await ImageCropPicker.openPicker({
      mediaType: 'photo',
      cropping: true,
      width,
      height,
      compressImageQuality: 0.9,
    });
    const fileName = image.path.split('/').pop() ?? 'photo.jpg';
    const file = await toCompressedUploadFile({
      uri: withFileScheme(image.path),
      name: image.filename ?? fileName,
      type: image.mime || 'image/jpeg',
    });
    return {
      file,
      sourceWidth: image.cropRect?.width ?? image.width,
      sourceHeight: image.cropRect?.height ?? image.height,
    };
  } catch (err) {
    if (isPickerCancel(err)) return null;
    throw err;
  }
}

export async function pickValidatedCroppedImage(
  width: number,
  height: number,
  messages: { tooSmall: string; error: string }
): Promise<NativeUploadFile | null> {
  let picked: CroppedImage | null;
  try {
    picked = await pickCroppedImage(width, height);
  } catch {
    toast.error(messages.error);
    return null;
  }
  if (picked == null) return null;
  if (Math.min(picked.sourceWidth, picked.sourceHeight) < MIN_IMAGE_SOURCE) {
    toast.error(messages.tooSmall);
    return null;
  }
  return picked.file;
}

export async function pickSingleImage(): Promise<PickedImage | null> {
  const result = await launchImageLibrary({
    mediaType: 'photo',
    selectionLimit: 1,
    maxWidth: 1920,
    maxHeight: 1920,
    quality: 0.9,
  });
  const asset = result.assets?.[0];
  if (result.didCancel || asset?.uri == null) return null;
  const file = await toCompressedUploadFile({
    uri: asset.uri,
    name: asset.fileName ?? 'photo.jpg',
    type: asset.type ?? 'image/jpeg',
  });
  return {
    file,
    width: asset.width ?? 0,
    height: asset.height ?? 0,
  };
}

const PASTE_EXTENSION_TYPES: Record<string, string> = {
  png: 'image/png',
  gif: 'image/gif',
  webp: 'image/webp',
};

export function pastedImageFile(uri: string): NativeUploadFile {
  const extension = uri.split('.').pop()?.toLowerCase() ?? 'jpg';
  const type = PASTE_EXTENSION_TYPES[extension] ?? 'image/jpeg';
  return { uri, name: `pasted.${type === 'image/jpeg' ? 'jpg' : extension}`, type };
}
