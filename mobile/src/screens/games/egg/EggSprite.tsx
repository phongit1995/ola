import { memo, useEffect, useRef, useState } from 'react';
import { Animated, Easing, Image, Pressable } from 'react-native';
import {
  ANIM_ANCHOR_X,
  ANIM_ANCHOR_Y,
  ANIM_OFFSET_Y,
  ANIM_SCALE,
  REST_ANCHOR_Y,
  REST_OFFSET_Y,
  REST_SCALE,
  SMASH_LOOP_FRAMES,
  SMASH_TAIL_HIT,
  SMASH_TAIL_MISS,
  TICK_MS,
} from '@ola/shared/lib';
import type { Nest } from '@ola/shared/types';
import { EGG_FRAMES, frameSize } from './eggAssets';
import type { SmashOutcome, SmashStarter } from './useEggGame';

const ANIM_FRAME_KEYS = Object.keys(EGG_FRAMES).filter((key) => key !== 'Egg');

type Phase = 'idle' | 'smashing' | 'broken';

interface AnimState {
  stage: 'loop' | 'tail';
  frames: string[];
  idx: number;
  revealAt: number;
  outcome: SmashOutcome | null;
  finalized: boolean;
}

interface EggSpriteProps {
  nest: Nest;
  scaleX: number;
  scaleY: number;
  onSmash: SmashStarter;
  onBroken: () => void;
}

function EggSpriteComponent({ nest, scaleX, scaleY, onSmash, onBroken }: EggSpriteProps) {
  const animRef = useRef<AnimState | null>(null);
  const tickerRef = useRef<ReturnType<typeof setInterval> | null>(null);
  const pendingRef = useRef(false);
  const bob = useRef(new Animated.Value(0)).current;
  const baseY = nest.y + REST_OFFSET_Y;

  const [phase, setPhase] = useState<Phase>('idle');
  const [frameKey, setFrameKey] = useState<string | null>(null);

  const onBrokenRef = useRef(onBroken);
  onBrokenRef.current = onBroken;

  useEffect(() => {
    const loop = Animated.loop(
      Animated.sequence([
        Animated.timing(bob, {
          toValue: 1,
          duration: 1300,
          easing: Easing.inOut(Easing.sin),
          useNativeDriver: true,
        }),
        Animated.timing(bob, {
          toValue: 0,
          duration: 1300,
          easing: Easing.inOut(Easing.sin),
          useNativeDriver: true,
        }),
      ])
    );
    loop.start();
    return () => loop.stop();
  }, [bob]);

  useEffect(
    () => () => {
      if (tickerRef.current != null) clearInterval(tickerRef.current);
    },
    []
  );

  function stopTicker() {
    if (tickerRef.current != null) {
      clearInterval(tickerRef.current);
      tickerRef.current = null;
    }
  }

  function tick() {
    const anim = animRef.current;
    if (!anim) {
      stopTicker();
      return;
    }
    anim.idx += 1;

    if (anim.stage === 'loop') {
      if (anim.idx < anim.frames.length) {
        setFrameKey(anim.frames[anim.idx] ?? null);
      } else if (anim.outcome) {
        const tail = anim.outcome.hit ? SMASH_TAIL_HIT : SMASH_TAIL_MISS;
        anim.stage = 'tail';
        anim.frames = tail.frames;
        anim.revealAt = tail.revealAt;
        anim.idx = 0;
        setFrameKey(tail.frames[0] ?? null);
      } else {
        anim.idx = 0;
        setFrameKey(anim.frames[0] ?? null);
      }
      return;
    }

    if (anim.idx === anim.revealAt && !anim.finalized) {
      anim.finalized = true;
      anim.outcome?.finalize();
    }
    if (anim.idx >= anim.frames.length) {
      const last = anim.frames[anim.frames.length - 1] ?? null;
      animRef.current = null;
      stopTicker();
      setFrameKey(last);
      setPhase('broken');
      onBrokenRef.current();
      return;
    }
    setFrameKey(anim.frames[anim.idx] ?? null);
  }

  function handleTap() {
    if (phase !== 'idle' || animRef.current || pendingRef.current) return;
    const pending = onSmash();
    if (!pending) return;
    pendingRef.current = true;
    setPhase('smashing');
    setFrameKey(SMASH_LOOP_FRAMES[0] ?? null);
    animRef.current = {
      stage: 'loop',
      frames: SMASH_LOOP_FRAMES,
      idx: 0,
      revealAt: -1,
      outcome: null,
      finalized: false,
    };
    stopTicker();
    tickerRef.current = setInterval(tick, TICK_MS);
    void pending.then((outcome) => {
      pendingRef.current = false;
      const anim = animRef.current;
      if (!anim || anim.stage !== 'loop') return;
      if (!outcome) {
        animRef.current = null;
        stopTicker();
        setPhase('idle');
        setFrameKey(null);
        return;
      }
      anim.outcome = outcome;
    });
  }

  const rest = frameSize('Egg');
  const restW = rest.width * REST_SCALE;
  const restH = rest.height * REST_SCALE;
  const restLeft = (nest.x - restW / 2) * scaleX;
  const restTop = (baseY - restH * REST_ANCHOR_Y) * scaleY;

  const visibleFrame = phase === 'idle' ? null : frameKey;

  return (
    <>
      {ANIM_FRAME_KEYS.map((key) => {
        const frame = frameSize(key);
        const frameW = frame.width * ANIM_SCALE;
        const frameH = frame.height * ANIM_SCALE;
        return (
          <Image
            key={key}
            source={EGG_FRAMES[key]}
            fadeDuration={0}
            resizeMode="stretch"
            style={{
              position: 'absolute',
              left: (nest.x - frameW * ANIM_ANCHOR_X) * scaleX,
              top: (baseY + ANIM_OFFSET_Y - frameH * ANIM_ANCHOR_Y) * scaleY,
              width: frameW * scaleX,
              height: frameH * scaleY,
              opacity: visibleFrame === key ? 1 : 0,
            }}
          />
        );
      })}
      {phase === 'idle' && (
        <Pressable
          onPress={handleTap}
          style={{
            position: 'absolute',
            left: restLeft,
            top: restTop,
            width: restW * scaleX,
            height: restH * scaleY,
          }}
        >
          <Animated.Image
            source={EGG_FRAMES.Egg}
            fadeDuration={0}
            resizeMode="stretch"
            style={{
              width: restW * scaleX,
              height: restH * scaleY,
              transform: [
                {
                  translateY: bob.interpolate({
                    inputRange: [0, 1],
                    outputRange: [-1.5 * scaleY, 1.5 * scaleY],
                  }),
                },
              ],
            }}
          />
        </Pressable>
      )}
    </>
  );
}

export const EggSprite = memo(EggSpriteComponent);
