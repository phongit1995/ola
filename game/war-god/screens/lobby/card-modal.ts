import { Container, Graphics } from 'pixi.js';
import { popIn, tween } from '../../kit';
import { DESIGN_W } from '../../layout';

export interface CardModal {
  box: Container;
  dim: Graphics;
  card: Container;
  open(): void;
  close(): void;
  hide(): void;
  isOpen(): boolean;
  layout(designH: number): void;
}

export function createCardModal(onBackdrop: () => void, dimAlpha = 0.72): CardModal {
  const box = new Container();
  const dim = new Graphics();
  const card = new Container();
  let animation = 0;

  dim.eventMode = 'static';
  dim.on('pointertap', onBackdrop);
  box.addChild(dim, card);
  box.visible = false;

  return {
    box,
    dim,
    card,
    open(): void {
      animation++;
      box.visible = true;
      card.alpha = 1;
      card.scale.set(1);
      dim.alpha = 0;
      void tween(dim, { alpha: 1 }, 200);
      popIn(card, 0, 380);
    },
    close(): void {
      if (!box.visible) return;
      const current = ++animation;
      void tween(dim, { alpha: 0 }, 160);
      void tween(card, { scale: 0.72, alpha: 0 }, 170).then(() => {
        if (current !== animation) return;
        box.visible = false;
        card.scale.set(1);
        card.alpha = 1;
      });
    },
    hide(): void {
      animation++;
      box.visible = false;
      card.scale.set(1);
      card.alpha = 1;
    },
    isOpen: () => box.visible,
    layout(designH: number): void {
      dim.clear().rect(0, 0, DESIGN_W, designH).fill({ color: 0x080814, alpha: dimAlpha });
      card.x = DESIGN_W / 2;
      card.y = designH / 2;
    },
  };
}
