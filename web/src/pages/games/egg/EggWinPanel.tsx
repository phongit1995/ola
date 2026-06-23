import { useCallback, useEffect, useRef, useState } from 'react';
import { Assets, Container, Graphics, Texture } from 'pixi.js';
import { useTick } from '@pixi/react';
import { useTranslation } from 'react-i18next';
import { vipIconUrl } from '@lib';
import { useEggGameStore } from '@/store/eggGameStore';
import type { EggDrawResult } from '@app-types';
import kenCoinUrl from '@/assets/icons/apps/ken.png';
import vipDaysIconUrl from '@/assets/games/egg/day_vip.png';

const CARD_H = 250;
const BTN_H = 42;
const ICON_BOX = 88;
const APPEAR_MS = 220;

const TITLE_STYLE = { fontSize: 20, fontWeight: 'bold' as const, fill: 0x5e3c20, align: 'center' as const };
const BTN_LABEL_STYLE = { fontSize: 16, fontWeight: 'bold' as const, fill: 0xffffff };

function rewardIconUrl(result: EggDrawResult): string | null {
  if (result.categoryType === 'ken') return kenCoinUrl;
  if (result.categoryType === 'vip_days') return vipDaysIconUrl;
  if (result.vipTypeId != null) return vipIconUrl(result.vipTypeId);
  return null;
}

interface EggWinPanelProps {
  result: EggDrawResult;
  width: number;
  height: number;
}

export function EggWinPanel({ result, width, height }: EggWinPanelProps) {
  const { t } = useTranslation();
  const closeWin = useEggGameStore((s) => s.closeWin);
  const [iconTex, setIconTex] = useState<Texture | null>(null);

  const cardRef = useRef<Container>(null);
  const appearRef = useRef(0);
  const setCard = useCallback((c: Container | null) => {
    cardRef.current = c;
    if (c) c.scale.set(0.8);
  }, []);

  useEffect(() => {
    const url = rewardIconUrl(result);
    if (!url) return;
    let alive = true;
    void Assets.load(url).then((tex) => {
      if (alive) setIconTex(tex as Texture);
    });
    return () => {
      alive = false;
    };
  }, [result]);

  useTick((ticker) => {
    const c = cardRef.current;
    if (!c || appearRef.current >= APPEAR_MS) return;
    appearRef.current = Math.min(APPEAR_MS, appearRef.current + ticker.deltaMS);
    const p = appearRef.current / APPEAR_MS;
    const eased = 1 - Math.pow(1 - p, 3);
    c.scale.set(0.8 + 0.2 * eased);
  });

  const cardW = Math.min(300, width - 40);
  const btnW = cardW - 44;

  const drawBackdrop = useCallback(
    (g: Graphics) => {
      g.clear();
      g.rect(0, 0, width, height).fill({ color: 0x000000, alpha: 0.22 });
    },
    [width, height]
  );

  const drawCard = useCallback(
    (g: Graphics) => {
      g.clear();
      g.roundRect(-cardW / 2, -CARD_H / 2, cardW, CARD_H, 18)
        .fill(0xffffff)
        .stroke({ width: 2, color: 0xffe0a3 });
    },
    [cardW]
  );

  const drawButton = useCallback(
    (g: Graphics) => {
      g.clear();
      g.roundRect(-btnW / 2, -BTN_H / 2, btnW, BTN_H, BTN_H / 2).fill(0x7cb342);
    },
    [btnW]
  );

  const title = result.isSuperLucky ? t('eggGame.winModal.superTitle') : t('eggGame.winModal.title');
  const label =
    result.categoryType === 'ken' && result.kenAmount
      ? t('eggGame.winModal.ken', { ken: result.kenAmount })
      : result.categoryType === 'vip_days' && result.vipDays
        ? t('eggGame.winModal.vipDays', { days: result.vipDays })
        : (result.rewardLabel ?? t('eggGame.winModal.defaultLabel'));

  const iconScale = iconTex
    ? Math.min(ICON_BOX / (iconTex.width || ICON_BOX), ICON_BOX / (iconTex.height || ICON_BOX))
    : 1;

  return (
    <pixiContainer>
      <pixiGraphics draw={drawBackdrop} eventMode="static" />
      <pixiContainer ref={setCard} x={width / 2} y={height / 2}>
        <pixiGraphics draw={drawCard} eventMode="static" />
        <pixiText text={title} anchor={{ x: 0.5, y: 0.5 }} x={0} y={-CARD_H / 2 + 32} style={TITLE_STYLE} />
        {iconTex && (
          <pixiSprite
            texture={iconTex}
            anchor={{ x: 0.5, y: 0.5 }}
            x={0}
            y={-CARD_H / 2 + 112}
            width={(iconTex.width || ICON_BOX) * iconScale}
            height={(iconTex.height || ICON_BOX) * iconScale}
          />
        )}
        <pixiText
          text={label}
          anchor={{ x: 0.5, y: 0.5 }}
          x={0}
          y={-CARD_H / 2 + 176}
          style={{
            fontSize: 18,
            fontWeight: 'bold',
            fill: 0x1f8a3b,
            align: 'center',
            wordWrap: true,
            wordWrapWidth: cardW - 36,
          }}
        />
        <pixiGraphics
          draw={drawButton}
          x={0}
          y={CARD_H / 2 - 34}
          eventMode="static"
          cursor="pointer"
          onPointerTap={closeWin}
        />
        <pixiText
          text={t('eggGame.winModal.ok')}
          anchor={{ x: 0.5, y: 0.5 }}
          x={0}
          y={CARD_H / 2 - 34}
          eventMode="none"
          style={BTN_LABEL_STYLE}
        />
      </pixiContainer>
    </pixiContainer>
  );
}
