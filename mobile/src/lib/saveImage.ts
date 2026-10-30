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

async function saveFileToGallery(path: string): Promise<void> {
  if (Platform.OS === 'ios') {
    if (OlaPhotoSaver == null) {
      throw new Error('OlaPhotoSaver native module is unavailable');
    }
    await OlaPhotoSaver.saveImageAtPath(path);
  } else {
    await CameraRoll.saveAsset(`file://${path}`, { type: 'photo' });
  }
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

    await saveFileToGallery(res.path());
    return true;
  } finally {
    res.flush();
  }
}

export async function savePngBase64ToGallery(base64: string): Promise<boolean> {
  if (!(await ensureAndroidPermission())) return false;

  const path = `${ReactNativeBlobUtil.fs.dirs.CacheDir}/ola-${Date.now()}.png`;
  await ReactNativeBlobUtil.fs.writeFile(path, base64, 'base64');
  try {
    await saveFileToGallery(path);
    return true;
  } finally {
    await ReactNativeBlobUtil.fs.unlink(path).catch(() => undefined);
  }
}
