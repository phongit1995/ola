import { useEffect, useRef, useState } from 'react';
import { Animated, Image, Pressable, Text, View } from 'react-native';
import { BG_H, BG_W, NESTS } from '@ola/shared/lib';
import { useEggGameStore } from '@ola/shared/stores/eggGameStore';
import { EggSprite } from './EggSprite';
import { Fireworks } from './Fireworks';
import { EggWinPanel } from './EggWinPanel';
import { eggAssets } from './eggAssets';
import type { SmashStarter } from './useEggGame';

const SOUND_MARGIN = 12;
const HINT_MARGIN = 8;
const RELOAD_MARGIN = 10;
const RELOAD_SIZE = 30;
const RELOAD_SPIN_MS = 400;

interface EggSceneProps {
  hint: string;
  play: SmashStarter;
}

export function EggScene({ hint, play }: EggSceneProps) {
  const [size, setSize] = useState({ w: 0, h: 0 });
  const [round, setRound] = useState(0);
  const [brokenCount, setBrokenCount] = useState(0);
  const reloadSpin = useRef(new Animated.Value(0)).current;

  const winReward = useEggGameStore((s) => s.winReward);
  const endSmash = useEggGameStore((s) => s.endSmash);
  const busy = useEggGameStore((s) => s.smashing || s.drawing);
  const muted = useEggGameStore((s) => s.muted);
  const toggleMute = useEggGameStore((s) => s.toggleMute);

  useEffect(() => {
    if (brokenCount < NESTS.length) return;
    const id = setTimeout(() => {
      setBrokenCount(0);
      setRound((r) => r + 1);
    }, 700);
    return () => clearTimeout(id);
  }, [brokenCount]);

  function handleReload() {
    const { smashing, drawing } = useEggGameStore.getState();
    if (smashing || drawing) return;
    reloadSpin.setValue(0);
    Animated.timing(reloadSpin, {
      toValue: 1,
      duration: RELOAD_SPIN_MS,
      easing: (v) => v,
      useNativeDriver: true,
    }).start();
    setBrokenCount(0);
    setRound((r) => r + 1);
    endSmash();
  }

  const scaleX = size.w / BG_W;
  const scaleY = size.h / BG_H;

  return (
    <View
      style={{ flex: 1 }}
      onLayout={(e) =>
        setSize({ w: e.nativeEvent.layout.width, h: e.nativeEvent.layout.height })
      }
    >
      {size.w > 0 && size.h > 0 && (
        <>
          <Image
            source={eggAssets.background}
            style={{ position: 'absolute', left: 0, top: 0, width: size.w, height: size.h }}
            resizeMode="stretch"
          />
          {NESTS.map((nest, index) => (
            <EggSprite
              key={`${round}-${index}`}
              nest={nest}
              scaleX={scaleX}
              scaleY={scaleY}
              onSmash={play}
              onBroken={() => setBrokenCount((c) => c + 1)}
            />
          ))}

          <Fireworks
            active={winReward !== null}
            big={winReward?.isSuperLucky ?? false}
            width={size.w}
            height={size.h}
          />

          <Pressable
            onPress={handleReload}
            disabled={busy}
            style={{
              position: 'absolute',
              right: RELOAD_MARGIN,
              top: RELOAD_MARGIN,
              width: RELOAD_SIZE,
              height: RELOAD_SIZE,
              opacity: busy ? 0.3 : 0.85,
            }}
          >
            <Animated.Image
              source={eggAssets.reload}
              resizeMode="contain"
              style={{
                width: RELOAD_SIZE,
                height: RELOAD_SIZE,
                transform: [
                  {
                    rotate: reloadSpin.interpolate({
                      inputRange: [0, 1],
                      outputRange: ['0deg', '360deg'],
                    }),
                  },
                ],
              }}
            />
          </Pressable>

          <View
            pointerEvents="none"
            style={{
              position: 'absolute',
              left: RELOAD_MARGIN + RELOAD_SIZE + 8,
              right: RELOAD_MARGIN + RELOAD_SIZE + 8,
              top: HINT_MARGIN,
              alignItems: 'center',
            }}
          >
            <Text
              style={{
                fontSize: 12,
                color: '#ffffff',
                opacity: 0.8,
                textAlign: 'center',
                textShadowColor: 'rgba(0,0,0,0.6)',
                textShadowOffset: { width: 0, height: 1 },
                textShadowRadius: 3,
              }}
            >
              {hint}
            </Text>
          </View>

          <Pressable
            onPress={toggleMute}
            style={{ position: 'absolute', right: SOUND_MARGIN, bottom: SOUND_MARGIN }}
          >
            <Text style={{ fontSize: 24 }}>{muted ? '🔇' : '🔊'}</Text>
          </Pressable>

          {winReward && <EggWinPanel result={winReward} width={size.w} height={size.h} />}
        </>
      )}
    </View>
  );
}
