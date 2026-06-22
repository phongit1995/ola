import { useCallback, useEffect, useState } from 'react';
import { type Texture } from 'pixi.js';
import { useApplication } from '@pixi/react';
import { useEggGameStore } from '@/store/eggGameStore';
import { EggSprite } from './EggSprite';
import { BG_H, BG_W, NESTS } from './eggGame.constants';
import { EGG_BACKGROUND_KEY, EGG_REST_KEY } from './eggAssets';
import type { SmashOutcome } from './useEggGame';

const SOUND_MARGIN = 12;
const SOUND_STYLE = { fontSize: 24 };
const HINT_MARGIN = 8;

interface EggSceneProps {
  textures: Record<string, Texture>;
  hint: string;
  play: () => Promise<SmashOutcome | null>;
}

export function EggScene({ textures, hint, play }: EggSceneProps) {
  const { app, isInitialised } = useApplication();
  const [size, setSize] = useState({ w: BG_W, h: BG_H });
  const [round, setRound] = useState(0);
  const [brokenCount, setBrokenCount] = useState(0);

  useEffect(() => {
    const renderer = app?.renderer;
    if (!isInitialised || !renderer) return;
    const onResize = () => {
      if (!app.renderer) return;
      setSize({ w: app.screen.width, h: app.screen.height });
    };
    onResize();
    renderer.on('resize', onResize);
    return () => {
      renderer.off('resize', onResize);
    };
  }, [app, isInitialised]);

  useEffect(() => {
    if (brokenCount < NESTS.length) return;
    const id = setTimeout(() => {
      setBrokenCount(0);
      setRound((r) => r + 1);
    }, 700);
    return () => clearTimeout(id);
  }, [brokenCount]);

  const onBroken = useCallback(() => setBrokenCount((c) => c + 1), []);

  const muted = useEggGameStore((s) => s.muted);
  const toggleMute = useEggGameStore((s) => s.toggleMute);

  const background = textures[EGG_BACKGROUND_KEY];
  const restTexture = textures[EGG_REST_KEY];
  if (!background || !restTexture) return null;

  return (
    <pixiContainer>
      <pixiContainer scale={{ x: size.w / BG_W, y: size.h / BG_H }}>
        <pixiSprite texture={background} width={BG_W} height={BG_H} />
        {NESTS.map((nest, index) => (
          <EggSprite
            key={`${round}-${index}`}
            nest={nest}
            restTexture={restTexture}
            frameTextures={textures}
            onSmash={play}
            onBroken={onBroken}
          />
        ))}
      </pixiContainer>
      <pixiText
        text={hint}
        anchor={{ x: 0.5, y: 0 }}
        x={size.w / 2}
        y={HINT_MARGIN}
        alpha={0.8}
        eventMode="none"
        style={{
          fontSize: 12,
          fill: '#ffffff',
          align: 'center',
          wordWrap: true,
          wordWrapWidth: size.w - 40,
          dropShadow: { color: '#000000', blur: 3, distance: 1, alpha: 0.6, angle: 1.57 },
        }}
      />
      <pixiText
        text={muted ? '🔇' : '🔊'}
        anchor={{ x: 1, y: 1 }}
        x={size.w - SOUND_MARGIN}
        y={size.h - SOUND_MARGIN}
        style={SOUND_STYLE}
        eventMode="static"
        cursor="pointer"
        onPointerTap={toggleMute}
      />
    </pixiContainer>
  );
}
