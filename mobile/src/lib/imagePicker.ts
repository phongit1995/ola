import { launchImageLibrary } from 'react-native-image-picker';
import type { NativeUploadFile } from '@ola/shared/lib';

export interface PickedImage {
  file: NativeUploadFile;
  width: number;
  height: number;
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
