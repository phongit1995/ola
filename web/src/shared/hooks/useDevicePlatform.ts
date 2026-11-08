import { useMemo } from 'react';

export type DevicePlatform = 'android' | 'ios' | 'desktop';

export const DESKTOP_OS_LIST = ['windows', 'mac', 'linux'] as const;
export type DesktopOs = (typeof DESKTOP_OS_LIST)[number];

const IN_APP_BROWSER_PATTERN =
  /FBAN|FBAV|FB_IAB|FBIOS|Instagram|Zalo|MicroMessenger|Line\/|TikTok/i;

function detectPlatform(
  userAgent: string,
  touchPoints: number
): DevicePlatform {
  if (/android/i.test(userAgent)) return 'android';
  if (/iphone|ipad|ipod/i.test(userAgent)) return 'ios';
  if (/macintosh/i.test(userAgent) && touchPoints > 1) return 'ios';
  return 'desktop';
}

function detectDesktopOs(userAgent: string): DesktopOs {
  if (/macintosh/i.test(userAgent)) return 'mac';
  if (/linux|x11|cros/i.test(userAgent)) return 'linux';
  return 'windows';
}

export interface DeviceInfo {
  platform: DevicePlatform;
  desktopOs: DesktopOs;
  isDesktopApp: boolean;
  isInAppBrowser: boolean;
  isStandalone: boolean;
}

export function useDevicePlatform(): DeviceInfo {
  return useMemo(() => {
    const userAgent = navigator.userAgent;
    return {
      platform: detectPlatform(userAgent, navigator.maxTouchPoints),
      desktopOs: detectDesktopOs(userAgent),
      isDesktopApp: 'olaDesktop' in window,
      isInAppBrowser: IN_APP_BROWSER_PATTERN.test(userAgent),
      isStandalone: window.matchMedia('(display-mode: standalone)').matches,
    };
  }, []);
}
