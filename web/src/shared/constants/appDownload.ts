const ANDROID_PACKAGE_ID = 'com.ola.me.net.org.vn';

export const APP_DOWNLOAD = {
  androidPackageId: ANDROID_PACKAGE_ID,
  playStoreUrl: `https://play.google.com/store/apps/details?id=${ANDROID_PACKAGE_ID}`,
  testflightUrl: 'https://testflight.apple.com/join/DyBJKdbb',
  testflightCode: 'DyBJKdbb',
  testflightAppStoreUrl:
    'https://apps.apple.com/vn/app/testflight/id899247664?l=vi',
} as const;
