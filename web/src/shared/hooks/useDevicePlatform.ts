import { useMemo } from 'react';

export type DevicePlatform = 'android' | 'ios' | 'desktop';

const IN_APP_BROWSER_PATTERN = /FBAN|FBAV|FB_IAB|FBIOS|Instagram|Zalo|MicroMessenger|Line\/|TikTok/i;

function detectPlatform(userAgent: string, touchPoints: number): DevicePlatform {
  if (/android/i.test(userAgent)) return 'android';
  if (/iphone|ipad|ipod/i.test(userAgent)) return 'ios';
  if (/macintosh/i.test(userAgent) && touchPoints > 1) return 'ios';
  return 'desktop';
}

export interface DeviceInfo {
  platform: DevicePlatform;
  isInAppBrowser: boolean;
  isStandalone: boolean;
}

export function useDevicePlatform(): DeviceInfo {
  return useMemo(() => {
    const userAgent = navigator.userAgent;
    return {
      platform: detectPlatform(userAgent, navigator.maxTouchPoints),
      isInAppBrowser: IN_APP_BROWSER_PATTERN.test(userAgent),
      isStandalone: window.matchMedia('(display-mode: standalone)').matches,
    };
  }, []);
}
