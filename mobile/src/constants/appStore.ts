export const IOS_APP_STORE_ID: string = '6812642941';

export function playStoreAppUrl(packageId: string): string {
  return `market://details?id=${packageId}`;
}

export function playStoreWebUrl(packageId: string): string {
  return `https://play.google.com/store/apps/details?id=${packageId}`;
}

export function appStoreReviewUrl(appId: string): string {
  return `itms-apps://apps.apple.com/app/id${appId}?action=write-review`;
}

export function appStoreWebReviewUrl(appId: string): string {
  return `https://apps.apple.com/app/id${appId}?action=write-review`;
}

export function appStoreAppUrl(appId: string): string {
  return `itms-apps://apps.apple.com/app/id${appId}`;
}

export function appStoreWebUrl(appId: string): string {
  return `https://apps.apple.com/app/id${appId}`;
}
