import { useRef, useState } from 'react';
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
  onSmash: () => SmashOutcome | null;
}

export function EggSprite({ nest, restTexture, frameTextures, onSmash }: EggSpriteProps) {
  const restRef = useRef<Sprite>(null);
  const animRef = useRef<AnimState | null>(null);
  const phaseRef = useRef<number>(nest.x % 6);
  const baseY = nest.y + REST_OFFSET_Y;

  const [smashing, setSmashing] = useState(false);
  const [frameKey, setFrameKey] = useState<string | null>(null);

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
          animRef.current = null;
          setSmashing(false);
          setFrameKey(null);
          return;
        }
        setFrameKey(anim.frames[anim.idx] ?? null);
      }
      return;
    }
    phaseRef.current += 0.04 * ticker.deltaTime;
    const rest = restRef.current;
    if (rest) rest.y = baseY + Math.sin(phaseRef.current) * 1.5;
  });

  function handleTap() {
    if (animRef.current) return;
    const outcome = onSmash();
    if (!outcome) return;
    setSmashing(true);
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
        visible={!smashing}
        anchor={{ x: 0.5, y: REST_ANCHOR_Y }}
        scale={REST_SCALE}
        x={nest.x}
        y={baseY}
        eventMode="static"
        cursor="pointer"
        onPointerTap={handleTap}
      />
      {smashing && animTexture && (
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
