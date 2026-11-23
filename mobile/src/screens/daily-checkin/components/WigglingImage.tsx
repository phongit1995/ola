import { useEffect, useRef } from 'react';
import { Animated, Easing, type ImageSourcePropType } from 'react-native';
import { CHECKIN_WIGGLE_MS, CHECKIN_WIGGLE_REST_MS } from '../constants';

export function WigglingImage({ source, size }: { source: ImageSourcePropType; size: number }) {
  const progress = useRef(new Animated.Value(0)).current;
  useEffect(() => {
    const loop = Animated.loop(
      Animated.sequence([
        Animated.timing(progress, { toValue: 1, duration: CHECKIN_WIGGLE_MS, easing: Easing.linear, useNativeDriver: true }),
        Animated.delay(CHECKIN_WIGGLE_REST_MS),
      ]),
    );
    loop.start();
    return () => loop.stop();
  }, [progress]);
  const rotate = progress.interpolate({
    inputRange: [0, 0.17, 0.33, 0.5, 0.67, 0.83, 1],
    outputRange: ['0deg', '-10deg', '9deg', '-7deg', '5deg', '-2deg', '0deg'],
  });
  return (
    <Animated.Image
      source={source}
      style={{ width: size, height: size, transformOrigin: 'bottom', transform: [{ rotate }] }}
      resizeMode="contain"
    />
  );
}
