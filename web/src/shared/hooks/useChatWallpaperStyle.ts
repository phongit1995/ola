import type { CSSProperties } from 'react';
import { chatWallpaperStyle } from '@lib';
import { useSettingsStore } from '@/store/settingsStore';

export function useChatWallpaperStyle(): CSSProperties | undefined {
  const wallpaperUrl = useSettingsStore((s) => s.settings.wallpaperUrl);
  return chatWallpaperStyle(wallpaperUrl);
}
