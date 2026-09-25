import { _decorator, Component, instantiate, Label, Node, Sprite, UITransform, Vec3 } from 'cc';
import type { PanelContext } from '../shared/PanelContext.types';
import type { ShopEntry } from './ShopView.types';

const { ccclass, property } = _decorator;

/** An authored ShopCard. Its Inspector artwork and text styles are kept when data changes. */
@ccclass('ShopCardView')
export class ShopCardView extends Component {
  @property(Sprite) background: Sprite = null!;
  @property(Sprite) lockedBackground: Sprite = null!;
  @property(Label) title: Label = null!;
  @property(Label) quantity: Label = null!;
  @property(Node) model: Node = null!;
  @property(Label) description: Label = null!;
  @property(Node) priceButton: Node = null!;
  @property(Sprite) priceBackground: Sprite = null!;
  @property(Label) priceLabel: Label = null!;
  @property(Sprite) coin: Sprite = null!;
  @property(Node) lock: Node = null!;

  render(ctx: PanelContext, entry: ShopEntry, width: number, height: number, cssRatio: number): void {
    const root = this.node.getComponent(UITransform)!;
    const authoredWidth = root.width,
      authoredHeight = root.height;
    const scale = width / authoredWidth,
      cssUnit = cssRatio / scale,
      localHeight = height / scale;
    this.node.setScale(scale, scale, 1);
    root.setContentSize(authoredWidth, localHeight);
    // Scale the native nine-slice corners with the card instead of stretching the old large corners.
    for (const background of [this.background, this.lockedBackground]) {
      const node = background.node;
      node.getComponent(UITransform)!.setContentSize(authoredWidth / node.scale.x, localHeight / node.scale.y);
    }
    this.background.node.active = !entry.locked;
    this.lockedBackground.node.active = entry.locked;
    this.title.string = entry.name;
    this.quantity.string = entry.quantity;
    this.description.string = entry.description;
    this.description.node.active = entry.detail;
    this.priceLabel.string = entry.coinPrice === undefined ? entry.label : String(entry.coinPrice);
    this.lock.active = entry.locked;
    this.coin.node.active = entry.coinPrice !== undefined;

    // Resize only the responsive content areas. Label colors, fonts, sprites and authored x offsets stay editable.
    const compact = height / cssRatio < 170,
      portrait = ctx.height > ctx.width;
    const adaptive = compact || portrait;
    const label = (value: Label, minimumCss: number) => {
      value.fontSize = Math.max(value.fontSize, Math.ceil(minimumCss * cssUnit));
      value.lineHeight = Math.max(value.lineHeight, value.fontSize * 1.08);
    };
    label(this.title, 12);
    label(this.priceLabel, 11);
    label(this.description, 10);
    const titleTransform = this.title.node.getComponent(UITransform)!,
      authoredTitleHeight = titleTransform.height;
    titleTransform.height = Math.max(titleTransform.height, 16 * cssUnit);
    this.title.node.setPosition(
      this.title.node.position.x,
      this.title.node.position.y +
        (localHeight - authoredHeight) / 2 -
        (titleTransform.height - authoredTitleHeight) / 2
    );

    const price = this.priceButton.getComponent(UITransform)!,
      authoredPriceHeight = price.height;
    price.height = Math.max(price.height, 44 * cssUnit);
    const priceY = adaptive
      ? -localHeight / 2 + price.height / 2 + 6 * cssUnit
      : this.priceButton.position.y + (authoredHeight - localHeight) / 2 + (price.height - authoredPriceHeight) / 2;
    this.priceButton.setPosition(this.priceButton.position.x, priceY);
    // The cream strip has its own visual size; its invisible input area remains at least 44 CSS px.
    const face = this.priceBackground.node,
      faceTransform = face.getComponent(UITransform)!;
    const faceHeight = Math.max(faceTransform.height * face.scale.y, 32 * cssUnit);
    faceTransform.setContentSize(price.width / face.scale.x, faceHeight / face.scale.y);
    const priceText = this.priceLabel.node.getComponent(UITransform)!;
    priceText.width = price.width - 12 * cssUnit;
    priceText.height = price.height - 4 * cssUnit;
    const labelY = this.priceLabel.node.position.y;
    if (entry.coinPrice !== undefined) {
      const coinTransform = this.coin.node.getComponent(UITransform)!;
      const coinSize = Math.max(coinTransform.width, 16 * cssUnit),
        gap = 4 * cssUnit;
      coinTransform.setContentSize(coinSize, coinSize);
      const center = entry.locked ? 10 * cssUnit : 0;
      priceText.width = Math.min(
        priceText.width - coinSize - gap - 2 * center,
        Math.max(24 * cssUnit, this.priceLabel.string.length * this.priceLabel.fontSize * 0.7)
      );
      this.priceLabel.node.setPosition(center - (coinSize + gap) / 2, labelY);
      this.coin.node.setPosition(center + (priceText.width + gap) / 2, labelY);
    } else {
      this.priceLabel.node.setPosition(entry.locked ? 12 * cssUnit : 0, labelY);
      if (entry.locked) priceText.width -= 24 * cssUnit;
    }
    if (adaptive) {
      const descriptionTransform = this.description.node.getComponent(UITransform)!;
      const descriptionHeight = (36 * cssUnit * descriptionTransform.height) / 52;
      const descriptionY =
        priceY + price.height / 2 + 3 * cssUnit + descriptionHeight / 2 + this.description.node.position.y + 56;
      descriptionTransform.height = descriptionHeight;
      this.description.node.setPosition(this.description.node.position.x, descriptionY);
      const modelHeight =
        ((entry.detail ? (compact ? 24 : 64) : compact ? 66 : 94) *
          cssUnit *
          this.model.getComponent(UITransform)!.height) /
        130;
      const modelY =
        (entry.detail
          ? descriptionY + descriptionHeight / 2 + 3 * cssUnit + modelHeight / 2
          : priceY + price.height / 2 + 5 * cssUnit + modelHeight / 2) +
        this.model.position.y -
        27;
      this.model.getComponent(UITransform)!.height = modelHeight;
      this.model.setPosition(this.model.position.x, modelY);
      const quantity = this.quantity.node.parent!;
      quantity.setPosition(
        quantity.position.x,
        this.title.node.position.y - titleTransform.height / 2 - 8 * cssUnit + quantity.position.y - 98
      );
    } else if (localHeight !== authoredHeight) {
      for (const n of [this.model, this.description.node])
        n.setPosition(n.position.x, (n.position.y * localHeight) / authoredHeight);
    }

    // Keep the nested Editor preview in the prefab; only the current catalog model is dynamic.
    for (const child of this.model.children) child.active = false;
    const source = entry.prefab && ctx.art.prefabs.get(entry.prefab);
    if (source) {
      const model = instantiate(source);
      model.name = 'RuntimeModel';
      this.model.addChild(model);
      const boxes = model
        .getComponentsInChildren(Sprite)
        .filter(s => s.node.activeInHierarchy && s.spriteFrame)
        .map(s => s.node.getComponent(UITransform)!.getBoundingBoxToWorld());
      if (boxes.length) {
        const left = Math.min(...boxes.map(b => b.xMin)),
          right = Math.max(...boxes.map(b => b.xMax));
        const bottom = Math.min(...boxes.map(b => b.yMin)),
          top = Math.max(...boxes.map(b => b.yMax));
        const t = this.model.getComponent(UITransform)!,
          world = this.model.worldScale;
        const fit = Math.min((t.width * world.x) / (right - left), (t.height * world.y) / (top - bottom));
        const center = t.convertToNodeSpaceAR(new Vec3((left + right) / 2, (bottom + top) / 2));
        if (Number.isFinite(fit) && fit > 0) {
          model.setScale(fit, fit, 1);
          model.setPosition(-center.x * fit, -center.y * fit);
        }
      }
    }
    ctx.ui.bindButton(this.priceButton, entry.id, entry.buy, entry.enabled);
  }
}
