import { useEffect } from 'react';
import { StyleSheet, View } from 'react-native';
import Animated, {
  cancelAnimation,
  interpolate,
  interpolateColor,
  useAnimatedStyle,
  useSharedValue,
  withRepeat,
  withSequence,
  withTiming,
} from 'react-native-reanimated';
import Svg, { Path } from 'react-native-svg';
import { ERROR } from '@constants';

export const TRASH_TARGET_SIZE = 56;
export const TRASH_TARGET_BOTTOM_GAP = 72;
export const TRASH_TARGET_TOLERANCE = 18;

const ICON_SIZE = 32;
const HALO_SIZE = 72;
const IDLE_BACKGROUND = '#eceff1';
const IDLE_STROKE = '#525252';
const ACTIVE_STROKE = '#ffffff';
const HUNGER_SCALE = 0.06;
const HIT_SCALE = 0.1;

interface ArcadeTrashTargetProps {
  visible: boolean;
  active: boolean;
  bottom: number;
}

export function ArcadeTrashTarget({
  visible,
  active,
  bottom,
}: ArcadeTrashTargetProps) {
  const appear = useSharedValue(0);
  const hit = useSharedValue(0);
  const lidAngle = useSharedValue(0);
  const hunger = useSharedValue(0);

  useEffect(() => {
    appear.value = withTiming(visible ? 1 : 0, { duration: 200 });
  }, [appear, visible]);

  useEffect(() => {
    hit.value = withTiming(active ? 1 : 0, { duration: 150 });
  }, [active, hit]);

  useEffect(() => {
    cancelAnimation(lidAngle);
    cancelAnimation(hunger);
    if (active) {
      lidAngle.value = withTiming(-42, { duration: 180 });
      hunger.value = withTiming(0, { duration: 150 });
      return;
    }
    if (!visible) {
      lidAngle.value = withTiming(0, { duration: 150 });
      hunger.value = 0;
      return;
    }
    lidAngle.value = withRepeat(
      withSequence(
        withTiming(-34, { duration: 170 }),
        withTiming(-3, { duration: 190 }),
        withTiming(-24, { duration: 170 }),
        withTiming(-3, { duration: 170 }),
        withTiming(0, { duration: 150 }),
      ),
      -1,
    );
    hunger.value = withRepeat(
      withSequence(
        withTiming(1, { duration: 170 }),
        withTiming(0.5, { duration: 190 }),
        withTiming(0.8, { duration: 170 }),
        withTiming(0, { duration: 320 }),
      ),
      -1,
    );
    return () => {
      cancelAnimation(lidAngle);
      cancelAnimation(hunger);
    };
  }, [active, hunger, lidAngle, visible]);

  const containerStyle = useAnimatedStyle(() => ({
    opacity: appear.value,
    transform: [
      { translateY: interpolate(appear.value, [0, 1], [24, 0]) },
      { scale: interpolate(appear.value, [0, 1], [0.75, 1]) },
    ],
  }));

  const circleStyle = useAnimatedStyle(() => ({
    backgroundColor: interpolateColor(
      hit.value,
      [0, 1],
      [IDLE_BACKGROUND, ERROR],
    ),
    transform: [
      { scale: 1 + hunger.value * HUNGER_SCALE + hit.value * HIT_SCALE },
    ],
  }));

  const haloStyle = useAnimatedStyle(() => ({ opacity: hit.value }));

  const lidStyle = useAnimatedStyle(() => ({
    transform: [
      {
        translateY: interpolate(
          lidAngle.value,
          [-42, -34, -24, 0],
          [-1.5, -1, -1, 0],
        ),
      },
      { rotate: `${lidAngle.value}deg` },
    ],
  }));

  const stroke = active ? ACTIVE_STROKE : IDLE_STROKE;

  return (
    <Animated.View
      pointerEvents="none"
      accessibilityElementsHidden
      importantForAccessibility="no-hide-descendants"
      style={[styles.container, { bottom }, containerStyle]}
    >
      <Animated.View style={[styles.halo, haloStyle]} />
      <Animated.View style={[styles.circle, circleStyle]}>
        <View style={styles.icon}>
          <Svg
            width={ICON_SIZE}
            height={ICON_SIZE}
            viewBox="0 0 32 32"
            fill="none"
            stroke={stroke}
            strokeWidth={2.25}
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <Path
              d="m10 12 1.05 12.55A2.7 2.7 0 0 0 13.74 27h4.52a2.7 2.7 0 0 0 2.69-2.45L22 12Z"
              fill={stroke}
              fillOpacity={0.18}
              stroke="none"
            />
            <Path d="m10 12 1.05 12.55A2.7 2.7 0 0 0 13.74 27h4.52a2.7 2.7 0 0 0 2.69-2.45L22 12" />
            <Path d="M14 16v6.5M18 16v6.5" />
          </Svg>
        </View>
        <Animated.View style={[styles.icon, styles.lid, lidStyle]}>
          <Svg
            width={ICON_SIZE}
            height={ICON_SIZE}
            viewBox="0 0 32 32"
            fill="none"
            stroke={stroke}
            strokeWidth={2.25}
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <Path d="M8 10h16" />
            <Path d="M12.5 10V7.75A1.75 1.75 0 0 1 14.25 6h3.5a1.75 1.75 0 0 1 1.75 1.75V10" />
          </Svg>
        </Animated.View>
      </Animated.View>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    left: 0,
    right: 0,
    zIndex: 101,
    elevation: 101,
    alignItems: 'center',
    justifyContent: 'center',
  },
  halo: {
    position: 'absolute',
    width: HALO_SIZE,
    height: HALO_SIZE,
    borderRadius: HALO_SIZE / 2,
    backgroundColor: 'rgba(227,69,69,0.18)',
  },
  circle: {
    width: TRASH_TARGET_SIZE,
    height: TRASH_TARGET_SIZE,
    borderRadius: TRASH_TARGET_SIZE / 2,
    borderWidth: 2,
    borderColor: '#ffffff',
    alignItems: 'center',
    justifyContent: 'center',
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.2,
    shadowRadius: 11,
  },
  icon: {
    width: ICON_SIZE,
    height: ICON_SIZE,
  },
  lid: {
    position: 'absolute',
    transformOrigin: [9, 10.5, 0],
  },
});
