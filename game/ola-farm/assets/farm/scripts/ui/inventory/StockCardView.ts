import { _decorator, Color, Label, Node, Sprite } from 'cc';
import type { StockItem } from '../../core/types/ItemTypes';
import { format } from '../../core/Format';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';
import { fitProductionTarget } from '../shared/ProductionTouch';
import { legacyIcon } from '../../render/Icons';
import { PANEL_BROWN, PANEL_MUTED } from '../shared/PanelPalette.constants';

const FULL = new Color(255, 255, 255, 255),
  FADED = new Color(255, 255, 255, 110);

const { ccclass, property } = _decorator;

/** One editable inventory cell, reused while its item remains in the selected category. */
@ccclass('StockCardView')
export class StockCardView extends AuthoredUiView {
  @property(Sprite) product: Sprite = null!;
  @property(Node) badge: Node = null!;
  @property(Label) count: Label = null!;
  @property(Label) itemName: Label = null!;

  /** Sizes are CSS pixels scaled by `unit`, matching the warehouse layout. */
  render(
    ctx: PanelContext,
    item: StockItem,
    x: number,
    y: number,
    columnWidth: number,
    rowHeight: number,
    unit: number
  ): void {
    this.begin(ctx.ui);
    this.place(this.node, x, y, columnWidth - 6, rowHeight - 6, unit);
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
      12,
      Math.min(50, columnWidth - 26),
      unit
    );
    // Items not in stock stay visible for discovery but fade out and drop their badge.
    const count = ctx.game.quantity(item.key),
      digits = format(count).length,
      badgeWidth = Math.max(26, 14 + digits * 8);
    this.product.color = count > 0 ? FULL : FADED;
    this.badge.active = this.count.node.active = count > 0;
    this.place(this.badge, columnWidth * 0.22, -6, badgeWidth, 26, unit);
    this.text(this.count, format(count), columnWidth * 0.22, -6, badgeWidth, 22, digits > 3 ? 11 : 13, unit);
    this.text(
      this.itemName,
      item.name,
      0,
      -rowHeight / 2 + 16,
      columnWidth - 6,
      20,
      12,
      unit,
      count > 0 ? PANEL_BROWN : PANEL_MUTED
    );
    fitProductionTarget(this.node, ctx.app.width);
  }
}
