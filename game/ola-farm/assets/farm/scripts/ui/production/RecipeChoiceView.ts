import { PANEL_BROWN } from '../shared/PanelPalette.constants';
import { _decorator, Label, Node, Sprite } from 'cc';
import type { Recipe } from '../../core/types/ProductionTypes';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';

const { ccclass, property } = _decorator;

/** One reusable recipe choice; the parent owns the list and navigation. */
@ccclass('RecipeChoiceView')
export class RecipeChoiceView extends AuthoredUiView {
  @property(Node) face: Node = null!;
  @property(Node) selected: Node = null!;
  @property(Sprite) product: Sprite = null!;
  @property(Label) recipeName: Label = null!;

  render(
    ctx: PanelContext,
    recipe: Recipe,
    selected: boolean,
    unlocked: boolean,
    x: number,
    y: number,
    width: number,
    unit: number,
    choose: () => void
  ): void {
    this.begin(ctx.ui);
    this.place(this.node, x, y, width, 98, unit);
    this.bind(ctx.ui, this.node, 'select-recipe-' + recipe.id, choose);
    this.place(this.face, 0, 10, 72, (72 * 184) / 195, unit);
    this.place(this.selected, 0, 10, 72, (72 * 184) / 195, unit);
    this.selected.active = selected;
    this.icon(this.product, ctx.art, `assets/sprites/${recipe.image}.png`, 0, 12, 43, unit);
    this.text(
      this.recipeName,
      recipe.name + (unlocked ? '' : ' · Chưa mở'),
      0,
      -34,
      width - 4,
      27,
      12,
      unit,
      PANEL_BROWN
    );
  }
}
