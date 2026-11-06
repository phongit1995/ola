import { useEffect, useRef, useState, type ReactNode } from 'react';
import { Animated, Easing, Image, Pressable, Text, View } from 'react-native';
import type { ImageSourcePropType } from 'react-native';

const EXPAND_DELAY_MS = 600;
const EXPAND_DURATION_MS = 500;
const MARQUEE_DELAY_MS = 300;
const PILL_COLLAPSED_WIDTH = 44;
const PILL_MAX_WIDTH = 320;
const MARQUEE_TRACK_WIDTH = 4000;
const OFFSCREEN_RIGHT = 1000;
const CONTENT_GAP = 4;

export const MARQUEE_INTRO_MS = EXPAND_DELAY_MS + EXPAND_DURATION_MS + MARQUEE_DELAY_MS;

interface MarqueePillProps {
  icon: ImageSourcePropType;
  dismissLabel?: string;
  opaque?: boolean;
  marqueeDurationMs: (travelPx: number) => number;
  onOpen?: () => void;
  onDismiss: () => void;
  onDone: () => void;
  children: ReactNode;
}

export function MarqueePill({
  icon,
  dismissLabel,
  opaque = false,
  marqueeDurationMs,
  onOpen,
  onDismiss,
  onDone,
  children,
}: MarqueePillProps) {
  const [clipWidth, setClipWidth] = useState(0);
  const [contentWidth, setContentWidth] = useState(0);
  const [expanded, setExpanded] = useState(false);
  const pillMaxWidth = useRef(new Animated.Value(PILL_COLLAPSED_WIDTH)).current;
  const marqueeX = useRef(new Animated.Value(OFFSCREEN_RIGHT)).current;
  const marqueeStartedRef = useRef(false);
  const marqueeAnimRef = useRef<Animated.CompositeAnimation | null>(null);

  useEffect(() => {
    const expand = Animated.timing(pillMaxWidth, {
      toValue: PILL_MAX_WIDTH,
      duration: EXPAND_DURATION_MS,
      delay: EXPAND_DELAY_MS,
      easing: Easing.out(Easing.ease),
      useNativeDriver: false,
    });
    expand.start(({ finished }) => {
      if (finished) setExpanded(true);
    });
    return () => expand.stop();
  }, [pillMaxWidth]);

  useEffect(() => {
    if (marqueeStartedRef.current || !expanded || clipWidth <= 0 || contentWidth <= 0) return;
    marqueeStartedRef.current = true;
    marqueeX.setValue(clipWidth);
    const marquee = Animated.timing(marqueeX, {
      toValue: -contentWidth,
      duration: marqueeDurationMs(clipWidth + contentWidth),
      delay: MARQUEE_DELAY_MS,
      easing: Easing.linear,
      useNativeDriver: true,
    });
    marqueeAnimRef.current = marquee;
    marquee.start(({ finished }) => {
      if (finished) onDone();
    });
  }, [expanded, clipWidth, contentWidth, marqueeX, marqueeDurationMs, onDone]);

  useEffect(() => () => marqueeAnimRef.current?.stop(), []);

  return (
    <Animated.View
      pointerEvents={onOpen == null ? 'box-none' : 'auto'}
      className={`h-9 flex-row items-center self-center overflow-hidden rounded-full pl-3 pr-1 ${
        opaque ? 'bg-white' : 'bg-white/95'
      }`}
      style={{
        maxWidth: pillMaxWidth,
        gap: CONTENT_GAP,
        borderWidth: 1,
        borderColor: 'rgba(0,0,0,0.1)',
        shadowColor: '#000',
        shadowOpacity: 0.22,
        shadowRadius: 14,
        shadowOffset: { width: 0, height: 4 },
        elevation: 6,
      }}
    >
      <Image source={icon} style={{ width: 24, height: 24 }} resizeMode="contain" />
      <Pressable
        pointerEvents={onOpen == null ? 'none' : 'auto'}
        className="h-full flex-1 justify-center overflow-hidden"
        style={{ minWidth: 0 }}
        onPress={onOpen}
        onLayout={(event) => setClipWidth(event.nativeEvent.layout.width)}
      >
        <Animated.View
          className="absolute inset-y-0 left-0 justify-center"
          style={{ width: MARQUEE_TRACK_WIDTH, alignItems: 'flex-start', transform: [{ translateX: marqueeX }] }}
        >
          <View
            className="flex-row items-center"
            style={{ gap: CONTENT_GAP }}
            onLayout={(event) => setContentWidth(Math.ceil(event.nativeEvent.layout.width))}
          >
            {children}
          </View>
        </Animated.View>
      </Pressable>
      <Pressable
        accessibilityLabel={dismissLabel}
        onPress={onDismiss}
        className="h-7 w-7 items-center justify-center rounded-full active:bg-black/10"
      >
        <Text className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.54)' }}>
          ✕
        </Text>
      </Pressable>
    </Animated.View>
  );
}
