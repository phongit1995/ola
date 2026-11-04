import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { StyleSheet, Text, View, useWindowDimensions } from 'react-native';
import Animated, {
  Easing,
  useAnimatedStyle,
  useReducedMotion,
  useSharedValue,
  withDelay,
  withSequence,
  withTiming,
} from 'react-native-reanimated';
import Svg, { Defs, G, Path, RadialGradient, Stop } from 'react-native-svg';
import { GIFT_ANIMATION_DURATION_MS } from '@ola/shared/constants';
import { formatKen } from '@ola/shared/lib';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';
import type { GiftAnimationItem } from '@ola/shared/types';
import { CachedImage } from '@components/ui/CachedImage';
import { GIFT_ACCENT, GIFT_SPARK } from './constants';

const FLY_EASING = Easing.bezier(0.22, 1, 0.36, 1);
const RAYS_SIZE = 260;
const RAY_COUNT = 12;
const GIFT_SIZE = 160;
const SPARK_SIZE = 12;
const SPARK_DURATION_MS = 1400;

const SPARKS = [
  { x: -120, y: -90, delay: 350 },
  { x: 110, y: -110, delay: 450 },
  { x: -140, y: 30, delay: 500 },
  { x: 130, y: 50, delay: 400 },
  { x: -60, y: -140, delay: 600 },
  { x: 70, y: 120, delay: 550 },
  { x: -90, y: 110, delay: 650 },
  { x: 20, y: -150, delay: 500 },
];

function at(fraction: number): number {
  return Math.round(GIFT_ANIMATION_DURATION_MS * fraction);
}

function rayPath(index: number) {
  const center = RAYS_SIZE / 2;
  const step = (Math.PI * 2) / RAY_COUNT;
  const start = index * step;
  const end = start + step / 3;
  const point = (angle: number) =>
    `${center + Math.cos(angle) * center} ${center + Math.sin(angle) * center}`;
  return `M ${center} ${center} L ${point(start)} L ${point(end)} Z`;
}

const RAY_PATHS = Array.from({ length: RAY_COUNT }, (_, index) => rayPath(index));

function GiftRays() {
  const opacity = useSharedValue(0);
  const scale = useSharedValue(0.4);
  const rotation = useSharedValue(0);

  useEffect(() => {
    const linear = (duration: number) => ({ duration, easing: Easing.linear });
    opacity.value = withSequence(
      withTiming(0.9, linear(at(0.25))),
      withDelay(at(0.5), withTiming(0, linear(at(0.25))))
    );
    scale.value = withSequence(
      withTiming(1, linear(at(0.25))),
      withDelay(at(0.5), withTiming(1.2, linear(at(0.25))))
    );
    rotation.value = withSequence(
      withTiming(90, linear(at(0.25))),
      withDelay(at(0.5), withTiming(140, linear(at(0.25))))
    );
  }, [opacity, rotation, scale]);

  const style = useAnimatedStyle(() => ({
    opacity: opacity.value,
    transform: [{ scale: scale.value }, { rotate: `${rotation.value}deg` }],
  }));

  return (
    <Animated.View pointerEvents="none" style={[styles.rays, style]}>
      <Svg width={RAYS_SIZE} height={RAYS_SIZE}>
        <Defs>
          <RadialGradient id="giftRays" cx="50%" cy="50%" r="50%">
            <Stop offset="0.3" stopColor={GIFT_SPARK} stopOpacity={0.55} />
            <Stop offset="1" stopColor={GIFT_SPARK} stopOpacity={0} />
          </RadialGradient>
        </Defs>
        <G>
          {RAY_PATHS.map((path) => (
            <Path key={path} d={path} fill="url(#giftRays)" />
          ))}
        </G>
      </Svg>
    </Animated.View>
  );
}

function GiftSpark({ x, y, delay }: { x: number; y: number; delay: number }) {
  const progress = useSharedValue(0);
  const opacity = useSharedValue(0);

  useEffect(() => {
    const easing = Easing.out(Easing.quad);
    progress.value = withDelay(delay, withTiming(1, { duration: SPARK_DURATION_MS, easing }));
    opacity.value = withDelay(
      delay,
      withSequence(
        withTiming(1, { duration: SPARK_DURATION_MS * 0.3, easing }),
        withTiming(0, { duration: SPARK_DURATION_MS * 0.7, easing })
      )
    );
  }, [delay, opacity, progress]);

  const style = useAnimatedStyle(() => ({
    opacity: opacity.value,
    transform: [
      { translateX: x * progress.value },
      { translateY: y * progress.value },
      { scale: 0.2 + 0.8 * progress.value },
    ],
  }));

  return <Animated.View pointerEvents="none" style={[styles.spark, style]} />;
}

function GiftScene({ item, reducedMotion }: { item: GiftAnimationItem; reducedMotion: boolean }) {
  const { t } = useTranslation();
  const { height } = useWindowDimensions();
  const flyOpacity = useSharedValue(reducedMotion ? 1 : 0);
  const flyY = useSharedValue(reducedMotion ? 0 : height * 0.45);
  const flyScale = useSharedValue(reducedMotion ? 1 : 0.3);
  const flyRotate = useSharedValue(reducedMotion ? 0 : -12);
  const captionOpacity = useSharedValue(reducedMotion ? 1 : 0);
  const captionY = useSharedValue(reducedMotion ? 0 : 12);

  useEffect(() => {
    if (reducedMotion) return;
    const timing = (value: number, fraction: number) =>
      withTiming(value, { duration: at(fraction), easing: FLY_EASING });
    flyOpacity.value = withSequence(timing(1, 0.22), withDelay(at(0.56), timing(0, 0.22)));
    flyY.value = withSequence(timing(0, 0.22), withDelay(at(0.56), timing(-height * 0.18, 0.22)));
    flyScale.value = withSequence(
      timing(1.18, 0.22),
      timing(0.96, 0.1),
      timing(1, 0.08),
      withDelay(at(0.38), timing(0.7, 0.22))
    );
    flyRotate.value = withSequence(timing(4, 0.22), timing(0, 0.1));

    const easeOut = (value: number, fraction: number) =>
      withTiming(value, { duration: at(fraction), easing: Easing.out(Easing.quad) });
    captionOpacity.value = withDelay(
      at(0.2),
      withSequence(easeOut(1, 0.12), withDelay(at(0.48), easeOut(0, 0.2)))
    );
    captionY.value = withDelay(
      at(0.2),
      withSequence(easeOut(0, 0.12), withDelay(at(0.48), easeOut(-8, 0.2)))
    );
  }, [captionOpacity, captionY, flyOpacity, flyRotate, flyScale, flyY, height, reducedMotion]);

  const flyStyle = useAnimatedStyle(() => ({
    opacity: flyOpacity.value,
    transform: [
      { translateY: flyY.value },
      { scale: flyScale.value },
      { rotate: `${flyRotate.value}deg` },
    ],
  }));

  const captionStyle = useAnimatedStyle(() => ({
    opacity: captionOpacity.value,
    transform: [{ translateY: captionY.value }],
  }));

  return (
    <View pointerEvents="none" style={styles.fill}>
      <View className="items-center">
        <View style={styles.stage}>
          {!reducedMotion && <GiftRays />}
          {!reducedMotion &&
            SPARKS.map((spark) => <GiftSpark key={`${spark.x}:${spark.y}`} {...spark} />)}
          <Animated.View style={flyStyle}>
            <CachedImage
              uri={item.imageUrl}
              style={{ width: GIFT_SIZE, height: GIFT_SIZE }}
              resizeMode="contain"
              priority="high"
            />
            {item.quantity > 1 && (
              <View className="absolute rounded-full px-2.5 py-0.5" style={styles.quantity}>
                <Text className="text-xl font-bold text-white">
                  {t('gift.quantityTimes', { count: item.quantity })}
                </Text>
              </View>
            )}
          </Animated.View>
        </View>
        <Animated.View className="mt-3 rounded-full px-4 py-1.5" style={[styles.caption, captionStyle]}>
          <Text className="text-center text-sm font-semibold text-white">
            {item.caption ?? item.name}
          </Text>
          {item.charmPoints > 0 && (
            <Text className="text-center text-xs" style={{ color: GIFT_SPARK }}>
              {t('gift.charmGain', { value: formatKen(item.charmPoints) })}
            </Text>
          )}
        </Animated.View>
      </View>
    </View>
  );
}

export function GiftAnimationOverlay() {
  const current = useGiftAnimationStore((s) => s.queue[0]);
  const next = useGiftAnimationStore((s) => s.next);
  const reducedMotion = useReducedMotion();

  useEffect(() => {
    if (current == null) return;
    const timer = setTimeout(next, GIFT_ANIMATION_DURATION_MS);
    return () => clearTimeout(timer);
  }, [current, next]);

  if (current == null) return null;
  return <GiftScene key={current.id} item={current} reducedMotion={reducedMotion} />;
}

const styles = StyleSheet.create({
  fill: {
    ...StyleSheet.absoluteFill,
    alignItems: 'center',
    justifyContent: 'center',
  },
  stage: {
    width: RAYS_SIZE,
    height: GIFT_SIZE,
    alignItems: 'center',
    justifyContent: 'center',
  },
  rays: {
    position: 'absolute',
    width: RAYS_SIZE,
    height: RAYS_SIZE,
    left: 0,
    top: (GIFT_SIZE - RAYS_SIZE) / 2,
  },
  spark: {
    position: 'absolute',
    width: SPARK_SIZE,
    height: SPARK_SIZE,
    borderRadius: SPARK_SIZE / 2,
    left: (RAYS_SIZE - SPARK_SIZE) / 2,
    top: (GIFT_SIZE - SPARK_SIZE) / 2,
    backgroundColor: GIFT_SPARK,
    shadowColor: GIFT_SPARK,
    shadowOpacity: 1,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 0 },
  },
  quantity: {
    right: -12,
    bottom: 8,
    backgroundColor: GIFT_ACCENT,
    shadowColor: '#000',
    shadowOpacity: 0.3,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 3 },
    elevation: 6,
  },
  caption: {
    backgroundColor: 'rgba(0,0,0,0.6)',
    shadowColor: '#000',
    shadowOpacity: 0.3,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 3 },
    elevation: 6,
  },
});
