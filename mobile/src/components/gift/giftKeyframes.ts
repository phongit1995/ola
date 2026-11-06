import { Easing } from 'react-native-reanimated';

export type EasingCurve = (t: number) => number;

export type TransformProp =
  | 'orbit'
  | 'translateX'
  | 'translateY'
  | 'rotateY'
  | 'rotate'
  | 'scale'
  | 'scaleX'
  | 'scaleY'
  | 'skewX';

export type KeyframeTransform = Partial<Record<TransformProp, number>>;

export interface Keyframe {
  at: number;
  opacity?: number;
  transform?: KeyframeTransform;
}

export interface KeyframeAnimation {
  frames: Keyframe[];
  duration: number;
  easing: EasingCurve;
  delay?: number;
}

export const TRANSFORM_DEFAULTS: Record<TransformProp, number> = {
  orbit: 0,
  translateX: 0,
  translateY: 0,
  rotateY: 0,
  rotate: 0,
  scale: 1,
  scaleX: 1,
  scaleY: 1,
  skewX: 0,
};

export const TRANSFORM_PROPS = Object.keys(TRANSFORM_DEFAULTS) as TransformProp[];

export const EASE = {
  linear: Easing.linear,
  in: Easing.bezierFn(0.42, 0, 1, 1),
  out: Easing.bezierFn(0, 0, 0.58, 1),
  inOut: Easing.bezierFn(0.42, 0, 0.58, 1),
  snappy: Easing.bezierFn(0.22, 1, 0.36, 1),
  bouncy: Easing.bezierFn(0.34, 1.2, 0.64, 1),
} satisfies Record<string, EasingCurve>;

export function keyframeTrack(
  frames: Keyframe[],
  pick: (frame: Keyframe) => number | undefined
): { at: number; value: number }[] {
  const track: { at: number; value: number }[] = [];
  for (const frame of frames) {
    const value = pick(frame);
    if (value !== undefined) track.push({ at: frame.at, value });
  }
  return track;
}

export function transformValue(frame: Keyframe, prop: TransformProp): number | undefined {
  if (frame.transform === undefined) return undefined;
  return frame.transform[prop] ?? TRANSFORM_DEFAULTS[prop];
}
