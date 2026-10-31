export type PortraitLockRotation = 0 | 90 | -90;

const PHONE_MAX_SHORT_SIDE = 600;

export function isPhoneScreen(coarsePointer: boolean, screenWidth: number, screenHeight: number): boolean {
  return coarsePointer && Math.min(screenWidth, screenHeight) < PHONE_MAX_SHORT_SIDE;
}

// Góc theo screen.orientation.angle / window.orientation: 90 là máy quay ngược
// chiều kim đồng hồ, nên game phải quay -90° để vẫn đứng dọc theo thân máy.
export function portraitLockRotation(angle: number | undefined, phone: boolean): PortraitLockRotation {
  if (!phone || angle == null) return 0;
  const normalized = ((angle % 360) + 360) % 360;
  if (normalized === 90) return -90;
  if (normalized === 270) return 90;
  return 0;
}
