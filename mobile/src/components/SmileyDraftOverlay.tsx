import { useCallback, useReducer, useState } from 'react';
import { Image, Platform, Text, View } from 'react-native';
import type { TextInputScrollEvent } from 'react-native';
import { splitSmileys } from '../lib/chatSmiley';
import { imageAspectRatio, smileyBaselineShift } from '../lib/richText';

const codeWidths = new Map<string, number>();

const IMAGE_SIZE = 20;
const COMPOSER_LINE_HEIGHT = 24;

export const composerHiddenTextColor = Platform.OS === 'android' ? 'rgba(0,0,0,0.004)' : 'transparent';

export function composerSingleLineHeight(verticalPadding: number): number {
  return COMPOSER_LINE_HEIGHT + verticalPadding * 2;
}

export function useComposerScrollSync(draft: string) {
  const [scrollY, setScrollY] = useState(0);
  if (draft === '' && scrollY !== 0) setScrollY(0);
  const handleScroll = useCallback(
    (event: TextInputScrollEvent) => setScrollY(event.nativeEvent.contentOffset.y),
    []
  );
  return { scrollY, handleScroll };
}

export function ComposerDraftOverlay({
  text,
  scrollY,
  paddingHorizontal,
  paddingVertical,
  color,
}: {
  text: string;
  scrollY: number;
  paddingHorizontal: number;
  paddingVertical: number;
  color?: string;
}) {
  return (
    <View
      pointerEvents="none"
      className="absolute inset-0 overflow-hidden"
      style={{ paddingHorizontal, paddingVertical }}
    >
      <View style={{ transform: [{ translateY: -scrollY }] }}>
        <SmileyDraftOverlay text={text} color={color} />
      </View>
    </View>
  );
}

export function SmileyDraftOverlay({ text, color }: { text: string; color?: string }) {
  const [, remeasured] = useReducer((count: number) => count + 1, 0);
  const segments = splitSmileys(text);
  const pendingCodes = [
    ...new Set(
      segments.flatMap((segment) =>
        segment.kind === 'image' && !codeWidths.has(segment.code) ? [segment.code] : []
      )
    ),
  ];

  return (
    <>
      <Text className="text-base" style={{ color: color ?? 'rgba(0,0,0,0.87)' }}>
        {segments.map((segment, index) => {
          if (segment.kind === 'text') {
            return <Text key={index}>{segment.value}</Text>;
          }
          const width = codeWidths.get(segment.code);
          if (width == null) {
            return (
              <Text key={index} style={{ color: composerHiddenTextColor }}>
                {segment.code}
              </Text>
            );
          }
          return (
            <Text key={index}>
              {'\u200B'}
              <View
                style={{
                  width,
                  height: IMAGE_SIZE,
                  alignItems: 'center',
                  justifyContent: 'center',
                  transform: [{ translateY: smileyBaselineShift(IMAGE_SIZE) }],
                }}
              >
                <Image
                  source={segment.src}
                  style={{
                    width: Math.min(IMAGE_SIZE * imageAspectRatio(segment.src), width + 8),
                    height: IMAGE_SIZE,
                  }}
                  resizeMode="contain"
                />
              </View>
            </Text>
          );
        })}
      </Text>
      {pendingCodes.length > 0 && (
        <View pointerEvents="none" className="absolute opacity-0">
          {pendingCodes.map((code) => (
            <Text
              key={code}
              className="text-base"
              onLayout={(event) => {
                codeWidths.set(code, event.nativeEvent.layout.width);
                remeasured();
              }}
            >
              {code}
            </Text>
          ))}
        </View>
      )}
    </>
  );
}
