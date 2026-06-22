import { useEffect, useState } from 'react';
import { type Texture } from 'pixi.js';
import { useApplication } from '@pixi/react';
import { EggSprite } from './EggSprite';
import { BG_H, BG_W, NESTS } from './eggGame.constants';
import { EGG_BACKGROUND_KEY, EGG_REST_KEY } from './eggAssets';
import type { SmashOutcome } from './useEggGame';

interface EggSceneProps {
  textures: Record<string, Texture>;
  play: () => SmashOutcome | null;
}

export function EggScene({ textures, play }: EggSceneProps) {
  const { app } = useApplication();
  const [size, setSize] = useState({ w: app.screen.width, h: app.screen.height });

  useEffect(() => {
    const onResize = () => setSize({ w: app.screen.width, h: app.screen.height });
    onResize();
    app.renderer.on('resize', onResize);
    return () => {
      app.renderer.off('resize', onResize);
    };
  }, [app]);

  const background = textures[EGG_BACKGROUND_KEY];
  const restTexture = textures[EGG_REST_KEY];
  if (!background || !restTexture) return null;

  return (
    <pixiContainer scale={{ x: size.w / BG_W, y: size.h / BG_H }}>
      <pixiSprite texture={background} width={BG_W} height={BG_H} />
      {NESTS.map((nest, index) => (
        <EggSprite
          key={index}
          nest={nest}
          restTexture={restTexture}
          frameTextures={textures}
          onSmash={play}
        />
      ))}
    </pixiContainer>
  );
}
