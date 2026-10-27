import { useCallback, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  type LayoutRectangle,
  Pressable,
  StyleSheet,
  View,
} from 'react-native';
import Animated, {
  useAnimatedStyle,
  useReducedMotion,
  useSharedValue,
  withDelay,
  withSequence,
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
    bottom: 12,
    flexDirection: 'row',
    justifyContent: 'center',
    gap: 6,
    paddingHorizontal: 12,
  },
  button: { padding: 4, borderRadius: 999 },
  image: { width: 38, height: 38 },
});

function ReactionButton({
  type,
  onPress,
  onMeasure,
}: {
  type: ReactionType;
  onPress: (type: ReactionType) => void;
  onMeasure: (type: ReactionType, layout: LayoutRectangle) => void;
}) {
  const { t } = useTranslation();
  const scale = useSharedValue(1);
  const popStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
  }));
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
}: {
  onReact: (type: ReactionType) => void;
}) {
  const { t } = useTranslation();
  const reduceMotion = useReducedMotion();
  const stage = useRef<LayoutRectangle | null>(null);
  const bar = useRef<LayoutRectangle | null>(null);
  const buttons = useRef(new Map<ReactionType, LayoutRectangle>());
  const [bursts, setBursts] = useState<MomentReactionBurst[]>([]);

  const measureButton = useCallback(
    (type: ReactionType, layout: LayoutRectangle) => {
      buttons.current.set(type, layout);
    },
    [],
  );

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
          x: bar.current.x + button.x + button.width / 2,
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
      <View
        pointerEvents="box-none"
        accessibilityLabel={t('moment.reactions')}
        style={styles.bar}
        onLayout={event => {
          bar.current = event.nativeEvent.layout;
        }}
      >
        {REACTION_ORDER.map(type => (
          <ReactionButton
            key={type}
            type={type}
            onPress={react}
            onMeasure={measureButton}
          />
        ))}
      </View>
    </>
  );
}
