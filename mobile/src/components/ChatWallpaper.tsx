import { View } from 'react-native';
import { LOBBY_WALLPAPER_OPACITY, WALLPAPER_OPACITY } from '@ola/shared/constants';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { CachedImage } from '@components/ui/CachedImage';
import { CHAT_BG } from '@screens/chat/constants';

const FILL = {
  position: 'absolute',
  top: 0,
  left: 0,
  right: 0,
  bottom: 0,
} as const;

function Wallpaper({ opacity }: { opacity: number }) {
  const wallpaperUrl = useSettingsStore((s) => s.settings.wallpaperUrl);
  if (wallpaperUrl === '') return null;
  return (
    <View style={[FILL, { backgroundColor: CHAT_BG }]}>
      <CachedImage
        uri={wallpaperUrl}
        style={[FILL, { opacity }]}
        resizeMode="cover"
      />
    </View>
  );
}

export function ChatWallpaper() {
  return <Wallpaper opacity={WALLPAPER_OPACITY} />;
}

export function LobbyWallpaper() {
  return <Wallpaper opacity={LOBBY_WALLPAPER_OPACITY} />;
}
