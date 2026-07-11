import { launchImageLibrary } from 'react-native-image-picker';
import ImageCropPicker from 'react-native-image-crop-picker';
import type { NativeUploadFile } from '@ola/shared/lib';

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
    return {
      file: {
        uri: withFileScheme(image.path),
        name: image.filename ?? fileName,
        type: image.mime || 'image/jpeg',
      },
      sourceWidth: image.cropRect?.width ?? image.width,
      sourceHeight: image.cropRect?.height ?? image.height,
    };
  } catch (err) {
    if (isPickerCancel(err)) return null;
    throw err;
  }
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
  return {
    file: { uri: asset.uri, name: asset.fileName ?? 'photo.jpg', type: asset.type ?? 'image/jpeg' },
    width: asset.width ?? 0,
    height: asset.height ?? 0,
  };
}
