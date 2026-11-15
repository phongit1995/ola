import type { ComponentType } from 'react';
import { useSocialLimitStore } from '@ola/shared/stores/socialLimit';

let OverlayComponent: ComponentType | null = null;

export function registerSocialLimitOverlay(component: ComponentType): void {
  OverlayComponent = component;
}

export function SocialLimitOverlaySlot() {
  const open = useSocialLimitStore((state) => state.notice != null);
  if (!open || OverlayComponent == null) return null;
  return <OverlayComponent />;
}
