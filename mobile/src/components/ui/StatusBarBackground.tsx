import { Platform, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { PRIMARY } from '@constants';

export function StatusBarBackground() {
  const insets = useSafeAreaInsets();
  if (Platform.OS !== 'android' || insets.top <= 0) return null;
  return (
    <View
      pointerEvents="none"
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        height: insets.top,
        backgroundColor: PRIMARY,
      }}
    />
  );
}
