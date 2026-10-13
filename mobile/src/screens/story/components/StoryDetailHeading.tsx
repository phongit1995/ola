import type { ReactNode } from 'react';
import { Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { useThemeColors } from '@hooks/useThemeColors';
import { useStoryTextSize } from '../typography';

const ACCENT_WIDTH = 4;
const ACCENT_HEIGHT = 16;

export function StoryDetailHeading({ children }: { children: ReactNode }) {
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  return (
    <View className="min-w-0 flex-shrink flex-row items-center gap-2">
      <LinearGradient
        colors={[colors.primary, colors.primaryDark]}
        style={{ width: ACCENT_WIDTH, height: ACCENT_HEIGHT, borderRadius: ACCENT_WIDTH / 2 }}
      />
      <Text numberOfLines={1} className="min-w-0 flex-shrink font-bold text-ola-ink" style={textSize(15, 20)}>
        {children}
      </Text>
    </View>
  );
}
