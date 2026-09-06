import { launchImageLibrary, type Asset } from 'react-native-image-picker';
import ImageCropPicker from 'react-native-image-crop-picker';
import { imageUploadErrorText, mimeFromUploadName, toast } from '@ola/shared/lib';
import type { NativeUploadFile } from '@ola/shared/types';
import { MIN_IMAGE_SOURCE } from '@ola/shared/constants';
import i18n from '../i18n';
import { compressImageForUpload } from './compressImage';

export const AVATAR_OUTPUT = 800;

export const COVER_OUTPUT = { width: 1600, height: 900 };

export const WALLPAPER_OUTPUT = { width: 1080, height: 1920 };

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

export function uploadFileFromAsset(asset: Asset & { uri: string }): NativeUploadFile {
  const name = asset.fileName ?? asset.uri.split('/').pop() ?? 'photo';
  return {
    uri: asset.uri,
    name,
    type: asset.type ?? mimeFromUploadName(name),
    size: asset.fileSize,
    width: asset.width,
    height: asset.height,
  };
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
    const fileName = image.filename ?? image.path.split('/').pop() ?? 'photo';
    const file = await compressImageForUpload({
      uri: withFileScheme(image.path),
      name: fileName,
      type: image.mime || mimeFromUploadName(fileName),
      size: image.size,
      width: image.width,
      height: image.height,
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
  } catch (err) {
    toast.error(imageUploadErrorText(i18n.t, err, messages.error));
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
  });
  const asset = result.assets?.[0];
  if (result.didCancel || asset?.uri == null) return null;
  const file = await compressImageForUpload(uploadFileFromAsset({ ...asset, uri: asset.uri }));
  return {
    file,
    width: asset.width ?? 0,
    height: asset.height ?? 0,
  };
}

export function pastedImageFile(uri: string): NativeUploadFile {
  const name = uri.split('/').pop() ?? 'pasted';
  return { uri, name, type: mimeFromUploadName(name) };
}
