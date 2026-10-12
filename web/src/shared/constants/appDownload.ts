const ANDROID_PACKAGE_ID = 'com.ola.me.net.org.vn';
const IOS_APP_STORE_ID = '6812642941';

export const APP_DOWNLOAD = {
  androidPackageId: ANDROID_PACKAGE_ID,
  playStoreUrl: `https://play.google.com/store/apps/details?id=${ANDROID_PACKAGE_ID}`,
  iosAppStoreId: IOS_APP_STORE_ID,
  appStoreUrl: `https://apps.apple.com/vn/app/ola-me/id${IOS_APP_STORE_ID}`,
  iosMinVersion: '15.1',
} as const;
