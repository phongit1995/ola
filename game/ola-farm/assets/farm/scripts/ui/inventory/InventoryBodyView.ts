import {
  _decorator,
  Color,
  instantiate,
  Label,
  Node,
  Prefab,
  Rect,
  ScrollView,
  Size,
  Sprite,
  SpriteFrame,
  Vec2,
  view,
} from 'cc';
import { format } from '../../core/Format';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';
import { PANEL_BROWN, PANEL_MUTED } from '../shared/PanelPalette.constants';
import { inventoryLayout } from './InventoryLayout';
import { StockCardView } from './StockCardView';
import { t } from '../../core/i18n/I18n';

const { ccclass, property } = _decorator;

const squareTops = new WeakMap<SpriteFrame, SpriteFrame>();

/** The recessed list artwork without its rounded top rows: square top corners under the tabs, rounded bottom. */
function squareTopFrame(frame: SpriteFrame): SpriteFrame {
  if (frame.rotated || frame.insetTop <= 0) return frame;
  let cut = squareTops.get(frame);
  if (!cut) {
    const r = frame.rect,
      top = frame.insetTop;
    cut = new SpriteFrame();
    cut.reset({
      texture: frame.texture,
      rect: new Rect(r.x, r.y + top, r.width, r.height - top),
      originalSize: new Size(r.width, r.height - top),
      offset: new Vec2(),
      isRotate: false,
      borderTop: 0,
      borderBottom: frame.insetBottom,
      borderLeft: frame.insetLeft,
      borderRight: frame.insetRight,
    });
    squareTops.set(frame, cut);
  }
  return cut;
}

/**
 * The native inventory layout is authored once; only item data and responsive bounds change.
 * Sizes are CSS pixels times the layout unit, like the livestock and factory dialogs.
 */
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
  private cells = new Map<string, StockCardView>();
  private gridFrame: SpriteFrame | null = null;

  render(ctx: PanelContext): void {
    this.begin(ctx.ui);
    const { state, game } = ctx,
      frame = view.getFrameSize(),
      layout = inventoryLayout(ctx.app.width, frame.width, frame.height),
      { unit: u, width: w, height: h, contentWidth } = layout;
    this.place(this.node, 0, 0, w, h, u);
    this.preview.active = false;
    const tab = state.inventoryTab === 'goods' ? 'goods' : 'raw';
    const total = Object.values(ctx.farm.inventory).reduce((sum, count) => sum + count, 0);
    this.text(this.count, t('stock.summary', { count: format(total) }), 0, layout.summaryY, contentWidth, 20, 13, u);
    const tabWidth = (contentWidth - 8) / 2;
    (['raw', 'goods'] as const).forEach((id, i) => {
      const node = this.tabs[i],
        units = game.stock(id).reduce((sum, item) => sum + game.quantity(item.key), 0);
      this.place(node, (i - 0.5) * (tabWidth + 8), layout.tabsY, tabWidth, layout.tabHeight, u);
      this.stateFrame(node.getComponent(Sprite)!, id === tab ? this.activeTab : this.inactiveTab);
      // Narrow phones shrink the title rather than letting it run past the tab.
      this.tabTitles[i].enableWrapText = false;
      this.tabTitles[i].overflow = Label.Overflow.SHRINK;
      this.text(
        this.tabTitles[i],
        `${t(id === 'raw' ? 'stock.raw' : 'stock.goods')} (${format(units)})`,
        0,
        1,
        tabWidth - 16,
        layout.tabHeight - 6,
        15,
        u,
        id === tab ? PANEL_BROWN : PANEL_MUTED
      );
      this.bind(ctx.ui, node, 'tab-' + id, () => {
        state.inventoryTab = id;
        ctx.render();
      });
    });
    // The list starts flush under the tabs with a square top; only its bottom corners stay rounded.
    const gridSprite = this.grid.getComponent(Sprite)!;
    this.gridFrame ??= gridSprite.spriteFrame;
    if (this.gridFrame) gridSprite.spriteFrame = squareTopFrame(this.gridFrame);
    const frameTop = layout.tabsY - layout.tabHeight / 2,
      frameBottom = layout.gridY - layout.gridHeight / 2 - 6;
    this.place(this.grid, 0, (frameTop + frameBottom) / 2, contentWidth + 12, frameTop - frameBottom, u);
    // Owned items first, each group in catalog order.
    const items = game
        .stock(tab)
        .map((item, order) => ({ item, order, owned: game.quantity(item.key) > 0 }))
        .sort((a, b) => Number(b.owned) - Number(a.owned) || a.order - b.order)
        .map(entry => entry.item),
      { columns, cellWidth, rowHeight, gridHeight } = layout;
    const content = this.scroll.content!;
    this.place(this.scroll.node, 0, layout.gridY, contentWidth, gridHeight, u);
    this.place(content.parent!, 0, 0, contentWidth, gridHeight, u);
    this.place(
      content,
      -contentWidth / 2,
      gridHeight / 2,
      contentWidth,
      Math.max(gridHeight, Math.ceil(items.length / columns) * rowHeight),
      u
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
        cellWidth * ((i % columns) + 0.5),
        -rowHeight * (Math.floor(i / columns) + 0.5),
        cellWidth,
        rowHeight,
        u
      );
    });
    // A short window drops the hint so whole rows still fit above the button.
    this.hint.node.active = !layout.short;
    if (!layout.short) this.text(this.hint, t('stock.hint'), 0, layout.hintY, w - 60, 20, 13, u);
    this.place(this.quickSale, 0, layout.buttonY, layout.buttonWidth, layout.buttonHeight, u);
    // The only button on this screen uses the primary green frame so it does not read as disabled.
    this.stateFrame(this.quickSale.getComponent(Sprite)!, ctx.art.frame('island-ui/green'));
    this.text(
      this.quickSaleTitle,
      t('stock.quickSale'),
      0,
      2,
      layout.buttonWidth - 20,
      layout.buttonHeight - 6,
      17,
      u,
      Color.WHITE
    );
    this.bind(ctx.ui, this.quickSale, 'inventory-sales', () => ctx.app.open('inventory-sales'));
    ctx.adoptScroll(this.scroll);
  }
}
