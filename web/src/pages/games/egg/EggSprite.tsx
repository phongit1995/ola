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
  TICK_MS,
  type Nest,
} from './eggGame.constants';
import type { SmashOutcome } from './useEggGame';

type Phase = 'idle' | 'smashing' | 'broken';

interface AnimState {
  frames: string[];
  revealAt: number;
  idx: number;
  acc: number;
  finalized: boolean;
  finalize: () => void;
}

interface EggSpriteProps {
  nest: Nest;
  restTexture: Texture;
  frameTextures: Record<string, Texture>;
  onSmash: () => Promise<SmashOutcome | null>;
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
        if (anim.idx === anim.revealAt && !anim.finalized) {
          anim.finalized = true;
          anim.finalize();
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

  async function handleTap() {
    if (phase !== 'idle' || animRef.current || pendingRef.current) return;
    pendingRef.current = true;
    const outcome = await onSmash();
    pendingRef.current = false;
    if (!outcome || animRef.current) return;
    setPhase('smashing');
    setFrameKey(outcome.frames[0] ?? null);
    animRef.current = {
      frames: outcome.frames,
      revealAt: outcome.revealAt,
      idx: 0,
      acc: 0,
      finalized: false,
      finalize: outcome.finalize,
    };
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
        onPointerTap={() => void handleTap()}
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
