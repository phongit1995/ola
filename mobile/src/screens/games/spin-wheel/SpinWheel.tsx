import { useEffect, useRef } from 'react';
import { Animated, Easing, Image, View } from 'react-native';
import { SPIN_DURATION_MS, segmentAngle } from '@ola/shared/lib';
import type { WheelPlayerSegment } from '@ola/shared/types';
import { assetRatio } from '@screens/games/pen/penUi';
import { wheelAssets } from './spinWheelAssets';
import { WheelFace } from './WheelFace';
import { WheelLabels } from './WheelLabels';

const POINTER_MAX_TICK_DEG = 15;

function pointerTickDeg(wheelAngle: number, angle: number): number {
  if (angle <= 0) return 0;
  const phase = (((wheelAngle - angle / 2) % angle) + angle) % angle;
  const t = phase / angle;
  return -POINTER_MAX_TICK_DEG * t * t;
}

interface SpinWheelProps {
  segments: WheelPlayerSegment[];
  rotation: number;
  spinning: boolean;
  onSettle: () => void;
  size: number;
}

export function SpinWheel({ segments, rotation, spinning, onSettle, size }: SpinWheelProps) {
  const angle = segmentAngle(segments.length);
  const rotationAnim = useRef(new Animated.Value(rotation)).current;
  const pointerAnim = useRef(new Animated.Value(0)).current;
  const onSettleRef = useRef(onSettle);
  onSettleRef.current = onSettle;

  useEffect(() => {
    if (!spinning) {
      rotationAnim.setValue(rotation);
      pointerAnim.setValue(0);
      return;
    }
    const listenerId = rotationAnim.addListener(({ value }) => {
      pointerAnim.setValue(pointerTickDeg(value, angle));
    });
    const animation = Animated.timing(rotationAnim, {
      toValue: rotation,
      duration: SPIN_DURATION_MS,
      easing: Easing.bezier(0.16, 0.72, 0.12, 1),
      useNativeDriver: false,
    });
    animation.start(({ finished }) => {
      rotationAnim.removeListener(listenerId);
      pointerAnim.setValue(0);
      if (finished) onSettleRef.current();
    });
    return () => {
      animation.stop();
      rotationAnim.removeListener(listenerId);
    };
  }, [rotation, spinning, angle, rotationAnim, pointerAnim]);

  const pointerWidth = size * 0.13;
  const pointerHeight = pointerWidth / assetRatio(wheelAssets.pointer);
  const pointerPivotShift = pointerHeight * (0.5 - 0.36);
  const centerSize = size * 0.26;
  const logoWidth = centerSize * 0.68;

  return (
    <View style={{ width: size, height: size }}>
      <Animated.View
        style={{
          position: 'absolute',
          left: 0,
          top: 0,
          width: size,
          height: size,
          transform: [
            {
              rotate: rotationAnim.interpolate({
                inputRange: [0, 360],
                outputRange: ['0deg', '360deg'],
              }),
            },
          ],
        }}
      >
        <WheelFace segments={segments} angle={angle} size={size} />
        <WheelLabels segments={segments} angle={angle} size={size} />
        <Image
          source={wheelAssets.wheelOuterRing}
          style={{ position: 'absolute', left: 0, top: 0, width: size, height: size }}
          resizeMode="stretch"
        />
      </Animated.View>
      <View
        style={{
          position: 'absolute',
          left: (size - centerSize) / 2,
          top: (size - centerSize) / 2,
          width: centerSize,
          height: centerSize,
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 10,
        }}
      >
        <Image
          source={wheelAssets.wheelCenter}
          style={{ position: 'absolute', left: 0, top: 0, width: centerSize, height: centerSize }}
          resizeMode="contain"
        />
        <Image
          source={wheelAssets.wheelLogo}
          style={{
            width: logoWidth,
            height: logoWidth / assetRatio(wheelAssets.wheelLogo),
          }}
          resizeMode="contain"
        />
      </View>
      <Animated.Image
        source={wheelAssets.pointer}
        style={{
          position: 'absolute',
          left: (size - pointerWidth) / 2,
          top: -size * 0.05,
          width: pointerWidth,
          height: pointerHeight,
          zIndex: 20,
          transform: [
            { translateY: -pointerPivotShift },
            {
              rotate: pointerAnim.interpolate({
                inputRange: [0, 360],
                outputRange: ['0deg', '360deg'],
              }),
            },
            { translateY: pointerPivotShift },
          ],
        }}
        resizeMode="contain"
      />
    </View>
  );
}
