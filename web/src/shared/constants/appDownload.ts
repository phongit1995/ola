const ANDROID_PACKAGE_ID = 'com.ola.me.net.org.vn';
const IOS_APP_STORE_ID = '6812642941';

function driveDownloadUrl(fileId: string) {
  return `https://drive.usercontent.google.com/download?id=${fileId}&export=download&confirm=t`;
}

export const APP_DOWNLOAD = {
  androidPackageId: ANDROID_PACKAGE_ID,
  playStoreUrl: `https://play.google.com/store/apps/details?id=${ANDROID_PACKAGE_ID}`,
  iosAppStoreId: IOS_APP_STORE_ID,
  appStoreUrl: `https://apps.apple.com/vn/app/ola-me/id${IOS_APP_STORE_ID}`,
  iosMinVersion: '15.1',
  macMinVersion: '12',
  windowsUrl: driveDownloadUrl('18VeXqUhhk4v3cNUvW0X_S0Bes3ulRbNX'),
  macUrl: driveDownloadUrl('1E3lja98gaYJMk1MFMYIlZ7nCmicSWPEy'),
  linuxAppImageUrl: driveDownloadUrl('1RUOTK6RjzCn1bomR0xJj9szO9lIZw-T9'),
  linuxDebUrl: driveDownloadUrl('1h6HjLIi0bq_Hzem7GZEiM65Ztkq_b7bK'),
} as const;
