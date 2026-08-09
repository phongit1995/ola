import { StyleSheet, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { themeOptionOf } from '@ola/shared/constants';
import { withAlpha } from '@ola/shared/lib';
import { useThemeStore } from '@ola/shared/stores/themeStore';

const TOP_OPACITY = 0.25;
const BOTTOM_OPACITY = 0.45;
const BASE_COLOR = '#ffffff';

export function TabBarGradient() {
  const theme = useThemeStore((state) => state.theme);
  const { swatch } = themeOptionOf(theme);
  return (
    <View style={[StyleSheet.absoluteFill, { backgroundColor: BASE_COLOR }]}>
      <LinearGradient
        colors={[withAlpha(swatch, TOP_OPACITY), withAlpha(swatch, BOTTOM_OPACITY)]}
        start={{ x: 0, y: 0 }}
        end={{ x: 0, y: 1 }}
        style={StyleSheet.absoluteFill}
      />
    </View>
  );
}
