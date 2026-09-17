import { createContext, useContext, type ComponentType } from 'react';
import { useAppLockStore } from '@store/appLockStore';

export const AppLockExemptContext = createContext(false);

export function useBlockedByAppLock(): boolean {
  const exempt = useContext(AppLockExemptContext);
  const blocked = useAppLockStore((s) => s.enabled && (s.locked || s.covered));
  return !exempt && blocked;
}

let OverlayComponent: ComponentType | null = null;

// Dialog/OlaModal chỉ phụ thuộc file nhẹ này; AppLockOverlay (kéo theo
// services, native module) tự đăng ký khi app khởi động qua AppLockGate.
export function registerAppLockOverlay(component: ComponentType): void {
  OverlayComponent = component;
}

export function AppLockOverlaySlot() {
  const blocked = useBlockedByAppLock();
  if (!blocked || OverlayComponent == null) return null;
  return <OverlayComponent />;
}
