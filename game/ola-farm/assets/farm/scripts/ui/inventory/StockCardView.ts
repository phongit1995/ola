import { _decorator, Label, Node, Sprite } from 'cc';
import type { StockItem } from '../../core/types/ItemTypes';
import { format } from '../../core/Format';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';
import { fitProductionTarget } from '../shared/ProductionTouch';
import { legacyIcon } from '../../render/Icons';

const { ccclass, property } = _decorator;

/** One editable inventory cell, reused while its item remains in the selected category. */
@ccclass('StockCardView')
export class StockCardView extends AuthoredUiView {
  @property(Sprite) product: Sprite = null!;
  @property(Node) badge: Node = null!;
  @property(Label) count: Label = null!;
  @property(Label) itemName: Label = null!;

  render(ctx: PanelContext, item: StockItem, x: number, y: number, columnWidth: number, rowHeight: number): void {
    this.begin(ctx.ui);
    this.place(this.node, x, y, columnWidth - 8, rowHeight - 8);
    this.bind(ctx.ui, this.node, 'stock-' + item.key, () => {
      ctx.state.saleKey = item.key;
      ctx.state.saleQuantity = 1;
      ctx.app.open('inventory-item');
    });
    this.icon(
      this.product,
      ctx.art,
      legacyIcon(ctx.art, item.tab, item.legacyId) ?? `assets/sprites/${item.image}.png`,
      0,
      22,
      Math.min(80, columnWidth - 30)
    );
    this.place(this.badge, columnWidth * 0.24, -8, 43, 43);
    this.text(this.count, format(ctx.game.quantity(item.key)), columnWidth * 0.24, -8, 60, 36, 22);
    this.text(this.itemName, item.name, 0, -52, columnWidth - 10, 42, 20);
    fitProductionTarget(this.node, ctx.app.width);
    this.count.lineHeight = this.count.fontSize + 7;
    this.itemName.lineHeight = this.itemName.fontSize + 7;
  }
}
