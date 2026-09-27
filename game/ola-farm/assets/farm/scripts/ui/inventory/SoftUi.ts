import { Color, Label, LabelOutline, Node, view } from 'cc';
import { inventoryLayout } from './InventoryLayout';
import { PANEL_BROWN, PANEL_MUTED } from '../shared/PanelPalette.constants';
import type { PanelContext } from '../shared/PanelContext.types';
import { FACE_SCALE, PRIMARY_OUTLINE } from './SoftUi.constants';

/** Small-corner Golden Island buttons and cards for code-built panels in the warehouse frame (sale, diamonds). */

/** The warehouse layout for the current screen, shared by the sale and diamond dialogs so the frame never jumps. */
export function saleLayout(ctx: PanelContext) {
  const frame = view.getFrameSize();
  return inventoryLayout(ctx.app.width, frame.width, frame.height);
}

/** Labels built in code take the Golden Island face used by the warehouse, factory and livestock prefabs. */
export function goldenIsland(ctx: PanelContext, node: Node): void {
  const font = ctx.art.shopFont;
  if (font) for (const label of node.getComponentsInChildren(Label)) label.font = font;
}

/** A one-line label that shrinks rather than running into the frame border. */
export function fitLine(label: Label): void {
  label.enableWrapText = false;
  label.overflow = Label.Overflow.SHRINK;
}

const DISABLED_TITLE = new Color(PANEL_MUTED.r, PANEL_MUTED.g, PANEL_MUTED.b, 140);

/** Island artwork behind a card or button, scaled like the factory's so its corners stay small. */
export function softFace(ctx: PanelContext, parent: Node, key: string, width: number, height: number, u: number): Node {
  const face = ctx.art.island(parent, key, 0, 0, width / FACE_SCALE, height / FACE_SCALE, 'Face');
  face.setScale(FACE_SCALE * u, FACE_SCALE * u, 1);
  return face;
}

/**
 * A factory-style button in CSS pixels: green or white (`info`) artwork with small corners and a one-line title.
 * A disabled green button turns white, and a disabled white one fades its title, as in the factory dialog.
 */
export function softButton(
  ctx: PanelContext,
  parent: Node,
  id: string,
  title: string,
  x: number,
  y: number,
  width: number,
  height: number,
  action: () => void,
  options: { enabled?: boolean; primary?: boolean; size?: number } = {}
): Node {
  const u = saleLayout(ctx).unit,
    enabled = options.enabled ?? true,
    primary = (options.primary ?? false) && enabled;
  const node = ctx.ui.node(parent, id, x * u, y * u, width * u, height * u);
  softFace(ctx, node, primary ? 'green' : 'info', width, height, u);
  const label = ctx.ui.text(
    node,
    'Title',
    title,
    0,
    (primary ? 2 : 0) * u,
    (width - 12) * u,
    (height - 6) * u,
    (options.size ?? 15) * u,
    primary ? Color.WHITE : enabled ? PANEL_BROWN : DISABLED_TITLE
  );
  fitLine(label);
  if (primary) {
    const outline = label.node.addComponent(LabelOutline);
    outline.color = PRIMARY_OUTLINE;
    outline.width = 2;
  }
  return ctx.ui.bindButton(node, id, action, enabled);
}
