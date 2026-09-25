import { PANEL_GREEN as green, PANEL_MUTED as muted } from '../shared/PanelPalette.constants';
import { _decorator, Label, Node, Sprite, UITransform } from 'cc';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';

const { ccclass, property } = _decorator;

@ccclass('FactoryQueueSlotView')
export class FactoryQueueSlotView extends AuthoredUiView {
  @property(Node) face: Node = null!;
  @property(Sprite) product: Sprite = null!;
  @property(Label) stateLabel: Label = null!;
  @property(Label) add: Label = null!;
  @property(Node) lock: Node = null!;
  @property(Label) price: Label = null!;
  @property(Node) coin: Node = null!;
  @property(Label) empty: Label = null!;

  render(
    ctx: PanelContext,
    id: string,
    size: number,
    unit: number,
    action: () => void,
    enabled: boolean,
    job: { image: string; running: boolean } | null,
    locked: boolean,
    next: boolean,
    price: number,
    requiredLevel?: number
  ): void {
    this.begin(ctx.ui);
    this.node.getComponent(UITransform)!.setContentSize(size * unit, 52 * unit);
    this.bind(ctx.ui, this.node, id, action, enabled);
    this.place(this.face, 0, 0, size, (size * 196) / 198, unit);
    this.product.node.active = this.stateLabel.node.active = !!job;
    this.add.node.active = locked && (next || !!requiredLevel);
    this.lock.active = locked && !next && !requiredLevel;
    this.price.node.active = this.coin.active = locked;
    this.empty.node.active = !locked && !job;
    if (job) {
      this.icon(this.product, ctx.art, `assets/sprites/${job.image}.png`, 0, 8, 26, unit);
      this.text(
        this.stateLabel,
        job.running ? 'Đang làm' : 'Hủy',
        0,
        -15,
        size - 4,
        15,
        10,
        unit,
        job.running ? green : muted
      );
    }
    this.text(
      this.add,
      requiredLevel ? `Lv ${requiredLevel}` : '+',
      0,
      10,
      size - 4,
      24,
      requiredLevel ? 10 : 22,
      unit,
      requiredLevel ? muted : green
    );
    this.place(this.lock, 0, 9, 13, 14.5, unit);
    this.text(this.price, String(price), -6, -13, size - 16, 16, 10, unit, muted);
    this.place(this.coin, size / 2 - 10, -13, 11, 11, unit);
    this.text(this.empty, '—', 0, 0, size - 8, 24, 17, unit);
  }
}
