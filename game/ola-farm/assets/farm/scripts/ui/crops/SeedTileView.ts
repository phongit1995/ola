import { SEED_COST_COLOR, SEED_LOCKED_COLOR } from './SeedTileView.constants';
import { _decorator, Label, Sprite, UIOpacity } from 'cc';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import { Art } from '../../render/Art';
import { Ui } from '../../render/Ui';

const { ccclass, property } = _decorator;

/** An Editor-authored hex seed card, including its seed image and coin price. */
@ccclass('SeedTileView')
export class SeedTileView extends AuthoredUiView {
  @property(Sprite) seed: Sprite = null!;
  @property(Sprite) coin: Sprite = null!;
  @property(Label) cost: Label = null!;
  @property(UIOpacity) opacity: UIOpacity = null!;
  private authoredOpacity: number | null = null;

  render(
    ui: Ui,
    art: Art,
    id: string,
    source: string,
    price: number,
    enabled: boolean,
    action: () => void,
    requiredLevel?: number
  ): void {
    this.begin(ui);
    this.authoredOpacity ??= this.opacity.opacity;
    this.opacity.opacity = this.authoredOpacity * (enabled ? 1 : 135 / 255);
    this.icon(this.seed, art, source, 0, 8, 70);
    const amount = requiredLevel ? `Lv ${requiredLevel}` : String(price),
      span = Math.max(24, amount.length * 17);
    this.text(
      this.cost,
      amount,
      requiredLevel ? 0 : -13,
      -40.5,
      span + 6,
      36,
      requiredLevel ? 21 : 26,
      1,
      enabled ? SEED_COST_COLOR : SEED_LOCKED_COLOR
    );
    this.icon(this.coin, art, art.data.ui.widgets.coin.texture, span / 2 + 2, -40.5, 26);
    this.coin.node.active = !requiredLevel;
    this.bind(ui, this.node, id, action, enabled);
  }
}
