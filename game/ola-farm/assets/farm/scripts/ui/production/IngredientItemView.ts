import { PANEL_BROWN, PANEL_ERROR, PANEL_GREEN } from '../shared/PanelPalette.constants';
import { _decorator, Label, Sprite } from 'cc';
import type { ItemAmount } from '../../core/types/ItemTypes';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';

const { ccclass, property } = _decorator;

/** One ingredient with its stock requirement and a link to its production source. */
@ccclass('IngredientItemView')
export class IngredientItemView extends AuthoredUiView {
  @property(Sprite) product: Sprite = null!;
  @property(Label) itemName: Label = null!;
  @property(Label) stock: Label = null!;

  render(
    ctx: PanelContext,
    id: string,
    ingredient: ItemAmount,
    x: number,
    y: number,
    width: number,
    unit: number,
    findSource: () => void
  ): void {
    this.begin(ctx.ui);
    const source = ctx.game.item(ingredient.key),
      quantity = ctx.game.quantity(ingredient.key),
      missing = quantity < ingredient.quantity;
    this.action(this.node, ctx.ui, ctx.art, id, '', x, y, width, 52, unit, findSource, true, 'material');
    this.product.node.active = !!source;
    if (source) this.icon(this.product, ctx.art, `assets/sprites/${source.image}.png`, -width / 2 + 23, 0, 30, unit);
    this.text(this.itemName, source?.name ?? ingredient.key, 19, 11, width - 48, 21, 12, unit, PANEL_BROWN);
    this.text(
      this.stock,
      `${quantity} / ${ingredient.quantity}${missing ? ' · Thiếu' : ''}`,
      19,
      -10,
      width - 48,
      20,
      12,
      unit,
      missing ? PANEL_ERROR : PANEL_GREEN
    );
  }
}
