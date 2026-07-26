import { NativeModules, PermissionsAndroid, Platform } from 'react-native';
import { CameraRoll } from '@react-native-camera-roll/camera-roll';
import ReactNativeBlobUtil from 'react-native-blob-util';

const IMAGE_EXTENSIONS = new Set(['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic']);

interface OlaPhotoSaverModule {
  saveImageAtPath(path: string): Promise<boolean>;
}

const OlaPhotoSaver = NativeModules.OlaPhotoSaver as OlaPhotoSaverModule | undefined;

function extensionFromUrl(url: string): string {
  const clean = url.split('?')[0]!.split('#')[0]!;
  const ext = clean.split('.').pop()?.toLowerCase() ?? '';
  return IMAGE_EXTENSIONS.has(ext) ? ext : 'jpg';
}

async function ensureAndroidPermission(): Promise<boolean> {
  if (Platform.OS !== 'android' || Number(Platform.Version) > 28) return true;
  const granted = await PermissionsAndroid.request(
    PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE
  );
  return granted === PermissionsAndroid.RESULTS.GRANTED;
}

export async function saveImageToGallery(url: string): Promise<boolean> {
  if (!(await ensureAndroidPermission())) return false;

  const res = await ReactNativeBlobUtil.config({
    fileCache: true,
    appendExt: extensionFromUrl(url),
  }).fetch('GET', url);

  try {
    const status = res.info().status;
    if (status < 200 || status >= 300) {
      throw new Error(`Image download failed with HTTP ${status}`);
    }

    const path = res.path();
    if (Platform.OS === 'ios') {
      if (OlaPhotoSaver == null) {
        throw new Error('OlaPhotoSaver native module is unavailable');
      }
      await OlaPhotoSaver.saveImageAtPath(path);
    } else {
      await CameraRoll.saveAsset(`file://${path}`, { type: 'photo' });
    }
    return true;
  } finally {
    res.flush();
  }
}
