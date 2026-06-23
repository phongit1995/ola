import { useEffect, useRef, useState } from 'react';
import { Sprite, type Texture } from 'pixi.js';
import { useTick } from '@pixi/react';
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
  type Nest,
} from './eggGame.constants';
import type { SmashOutcome, SmashStarter } from './useEggGame';

type Phase = 'idle' | 'smashing' | 'broken';

interface AnimState {
  stage: 'loop' | 'tail';
  frames: string[];
  idx: number;
  acc: number;
  revealAt: number;
  outcome: SmashOutcome | null;
  finalized: boolean;
}

interface EggSpriteProps {
  nest: Nest;
  restTexture: Texture;
  frameTextures: Record<string, Texture>;
  onSmash: SmashStarter;
  onBroken: () => void;
}

export function EggSprite({ nest, restTexture, frameTextures, onSmash, onBroken }: EggSpriteProps) {
  const restRef = useRef<Sprite>(null);
  const animRef = useRef<AnimState | null>(null);
  const pendingRef = useRef(false);
  const bobRef = useRef<number>(nest.x % 6);
  const baseY = nest.y + REST_OFFSET_Y;

  const [phase, setPhase] = useState<Phase>('idle');
  const [frameKey, setFrameKey] = useState<string | null>(null);

  const onBrokenRef = useRef(onBroken);
  useEffect(() => {
    onBrokenRef.current = onBroken;
  });

  useTick((ticker) => {
    const anim = animRef.current;
    if (anim) {
      anim.acc += ticker.deltaMS;
      while (anim.acc >= TICK_MS) {
        anim.acc -= TICK_MS;
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
          continue;
        }

        if (anim.idx === anim.revealAt && !anim.finalized) {
          anim.finalized = true;
          anim.outcome?.finalize();
        }
        if (anim.idx >= anim.frames.length) {
          const last = anim.frames[anim.frames.length - 1] ?? null;
          animRef.current = null;
          setFrameKey(last);
          setPhase('broken');
          onBrokenRef.current();
          return;
        }
        setFrameKey(anim.frames[anim.idx] ?? null);
      }
      return;
    }
    if (phase !== 'idle') return;
    bobRef.current += 0.04 * ticker.deltaTime;
    const rest = restRef.current;
    if (rest) rest.y = baseY + Math.sin(bobRef.current) * 1.5;
  });

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
      acc: 0,
      revealAt: -1,
      outcome: null,
      finalized: false,
    };
    void pending.then((outcome) => {
      pendingRef.current = false;
      const anim = animRef.current;
      if (!anim || anim.stage !== 'loop') return;
      if (!outcome) {
        animRef.current = null;
        setPhase('idle');
        setFrameKey(null);
        return;
      }
      anim.outcome = outcome;
    });
  }

  const animTexture = frameKey ? frameTextures[frameKey] : null;

  return (
    <pixiContainer>
      <pixiSprite
        ref={restRef}
        texture={restTexture}
        visible={phase === 'idle'}
        anchor={{ x: 0.5, y: REST_ANCHOR_Y }}
        scale={REST_SCALE}
        x={nest.x}
        y={baseY}
        eventMode="static"
        cursor="pointer"
        onPointerTap={handleTap}
      />
      {phase !== 'idle' && animTexture && (
        <pixiSprite
          texture={animTexture}
          anchor={{ x: ANIM_ANCHOR_X, y: ANIM_ANCHOR_Y }}
          scale={ANIM_SCALE}
          x={nest.x}
          y={baseY + ANIM_OFFSET_Y}
        />
      )}
    </pixiContainer>
  );
}
