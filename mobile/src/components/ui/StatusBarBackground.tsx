import { Platform, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useOverlayBreadcrumb } from '@hooks/useOverlayBreadcrumb';
import { useThemeColors } from '@hooks/useThemeColors';

export function StatusBarBackground() {
  const insets = useSafeAreaInsets();
  const colors = useThemeColors();
  const visible = Platform.OS === 'android' && insets.top > 0;
  useOverlayBreadcrumb('StatusBarBackground', visible ? 'shown' : null);
  if (!visible) return null;
  return (
    <View
      pointerEvents="none"
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        height: insets.top,
        backgroundColor: colors.primary,
      }}
    />
  );
}
