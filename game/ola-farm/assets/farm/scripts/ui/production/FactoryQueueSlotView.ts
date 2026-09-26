import { PANEL_BROWN as brown, PANEL_ERROR as red, PANEL_GREEN as green } from '../shared/PanelPalette.constants';
import { _decorator, Label, Layers, Node, Sprite, UITransform } from 'cc';
import { CANCEL_BADGE_SIZE, CANCEL_FACE_SCALE } from './FactoryQueueSlotView.constants';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import type { PanelContext } from '../shared/PanelContext.types';
import type { QueueSlotJob } from './FactoryQueueSlotView.types';
import { PANEL_MUTED as muted } from '../shared/PanelPalette.constants';

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
  /** Runtime-only extras, created once per slot and reused on every render. */
  private clock: Node | null = null;
  private cancel: Node | null = null;

  /** Built once: a fully rounded island `info` face (drawn large, scaled down) and a bold red cross. */
  private cancelBadge(ctx: PanelContext): Node {
    const badge = new Node('Cancel');
    badge.layer = Layers.Enum.UI_2D;
    badge.addComponent(UITransform);
    this.node.addChild(badge);
    ctx.art.island(badge, 'info', 0, 0, 1, 1, 'Face');
    const mark = new Node('Mark');
    mark.layer = Layers.Enum.UI_2D;
    mark.addComponent(UITransform);
    badge.addChild(mark);
    const label = mark.addComponent(Label);
    label.string = '×';
    label.color = red;
    label.horizontalAlign = Label.HorizontalAlign.CENTER;
    label.verticalAlign = Label.VerticalAlign.CENTER;
    label.isBold = true;
    if (ctx.art.shopFont) label.font = ctx.art.shopFont;
    return badge;
  }

  render(
    ctx: PanelContext,
    id: string,
    size: number,
    unit: number,
    action: () => void,
    enabled: boolean,
    job: QueueSlotJob | null,
    locked: boolean,
    next: boolean,
    price: number,
    requiredLevel?: number
  ): void {
    this.begin(ctx.ui);
    // Authored at 52 px; every part scales with the slot so larger slots stay proportional.
    const k = size / 52;
    this.node.getComponent(UITransform)!.setContentSize(size * unit, size * unit);
    this.bind(ctx.ui, this.node, id, action, enabled);
    this.place(this.face, 0, 0, size, (size * 196) / 198, unit);
    this.product.node.active = this.stateLabel.node.active = !!job;
    this.add.node.active = locked && (next || !!requiredLevel);
    this.lock.active = locked && !next && !requiredLevel;
    this.price.node.active = this.coin.active = locked;
    this.empty.node.active = !locked && !job;
    // Jobs show their time behind a clock, like crops and animals; a ready batch just says "Nhận".
    const timed = !!job && job.tone !== 'ready';
    this.clock ??= ctx.art.plot(this.node, 'clock', 0, 0, 1, 1, 'Clock');
    this.clock.active = timed;
    if (job) {
      // The product fills most of the slot; the time sits on a band along its bottom edge.
      this.icon(this.product, ctx.art, `assets/sprites/${job.image}.png`, 0, 7.5 * k, 34 * k, unit);
      if (timed) this.place(this.clock, -size / 2 + 12 * k, -16 * k, 11 * k, (11 * k * 63) / 74, unit);
      this.text(
        this.stateLabel,
        job.label,
        timed ? 6 * k : 0,
        -16 * k,
        size - (timed ? 24 * k : 6),
        13 * k,
        10.5 * k,
        unit,
        job.tone === 'queued' ? brown : green
      );
      this.stateLabel.overflow = Label.Overflow.SHRINK;
    }
    // A queued job's round cream badge with a red "×" on the top-right corner, unlike the dialog's close button.
    // Tapping the slot itself never cancels.
    this.cancel ??= this.cancelBadge(ctx);
    this.cancel.active = !!job?.cancel;
    if (job?.cancel) {
      const d = CANCEL_BADGE_SIZE;
      this.cancel.setPosition((size / 2 - d / 2 + 6) * unit, (size / 2 - d / 2 + 6) * unit);
      this.cancel.getComponent(UITransform)!.setContentSize(d * unit, d * unit);
      const face = this.cancel.getChildByName('Face')!;
      face.getComponent(UITransform)!.setContentSize(d / CANCEL_FACE_SCALE, d / CANCEL_FACE_SCALE);
      face.setScale(CANCEL_FACE_SCALE * unit, CANCEL_FACE_SCALE * unit, 1);
      const mark = this.cancel.getChildByName('Mark')!.getComponent(Label)!;
      mark.fontSize = Math.ceil(24 * unit);
      mark.lineHeight = Math.ceil(26 * unit);
      mark.node.getComponent(UITransform)!.setContentSize(d * unit, d * unit);
      mark.node.setPosition(0, 2 * unit);
      this.bind(ctx.ui, this.cancel, job.cancel.id, job.cancel.action, job.cancel.enabled);
    }
    this.text(
      this.add,
      requiredLevel ? `Lv ${requiredLevel}` : '+',
      0,
      10 * k,
      size - 4,
      24 * k,
      (requiredLevel ? 10 : 22) * k,
      unit,
      requiredLevel ? muted : green
    );
    this.place(this.lock, 0, 9 * k, 13 * k, 14.5 * k, unit);
    this.text(this.price, String(price), -6 * k, -13 * k, size - 16 * k, 16 * k, 10 * k, unit, muted);
    this.place(this.coin, size / 2 - 10 * k, -13 * k, 11 * k, 11 * k, unit);
    this.text(this.empty, '—', 0, 0, size - 8, 24 * k, 17 * k, unit);
  }
}
