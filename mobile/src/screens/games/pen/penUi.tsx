import { Image, StyleSheet, View, type ImageSourcePropType, type StyleProp, type TextStyle, type ViewStyle } from 'react-native';
import type { ReactNode } from 'react';

export const PEN_COLORS = {
  screenBg: '#011d42',
  gold: '#ffd54f',
  green: '#46e06a',
  blue: '#3aa0ff',
  red: '#ff5b5b',
  yellow: '#ffd23f',
};

export const penTextShadow: TextStyle = {
  textShadowColor: 'rgba(0,0,0,0.45)',
  textShadowOffset: { width: 0, height: 1 },
  textShadowRadius: 2,
};

export function assetRatio(source: ImageSourcePropType): number {
  const resolved = Image.resolveAssetSource(source);
  return resolved != null && resolved.height > 0 ? resolved.width / resolved.height : 1;
}

export function sizeByHeight(source: ImageSourcePropType, height: number): { width: number; height: number } {
  return { width: Math.round(height * assetRatio(source)), height };
}

export function PenBg({ source }: { source: ImageSourcePropType }) {
  return (
    <View style={StyleSheet.absoluteFill} pointerEvents="none">
      <Image source={source} style={{ width: '100%', height: '100%' }} resizeMode="stretch" />
    </View>
  );
}

export function PenPanel({ style, children }: { style?: StyleProp<ViewStyle>; children: ReactNode }) {
  return (
    <View
      style={[
        {
          borderRadius: 34,
          padding: 2,
          backgroundColor: '#9fc6e0',
          shadowColor: '#1c55c3',
          shadowOpacity: 0.6,
          shadowRadius: 16,
          shadowOffset: { width: 0, height: 0 },
          elevation: 10,
        },
        style,
      ]}
    >
      <View style={{ flex: 1, borderRadius: 32, backgroundColor: '#001238', overflow: 'hidden' }}>
        {children}
      </View>
    </View>
  );
}
