import type { LoadingContentScale } from './LoadingScreenView.types';
import { _decorator, Component, Label, Node, Sprite, UITransform, Widget } from 'cc';
import type { ArtLoadProgress } from '../../render/types/Art.types';
import { STATUS } from './LoadingScreenView.constants';

const { ccclass, property } = _decorator;

/** Binds progress to the native scene artwork; all visuals and layout are authored in the Editor. */
@ccclass('LoadingScreenView')
export class LoadingScreenView extends Component {
  @property(Node) content: Node = null!;
  @property(Sprite) backdrop: Sprite = null!;
  @property(Sprite) landscape: Sprite = null!;
  @property(Sprite) farmMark: Sprite = null!;
  @property(Label) title: Label = null!;
  @property(Label) status: Label = null!;
  @property(Label) progressText: Label = null!;
  @property(Sprite) progressTrack: Sprite = null!;
  @property(Sprite) progressFill: Sprite = null!;

  private host: Node | null = null;
  private ratio: number | null = null;
  private travel = 0;
  private failed = false;
  private animate = true;
  private contentScale: LoadingContentScale | null = null;

  onEnable(): void {
    this.node.on(Node.EventType.SIZE_CHANGED, this.layout, this);
    this.layout();
  }

  onDisable(): void {
    this.node.off(Node.EventType.SIZE_CHANGED, this.layout, this);
    this.host?.off(Node.EventType.SIZE_CHANGED, this.fitParent, this);
  }

  setup(parent: Node = this.node.parent!): void {
    this.host?.off(Node.EventType.SIZE_CHANGED, this.fitParent, this);
    this.host = parent;
    if (this.node.parent !== parent) parent.addChild(this.node);
    this.node.setSiblingIndex(parent.children.length - 1);
    this.node.active = true;
    this.animate = !(globalThis as { matchMedia?: (q: string) => { matches: boolean } }).matchMedia?.(
      '(prefers-reduced-motion: reduce)'
    ).matches;
    parent.on(Node.EventType.SIZE_CHANGED, this.fitParent, this);
    this.fitParent();
    this.setProgress({ phase: 'data' });
  }

  setProgress(progress: ArtLoadProgress): void {
    if (this.failed) return;
    this.status.string = STATUS[progress.phase];
    if (progress.phase === 'ported' && Number.isFinite(progress.total) && progress.total > 0) {
      const total = Math.max(1, Math.floor(progress.total));
      const done = Math.max(0, Math.min(total, Math.floor(Number.isFinite(progress.done) ? progress.done : 0)));
      this.ratio = done / total;
      this.progressText.string = `${done} / ${total}`;
    } else {
      this.ratio = null;
      this.progressText.string = '';
    }
    this.updateProgress();
  }

  showError(message = 'Hãy tải lại trang để thử lại.'): void {
    this.failed = true;
    this.status.string = 'Chưa thể mở nông trại';
    this.progressText.string = message;
    this.progressTrack.node.active = false;
  }

  update(dt: number): void {
    if (!this.animate || this.failed || this.ratio !== null) return;
    this.travel = (this.travel + dt * 0.55) % 2;
    this.updateProgress();
  }

  private fitParent(): void {
    const size = this.host?.getComponent(UITransform);
    if (!size) return;
    this.node.setPosition((0.5 - size.anchorX) * size.width, (0.5 - size.anchorY) * size.height);
    this.node.getComponent(UITransform)!.setContentSize(size.width, size.height);
    this.layout();
  }

  private layout(): void {
    if (!this.content) return;
    const size = this.node.getComponent(UITransform)!,
      body = this.content.getComponent(UITransform)!;
    const scale = Math.max(0.1, Math.min(1, (size.width - 64) / body.width, (size.height - 64) / body.height));
    this.contentScale ??= { x: this.content.scale.x, y: this.content.scale.y };
    this.content.setScale(scale * this.contentScale.x, scale * this.contentScale.y, 1);
    for (const sprite of [this.backdrop, this.landscape, this.progressFill])
      sprite?.node.getComponent(Widget)?.updateAlignment();
  }

  private updateProgress(): void {
    if (!this.progressFill) return;
    this.progressFill.fillStart = this.ratio === null ? 0.76 * (1 - Math.abs(1 - this.travel)) : 0;
    this.progressFill.fillRange = this.ratio ?? 0.24;
  }
}
