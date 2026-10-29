import { useCallback, useEffect, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  type LayoutRectangle,
  type NativeScrollEvent,
  type NativeSyntheticEvent,
  Pressable,
  StyleSheet,
  View,
} from 'react-native';
import { ScrollView } from 'react-native-gesture-handler';
import Animated, {
  useAnimatedStyle,
  useReducedMotion,
  useSharedValue,
  withDelay,
  withSequence,
  withSpring,
  withTiming,
} from 'react-native-reanimated';
import LinearGradient from 'react-native-linear-gradient';
import {
  createMomentReactionBurst,
  MOMENT_REACTION_LABEL_KEY,
} from '@ola/shared/lib';
import type { MomentReactionBurst, ReactionType } from '@ola/shared/types';
import { hapticTick } from '@lib/haptics';
import { REACTION_IMAGE, REACTION_ORDER } from '@lib/reactions';
import { MomentReactionFireworks } from './MomentReactionFireworks';

const MAX_BURSTS = 5;
const POP_PEAK = 1.4;
const POP_MS = 100;
const POP_HOLD_MS = 120;
const REACTION_HIT_SLOP = 4;
const LEADING_WIDTH = 200;
const POP_ROOM = 10;
const ENTER_DELAY_MS = 120;
const ENTER_STAGGER_MS = 45;
const ENTER_RISE = 16;
const ENTER_SCALE_FROM = 0.4;
const ENTER_FADE = 2.5;
const ENTER_SPRING = { damping: 11, stiffness: 190, mass: 0.8 };

const styles = StyleSheet.create({
  shade: { position: 'absolute', left: 0, right: 0, bottom: 0, height: 112 },
  stage: {
    position: 'absolute',
    top: 0,
    right: 0,
    bottom: 0,
    left: 0,
    overflow: 'hidden',
  },
  bar: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 12 - POP_ROOM,
  },
  barContent: {
    flexGrow: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 6,
    paddingVertical: POP_ROOM,
    paddingHorizontal: 12,
  },
  leading: { flexGrow: 1, flexShrink: 0, flexBasis: LEADING_WIDTH, marginRight: 2 },
  button: { padding: 4, borderRadius: 999 },
  image: { width: 38, height: 38 },
});

function ReactionButton({
  type,
  index,
  onPress,
  onMeasure,
}: {
  type: ReactionType;
  index: number;
  onPress: (type: ReactionType) => void;
  onMeasure: (type: ReactionType, layout: LayoutRectangle) => void;
}) {
  const { t } = useTranslation();
  const reduceMotion = useReducedMotion();
  const scale = useSharedValue(1);
  const enter = useSharedValue(reduceMotion ? 1 : 0);
  const popStyle = useAnimatedStyle(() => ({
    opacity: Math.min(enter.value * ENTER_FADE, 1),
    transform: [
      { translateY: (1 - enter.value) * ENTER_RISE },
      { scale: scale.value * (ENTER_SCALE_FROM + (1 - ENTER_SCALE_FROM) * enter.value) },
    ],
  }));

  useEffect(() => {
    if (reduceMotion) return;
    enter.value = withDelay(ENTER_DELAY_MS + index * ENTER_STAGGER_MS, withSpring(1, ENTER_SPRING));
  }, [enter, index, reduceMotion]);
  const image = REACTION_IMAGE[type];
  if (image == null) return null;

  function press() {
    scale.value = withSequence(
      withTiming(POP_PEAK, { duration: POP_MS }),
      withDelay(POP_HOLD_MS, withTiming(1, { duration: POP_MS })),
    );
    hapticTick();
    onPress(type);
  }

  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={t(MOMENT_REACTION_LABEL_KEY[type])}
      hitSlop={REACTION_HIT_SLOP}
      onPress={press}
      onLayout={event => onMeasure(type, event.nativeEvent.layout)}
      style={styles.button}
    >
      <Animated.Image
        source={image}
        resizeMode="contain"
        style={[styles.image, popStyle]}
      />
    </Pressable>
  );
}

export function MomentReactionBar({
  onReact,
  leading,
}: {
  onReact: (type: ReactionType) => void;
  leading?: ReactNode;
}) {
  const reduceMotion = useReducedMotion();
  const stage = useRef<LayoutRectangle | null>(null);
  const bar = useRef<LayoutRectangle | null>(null);
  const scrollX = useRef(0);
  const buttons = useRef(new Map<ReactionType, LayoutRectangle>());
  const [bursts, setBursts] = useState<MomentReactionBurst[]>([]);

  const measureButton = useCallback(
    (type: ReactionType, layout: LayoutRectangle) => {
      buttons.current.set(type, layout);
    },
    [],
  );

  const trackScroll = useCallback((event: NativeSyntheticEvent<NativeScrollEvent>) => {
    scrollX.current = event.nativeEvent.contentOffset.x;
  }, []);

  const finishBurst = useCallback((id: number) => {
    setBursts(current => current.filter(burst => burst.id !== id));
  }, []);

  const react = useCallback(
    (type: ReactionType) => {
      const button = buttons.current.get(type);
      if (
        !reduceMotion &&
        stage.current != null &&
        bar.current != null &&
        button != null
      ) {
        const burst = createMomentReactionBurst(type, stage.current, {
          x: bar.current.x + button.x - scrollX.current + button.width / 2,
          y: bar.current.y + button.y + button.height / 2,
        });
        setBursts(current => [...current, burst].slice(-MAX_BURSTS));
      }
      onReact(type);
    },
    [onReact, reduceMotion],
  );

  return (
    <>
      <LinearGradient
        pointerEvents="none"
        colors={['rgba(0,0,0,0)', 'rgba(0,0,0,0.55)']}
        style={styles.shade}
      />
      <View
        pointerEvents="none"
        style={styles.stage}
        onLayout={event => {
          stage.current = event.nativeEvent.layout;
        }}
      >
        <MomentReactionFireworks bursts={bursts} onDone={finishBurst} />
      </View>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        keyboardShouldPersistTaps="handled"
        scrollEventThrottle={32}
        onScroll={trackScroll}
        onLayout={event => {
          bar.current = event.nativeEvent.layout;
        }}
        style={styles.bar}
        contentContainerStyle={styles.barContent}
      >
        {leading != null && <View style={styles.leading}>{leading}</View>}
        {REACTION_ORDER.map((type, index) => (
          <ReactionButton
            key={type}
            type={type}
            index={index}
            onPress={react}
            onMeasure={measureButton}
          />
        ))}
      </ScrollView>
    </>
  );
}
