// iOS chưa lên App Store (mới chỉ TestFlight) nên chưa có numeric app id.
// Điền vào đây ngay khi app được duyệt để nút "Đánh giá" mở thẳng trang rating.
export const IOS_APP_STORE_ID: string = '';

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
