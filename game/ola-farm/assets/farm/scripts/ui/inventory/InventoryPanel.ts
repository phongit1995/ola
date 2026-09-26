import { Color, instantiate, Label, LabelOutline, Node, view } from 'cc';
import { InventoryBodyView } from './InventoryBodyView';
import { inventoryLayout } from './InventoryLayout';
import { format } from '../../core/Format';
import { ink } from '../../render/constants/Ui.constants';
import { PANEL_BROWN, PANEL_MUTED } from '../shared/PanelPalette.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { legacyIcon } from '../../render/Icons';

/** Storage uses Golden Island category tabs and a recessed item grid. */
export const inventoryPanel: PanelDefinition = {
  title: 'Kho nông sản',
  render(ctx: PanelContext): void {
    let body = ctx.card.getComponentInChildren(InventoryBodyView);
    if (!body) {
      const node = instantiate(ctx.ui.prefabs.inventoryBody);
      ctx.card.addChild(node);
      body = node.getComponent(InventoryBodyView);
      if (!body) throw Error('InventoryBody.prefab thiếu InventoryBodyView.');
    }
    body.render(ctx);
  },
};

/** The warehouse layout for the current screen, shared by the sale dialogs so the frame never jumps. */
function saleLayout(ctx: PanelContext) {
  const frame = view.getFrameSize();
  return inventoryLayout(ctx.app.width, frame.width, frame.height);
}

/** Labels built in code take the Golden Island face used by the warehouse, factory and livestock prefabs. */
function goldenIsland(ctx: PanelContext, node: Node): void {
  const font = ctx.art.shopFont;
  if (font) for (const label of node.getComponentsInChildren(Label)) label.font = font;
}

/** A one-line label that shrinks rather than running into the frame border. */
function fitLine(label: Label): void {
  label.enableWrapText = false;
  label.overflow = Label.Overflow.SHRINK;
}

const DISABLED_TITLE = new Color(PANEL_MUTED.r, PANEL_MUTED.g, PANEL_MUTED.b, 140),
  PRIMARY_OUTLINE = new Color(54, 105, 15);
/** FactoryBody.prefab draws button artwork at this scale, which keeps corners small (about 14–20 CSS px). */
const FACE_SCALE = 0.45;

/** Island artwork behind a card or button, scaled like the factory's so its corners stay small. */
function softFace(ctx: PanelContext, parent: Node, key: string, width: number, height: number, u: number): Node {
  const face = ctx.art.island(parent, key, 0, 0, width / FACE_SCALE, height / FACE_SCALE, 'Face');
  face.setScale(FACE_SCALE * u, FACE_SCALE * u, 1);
  return face;
}

/**
 * A factory-style button in CSS pixels: green or white (`info`) artwork with small corners and a one-line title.
 * A disabled green button turns white, and a disabled white one fades its title, as in the factory dialog.
 */
function softButton(
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

export const salePanel: PanelDefinition = {
  title: 'Bán sản phẩm',
  render(ctx: PanelContext): void {
    const { app, state, game, ui, card } = ctx,
      layout = saleLayout(ctx),
      { unit: u, height: h, contentWidth } = layout,
      item = game.item(state.saleKey);
    if (!item) {
      goldenIsland(ctx, card);
      return;
    }
    const count = game.quantity(item.key),
      quantity = Math.min(count, Math.max(1, state.saleQuantity));
    state.saleQuantity = quantity;
    // A short landscape window puts "Tối đa" beside the stepper so the stack still fits above the buttons.
    const top = h / 2,
      short = layout.short,
      stepperX = short ? -90 : 0,
      stepperY = top - (short ? 206 : 244);
    ui.item(card, `assets/sprites/${item.image}.png`, 0, (top - (short ? 92 : 108)) * u, (short ? 48 : 72) * u);
    ui.text(card, 'SaleItem', item.name, 0, (top - (short ? 136 : 166)) * u, contentWidth * u, 28 * u, 20 * u, ink);
    ui.text(
      card,
      'SaleStock',
      `Trong kho: ${format(count)} · Giá: ${format(item.sellPrice)} xu/cái`,
      0,
      (top - (short ? 160 : 192)) * u,
      contentWidth * u,
      20 * u,
      13 * u,
      PANEL_MUTED
    );
    softFace(ctx, ui.node(card, 'SaleQuantityBox', stepperX * u, stepperY * u, 96 * u, 44 * u), 'material', 96, 44, u);
    ui.text(card, 'SaleQuantity', format(quantity), stepperX * u, stepperY * u, 90 * u, 36 * u, 20 * u, ink);
    const change = (next: number): void => {
      state.saleQuantity = Math.max(1, Math.min(count, next));
      ctx.render();
    };
    for (const [id, title, dx, next, enabled] of [
      ['sale-minus', '−', -82, quantity - 1, quantity > 1],
      ['sale-plus', '+', 82, quantity + 1, quantity < count],
    ] as const)
      softButton(ctx, card, id, title, stepperX + dx, stepperY, 52, 44, () => change(next), { enabled, size: 22 });
    softButton(
      ctx,
      card,
      'sale-max',
      `Tối đa (${format(count)})`,
      short ? 130 : 0,
      short ? stepperY : top - 300,
      short ? 150 : 180,
      44,
      () => change(count),
      { enabled: quantity < count }
    );
    ui.text(
      card,
      'SaleReward',
      `Nhận ${format(quantity * item.sellPrice)} xu`,
      0,
      (top - (short ? 250 : 352)) * u,
      contentWidth * u,
      28 * u,
      20 * u,
      ink
    );
    // One green action, inset from the frame border like the factory footer.
    softButton(
      ctx,
      card,
      'sale-confirm',
      `Bán ${format(quantity)} sản phẩm`,
      0,
      layout.buttonY,
      layout.buttonWidth,
      layout.buttonHeight,
      () => app.act({ type: 'sellItem', item: item.key, quantity }, 'Sao tien bay', () => app.open('inventory')),
      { enabled: ctx.canAct && quantity > 0, primary: true, size: 16 }
    );
    goldenIsland(ctx, card);
  },
};

/** Legacy quick-sale grid with per-item "sell one / sell all" buttons. */
export const quickSalePanel: PanelDefinition = {
  title: 'Bán nhanh',
  render(ctx: PanelContext): void {
    const { app, state, game, ui, art, card, farm: s } = ctx,
      layout = saleLayout(ctx),
      { unit: u, height: h, contentWidth } = layout;
    // Only what can be sold right now; empty goods would only show disabled buttons.
    const items = game.items.filter(
      item => (state.inventoryTab === 'all' || item.tab === state.inventoryTab) && game.quantity(item.key) > 0
    );
    const tabs = [
      ['all', 'Tất cả'],
      ['raw', 'Nguyên liệu'],
      ['goods', 'Thành phẩm'],
    ] as const;
    // Pill buttons as before, with the factory's smaller corners; green marks the selected filter.
    const tabWidth = (contentWidth - 8 * (tabs.length - 1)) / tabs.length;
    tabs.forEach(([id, title], i) =>
      softButton(
        ctx,
        card,
        'tab-' + id,
        title,
        (i - (tabs.length - 1) / 2) * (tabWidth + 8),
        layout.tabsY,
        tabWidth,
        40,
        () => {
          state.inventoryTab = id;
          ctx.render();
        },
        { primary: state.inventoryTab === id }
      )
    );
    // A narrow phone gets one wide card per row: icon and name on top, two full-size buttons below.
    const columns = contentWidth >= 600 ? 3 : contentWidth >= 400 ? 2 : 1,
      single = columns === 1,
      rowH = single ? 118 : 158,
      top = layout.tabsY - 28,
      bottom = -h / 2 + 24,
      cw = contentWidth / columns;
    const list = ui.scroll(card, contentWidth * u, (top - bottom) * u, Math.ceil(items.length / columns) * rowH * u);
    list.scroll.node.setPosition(0, ((top + bottom) / 2) * u);
    ctx.adoptScroll(list.scroll);
    const content = list.content;
    if (!items.length)
      ui.text(
        content,
        'StockEmpty',
        'Chưa có sản phẩm để bán.',
        (contentWidth / 2) * u,
        -40 * u,
        contentWidth * u,
        30 * u,
        16 * u,
        PANEL_MUTED
      );
    items.forEach((item, i) => {
      const suffix = `${item.tab}-${item.legacyId ?? item.key}`,
        count = game.quantity(item.key);
      const x = cw * ((i % columns) + 0.5),
        y = -rowH / 2 - Math.floor(i / columns) * rowH;
      const cell = ui.node(content, 'StockItem', x * u, y * u, (cw - 8) * u, (rowH - 8) * u);
      softFace(ctx, cell, 'info', cw - 8, rowH - 8, u);
      const textX = single ? 26 : 0,
        textWidth = single ? cw - 84 : cw - 16;
      ui.item(
        cell,
        legacyIcon(art, item.tab, item.legacyId) ?? `assets/sprites/${item.image}.png`,
        (single ? -cw / 2 + 40 : 0) * u,
        (rowH / 2 - (single ? 38 : 34)) * u,
        44 * u
      );
      ui.text(
        cell,
        'StockLabel',
        `${item.name} × ${format(count)}`,
        textX * u,
        (rowH / 2 - (single ? 28 : 72)) * u,
        textWidth * u,
        20 * u,
        14 * u,
        ink
      );
      ui.text(
        cell,
        'Price',
        `${format(item.sellPrice)} xu / sản phẩm`,
        textX * u,
        (rowH / 2 - (single ? 50 : 94)) * u,
        textWidth * u,
        18 * u,
        12 * u,
        PANEL_MUTED
      );
      const buttonY = -rowH / 2 + (single ? 30 : 34),
        buttonW = (cw - (single ? 40 : 44)) / 2;
      for (const [id, title, side, quantity] of [
        [`sell-${suffix}`, 'Bán 1', -1, 1],
        [`sell-all-${suffix}`, 'Bán hết', 1, count],
      ] as const)
        softButton(
          ctx,
          cell,
          id,
          title,
          side * (buttonW / 2 + 3),
          buttonY,
          buttonW,
          40,
          () => app.act({ type: 'sellItem', item: item.key, quantity }, 'Sao tien bay'),
          { enabled: ctx.canAct && count > 0, primary: true }
        );
    });
    // Same place as the warehouse summary, above the tabs.
    fitLine(
      ui.text(
        card,
        'StockSummary',
        `Tổng kho: ${format(Object.values(s.inventory).reduce((n, v) => n + v, 0))} · Thu hoạch: ${format(s.harvested)} · Doanh thu: ${format(s.earned)} xu`,
        0,
        layout.summaryY * u,
        contentWidth * u,
        20 * u,
        12 * u,
        PANEL_MUTED
      )
    );
    goldenIsland(ctx, card);
  },
};
