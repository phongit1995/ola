import { Platform } from 'react-native';
import hotUpdate from 'react-native-app-core';
import ReactNativeBlobUtil from 'react-native-blob-util';
import DeviceInfo from 'react-native-device-info';

const OTA_REPO = 'ducphanvanntq/ola-release';
const MANIFEST_URL = `https://github.com/${OTA_REPO}/releases/latest/download/manifest.json`;

interface OtaEntry {
  version: number;
  android?: string;
  ios?: string;
}

interface OtaManifest {
  bundle_id?: string;
  versions?: Record<string, OtaEntry>;
}

export async function checkForOtaUpdate(): Promise<void> {
  try {
    const response = await fetch(MANIFEST_URL, { headers: { 'Cache-Control': 'no-cache' } });
    if (!response.ok) return;

    const manifest = (await response.json()) as OtaManifest;
    if (manifest.bundle_id != null && manifest.bundle_id !== DeviceInfo.getBundleId()) return;

    const entry = manifest.versions?.[DeviceInfo.getVersion()];
    const url = Platform.OS === 'ios' ? entry?.ios : entry?.android;
    if (!entry || !url || !Number.isInteger(entry.version)) return;

    const currentVersion = Number(await hotUpdate.getCurrentVersion()) || 0;
    if (entry.version <= currentVersion) return;

    hotUpdate.downloadBundleUri(ReactNativeBlobUtil, url, entry.version, {
      restartAfterInstall: false,
      updateFail: () => undefined,
    });
  } catch {
    return;
  }
}

export function rollbackOta(): void {
  hotUpdate.rollbackToPreviousBundle();
}
