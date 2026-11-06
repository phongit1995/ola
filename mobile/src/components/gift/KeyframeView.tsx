import { useEffect, useState, type ReactNode } from 'react';
import type { StyleProp, ViewStyle } from 'react-native';
import Animated, {
  Easing,
  cancelAnimation,
  makeMutable,
  useAnimatedStyle,
  withDelay,
  withTiming,
} from 'react-native-reanimated';
import {
  TRANSFORM_DEFAULTS,
  TRANSFORM_PROPS,
  keyframeTrack,
  transformValue,
  type EasingCurve,
  type KeyframeAnimation,
  type TransformProp,
} from './giftKeyframes';

type Track = { at: number; value: number }[];

function sample(track: Track, fallback: number, progress: number, easing: EasingCurve): number {
  'worklet';
  if (track.length === 0) return fallback;
  if (progress <= track[0].at) return track[0].value;
  for (let i = 1; i < track.length; i += 1) {
    const end = track[i];
    if (progress <= end.at) {
      const start = track[i - 1];
      const span = end.at - start.at;
      const local = span > 0 ? (progress - start.at) / span : 1;
      return start.value + (end.value - start.value) * easing(local);
    }
  }
  return track[track.length - 1].value;
}

function createPlayer(animation: KeyframeAnimation) {
  const opacityTrack = keyframeTrack(animation.frames, (frame) => frame.opacity);
  const tracks = {} as Record<TransformProp, Track>;
  for (const prop of TRANSFORM_PROPS) {
    tracks[prop] = keyframeTrack(animation.frames, (frame) => transformValue(frame, prop));
  }
  const progress = makeMutable(0);
  const play = () => {
    progress.value = withDelay(
      animation.delay ?? 0,
      withTiming(1, { duration: animation.duration, easing: Easing.linear })
    );
  };
  const stop = () => cancelAnimation(progress);
  return { progress, opacityTrack, tracks, easing: animation.easing, play, stop };
}

interface KeyframeViewProps {
  animation: KeyframeAnimation;
  style?: StyleProp<ViewStyle>;
  children?: ReactNode;
}

export function KeyframeView({ animation, style, children }: KeyframeViewProps) {
  const [player] = useState(() => createPlayer(animation));

  useEffect(() => {
    player.play();
    return player.stop;
  }, [player]);

  const { progress, opacityTrack, tracks, easing } = player;

  const animatedStyle = useAnimatedStyle(() => {
    const p = progress.value;
    const at = (prop: TransformProp) => sample(tracks[prop], TRANSFORM_DEFAULTS[prop], p, easing);
    return {
      opacity: sample(opacityTrack, 1, p, easing),
      transform: [
        { rotate: `${at('orbit')}deg` },
        { translateX: at('translateX') },
        { translateY: at('translateY') },
        { perspective: 800 },
        { rotateY: `${at('rotateY')}deg` },
        { rotate: `${at('rotate')}deg` },
        { scale: at('scale') },
        { scaleX: at('scaleX') },
        { scaleY: at('scaleY') },
        { skewX: `${at('skewX')}deg` },
      ],
    };
  });

  return (
    <Animated.View pointerEvents="none" style={[style, animatedStyle]}>
      {children}
    </Animated.View>
  );
}
