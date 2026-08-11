import type { Container, FederatedPointerEvent, FederatedWheelEvent } from 'pixi.js';

export interface DragScrollBinding {
  reset(): void;
  wasDragged(): boolean;
  destroy(): void;
}

interface DragScrollOptions {
  scale(): number;
  offset(): number;
  setOffset(value: number): void;
  apply(): void;
  threshold?: number;
  wheelFactor?: number;
}

export function bindDragScroll(
  target: Container,
  options: DragScrollOptions,
): DragScrollBinding {
  let dragY: number | null = null;
  let moved = 0;
  const threshold = options.threshold ?? 8;
  const wheelFactor = options.wheelFactor ?? 1 / 3;

  const onPointerDown = (event: FederatedPointerEvent): void => {
    dragY = event.global.y;
    moved = 0;
  };
  const onPointerMove = (event: FederatedPointerEvent): void => {
    if (dragY == null) return;
    const scale = options.scale() || 1;
    const delta = (event.global.y - dragY) / scale;
    moved += Math.abs(delta);
    options.setOffset(options.offset() - delta);
    dragY = event.global.y;
    options.apply();
  };
  const endDrag = (): void => {
    dragY = null;
  };
  const onWheel = (event: FederatedWheelEvent): void => {
    options.setOffset(options.offset() + event.deltaY * wheelFactor);
    options.apply();
  };

  target.on('pointerdown', onPointerDown);
  target.on('pointermove', onPointerMove);
  target.on('pointerup', endDrag);
  target.on('pointerupoutside', endDrag);
  target.on('wheel', onWheel);

  return {
    reset(): void {
      dragY = null;
      moved = 0;
    },
    wasDragged: () => moved >= threshold,
    destroy(): void {
      target.off('pointerdown', onPointerDown);
      target.off('pointermove', onPointerMove);
      target.off('pointerup', endDrag);
      target.off('pointerupoutside', endDrag);
      target.off('wheel', onWheel);
    },
  };
}
