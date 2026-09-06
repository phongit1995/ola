import { Platform } from 'react-native';
import hotUpdate from 'react-native-ota-hot-update';
import ReactNativeBlobUtil from 'react-native-blob-util';
import DeviceInfo from 'react-native-device-info';

const OTA_REPO = 'ducphanvanntq/ola';
const LATEST_RELEASE_URL = `https://api.github.com/repos/${OTA_REPO}/releases/latest`;

interface ReleaseBody {
  app_version: string;
  bundle_id?: string;
  notes?: string;
}

interface ReleaseAsset {
  name: string;
  browser_download_url: string;
}

interface GithubRelease {
  tag_name?: string;
  body?: string;
  assets?: ReleaseAsset[];
}

export async function checkForOtaUpdate(): Promise<void> {
  try {
    const response = await fetch(LATEST_RELEASE_URL, {
      headers: { Accept: 'application/vnd.github.v3+json' },
    });
    if (!response.ok) return;

    const release = (await response.json()) as GithubRelease;

    let meta: ReleaseBody;
    try {
      meta = JSON.parse(release.body ?? '') as ReleaseBody;
    } catch {
      return;
    }

    if (meta.app_version !== DeviceInfo.getVersion()) return;
    if (meta.bundle_id != null && meta.bundle_id !== DeviceInfo.getBundleId()) return;

    const remoteVersion = parseInt((release.tag_name ?? '').replace(/^v/, ''), 10);
    if (Number.isNaN(remoteVersion)) return;

    const currentVersion = Number(await hotUpdate.getCurrentVersion()) || 0;
    if (remoteVersion <= currentVersion) return;

    const assetName = Platform.OS === 'ios' ? 'ios-bundle.zip' : 'android-bundle.zip';
    const asset = release.assets?.find((item) => item.name === assetName);
    if (!asset) return;

    hotUpdate.downloadBundleUri(ReactNativeBlobUtil, asset.browser_download_url, remoteVersion, {
      updateSuccess: () => hotUpdate.resetApp(),
      updateFail: () => undefined,
      restartAfterInstall: true,
    });
  } catch {
    return;
  }
}

export function rollbackOta(): void {
  hotUpdate.rollbackToPreviousBundle();
}
