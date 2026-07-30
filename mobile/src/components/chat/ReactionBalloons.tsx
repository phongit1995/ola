import { useEffect, useState } from 'react';
import { Animated, Dimensions, Easing, Image, View } from 'react-native';
import type { ReactionType } from '@ola/shared/types';
import { REACTION_IMAGE } from '@lib/reactions';

interface Balloon {
  id: number;
  image: NonNullable<(typeof REACTION_IMAGE)[ReactionType]>;
  right: number;
  size: number;
  rise: number;
  sway: number;
  drift: number;
  delay: number;
  duration: number;
  progress: Animated.Value;
}

interface ReactionBalloonsProps {
  subscribe: (onReaction: (type: string) => void) => () => void;
}

const MAX_BALLOONS = 12;

let nextBalloonId = 0;

function spawnBalloons(image: Balloon['image']): Balloon[] {
  const windowHeight = Dimensions.get('window').height;
  const count = 2 + Math.round(Math.random());
  return Array.from({ length: count }, (_, index) => {
    nextBalloonId += 1;
    return {
      id: nextBalloonId,
      image,
      right: 16 + Math.random() * 72,
      size: 24 + Math.random() * 12,
      rise: windowHeight * (0.38 + Math.random() * 0.22),
      sway: (Math.random() * 2 - 1) * 40,
      drift: (Math.random() * 2 - 1) * 56,
      delay: index * 150 + Math.random() * 120,
      duration: 2000 + Math.random() * 700,
      progress: new Animated.Value(0),
    };
  });
}

export function ReactionBalloons({ subscribe }: ReactionBalloonsProps) {
  const [balloons, setBalloons] = useState<Balloon[]>([]);

  useEffect(
    () =>
      subscribe(type => {
        const image = REACTION_IMAGE[type as ReactionType];
        if (image == null) return;
        const spawned = spawnBalloons(image);
        setBalloons(current => [...current, ...spawned].slice(-MAX_BALLOONS));
        spawned.forEach(balloon => {
          Animated.timing(balloon.progress, {
            toValue: 1,
            duration: balloon.duration,
            delay: balloon.delay,
            easing: Easing.out(Easing.quad),
            useNativeDriver: true,
          }).start(() => {
            setBalloons(current =>
              current.filter(item => item.id !== balloon.id),
            );
          });
        });
      }),
    [subscribe],
  );

  if (balloons.length === 0) return null;

  return (
    <View
      pointerEvents="none"
      className="absolute inset-0 z-10 overflow-hidden"
    >
      {balloons.map(balloon => (
        <Animated.View
          key={balloon.id}
          style={{
            position: 'absolute',
            right: balloon.right,
            bottom: 84,
            opacity: balloon.progress.interpolate({
              inputRange: [0, 0.08, 0.7, 1],
              outputRange: [0, 1, 0.9, 0],
            }),
            transform: [
              {
                translateY: balloon.progress.interpolate({
                  inputRange: [0, 1],
                  outputRange: [0, -balloon.rise],
                }),
              },
              {
                translateX: balloon.progress.interpolate({
                  inputRange: [0, 0.3, 0.6, 1],
                  outputRange: [
                    0,
                    balloon.sway,
                    -balloon.sway * 0.5,
                    balloon.drift,
                  ],
                }),
              },
              {
                scale: balloon.progress.interpolate({
                  inputRange: [0, 0.15, 1],
                  outputRange: [0.5, 1, 1.12],
                }),
              },
            ],
          }}
        >
          <Image
            source={balloon.image}
            style={{ width: balloon.size, height: balloon.size }}
            resizeMode="contain"
          />
        </Animated.View>
      ))}
    </View>
  );
}
