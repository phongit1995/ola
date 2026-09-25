import { _decorator, instantiate, Label, Node, Prefab, ScrollView, Sprite, SpriteFrame, view } from 'cc';
import { format } from '../../core/Format';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';
import { productionTargetSize } from '../shared/ProductionTouch';
import { StockCardView } from './StockCardView';

const { ccclass, property } = _decorator;

/** The native inventory layout is authored once; only item data and responsive bounds change. */
@ccclass('InventoryBodyView')
export class InventoryBodyView extends AuthoredUiView {
  @property(Prefab) stockCardPrefab: Prefab = null!;
  @property(Label) count: Label = null!;
  @property([Node]) tabs: Node[] = [];
  @property([Label]) tabTitles: Label[] = [];
  @property(SpriteFrame) activeTab: SpriteFrame = null!;
  @property(SpriteFrame) inactiveTab: SpriteFrame = null!;
  @property(Node) grid: Node = null!;
  @property(ScrollView) scroll: ScrollView = null!;
  @property(Node) preview: Node = null!;
  @property(Label) hint: Label = null!;
  @property(Node) quickSale: Node = null!;
  @property(Label) quickSaleTitle: Label = null!;
  @property rowHeight = 160;
  private cells = new Map<string, StockCardView>();

  render(ctx: PanelContext): void {
    this.begin(ctx.ui);
    const { state, game, width: w, height: h } = ctx,
      touch = productionTargetSize(ctx.app.width);
    const targetFont = Math.max(26, Math.ceil((13 * ctx.app.width) / Math.max(1, view.getFrameSize().width)));
    this.place(this.node, 0, 0, w, h);
    this.preview.active = false;
    const tab = state.inventoryTab === 'goods' ? 'goods' : 'raw';
    const total = Object.values(ctx.farm.inventory).reduce((sum, count) => sum + count, 0);
    this.text(this.count, `${format(total)} sản phẩm · Không giới hạn kho`, 0, h / 2 - 108, w - 100, 38, 23);
    this.count.lineHeight = this.count.fontSize + 7;
    (['raw', 'goods'] as const).forEach((id, i) => {
      const node = this.tabs[i],
        title = this.tabTitles[i],
        width = (w - 90) / 2;
      this.place(node, ((i - 0.5) * (w - 80)) / 2, h / 2 - 166, width, touch);
      this.stateFrame(node.getComponent(Sprite)!, id === tab ? this.activeTab : this.inactiveTab);
      this.text(title, id === 'raw' ? 'Nguyên liệu' : 'Thành phẩm', 0, 1, width - 24, touch - 10, targetFont);
      title.lineHeight = title.fontSize + 6;
      this.bind(ctx.ui, node, 'tab-' + id, () => {
        state.inventoryTab = id;
        ctx.render();
      });
    });
    const gridW = w - 64,
      gridTop = h / 2 - 166 - touch / 2 - 8,
      hintY = -h / 2 + touch + 38;
    const gridBottom = hintY + 28,
      gridH = gridTop - gridBottom,
      gridY = (gridTop + gridBottom) / 2;
    this.place(this.grid, 0, gridY, gridW + 12, gridH + 12);
    const items = game.stock(tab),
      columns = w < 800 ? 4 : 6,
      columnWidth = gridW / columns;
    const content = this.scroll.content!,
      viewport = content.parent!;
    this.place(this.scroll.node, 0, gridY, gridW, gridH);
    this.place(viewport, 0, 0, gridW, gridH);
    this.place(
      content,
      -gridW / 2,
      gridH / 2,
      gridW,
      Math.max(gridH, Math.ceil(items.length / columns) * this.rowHeight)
    );
    const keys = new Set(items.map(item => item.key));
    for (const [key, cell] of this.cells)
      if (!keys.has(key)) {
        cell.node.removeFromParent();
        cell.node.destroy();
        this.cells.delete(key);
      }
    items.forEach((item, i) => {
      let cell = this.cells.get(item.key);
      if (!cell) {
        const node = instantiate(this.stockCardPrefab);
        content.addChild(node);
        cell = node.getComponent(StockCardView)!;
        if (!cell) throw Error('StockCard.prefab thiếu StockCardView.');
        this.cells.set(item.key, cell);
      }
      cell.render(
        ctx,
        item,
        columnWidth * ((i % columns) + 0.5),
        -this.rowHeight * (Math.floor(i / columns) + 0.5),
        columnWidth,
        this.rowHeight
      );
    });
    this.text(this.hint, 'Chạm vào sản phẩm để chọn số lượng bán', 0, hintY, w - 70, 34, 21);
    this.hint.lineHeight = this.hint.fontSize + 7;
    this.place(this.quickSale, 0, -h / 2 + touch / 2 + 14, w - 130, touch);
    this.text(this.quickSaleTitle, 'Bán nhanh', 0, 1, w - 154, touch - 10, targetFont);
    this.quickSaleTitle.lineHeight = this.quickSaleTitle.fontSize + 6;
    this.bind(ctx.ui, this.quickSale, 'inventory-sales', () => ctx.app.open('inventory-sales'));
    ctx.adoptScroll(this.scroll);
  }
}
