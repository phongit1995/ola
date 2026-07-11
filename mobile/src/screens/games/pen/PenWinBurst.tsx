import { useEffect, useRef } from 'react';
import { Animated, Easing, Image, Text, View } from 'react-native';
import { formatKen } from '@ola/shared/lib';
import { penAssets } from './penAssets';
import { PEN_COLORS } from './penUi';

interface BurstBall {
  dx: number;
  dy: number;
  peak: number;
  rot: number;
  delay: number;
}

const BURST: BurstBall[] = [
  { dx: -150, dy: 70, peak: -150, rot: -540, delay: 0 },
  { dx: 150, dy: 70, peak: -150, rot: 540, delay: 0 },
  { dx: -95, dy: 95, peak: -195, rot: -430, delay: 50 },
  { dx: 95, dy: 95, peak: -195, rot: 430, delay: 50 },
  { dx: -45, dy: 108, peak: -220, rot: -360, delay: 90 },
  { dx: 45, dy: 108, peak: -220, rot: 360, delay: 90 },
  { dx: 0, dy: 80, peak: -245, rot: 300, delay: 70 },
  { dx: -120, dy: 40, peak: -120, rot: -620, delay: 110 },
  { dx: 120, dy: 40, peak: -120, rot: 620, delay: 110 },
];

function BurstBallSprite({ ball }: { ball: BurstBall }) {
  const progress = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(progress, {
      toValue: 1,
      duration: 1200,
      delay: ball.delay,
      easing: Easing.bezier(0.22, 0.61, 0.36, 1),
      useNativeDriver: true,
    }).start();
  }, [progress, ball.delay]);

  return (
    <Animated.Image
      source={penAssets.ball}
      resizeMode="contain"
      style={{
        position: 'absolute',
        left: -18,
        top: -18,
        width: 36,
        height: 36,
        opacity: progress.interpolate({ inputRange: [0, 0.12, 0.42, 1], outputRange: [0, 1, 1, 0] }),
        transform: [
          {
            translateX: progress.interpolate({
              inputRange: [0, 0.42, 1],
              outputRange: [0, ball.dx * 0.5, ball.dx],
            }),
          },
          {
            translateY: progress.interpolate({
              inputRange: [0, 0.42, 1],
              outputRange: [0, ball.peak, ball.dy],
            }),
          },
          {
            rotate: progress.interpolate({
              inputRange: [0, 0.42, 1],
              outputRange: ['0deg', `${ball.rot * 0.45}deg`, `${ball.rot}deg`],
            }),
          },
          {
            scale: progress.interpolate({
              inputRange: [0, 0.42, 1],
              outputRange: [0.4, 1, 0.85],
            }),
          },
        ],
      }}
    />
  );
}

export function PenWinBurst({ amount }: { amount: number }) {
  const float = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(float, {
      toValue: 1,
      duration: 1450,
      easing: Easing.out(Easing.ease),
      useNativeDriver: true,
    }).start();
  }, [float]);

  return (
    <View
      pointerEvents="none"
      style={{
        position: 'absolute',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        zIndex: 30,
        overflow: 'hidden',
      }}
    >
      <View style={{ position: 'absolute', left: '50%', top: '52%' }}>
        {BURST.map((ball, i) => (
          <BurstBallSprite key={i} ball={ball} />
        ))}
      </View>

      <View
        style={{ position: 'absolute', left: 0, right: 0, top: '40%', alignItems: 'center' }}
      >
        <Animated.View
          style={{
            flexDirection: 'row',
            alignItems: 'center',
            gap: 6,
            opacity: float.interpolate({
              inputRange: [0, 0.18, 0.4, 1],
              outputRange: [0, 1, 1, 0],
            }),
            transform: [
              {
                translateY: float.interpolate({
                  inputRange: [0, 0.18, 0.4, 1],
                  outputRange: [0, -14, -32, -140],
                }),
              },
              {
                scale: float.interpolate({
                  inputRange: [0, 0.18, 0.4, 1],
                  outputRange: [0.6, 1.18, 1, 1],
                }),
              },
            ],
          }}
        >
          <Text
            style={{
              fontSize: 36,
              fontWeight: '800',
              fontStyle: 'italic',
              color: PEN_COLORS.green,
              textShadowColor: 'rgba(0,0,0,0.7)',
              textShadowOffset: { width: 0, height: 3 },
              textShadowRadius: 8,
            }}
          >
            +{formatKen(amount)}
          </Text>
          <Image source={penAssets.kenIcon} style={{ width: 32, height: 32 }} resizeMode="contain" />
        </Animated.View>
      </View>
    </View>
  );
}
