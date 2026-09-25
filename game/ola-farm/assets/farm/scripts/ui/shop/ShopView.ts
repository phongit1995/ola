import {
  _decorator,
  Button,
  Component,
  Graphics,
  instantiate,
  Label,
  Node,
  Prefab,
  ScrollView,
  UITransform,
  Vec2,
  view,
} from 'cc';
import type { PanelContext } from '../shared/PanelContext.types';
import { ShopCardView } from './ShopCardView';
import { productionReturnLabel, returnToProduction } from '../production/ProductionNavigation';
import type { ShopEntry, AuthoredNode } from './ShopView.types';

const { ccclass, property, executeInEditMode } = _decorator;

/** Linked Editor nodes form the shop. Runtime only binds data and adapts the saved layout to the viewport. */
@ccclass('ShopView')
@executeInEditMode
export class ShopView extends Component {
  @property(Prefab) cardPrefab: Prefab = null!;
  @property(Node) drawer: Node = null!;
  @property(Node) rim: Node = null!;
  @property(Node) animalTab: Node = null!;
  @property(Node) buildingTab: Node = null!;
  @property(Node) dismiss: Node = null!;
  @property(Node) productionReturn: Node = null!;
  @property(Node) empty: Node = null!;
  @property(ScrollView) scroll: ScrollView = null!;
  @property cardGap = 22.5;
  @property cardPadding = 22.5;
  @property bottomPadding = 13.335;
  @property headerHeight = 142.5;
  @property portraitCardWidth = 128;
  @property portraitCardHeight = 190;
  @property portraitHeaderHeight = 60;
  @property compactCardWidth = 120;
  @property compactCardHeight = 145;
  @property compactHeaderHeight = 52;

  private authored = new Map<Node, AuthoredNode>();
  private labelSizes = new Map<Label, number>();
  private dynamicCards: Node[] = [];
  private sourceBodyTop = 0;

  onEnable(): void {
    this.paintDrawer();
    this.drawer?.on(Node.EventType.SIZE_CHANGED, this.paintDrawer, this);
  }
  onDisable(): void {
    this.drawer?.off(Node.EventType.SIZE_CHANGED, this.paintDrawer, this);
  }

  private paintDrawer(): void {
    const graphics = this.drawer?.getComponent(Graphics),
      t = this.drawer?.getComponent(UITransform);
    if (!graphics || !t) return;
    graphics.clear();
    graphics.rect(-t.width / 2, -t.height / 2, t.width, t.height);
    graphics.fill();
  }

  private original(node: Node): AuthoredNode {
    let value = this.authored.get(node);
    if (!value) {
      const t = node.getComponent(UITransform)!;
      value = {
        x: node.position.x,
        y: node.position.y,
        width: t.width,
        height: t.height,
        scaleX: node.scale.x,
        scaleY: node.scale.y,
      };
      this.authored.set(node, value);
    }
    return value;
  }

  render(ctx: PanelContext, entries: ShopEntry[]): void {
    if (!this.cardPrefab || !this.scroll?.content) throw Error('Shop prefab chưa liên kết đủ ShopCard và ScrollView.');
    const { width: w, height: h, app, state, ui } = ctx,
      frame = view.getFrameSize();
    const cssRatio = app.width / Math.max(1, frame.width),
      portrait = h > w,
      compact = !portrait && frame.height < 500;
    if (!this.authored.size) {
      this.sourceBodyTop = this.drawer.position.y + this.drawer.getComponent(UITransform)!.height / 2;
      for (const node of this.node.getComponentsInChildren(UITransform).map(t => t.node)) this.original(node);
      for (const label of this.node.getComponentsInChildren(Label)) this.labelSizes.set(label, label.fontSize);
    }
    const source = (this.cardPrefab.data as Node).getComponent(UITransform)!;
    const scale = portrait
      ? (this.portraitCardWidth * cssRatio) / source.width
      : compact
        ? (this.compactCardWidth * cssRatio) / source.width
        : h / 1080;
    const cardWidth = source.width * scale,
      cardHeight = portrait
        ? this.portraitCardHeight * cssRatio
        : compact
          ? this.compactCardHeight * cssRatio
          : source.height * scale;
    const bodyHeight = cardHeight + this.bottomPadding * scale,
      bodyTop = -h / 2 + bodyHeight;
    const headerScale = portrait
      ? (this.portraitHeaderHeight * cssRatio) / this.headerHeight
      : compact
        ? (this.compactHeaderHeight * cssRatio) / this.headerHeight
        : scale;
    const headerHeight = this.headerHeight * headerScale,
      headerTop = bodyTop + headerHeight,
      touch = 44 * cssRatio;
    const size = (node: Node, width: number, height: number) =>
      node.getComponent(UITransform)!.setContentSize(width, height);
    size(this.node, w, h);
    size(this.drawer, w, bodyHeight);
    this.drawer.setPosition(0, -h / 2 + bodyHeight / 2);
    this.paintDrawer();
    this.rim.setPosition(0, bodyTop + (this.original(this.rim).y - this.sourceBodyTop) * headerScale);
    size(this.rim, w, this.original(this.rim).height * headerScale);

    const tabSource = this.original(this.animalTab),
      tabWidth = Math.max(touch, tabSource.width * headerScale);
    const gap = -4.5 * headerScale,
      left = Math.min(112.5 * headerScale, (w - tabWidth * 2 - gap) / 2);
    for (const [i, tab, key] of [
      [0, this.animalTab, 'animals'],
      [1, this.buildingTab, 'buildings'],
    ] as const) {
      const x = -w / 2 + left + tabWidth / 2 + i * (tabWidth + gap);
      tab.setScale(headerScale, headerScale, 1);
      tab.setPosition(x, bodyTop + headerHeight / 2);
      size(tab, Math.max(touch, tabWidth - 9 * headerScale) / headerScale, Math.max(touch, headerHeight) / headerScale);
      for (const label of tab.getComponentsInChildren(Label)) {
        label.fontSize = Math.max(this.labelSizes.get(label)!, (12 * cssRatio) / headerScale);
        label.lineHeight = label.fontSize * 1.08;
        const t = label.node.getComponent(UITransform)!,
          original = this.original(label.node);
        t.height = Math.max(original.height, (16 * cssRatio) / headerScale);
        label.node.setPosition(
          original.x,
          Math.max(original.y, -this.headerHeight / 2 + t.height / 2 + (2 * cssRatio) / headerScale)
        );
      }
      const prefix = key === 'animals' ? 'Animal' : 'Building';
      for (const selected of [false, true]) {
        const background = this.node.getChildByName(prefix + (selected ? 'Selected' : 'Inactive'))!;
        const original = this.original(background);
        background.active = selected === (state.shopTab === key);
        background.setScale(headerScale, headerScale, 1);
        background.setPosition(
          x + (original.x - this.original(tab).x) * headerScale,
          bodyTop + (original.y - this.sourceBodyTop) * headerScale
        );
      }
      const icon = tab.getChildByName('CategoryIcon')!,
        authoredIcon = this.original(icon);
      const factor = state.shopTab === key ? 1 : 0.74;
      const authoredStateScale = key === 'animals' ? 1 : 0.74;
      icon.setScale(
        (authoredIcon.scaleX / authoredStateScale) * factor,
        (authoredIcon.scaleY / authoredStateScale) * factor,
        1
      );
      icon.setPosition(authoredIcon.x, authoredIcon.y + authoredIcon.height * 0.25 * (factor - authoredStateScale));
      tab.off(Button.EventType.CLICK);
      ui.bindButton(tab, 'shop-tab-' + key, () => {
        this.scroll.scrollToOffset(new Vec2(), 0);
        state.shopTab = key;
        ctx.render();
      });
    }
    size(this.dismiss, w, Math.max(1, h / 2 - headerTop));
    this.dismiss.setPosition(0, (h / 2 + headerTop) / 2);
    this.dismiss.off(Button.EventType.CLICK);
    ui.bindButton(this.dismiss, 'shop-dismiss', () => app.close());

    const viewportHeight = bodyHeight,
      viewport = this.scroll.content.parent!;
    size(this.scroll.node, w, viewportHeight);
    this.scroll.node.setPosition(0, -h / 2 + viewportHeight / 2);
    size(viewport, w, viewportHeight);
    const contentWidth = Math.max(
      w,
      2 * this.cardPadding * scale + entries.length * cardWidth + Math.max(0, entries.length - 1) * this.cardGap * scale
    );
    size(this.scroll.content, contentWidth, viewportHeight);
    this.scroll.content.setPosition(-w / 2, viewportHeight / 2);
    for (const node of this.dynamicCards) {
      for (const [id, control] of ui.controls) if (control === node || control.isChildOf(node)) ui.controls.delete(id);
      node.removeFromParent();
      node.destroy();
    }
    this.dynamicCards = [];
    for (const child of this.scroll.content.children) if (child !== this.empty) child.active = false;
    entries.forEach((entry, i) => {
      const card = instantiate(this.cardPrefab);
      card.name = 'ShopCard';
      this.scroll.content!.addChild(card);
      this.dynamicCards.push(card);
      card.setPosition(
        this.cardPadding * scale + cardWidth / 2 + i * (cardWidth + this.cardGap * scale),
        -cardHeight / 2
      );
      card.getComponent(ShopCardView)!.render(ctx, entry, cardWidth, cardHeight, cssRatio);
    });
    this.empty.active = entries.length === 0;
    this.empty.setPosition(w / 2, -viewportHeight / 2);
    const emptyClose = this.empty.getChildByName('shop-all-built-close')!;
    size(emptyClose, Math.max(180 * scale, touch * 3), touch);
    emptyClose.setPosition(0, -touch / 2);
    const emptyLabel = this.empty.getChildByName('ShopEmpty')!;
    size(emptyLabel, w - 40, touch);
    emptyLabel.setPosition(0, touch);
    for (const label of this.empty.getComponentsInChildren(Label)) {
      label.fontSize = Math.max(12 * cssRatio, this.labelSizes.get(label)! * scale);
      label.lineHeight = label.fontSize * 1.08;
    }
    emptyClose.off(Button.EventType.CLICK);
    ui.bindButton(emptyClose, 'shop-all-built-close', () => app.close());
    ctx.adoptScroll(this.scroll);
    if (state.shopItemId) {
      const index = entries.findIndex(entry => entry.id === state.shopItemId);
      state.shopItemId = null;
      if (index >= 0)
        this.scroll.scrollToOffset(
          new Vec2(
            Math.max(0, this.cardPadding * scale + index * (cardWidth + this.cardGap * scale) - (w - cardWidth) / 2),
            0
          ),
          0
        );
    }
    this.productionReturn.active = state.recipeReturnMachineId >= 0;
    size(this.productionReturn, Math.min(w - 40, Math.max(touch * 4, 315 * scale)), touch);
    this.productionReturn.setPosition(0, headerTop + touch / 2 + 4 * cssRatio);
    const returnLabel = this.productionReturn.getComponentInChildren(Label)!;
    returnLabel.string = productionReturnLabel(ctx);
    returnLabel.fontSize = 12 * cssRatio;
    returnLabel.lineHeight = 14 * cssRatio;
    size(returnLabel.node, this.productionReturn.getComponent(UITransform)!.width - 20, touch - 6);
    this.productionReturn.off(Button.EventType.CLICK);
    ui.bindButton(this.productionReturn, 'shop-production-return', () => returnToProduction(ctx));
  }
}
