import { useEffect, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { StyleSheet, Text, View, useWindowDimensions } from 'react-native';
import { useReducedMotion } from 'react-native-reanimated';
import Svg, { Circle, Defs, G, Path, RadialGradient, Stop } from 'react-native-svg';
import { GIFT_ANIMATION_DURATION_MS } from '@ola/shared/constants';
import { formatKen, isGiftAnimationKey } from '@ola/shared/lib';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';
import type { GiftAnimationItem, GiftAnimationKey } from '@ola/shared/types';
import { CachedImage } from '@components/ui/CachedImage';
import { GIFT_ACCENT, GIFT_SPARK } from './constants';
import { EASE, type KeyframeAnimation } from './giftKeyframes';
import { KeyframeView } from './KeyframeView';
import {
  BUBBLES,
  CONFETTI,
  FIREWORK,
  FLASH_ANIMATION,
  GIFT_SCENE_EFFECTS,
  GLOW_ANIMATION,
  HEARTS,
  PETALS,
  RAINBOW_ANIMATION,
  RAYS_ANIMATION,
  RING_DELAYS,
  SPARKS,
  STARS,
  bubbleAnimation,
  confettiAnimation,
  fireworkAnimation,
  giftMotion,
  heartAnimation,
  petalAnimation,
  ringAnimation,
  sparkAnimation,
  starAnimation,
  type GiftEffect,
  type Viewport,
} from './giftScenes';
import { CharmIcon } from './CharmIcon';

const GIFT_SIZE_MAX = 240;
const GIFT_SIZE_VW = 62;
const RAYS_SIZE = 380;
const RAY_COUNT = 12;
const GLOW_SIZE = 340;
const FLASH_SIZE = 320;
const RAINBOW_SIZE = 350;
const RAINBOW_RADIUS = 148;
const RAINBOW_STROKE = 22;
const RAINBOW_SEGMENTS = 36;
const RAINBOW_COLORS: [number, number, number][] = [
  [255, 64, 129],
  [255, 214, 0],
  [105, 240, 174],
  [64, 196, 255],
  [224, 64, 251],
  [255, 64, 129],
];
const RING_SIZE = 240;
const SPARK_SIZE = 14;
const DOT_SIZE = 8;

const CAPTION_ANIMATION: KeyframeAnimation = {
  frames: [
    { at: 0, opacity: 0, transform: { translateY: 12 } },
    { at: 0.2, opacity: 0, transform: { translateY: 12 } },
    { at: 0.32, opacity: 1, transform: {} },
    { at: 0.8, opacity: 1, transform: {} },
    { at: 1, opacity: 0, transform: { translateY: -8 } },
  ],
  duration: GIFT_ANIMATION_DURATION_MS,
  easing: EASE.out,
};

function rayPath(index: number) {
  const center = RAYS_SIZE / 2;
  const step = (Math.PI * 2) / RAY_COUNT;
  const start = index * step;
  const end = start + step / 3;
  const point = (angle: number) => `${center + Math.cos(angle) * center} ${center + Math.sin(angle) * center}`;
  return `M ${center} ${center} L ${point(start)} L ${point(end)} Z`;
}

const RAY_PATHS = Array.from({ length: RAY_COUNT }, (_, index) => rayPath(index));

function mixColor(a: [number, number, number], b: [number, number, number], ratio: number): string {
  const channel = (i: number) => Math.round(a[i] + (b[i] - a[i]) * ratio);
  return `rgb(${channel(0)}, ${channel(1)}, ${channel(2)})`;
}

function rainbowColor(fraction: number): string {
  const scaled = fraction * (RAINBOW_COLORS.length - 1);
  const index = Math.min(Math.floor(scaled), RAINBOW_COLORS.length - 2);
  return mixColor(RAINBOW_COLORS[index], RAINBOW_COLORS[index + 1], scaled - index);
}

function arcPath(startFraction: number, endFraction: number): string {
  const center = RAINBOW_SIZE / 2;
  const point = (fraction: number) => {
    const angle = fraction * Math.PI * 2 - Math.PI / 2;
    return `${center + Math.cos(angle) * RAINBOW_RADIUS} ${center + Math.sin(angle) * RAINBOW_RADIUS}`;
  };
  return `M ${point(startFraction)} A ${RAINBOW_RADIUS} ${RAINBOW_RADIUS} 0 0 1 ${point(endFraction)}`;
}

const RAINBOW_ARCS = Array.from({ length: RAINBOW_SEGMENTS }, (_, i) => ({
  d: arcPath(i / RAINBOW_SEGMENTS, (i + 1.05) / RAINBOW_SEGMENTS),
  color: rainbowColor((i + 0.5) / RAINBOW_SEGMENTS),
}));

function centered(width: number, height: number) {
  return { position: 'absolute' as const, left: -width / 2, top: -height / 2, width, height };
}

function Centered({ animation, width, height, children }: {
  animation: KeyframeAnimation;
  width: number;
  height: number;
  children?: ReactNode;
}) {
  return (
    <KeyframeView animation={animation} style={centered(width, height)}>
      {children}
    </KeyframeView>
  );
}

function RadialDisc({ id, size, stops }: { id: string; size: number; stops: [number, string, number][] }) {
  return (
    <Svg width={size} height={size}>
      <Defs>
        <RadialGradient id={id} cx="50%" cy="50%" r="50%">
          {stops.map(([offset, color, opacity]) => (
            <Stop key={offset} offset={offset} stopColor={color} stopOpacity={opacity} />
          ))}
        </RadialGradient>
      </Defs>
      <Circle cx={size / 2} cy={size / 2} r={size / 2} fill={`url(#${id})`} />
    </Svg>
  );
}

function EffectLayer({ effect, viewport }: { effect: GiftEffect; viewport: Viewport }) {
  switch (effect) {
    case 'rays':
      return (
        <Centered animation={RAYS_ANIMATION} width={RAYS_SIZE} height={RAYS_SIZE}>
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
        </Centered>
      );
    case 'glow':
      return (
        <Centered animation={GLOW_ANIMATION} width={GLOW_SIZE} height={GLOW_SIZE}>
          <RadialDisc
            id="giftGlow"
            size={GLOW_SIZE}
            stops={[
              [0, '#ffd600', 0.55],
              [0.4, '#ff4081', 0.35],
              [0.7, '#ff4081', 0],
              [1, '#ff4081', 0],
            ]}
          />
        </Centered>
      );
    case 'rainbow':
      return (
        <Centered animation={RAINBOW_ANIMATION} width={RAINBOW_SIZE} height={RAINBOW_SIZE}>
          <Svg width={RAINBOW_SIZE} height={RAINBOW_SIZE}>
            {RAINBOW_ARCS.map((arc) => (
              <Path key={arc.d} d={arc.d} stroke={arc.color} strokeWidth={RAINBOW_STROKE} fill="none" />
            ))}
          </Svg>
        </Centered>
      );
    case 'ring':
      return (
        <>
          {RING_DELAYS.map((delay) => (
            <Centered key={delay} animation={ringAnimation(delay)} width={RING_SIZE} height={RING_SIZE}>
              <View style={styles.ring} />
            </Centered>
          ))}
        </>
      );
    case 'sparks':
      return (
        <>
          {SPARKS.map((spark) => (
            <Centered key={`${spark.x}:${spark.y}`} animation={sparkAnimation(spark)} width={SPARK_SIZE} height={SPARK_SIZE}>
              <View style={styles.spark} />
            </Centered>
          ))}
        </>
      );
    case 'confetti':
      return (
        <>
          {CONFETTI.map((piece) => (
            <Centered key={`${piece.x}:${piece.delay}`} animation={confettiAnimation(piece, viewport)} width={8} height={14}>
              <View style={[styles.confetti, { backgroundColor: piece.color }]} />
            </Centered>
          ))}
        </>
      );
    case 'hearts':
      return (
        <>
          {HEARTS.map((heart) => (
            <Centered key={`${heart.x}:${heart.delay}`} animation={heartAnimation(heart)} width={heart.size * 1.4} height={heart.size * 1.4}>
              <Text style={[styles.glyph, { color: heart.color, fontSize: heart.size, lineHeight: heart.size * 1.4 }]}>♥</Text>
            </Centered>
          ))}
        </>
      );
    case 'stars':
      return (
        <>
          {STARS.map((star) => (
            <Centered key={`${star.x}:${star.y}`} animation={starAnimation(star)} width={star.size * 1.4} height={star.size * 1.4}>
              <Text
                style={[
                  styles.glyph,
                  { color: star.color, fontSize: star.size, lineHeight: star.size * 1.4, textShadowColor: star.color },
                ]}
              >
                ✦
              </Text>
            </Centered>
          ))}
        </>
      );
    case 'bubbles':
      return (
        <>
          {BUBBLES.map((bubble) => (
            <Centered key={`${bubble.x}:${bubble.delay}`} animation={bubbleAnimation(bubble)} width={bubble.size} height={bubble.size}>
              <View style={[styles.bubble, { borderRadius: bubble.size / 2 }]} />
            </Centered>
          ))}
        </>
      );
    case 'firework':
      return (
        <>
          {FIREWORK.map((dot) => (
            <Centered key={dot.key} animation={fireworkAnimation(dot)} width={DOT_SIZE} height={DOT_SIZE}>
              <View style={[styles.dot, { backgroundColor: dot.color, shadowColor: dot.color }]} />
            </Centered>
          ))}
        </>
      );
    case 'petals':
      return (
        <>
          {PETALS.map((petal) => (
            <Centered key={`${petal.x}:${petal.delay}`} animation={petalAnimation(petal, viewport)} width={16} height={12}>
              <View style={styles.petal} />
            </Centered>
          ))}
        </>
      );
  }
}

function GiftImage({ item, size }: { item: GiftAnimationItem; size: number }) {
  const { t } = useTranslation();
  return (
    <View style={{ width: size, height: size }}>
      <CachedImage uri={item.imageUrl} style={{ width: size, height: size }} resizeMode="contain" priority="high" />
      {item.quantity > 1 && (
        <View className="absolute rounded-full px-3 py-0.5" style={styles.quantity}>
          <Text className="text-2xl font-bold text-white">{t('gift.quantityTimes', { count: item.quantity })}</Text>
        </View>
      )}
    </View>
  );
}

function GiftCaption({ item }: { item: GiftAnimationItem }) {
  const { t } = useTranslation();
  return (
    <View className="rounded-full px-4 py-1.5" style={styles.caption}>
      <Text className="text-center text-sm font-semibold text-white">{item.caption ?? item.name}</Text>
      {item.charmPoints > 0 && (
        <View className="flex-row items-center justify-center" style={{ gap: 3 }}>
          <CharmIcon size={14} />
          <Text className="text-xs" style={{ color: GIFT_SPARK }}>
            {t('gift.charmGain', { value: formatKen(item.charmPoints) })}
          </Text>
        </View>
      )}
    </View>
  );
}

function GiftScene({ item, reducedMotion }: { item: GiftAnimationItem; reducedMotion: boolean }) {
  const { width, height } = useWindowDimensions();
  const viewport: Viewport = { vw: width / 100, vh: height / 100 };
  const size = Math.min(GIFT_SIZE_VW * viewport.vw, GIFT_SIZE_MAX);
  const key: GiftAnimationKey = isGiftAnimationKey(item.animation) ? item.animation : 'fly';
  const captionTop = size / 2 + 12;

  if (reducedMotion) {
    return (
      <View pointerEvents="none" style={styles.fill}>
        <GiftImage item={item} size={size} />
        <View className="mt-3">
          <GiftCaption item={item} />
        </View>
      </View>
    );
  }

  return (
    <View pointerEvents="none" style={styles.fill}>
      <View style={styles.anchor}>
        {GIFT_SCENE_EFFECTS[key].map((effect) => (
          <EffectLayer key={effect} effect={effect} viewport={viewport} />
        ))}
        <Centered animation={FLASH_ANIMATION} width={FLASH_SIZE} height={FLASH_SIZE}>
          <RadialDisc
            id="giftFlash"
            size={FLASH_SIZE}
            stops={[
              [0, '#ffffff', 0.95],
              [0.35, '#ffffff', 0.5],
              [0.7, '#ffffff', 0],
              [1, '#ffffff', 0],
            ]}
          />
        </Centered>
        <Centered animation={giftMotion(key, viewport)} width={size} height={size}>
          <GiftImage item={item} size={size} />
        </Centered>
        <KeyframeView animation={CAPTION_ANIMATION} style={[styles.captionSlot, { top: captionTop }]}>
          <GiftCaption item={item} />
        </KeyframeView>
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
    overflow: 'hidden',
  },
  anchor: {
    width: 0,
    height: 0,
    overflow: 'visible',
  },
  captionSlot: {
    position: 'absolute',
    left: -150,
    width: 300,
    alignItems: 'center',
  },
  ring: {
    width: RING_SIZE,
    height: RING_SIZE,
    borderRadius: RING_SIZE / 2,
    borderWidth: 4,
    borderColor: GIFT_SPARK,
    shadowColor: GIFT_SPARK,
    shadowOpacity: 1,
    shadowRadius: 8,
    shadowOffset: { width: 0, height: 0 },
  },
  spark: {
    width: SPARK_SIZE,
    height: SPARK_SIZE,
    borderRadius: SPARK_SIZE / 2,
    backgroundColor: GIFT_SPARK,
    shadowColor: GIFT_SPARK,
    shadowOpacity: 1,
    shadowRadius: 6,
    shadowOffset: { width: 0, height: 0 },
  },
  confetti: {
    width: 8,
    height: 14,
    borderRadius: 2,
  },
  glyph: {
    textAlign: 'center',
    textShadowRadius: 6,
    textShadowOffset: { width: 0, height: 0 },
  },
  bubble: {
    flex: 1,
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.8)',
    backgroundColor: 'rgba(64,196,255,0.25)',
  },
  dot: {
    width: DOT_SIZE,
    height: DOT_SIZE,
    borderRadius: DOT_SIZE / 2,
    shadowOpacity: 1,
    shadowRadius: 4,
    shadowOffset: { width: 0, height: 0 },
  },
  petal: {
    width: 16,
    height: 12,
    borderTopLeftRadius: 12,
    borderBottomRightRadius: 12,
    backgroundColor: '#ff9ec7',
  },
  quantity: {
    right: 0,
    bottom: 12,
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
