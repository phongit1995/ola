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

interface GradientStop {
  color: string;
  pos: number;
}

function hexToRgb(hex: string): [number, number, number] {
  const value = parseInt(hex.slice(1), 16);
  return [(value >> 16) & 255, (value >> 8) & 255, value & 255];
}

function colorAt(stops: GradientStop[], t: number): string {
  let from = stops[0];
  let to = stops[stops.length - 1];
  for (let i = 0; i < stops.length - 1; i += 1) {
    if (t >= stops[i].pos && t <= stops[i + 1].pos) {
      from = stops[i];
      to = stops[i + 1];
      break;
    }
  }
  const span = to.pos - from.pos;
  const local = span > 0 ? (t - from.pos) / span : 0;
  const a = hexToRgb(from.color);
  const b = hexToRgb(to.color);
  const mix = a.map((channel, i) => Math.round(channel + (b[i] - channel) * local));
  return `rgb(${mix[0]},${mix[1]},${mix[2]})`;
}

export function VerticalGradient({
  stops,
  steps = 24,
  style,
}: {
  stops: GradientStop[];
  steps?: number;
  style?: StyleProp<ViewStyle>;
}) {
  return (
    <View style={style} pointerEvents="none">
      {Array.from({ length: steps }).map((_, i) => (
        <View
          key={i}
          style={{
            position: 'absolute',
            left: 0,
            right: 0,
            top: `${(i / steps) * 100}%`,
            height: `${100 / steps + 0.5}%`,
            backgroundColor: colorAt(stops, i / (steps - 1)),
          }}
        />
      ))}
    </View>
  );
}

const PANEL_BORDER_STOPS: GradientStop[] = [
  { color: '#5e93c2', pos: 0 },
  { color: '#b6dcef', pos: 0.45 },
  { color: '#2a98c2', pos: 1 },
];

const PANEL_BG_STOPS: GradientStop[] = [
  { color: '#001641', pos: 0 },
  { color: '#001238', pos: 0.52 },
  { color: '#00102d', pos: 1 },
];

export function PenPanel({ style, children }: { style?: StyleProp<ViewStyle>; children: ReactNode }) {
  return (
    <View
      style={[
        {
          borderRadius: 34,
          shadowColor: '#1c55c3',
          shadowOpacity: 0.6,
          shadowRadius: 16,
          shadowOffset: { width: 0, height: 0 },
          elevation: 10,
        },
        style,
      ]}
    >
      <VerticalGradient
        stops={PANEL_BORDER_STOPS}
        style={[StyleSheet.absoluteFill, { borderRadius: 34, overflow: 'hidden' }]}
      />
      <View
        style={{
          flexGrow: 1,
          flexShrink: 1,
          margin: 2,
          borderRadius: 32,
          overflow: 'hidden',
        }}
      >
        <VerticalGradient stops={PANEL_BG_STOPS} style={StyleSheet.absoluteFill} />
        {children}
      </View>
    </View>
  );
}
