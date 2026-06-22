import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Assets, Container, Sprite, Text, Texture } from 'pixi.js';
import { Application, extend } from '@pixi/react';
import { EggScene } from './EggScene';
import { EGG_TEXTURE_URLS } from './eggAssets';
import type { SmashOutcome } from './useEggGame';

extend({ Container, Sprite, Text });

interface EggStageProps {
  hint: string;
  play: () => Promise<SmashOutcome | null>;
}

export function EggStage({ hint, play }: EggStageProps) {
  const { t } = useTranslation();
  const containerRef = useRef<HTMLDivElement>(null);
  const [textures, setTextures] = useState<Record<string, Texture> | null>(null);

  useEffect(() => {
    let alive = true;
    const entries = Object.entries(EGG_TEXTURE_URLS);
    void Assets.load(entries.map(([, url]) => url)).then(() => {
      if (!alive) return;
      const map: Record<string, Texture> = {};
      for (const [key, url] of entries) map[key] = Texture.from(url);
      setTextures(map);
    });
    return () => {
      alive = false;
    };
  }, []);

  return (
    <div ref={containerRef} className="relative h-full w-full">
      {textures ? (
        <Application
          resizeTo={containerRef}
          backgroundAlpha={0}
          antialias
          autoDensity
          resolution={window.devicePixelRatio || 1}
        >
          <EggScene textures={textures} hint={hint} play={play} />
        </Application>
      ) : (
        <div className="flex h-full w-full items-center justify-center text-sm text-white/80">
          {t('eggGame.loading')}
        </div>
      )}
    </div>
  );
}
