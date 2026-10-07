import type { ReactNode } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Svg, { Defs, LinearGradient, Rect, Stop } from 'react-native-svg';
import { colorForName } from '@ola/shared/lib';
import { CachedImage } from '@components/ui/CachedImage';
import { READER_FONTS } from '../constants';

type CoverSize = 'sm' | 'md' | 'lg';

const TITLE_STYLE: Record<CoverSize, { lines: number; fontSize: number; lineHeight: number }> = {
  sm: { lines: 4, fontSize: 9, lineHeight: 11 },
  md: { lines: 4, fontSize: 12, lineHeight: 16 },
  lg: { lines: 5, fontSize: 16, lineHeight: 20 },
};

const COVER_RATIO = 4 / 3;
const COVER_RADIUS = 6;
const SPINE_LEFT = 0.08;
const TITLE_TOP = 0.16;
const TITLE_SIDE = 0.14;
const SHADE_KEEP = 0.45;
const HEX_RADIX = 16;

const COVER_SHADOW = {
  shadowColor: '#000',
  shadowOpacity: 0.25,
  shadowRadius: 3,
  shadowOffset: { width: 0, height: 2 },
  elevation: 3,
};

function shade(hex: string): string {
  const value = hex.replace('#', '');
  const channel = (offset: number) =>
    Math.round(parseInt(value.slice(offset, offset + 2), HEX_RADIX) * SHADE_KEEP)
      .toString(HEX_RADIX)
      .padStart(2, '0');
  return `#${channel(0)}${channel(2)}${channel(4)}`;
}

interface StoryCoverProps {
  title: string;
  coverUrl?: string | null;
  width: number;
  size?: CoverSize;
  children?: ReactNode;
}

export function StoryCover({ title, coverUrl, width, size = 'md', children }: StoryCoverProps) {
  const color = colorForName(title);
  const height = Math.round(width * COVER_RATIO);
  const titleStyle = TITLE_STYLE[size];
  return (
    <View
      style={[
        { width, height, borderRadius: COVER_RADIUS, backgroundColor: color },
        COVER_SHADOW,
      ]}
    >
      <View style={{ flex: 1, borderRadius: COVER_RADIUS, overflow: 'hidden' }}>
        {coverUrl ? (
          <CachedImage uri={coverUrl} style={StyleSheet.absoluteFill} resizeMode="cover" />
        ) : (
          <>
            <Svg width={width} height={height} style={StyleSheet.absoluteFill}>
              <Defs>
                <LinearGradient id="story-cover-shade" x1="0" y1="0" x2="0.35" y2="1">
                  <Stop offset="0" stopColor={color} />
                  <Stop offset="1" stopColor={shade(color)} />
                </LinearGradient>
              </Defs>
              <Rect x="0" y="0" width={width} height={height} fill="url(#story-cover-shade)" />
            </Svg>
            <View
              style={{
                position: 'absolute',
                top: 0,
                bottom: 0,
                left: width * SPINE_LEFT,
                width: 1,
                backgroundColor: 'rgba(255,255,255,0.3)',
              }}
            />
            <Text
              numberOfLines={titleStyle.lines}
              style={{
                position: 'absolute',
                top: height * TITLE_TOP,
                left: width * TITLE_SIDE,
                right: width * TITLE_SIDE,
                textAlign: 'center',
                fontWeight: 'bold',
                color: '#ffffff',
                fontFamily: READER_FONTS.serif.family,
                fontSize: titleStyle.fontSize,
                lineHeight: titleStyle.lineHeight,
                textShadowColor: 'rgba(0,0,0,0.35)',
                textShadowOffset: { width: 0, height: 1 },
                textShadowRadius: 2,
              }}
            >
              {title}
            </Text>
          </>
        )}
        {children}
      </View>
    </View>
  );
}
