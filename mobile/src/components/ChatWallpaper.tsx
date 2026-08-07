import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { CachedImage } from '@components/ui/CachedImage';

const FILL = {
  position: 'absolute',
  top: 0,
  left: 0,
  right: 0,
  bottom: 0,
} as const;

export function ChatWallpaper() {
  const wallpaperUrl = useSettingsStore((s) => s.settings.wallpaperUrl);
  if (wallpaperUrl === '') return null;
  return <CachedImage uri={wallpaperUrl} style={FILL} resizeMode="cover" />;
}
