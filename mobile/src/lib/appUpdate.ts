import { Linking, Platform, TurboModuleRegistry } from 'react-native';
import DeviceInfo from 'react-native-device-info';
import type SpInAppUpdates from 'sp-react-native-in-app-updates';
import { AndroidAvailabilityStatus } from 'sp-react-native-in-app-updates/src/types';
import { SettingsService } from '@ola/shared/services';
import {
  IOS_APP_STORE_ID,
  appStoreAppUrl,
  appStoreWebUrl,
  playStoreAppUrl,
  playStoreWebUrl,
} from '@constants/appStore';

const STORE_COUNTRY = 'vn';
const isAndroid = Platform.OS === 'android';

export const STORE_CHECK = {
  newer: 'newer',
  latest: 'latest',
  unknown: 'unknown',
} as const;

export type StoreCheck = (typeof STORE_CHECK)[keyof typeof STORE_CHECK];

let inAppUpdates: SpInAppUpdates | null | undefined;

// Bản Android lấy native module ngay lúc import; APK chưa build kèm module (vd nhận bundle OTA) mà require là crash.
function getInAppUpdates(): SpInAppUpdates | null {
  if (inAppUpdates !== undefined) return inAppUpdates;
  inAppUpdates = null;
  if (isAndroid && TurboModuleRegistry.get('SpInAppUpdates') == null) return inAppUpdates;
  try {
    const InAppUpdates: typeof SpInAppUpdates = require('sp-react-native-in-app-updates').default;
    inAppUpdates = new InAppUpdates(false);
  } catch {
    inAppUpdates = null;
  }
  return inAppUpdates;
}

// Play chỉ trả versionCode nên Android so với build number; app không cài từ Google Play thì Play Core báo lỗi → unknown.
export async function checkStoreForUpdate(): Promise<StoreCheck> {
  const updates = getInAppUpdates();
  if (updates == null) return STORE_CHECK.unknown;
  try {
    const result = await updates.checkNeedsUpdate(
      isAndroid ? { curVersion: DeviceInfo.getBuildNumber() } : { country: STORE_COUNTRY },
    );
    if (result.shouldUpdate) return STORE_CHECK.newer;
    if (result.storeVersion != null) return STORE_CHECK.latest;
    const availability = (result.other as { updateAvailability?: number } | undefined)?.updateAvailability;
    return isAndroid && availability === AndroidAvailabilityStatus.UNAVAILABLE
      ? STORE_CHECK.latest
      : STORE_CHECK.unknown;
  } catch {
    return STORE_CHECK.unknown;
  }
}

// Không hỏi được server thì trả null để giữ nguyên hộp thoại đang hiện, tránh rớt mạng là thoát được màn bắt buộc.
export async function fetchUpdateRequired(): Promise<boolean | null> {
  try {
    const result = await SettingsService.appUpdate();
    return result.required === true;
  } catch {
    return null;
  }
}

function storeListingUrls(): string[] {
  if (isAndroid) {
    const packageId = DeviceInfo.getBundleId();
    return [playStoreAppUrl(packageId), playStoreWebUrl(packageId)];
  }
  if (Platform.OS === 'ios' && IOS_APP_STORE_ID !== '') {
    return [appStoreAppUrl(IOS_APP_STORE_ID), appStoreWebUrl(IOS_APP_STORE_ID)];
  }
  return [];
}

export async function openStoreForUpdate(): Promise<boolean> {
  for (const url of storeListingUrls()) {
    try {
      await Linking.openURL(url);
      return true;
    } catch {
      continue;
    }
  }
  return false;
}
