import { useCallback, useReducer, useState } from 'react';
import { Image, Platform, Text, View } from 'react-native';
import type { ImageSourcePropType, TextInputScrollEvent } from 'react-native';
import { SMILEY_PLACEHOLDER, smileyImageForCode, splitSmileys } from '../lib/chatSmiley';
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

interface DraftOverlayProps {
  display: string;
  codes: string[];
  color?: string;
}

export function ComposerDraftOverlay({
  display,
  codes,
  scrollY,
  paddingHorizontal,
  paddingVertical,
  color,
}: DraftOverlayProps & {
  scrollY: number;
  paddingHorizontal: number;
  paddingVertical: number;
}) {
  return (
    <View
      pointerEvents="none"
      className="absolute inset-0 overflow-hidden"
      style={{ paddingHorizontal, paddingVertical }}
    >
      <View style={{ transform: [{ translateY: -scrollY }] }}>
        <SmileyDraftOverlay display={display} codes={codes} color={color} />
      </View>
    </View>
  );
}

function DraftImageBox({ width, src }: { width: number; src: ImageSourcePropType }) {
  return (
    <Text>
      {'​'}
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
          source={src}
          style={{
            width: Math.min(IMAGE_SIZE * imageAspectRatio(src), width + 2),
            height: IMAGE_SIZE,
          }}
          resizeMode="contain"
        />
      </View>
    </Text>
  );
}

function PlaceholderBox({ code }: { code: string }) {
  const width = codeWidths.get(SMILEY_PLACEHOLDER);
  const src = code === '' ? null : smileyImageForCode(code);
  if (width == null || src == null) {
    return <Text style={{ color: composerHiddenTextColor }}>{SMILEY_PLACEHOLDER}</Text>;
  }
  return <DraftImageBox width={width} src={src} />;
}

export function SmileyDraftOverlay({ display, codes, color }: DraftOverlayProps) {
  const [, remeasured] = useReducer((count: number) => count + 1, 0);
  const parts = display.split(SMILEY_PLACEHOLDER);
  const partSegments = parts.map((part) => splitSmileys(part));
  const pendingCodes = [
    ...new Set([
      ...(parts.length > 1 && !codeWidths.has(SMILEY_PLACEHOLDER) ? [SMILEY_PLACEHOLDER] : []),
      ...partSegments.flatMap((segments) =>
        segments.flatMap((segment) =>
          segment.kind === 'image' && !codeWidths.has(segment.code) ? [segment.code] : []
        )
      ),
    ]),
  ];

  return (
    <>
      <Text className="text-base" style={{ color: color ?? 'rgba(0,0,0,0.87)' }}>
        {parts.map((part, partIndex) => (
          <Text key={partIndex}>
            {partSegments[partIndex].map((segment, index) => {
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
              return <DraftImageBox key={index} width={width} src={segment.src} />;
            })}
            {partIndex < parts.length - 1 && <PlaceholderBox code={codes[partIndex] ?? ''} />}
          </Text>
        ))}
      </Text>
      {pendingCodes.length > 0 && (
        <View
          pointerEvents="none"
          className="absolute opacity-0"
          style={{ alignItems: 'flex-start' }}
        >
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
