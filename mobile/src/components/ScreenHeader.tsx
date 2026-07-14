import type { ReactNode } from 'react';
import { Image, Pressable, Text, View, type StyleProp, type ViewStyle } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

const backIcon = require('../assets/icons/ic_back.png');

interface ScreenHeaderProps {
  title: string;
  subtitle?: string;
  onBack: () => void;
  right?: ReactNode;
  centerTitle?: boolean;
  style?: StyleProp<ViewStyle>;
}

export function ScreenHeader({ title, subtitle, onBack, right, centerTitle = false, style }: ScreenHeaderProps) {
  const insets = useSafeAreaInsets();
  return (
    <View className="flex-row items-center bg-ola-primary pr-2" style={[{ paddingTop: insets.top }, style]}>
      <View className="h-12 w-12 items-center justify-center">
        <Pressable
          onPress={onBack}
          hitSlop={6}
          className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
        >
          <Image source={backIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
        </Pressable>
      </View>
      <View className="min-w-0 flex-1">
        <Text
          numberOfLines={1}
          className={`text-lg font-medium text-white ${centerTitle ? 'text-center' : ''}`}
        >
          {title}
        </Text>
        {subtitle != null && subtitle !== '' && (
          <Text numberOfLines={1} className={`text-xs text-white/70 ${centerTitle ? 'text-center' : ''}`}>
            {subtitle}
          </Text>
        )}
      </View>
      {right ?? (centerTitle ? <View className="w-12" /> : null)}
    </View>
  );
}
