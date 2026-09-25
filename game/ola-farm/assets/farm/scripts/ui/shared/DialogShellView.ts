import {
  _decorator,
  Component,
  Font,
  Graphics,
  instantiate,
  Label,
  Node,
  Prefab,
  Sprite,
  SpriteFrame,
  UITransform,
} from 'cc';
import { FactoryDialogFrameView } from '../production/FactoryDialogFrameView';
import type { AuthoredPose, DialogPresentation } from './DialogShellView.types';

const { ccclass, property, executeInEditMode } = _decorator;

/** Complete Editor-authored modal chrome. Runtime binds content and responsive geometry only. */
@ccclass('DialogShellView')
@executeInEditMode
export class DialogShellView extends Component {
  @property(Node) card: Node = null!;
  @property(Node) body: Node = null!;
  @property(Sprite) window: Sprite = null!;
  @property(Sprite) factoryFrame: Sprite = null!;
  @property(Prefab) factoryDialogPrefab: Prefab = null!;
  @property(Sprite) livestockFrame: Sprite = null!;
  @property(Node) inset: Node = null!;
  @property(Label) title: Label = null!;
  @property(Node) closeButton: Node = null!;
  @property(Node) closeIcon: Node = null!;
  @property(Font) buildingTitleFont: Font = null!;
  @property marginX = 56;
  @property marginY = 64;
  @property buildingMaxWidth = 1080;
  @property buildingMaxHeight = 1000;

  private authored = new Map<Node, AuthoredPose>();
  private titleSize = 36;
  private titleLineHeight = 43;
  private titleFont: Font | null = null;
  private windowFrame: SpriteFrame | null = null;
  private factoryInstance: FactoryDialogFrameView | null = null;

  onEnable(): void {
    this.paintShield();
    this.node.on(Node.EventType.SIZE_CHANGED, this.paintShield, this);
  }
  onDisable(): void {
    this.node.off(Node.EventType.SIZE_CHANGED, this.paintShield, this);
  }

  private paintShield(): void {
    const graphics = this.node.getComponent(Graphics),
      size = this.node.getComponent(UITransform);
    if (!graphics || !size) return;
    graphics.clear();
    graphics.rect(-size.width / 2, -size.height / 2, size.width, size.height);
    graphics.fill();
  }

  private capture(): void {
    if (this.authored.size) return;
    for (const node of [
      this.card,
      this.body,
      this.factoryFrame.node,
      this.livestockFrame.node,
      this.inset,
      this.title.node,
      this.closeButton,
      this.closeIcon,
    ]) {
      const size = node.getComponent(UITransform)!;
      this.authored.set(node, {
        x: node.position.x,
        y: node.position.y,
        width: size.width,
        height: size.height,
        scaleX: node.scale.x,
        scaleY: node.scale.y,
      });
    }
    this.titleSize = this.title.fontSize;
    this.titleLineHeight = this.title.lineHeight;
    this.titleFont = this.title.font;
    this.windowFrame = this.window.spriteFrame;
  }

  get authoredWidth(): number {
    this.capture();
    return this.authored.get(this.card)!.width;
  }
  get authoredHeight(): number {
    this.capture();
    return this.authored.get(this.card)!.height;
  }
  get factoryDialogView(): FactoryDialogFrameView {
    if (!this.factoryInstance) {
      const node = instantiate(this.factoryDialogPrefab);
      this.card.addChild(node);
      node.setSiblingIndex(0);
      this.factoryInstance = node.getComponent(FactoryDialogFrameView)!;
    }
    return this.factoryInstance;
  }
  get activeCloseButton(): Node {
    return this.factoryInstance?.node.active ? this.factoryInstance.closeButton : this.closeButton;
  }

  present(options: DialogPresentation): void {
    this.capture();
    const { width: w, height: h, unit, header, kind } = options;
    const responsive = !!header,
      factory = kind === 'factory';
    const size = (node: Node, width: number, height: number) =>
      node.getComponent(UITransform)!.setContentSize(width, height);
    size(this.node, options.screenWidth, options.screenHeight);
    this.paintShield();
    size(this.card, w, h);
    size(this.body, w, h);
    const originalCard = this.authored.get(this.card)!;
    this.card.setScale(options.scale * originalCard.scaleX, options.scale * originalCard.scaleY, 1);
    this.window.enabled = !responsive;
    this.window.spriteFrame = kind === 'building' ? this.factoryFrame.spriteFrame : this.windowFrame;
    this.factoryFrame.node.active = false;
    this.livestockFrame.node.active = kind === 'livestock';
    if (this.factoryInstance) this.factoryInstance.node.active = factory;
    this.title.node.active = !factory;
    this.closeButton.active = !factory;
    if (factory) {
      this.inset.active = false;
      this.factoryDialogView.present(w, h, unit, options.title);
      return;
    }
    if (responsive) {
      const background = factory ? this.factoryFrame.node : this.livestockFrame.node,
        original = this.authored.get(background)!;
      const scale = header.scale * unit;
      size(background, w / scale, h / scale);
      background.setScale(scale * original.scaleX, scale * original.scaleY, 1);
    }
    this.inset.active = kind === 'window';
    const inset = this.authored.get(this.inset)!;
    size(this.inset, w - 34 + inset.width - 966, h - 110 + inset.height - 790);
    const title = this.authored.get(this.title.node)!;
    const headingY = h / 2 - (header ? header.titleTop * unit : 48);
    this.title.node.setPosition(title.x, headingY + title.y - 402);
    size(
      this.title.node,
      w - (responsive ? (factory ? 184 : 120) * unit : 220) + title.width - 780,
      ((header ? header.titleHeight * unit : 62) * title.height) / 62
    );
    this.title.string = options.title;
    this.title.fontSize = header ? (header.fontSize * unit * this.titleSize) / 36 : this.titleSize;
    this.title.lineHeight = header ? (this.title.fontSize * 1.1 * this.titleLineHeight) / 43 : this.titleLineHeight;
    this.title.font = responsive ? this.buildingTitleFont : this.titleFont;
    const close = this.authored.get(this.closeButton)!,
      icon = this.authored.get(this.closeIcon)!;
    // Keep the close hit area inside the responsive dialog, including authored position adjustments.
    const closeX = header ? Math.min(header.closeX * unit + close.x - 464, w / 2 - 22 * unit) : w / 2 - 36;
    const authoredCloseY = (header ? h / 2 - header.closeTop * unit : headingY) + close.y - 402;
    // The livestock list starts immediately below the title; keep X in the title band.
    const closeY =
      kind === 'livestock' ? Math.max(h / 2 - 26 * unit, Math.min(h / 2 - 22 * unit, authoredCloseY)) : authoredCloseY;
    this.closeButton.setPosition(closeX, closeY);
    // Keep the hit target above the dialog body and header artwork.
    this.closeButton.setSiblingIndex(this.closeButton.parent!.children.length - 1);
    size(
      this.closeButton,
      ((responsive ? 44 * unit : 88) * close.width) / 88,
      ((responsive ? 44 * unit : 88) * close.height) / 88
    );
    size(
      this.closeIcon,
      ((header ? header.closeWidth * unit : 70) * icon.width) / 70,
      ((header ? header.closeHeight * unit : 67) * icon.height) / 67
    );
  }
}
