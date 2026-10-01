import { useEffect, useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View, StyleSheet } from 'react-native';
import Animated, {
  Easing,
  cancelAnimation,
  useAnimatedStyle,
  useReducedMotion,
  useSharedValue,
  withDelay,
  withRepeat,
  withSequence,
  withTiming,
} from 'react-native-reanimated';
import Svg, { Defs, G, Path, RadialGradient, Stop } from 'react-native-svg';
import type { WordChainMessage } from '@ola/shared/types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { useThemeColors } from '@hooks/useThemeColors';
import { WordChainConfetti } from './WordChainConfetti';
import { WORD_CHAIN_STATUS_ICONS } from './wordChainAssets';

const WIN_CELEBRATION_MS = 3600;
const WIN_CELEBRATION_OUT_MS = 300;
const CARD_IN_MS = 500;
const TROPHY_DELAY_MS = 100;
const RAYS_TURN_MS = 8000;
const RAYS_SIZE = 160;
const RAY_COUNT = 15;
const TROPHY_SIZE = 80;
const OVERSHOOT = Easing.bezier(0.34, 1.56, 0.64, 1);
const WIN_WORD_COLOR = '#f59e0b';

function rayPath(index: number) {
  const center = RAYS_SIZE / 2;
  const step = (Math.PI * 2) / RAY_COUNT;
  const start = index * step;
  const end = start + step / 2;
  const point = (angle: number) =>
    `${center + Math.cos(angle) * center} ${center + Math.sin(angle) * center}`;
  return `M ${center} ${center} L ${point(start)} L ${point(end)} Z`;
}

const RAY_PATHS = Array.from({ length: RAY_COUNT }, (_, index) => rayPath(index));

function TrophyRays() {
  const reducedMotion = useReducedMotion();
  const rotation = useSharedValue(0);

  useEffect(() => {
    if (reducedMotion) return;
    rotation.value = withRepeat(
      withTiming(360, { duration: RAYS_TURN_MS, easing: Easing.linear }),
      -1,
      false
    );
    return () => cancelAnimation(rotation);
  }, [reducedMotion, rotation]);

  const style = useAnimatedStyle(() => ({
    transform: [{ rotate: `${rotation.value}deg` }],
  }));

  return (
    <Animated.View
      pointerEvents="none"
      style={[
        {
          position: 'absolute',
          width: RAYS_SIZE,
          height: RAYS_SIZE,
          left: '50%',
          top: '50%',
          marginLeft: -RAYS_SIZE / 2,
          marginTop: -RAYS_SIZE / 2,
        },
        style,
      ]}
    >
      <Svg width={RAYS_SIZE} height={RAYS_SIZE}>
        <Defs>
          <RadialGradient id="wordChainRays" cx="50%" cy="50%" r="50%">
            <Stop offset="0.3" stopColor="#ffd54f" stopOpacity={0.65} />
            <Stop offset="1" stopColor="#ffd54f" stopOpacity={0} />
          </RadialGradient>
        </Defs>
        <G>
          {RAY_PATHS.map((path) => (
            <Path key={path} d={path} fill="url(#wordChainRays)" />
          ))}
        </G>
      </Svg>
    </Animated.View>
  );
}

function Trophy() {
  const reducedMotion = useReducedMotion();
  const scale = useSharedValue(reducedMotion ? 1 : 0);
  const rotation = useSharedValue(reducedMotion ? 0 : -25);

  useEffect(() => {
    if (reducedMotion) return;
    scale.value = withDelay(
      TROPHY_DELAY_MS,
      withSequence(
        withTiming(1.18, { duration: 440 }),
        withTiming(0.94, { duration: 160 }),
        withTiming(1, { duration: 200 })
      )
    );
    rotation.value = withDelay(
      TROPHY_DELAY_MS,
      withSequence(
        withTiming(8, { duration: 440 }),
        withTiming(-4, { duration: 160 }),
        withTiming(0, { duration: 200 })
      )
    );
  }, [reducedMotion, rotation, scale]);

  const style = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }, { rotate: `${rotation.value}deg` }],
  }));

  return (
    <Animated.View style={style}>
      <Image
        source={WORD_CHAIN_STATUS_ICONS.win.source}
        style={{ width: TROPHY_SIZE, height: TROPHY_SIZE }}
        resizeMode="contain"
      />
    </Animated.View>
  );
}

export function WordChainWinCelebration({
  winner,
  isOwn,
}: {
  winner: WordChainMessage;
  isOwn: boolean;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const reducedMotion = useReducedMotion();
  const dismiss = useWordChainStore((store) => store.dismissCelebration);
  const [leaving, setLeaving] = useState(false);
  const progress = useSharedValue(0);
  const word = winner.word || winner.content;

  useEffect(() => {
    progress.value = withTiming(1, {
      duration: reducedMotion ? 250 : CARD_IN_MS,
      easing: reducedMotion ? Easing.out(Easing.quad) : OVERSHOOT,
    });
  }, [progress, reducedMotion]);

  useEffect(() => {
    if (!leaving) {
      const timer = setTimeout(() => setLeaving(true), WIN_CELEBRATION_MS);
      return () => clearTimeout(timer);
    }
    progress.value = withTiming(0, {
      duration: WIN_CELEBRATION_OUT_MS,
      easing: Easing.in(Easing.quad),
    });
    const timer = setTimeout(() => dismiss(winner.id), WIN_CELEBRATION_OUT_MS);
    return () => clearTimeout(timer);
  }, [dismiss, leaving, progress, winner.id]);

  const cardStyle = useAnimatedStyle(() => {
    const value = progress.value;
    if (reducedMotion) return { opacity: value };
    return {
      opacity: Math.min(1, value),
      transform: [
        { translateY: leaving ? (1 - value) * -8 : (1 - value) * 16 },
        { scale: leaving ? 0.92 + 0.08 * value : 0.7 + 0.3 * value },
      ],
    };
  });

  return (
    <View
      pointerEvents="box-none"
      accessibilityLiveRegion="polite"
      style={[StyleSheet.absoluteFill, { zIndex: 30, alignItems: 'center', justifyContent: 'center', paddingHorizontal: 24 }]}
    >
      {!reducedMotion && <WordChainConfetti />}
      <Animated.View style={[{ width: '100%', maxWidth: 300, marginTop: 40 }, cardStyle]}>
        <Pressable
          accessibilityRole="button"
          onPress={() => setLeaving(true)}
          className="items-center rounded-3xl bg-white px-6 pb-5"
          style={{
            borderWidth: 1,
            borderColor: '#fde68a',
            shadowColor: '#000',
            shadowOpacity: 0.25,
            shadowRadius: 25,
            shadowOffset: { width: 0, height: 18 },
            elevation: 12,
          }}
        >
          <View className="items-center justify-center" style={{ width: 112, height: 112, marginTop: -56 }}>
            <TrophyRays />
            <Trophy />
          </View>
          <Text className="text-center text-base font-semibold" style={{ color: 'rgba(0,0,0,0.8)' }}>
            {isOwn ? (
              t('wordChain.winCelebrationTitleMine')
            ) : (
              <Trans
                i18nKey="wordChain.winCelebrationTitle"
                values={{ name: winner.senderName ?? '' }}
                components={{ name: <Text style={{ fontWeight: '700', color: colors.primaryDark }} /> }}
              />
            )}
          </Text>
          <Text
            className="mt-1 text-center"
            style={{
              fontSize: 30,
              lineHeight: 38,
              fontWeight: '800',
              color: WIN_WORD_COLOR,
              textShadowColor: 'rgba(146,64,14,0.35)',
              textShadowOffset: { width: 0, height: 1 },
              textShadowRadius: 0,
            }}
          >
            {word}
          </Text>
          <View className="mt-3 rounded-full px-3 py-0.5" style={{ backgroundColor: '#fef3c7' }}>
            <Text className="text-sm font-semibold" style={{ color: '#b45309' }}>
              {t('wordChain.winCelebrationReward')}
            </Text>
          </View>
        </Pressable>
      </Animated.View>
    </View>
  );
}
