import { instantiate } from 'cc';
import { InventoryBodyView } from './InventoryBodyView';
import { format } from '../../core/Format';
import { ink } from '../../render/constants/Ui.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { legacyIcon } from '../../render/Icons';
import { productionTargetSize } from '../shared/ProductionTouch';

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

export const salePanel: PanelDefinition = {
  title: 'Bán sản phẩm',
  render(ctx: PanelContext): void {
    const { app, state, game, ui, art, width: w } = ctx,
      item = game.item(state.saleKey);
    if (!item) {
      ctx.footer('back-stock', 'Về kho', () => app.open('inventory'));
      return;
    }
    const count = game.quantity(item.key),
      quantity = Math.min(count, Math.max(1, state.saleQuantity));
    state.saleQuantity = quantity;
    const content = ctx.list(540),
      cx = (w - 80) / 2;
    ui.item(content, `assets/sprites/${item.image}.png`, cx, -65, 104);
    ui.text(content, 'SaleItem', `${item.name} · Kho: ${format(count)}`, cx, -144, w - 100, 48, 28, ink);
    art.island(content, 'inset', cx, -222, 156, 76);
    ui.text(content, 'SaleQuantity', String(quantity), cx, -222, 140, 60, 32, ink);
    const change = (next: number): void => {
      state.saleQuantity = Math.max(1, Math.min(count, next));
      ctx.render();
    };
    ui.islandButton(
      content,
      'sale-minus',
      '−',
      cx - 135,
      -222,
      90,
      76,
      () => change(quantity - 1),
      quantity > 1,
      'card'
    );
    ui.islandButton(
      content,
      'sale-plus',
      '+',
      cx + 135,
      -222,
      90,
      76,
      () => change(quantity + 1),
      quantity < count,
      'card'
    );
    ui.button(content, 'sale-max', 'Tối đa', cx, -312, 240, 64, () => change(count), { enabled: count > 0 });
    art.town(content, 'coin', cx - 100, -392, 44, 44);
    ui.text(content, 'SaleReward', `${format(quantity * item.sellPrice)} xu`, cx + 30, -392, 250, 55, 29, ink);
    ui.button(
      content,
      'sale-confirm',
      `Bán ${quantity} sản phẩm`,
      cx,
      -479,
      w - 180,
      70,
      () => app.act({ type: 'sellItem', item: item.key, quantity }, 'Sao tien bay', () => app.open('inventory')),
      { enabled: ctx.canAct && quantity > 0 }
    );
    ctx.footer('back-stock', 'Về kho', () => app.open('inventory'));
  },
};

/** Legacy quick-sale grid with per-item "sell one / sell all" buttons. */
export const quickSalePanel: PanelDefinition = {
  title: 'Bán nhanh',
  render(ctx: PanelContext): void {
    const { app, state, game, ui, art, card, width: w, height: h, farm: s } = ctx;
    const items = game.items.filter(item => state.inventoryTab === 'all' || item.tab === state.inventoryTab);
    const touch = productionTargetSize(app.width),
      cols = w < 900 ? 2 : 3,
      rowH = 220 + touch;
    const top = h / 2 - 110,
      bottom = -h / 2 + touch + 60;
    const list = ui.scroll(card, w - 80, top - bottom, 120 + Math.ceil(items.length / cols) * rowH);
    list.scroll.node.setPosition(0, (top + bottom) / 2);
    ctx.adoptScroll(list.scroll);
    const content = list.content;
    const tabs = [
      ['all', 'Tất cả'],
      ['raw', 'Nguyên liệu'],
      ['goods', 'Thành phẩm'],
    ] as const;
    tabs.forEach(([id, title], i) =>
      ui.button(
        content,
        'tab-' + id,
        title,
        ((w - 80) * (i + 0.5)) / tabs.length,
        -touch / 2 - 6,
        (w - 120) / tabs.length - 10,
        touch,
        () => {
          state.inventoryTab = id;
          ctx.render();
        },
        { variant: 'blue' }
      )
    );
    const cw = (w - 100) / cols;
    items.forEach((item, i) => {
      const suffix = `${item.tab}-${item.legacyId ?? item.key}`;
      const x = 10 + cw * ((i % cols) + 0.5),
        y = -112 - rowH / 2 - Math.floor(i / cols) * rowH;
      const count = game.quantity(item.key);
      const cell = ui.box(content, 'StockItem', x, y, cw - 8, rowH - 12);
      ui.item(
        cell,
        legacyIcon(art, item.tab, item.legacyId) ?? `assets/sprites/${item.image}.png`,
        0,
        rowH / 2 - 62,
        77
      );
      ui.text(cell, 'StockLabel', `${item.name}\n× ${count}`, 0, rowH / 2 - 130, cw - 14, 54, 23, ink);
      ui.text(cell, 'Price', `${item.sellPrice} xu / sản phẩm`, 0, rowH / 2 - 175, cw - 12, 28, 20, ink);
      const buttonY = -rowH / 2 + touch / 2 + 12;
      ui.button(
        cell,
        `sell-${suffix}`,
        'Bán 1',
        -cw * 0.23,
        buttonY,
        cw * 0.42,
        touch,
        () => app.act({ type: 'sellItem', item: item.key, quantity: 1 }, 'Sao tien bay'),
        { enabled: ctx.canAct && count > 0 }
      );
      ui.button(
        cell,
        `sell-all-${suffix}`,
        'Bán hết',
        cw * 0.23,
        buttonY,
        cw * 0.42,
        touch,
        () => app.act({ type: 'sellItem', item: item.key, quantity: count }, 'Sao tien bay'),
        { enabled: ctx.canAct && count > 0 }
      );
    });
    ui.text(
      card,
      'StockSummary',
      `Tổng kho: ${Object.values(s.inventory).reduce((n, v) => n + v, 0)} · Thu hoạch: ${s.harvested} · Doanh thu: ${format(s.earned)} xu`,
      0,
      -h / 2 + touch + 35,
      w - 110,
      28,
      19,
      ink
    );
    ctx.footer('inventory-sales', 'Về kho', () => app.open('inventory'));
  },
};
