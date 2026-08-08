import type { CSSProperties } from 'react';
import { lobbyWallpaperStyle } from '@lib';
import { useSettingsStore } from '@/store/settingsStore';

export function useLobbyWallpaperStyle(): CSSProperties | undefined {
  const wallpaperUrl = useSettingsStore((s) => s.settings.wallpaperUrl);
  return lobbyWallpaperStyle(wallpaperUrl);
}
