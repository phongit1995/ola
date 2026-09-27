import { instantiate } from 'cc';
import { InventoryBodyView } from './InventoryBodyView';
import { fitLine, goldenIsland, saleLayout, softButton, softFace } from './SoftUi';
import { format } from '../../core/Format';
import { ink } from '../../render/constants/Ui.constants';
import { PANEL_MUTED } from '../shared/PanelPalette.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { legacyIcon } from '../../render/Icons';
import { t } from '../../core/i18n/I18n';

/** Storage uses Golden Island category tabs and a recessed item grid. */
export const inventoryPanel: PanelDefinition = {
  title: () => t('stock.title'),
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

export const salePanel: PanelDefinition = {
  title: () => t('sell.title'),
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
      t('sell.stockAndPrice', { count: format(count), price: format(item.sellPrice) }),
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
      t('sell.max', { count: format(count) }),
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
      t('sell.receive', { coins: format(quantity * item.sellPrice) }),
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
      t('sell.confirm', { count: format(quantity) }),
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
  title: () => t('stock.quickSale'),
  render(ctx: PanelContext): void {
    const { app, state, game, ui, art, card, farm: s } = ctx,
      layout = saleLayout(ctx),
      { unit: u, height: h, contentWidth } = layout;
    // Only what can be sold right now; empty goods would only show disabled buttons.
    const items = game.items.filter(
      item => (state.inventoryTab === 'all' || item.tab === state.inventoryTab) && game.quantity(item.key) > 0
    );
    const tabs = [
      ['all', t('common.all')],
      ['raw', t('stock.raw')],
      ['goods', t('stock.goods')],
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
        t('sell.nothing'),
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
        t('sell.pricePerItem', { price: format(item.sellPrice) }),
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
        [`sell-${suffix}`, t('sell.one'), -1, 1],
        [`sell-all-${suffix}`, t('sell.all'), 1, count],
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
        t('sell.stats', {
          stock: format(Object.values(s.inventory).reduce((n, v) => n + v, 0)),
          harvested: format(s.harvested),
          revenue: format(s.earned),
        }),
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
