import { useEffect } from 'react';
import { StyleSheet, View } from 'react-native';
import Animated, {
  Easing,
  Extrapolation,
  interpolate,
  runOnJS,
  type SharedValue,
  useAnimatedStyle,
  useSharedValue,
  withDelay,
  withTiming,
} from 'react-native-reanimated';
import type {
  MomentReactionBurst,
  MomentReactionSpark,
} from '@ola/shared/types';
import { REACTION_IMAGE } from '@lib/reactions';

const ROCKET_SIZE = 40;
const FLASH_SIZE = 128;
const LAUNCH_MS = 650;
const BLAST_DELAY_MS = 600;
const BLAST_MS = 1100;
const SPARK_SPREAD_END = 0.7;
const SPARK_FALL = 32;
const ROCKET_POP_END = 0.15;

const styles = StyleSheet.create({
  rocket: { position: 'absolute', width: ROCKET_SIZE, height: ROCKET_SIZE },
  flash: {
    position: 'absolute',
    width: FLASH_SIZE,
    height: FLASH_SIZE,
    alignItems: 'center',
    justifyContent: 'center',
  },
  flashOuter: {
    width: FLASH_SIZE,
    height: FLASH_SIZE,
    borderRadius: FLASH_SIZE / 2,
    backgroundColor: 'rgba(255,226,140,0.25)',
  },
  flashMiddle: {
    position: 'absolute',
    width: FLASH_SIZE * 0.6,
    height: FLASH_SIZE * 0.6,
    borderRadius: FLASH_SIZE * 0.3,
    backgroundColor: 'rgba(255,240,200,0.45)',
  },
  flashCore: {
    position: 'absolute',
    width: FLASH_SIZE * 0.3,
    height: FLASH_SIZE * 0.3,
    borderRadius: FLASH_SIZE * 0.15,
    backgroundColor: 'rgba(255,255,255,0.85)',
  },
});

function Spark({
  spark,
  burst,
  blast,
}: {
  spark: MomentReactionSpark;
  burst: MomentReactionBurst;
  blast: SharedValue<number>;
}) {
  const sparkStyle = useAnimatedStyle(() => {
    const spread = Math.min(blast.value / SPARK_SPREAD_END, 1);
    const eased = 1 - Math.pow(1 - spread, 3);
    const fall =
      Math.max(blast.value - SPARK_SPREAD_END, 0) / (1 - SPARK_SPREAD_END);
    return {
      opacity: interpolate(
        blast.value,
        [0, 0.12, SPARK_SPREAD_END, 1],
        [0, 1, 1, 0],
      ),
      transform: [
        { translateX: spark.x * eased },
        { translateY: spark.y * eased + SPARK_FALL * fall },
        {
          scale: interpolate(
            blast.value,
            [0, SPARK_SPREAD_END, 1],
            [0.2, 1, 0.7],
          ),
        },
        { rotate: `${spark.rotate * eased}deg` },
      ],
    };
  });
  const box = {
    position: 'absolute' as const,
    left: burst.toX - spark.size / 2,
    top: burst.toY - spark.size / 2,
    width: spark.size,
    height: spark.size,
  };
  const image = REACTION_IMAGE[burst.type];

  if (spark.color != null) {
    return (
      <Animated.View
        style={[
          box,
          { borderRadius: spark.size / 2, backgroundColor: spark.color },
          sparkStyle,
        ]}
      />
    );
  }
  if (image == null) return null;
  return (
    <Animated.Image
      source={image}
      resizeMode="contain"
      style={[box, sparkStyle]}
    />
  );
}

function Firework({
  burst,
  onDone,
}: {
  burst: MomentReactionBurst;
  onDone: (id: number) => void;
}) {
  const across = useSharedValue(0);
  const rise = useSharedValue(0);
  const blast = useSharedValue(0);
  const image = REACTION_IMAGE[burst.type];

  useEffect(() => {
    across.value = withTiming(1, {
      duration: LAUNCH_MS,
      easing: Easing.inOut(Easing.quad),
    });
    rise.value = withTiming(1, {
      duration: LAUNCH_MS,
      easing: Easing.out(Easing.cubic),
    });
    blast.value = withDelay(
      BLAST_DELAY_MS,
      withTiming(1, { duration: BLAST_MS }, finished => {
        if (finished) runOnJS(onDone)(burst.id);
      }),
    );
  }, [across, rise, blast, burst.id, onDone]);

  const rocketStyle = useAnimatedStyle(() => {
    const pop = interpolate(
      blast.value,
      [0, ROCKET_POP_END],
      [0, 1],
      Extrapolation.CLAMP,
    );
    return {
      opacity: 1 - pop,
      transform: [
        { translateX: across.value * (burst.toX - burst.fromX) },
        { translateY: rise.value * (burst.toY - burst.fromY) },
        { scale: 0.9 + 0.45 * rise.value + 0.5 * pop },
      ],
    };
  });
  const flashStyle = useAnimatedStyle(() => ({
    opacity: interpolate(
      blast.value,
      [0, 0.02, 0.45],
      [0, 0.95, 0],
      Extrapolation.CLAMP,
    ),
    transform: [
      {
        scale: interpolate(
          blast.value,
          [0, 0.45],
          [0.2, 1.5],
          Extrapolation.CLAMP,
        ),
      },
    ],
  }));

  return (
    <>
      <Animated.View
        style={[
          styles.flash,
          {
            left: burst.toX - FLASH_SIZE / 2,
            top: burst.toY - FLASH_SIZE / 2,
          },
          flashStyle,
        ]}
      >
        <View style={styles.flashOuter} />
        <View style={styles.flashMiddle} />
        <View style={styles.flashCore} />
      </Animated.View>
      {burst.sparks.map((spark, index) => (
        <Spark key={index} spark={spark} burst={burst} blast={blast} />
      ))}
      {image != null && (
        <Animated.Image
          source={image}
          resizeMode="contain"
          style={[
            styles.rocket,
            {
              left: burst.fromX - ROCKET_SIZE / 2,
              top: burst.fromY - ROCKET_SIZE / 2,
            },
            rocketStyle,
          ]}
        />
      )}
    </>
  );
}

export function MomentReactionFireworks({
  bursts,
  onDone,
}: {
  bursts: MomentReactionBurst[];
  onDone: (id: number) => void;
}) {
  return bursts.map(burst => (
    <Firework key={burst.id} burst={burst} onDone={onDone} />
  ));
}
