import { Alert, Linking, NativeModules, PermissionsAndroid, Platform } from 'react-native';
import { CameraRoll } from '@react-native-camera-roll/camera-roll';
import ReactNativeBlobUtil from 'react-native-blob-util';
import type { TFunction } from 'i18next';

const IMAGE_EXTENSIONS = new Set(['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic']);
const PHOTO_PERMISSION_DENIED = 'E_PHOTO_PERMISSION_DENIED';

interface OlaPhotoSaverModule {
  saveImageAtPath(path: string): Promise<boolean>;
}

const OlaPhotoSaver = NativeModules.OlaPhotoSaver as OlaPhotoSaverModule | undefined;

function extensionFromUrl(url: string): string {
  const clean = url.split('?')[0]!.split('#')[0]!;
  const ext = clean.split('.').pop()?.toLowerCase() ?? '';
  return IMAGE_EXTENSIONS.has(ext) ? ext : 'jpg';
}

export function isPhotoPermissionDenied(error: unknown): boolean {
  return (error as { code?: unknown } | null)?.code === PHOTO_PERMISSION_DENIED;
}

export function alertPhotoPermissionDenied(t: TFunction): void {
  Alert.alert(t('media.save'), t('media.permissionDenied'), [
    { text: t('dialog.cancel'), style: 'cancel' },
    {
      text: t('settings.title'),
      onPress: () => {
        void Linking.openSettings().catch(() => undefined);
      },
    },
  ]);
}

async function ensureAndroidPermission(): Promise<void> {
  if (Platform.OS !== 'android' || Number(Platform.Version) > 28) return;
  const granted = await PermissionsAndroid.request(
    PermissionsAndroid.PERMISSIONS.WRITE_EXTERNAL_STORAGE
  );
  if (granted !== PermissionsAndroid.RESULTS.GRANTED) {
    throw Object.assign(new Error('Permission to save images was denied.'), {
      code: PHOTO_PERMISSION_DENIED,
    });
  }
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

export async function saveImageToGallery(url: string): Promise<void> {
  await ensureAndroidPermission();

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
  } finally {
    res.flush();
  }
}

export async function savePngBase64ToGallery(base64: string): Promise<void> {
  await ensureAndroidPermission();

  const path = `${ReactNativeBlobUtil.fs.dirs.CacheDir}/ola-${Date.now()}.png`;
  await ReactNativeBlobUtil.fs.writeFile(path, base64, 'base64');
  try {
    await saveFileToGallery(path);
  } finally {
    await ReactNativeBlobUtil.fs.unlink(path).catch(() => undefined);
  }
}
