import { penDefinition } from '../../core/FarmCatalog';
import { _decorator, Color, Component, Label, Node, Sprite, UITransform } from 'cc';
import { Art } from '../../render/Art';
import { FarmGame } from '../../core/FarmGame';
import type { Plot } from '../../core/types/PlotTypes';
import type { HerdBarActions } from './LivestockQuickBar.types';
import { Ui } from '../../render/Ui';
import { PANEL_BROWN as DEFAULT_TITLE, PANEL_MUTED as DEFAULT_DETAIL } from '../shared/PanelPalette.constants';

const { ccclass, property } = _decorator;

/** A complete care bar. Layout adapts the authored rectangles; content never rebuilds its static children. */
@ccclass('HerdQuickBarView')
export class HerdQuickBarView extends Component {
  @property(Sprite) frame: Sprite = null!;
  @property(Label) summary: Label = null!;
  @property(Label) count: Label = null!;
  @property(Label) unlock: Label = null!;
  @property(Node) feedStock: Node = null!;
  @property(Sprite) feedIcon: Sprite = null!;
  @property(Label) feedQuantity: Label = null!;
  @property(Node) ownedActions: Node = null!;
  @property(Node) buildActions: Node = null!;
  @property([Node]) buttons: Node[] = [];
  @property([Label]) titles: Label[] = [];
  @property([Label]) details: Label[] = [];
  @property([Sprite]) faces: Sprite[] = [];
  @property([Sprite]) activeFaces: Sprite[] = [];
  @property(Color) disabledColor = new Color(154, 112, 76);
  @property(Color) activeColor = Color.WHITE.clone();

  bind(ui: Ui, art: Art, game: FarmGame, plot: Plot, width: number, unit: number, actions: HerdBarActions): void {
    const root = this.node.getComponent(UITransform)!,
      delta = width - root.width;
    const move = (node: Node, dx: number) => node.setPosition(node.position.x + dx, node.position.y);
    const widen = (node: Node, dw: number) => {
      node.getComponent(UITransform)!.width += dw;
    };
    root.width = width;
    widen(this.frame.node, delta / this.frame.node.scale.x);
    const pen = plot.residents,
      spec = penDefinition(game.catalog, plot);
    const species = game.catalog.livestock?.find(s => s.key === spec?.species);
    const hungry = pen?.animals.filter(a => !a.job).length ?? 0;
    const feedNeeded = hungry * (species ? game.feedPerAnimal(species.key) : 1);
    const ready = pen?.animals.filter(a => a.job && a.job.ready <= game.state.time).length ?? 0;
    const feed = species ? game.quantity(species.feed) : 0,
      status = game.penUnlockStatus(plot.id);
    this.summary.string =
      (
        { layer: 'Chuồng gà', 'dairy-cow': 'Chuồng bò', pig: 'Chuồng heo', sheep: 'Chuồng cừu' } as Record<
          string,
          string
        >
      )[species?.key ?? ''] ?? 'Chuồng vật nuôi';
    widen(this.summary.node, delta + (pen ? 0 : 114));
    if (!pen) move(this.summary.node, 57);
    widen(this.count.node, delta);
    widen(this.unlock.node, delta);
    move(this.feedStock, delta / 2);
    // The quick bar focuses on feeding and collecting; capacity/slot progress is shown in herd management.
    // Keep the count label hidden so the bar does not display strings such as "4/5 ô đã mở".
    this.count.node.active = false;
    this.feedStock.active = this.ownedActions.active = !!pen;
    this.unlock.node.active = this.buildActions.active = !pen;
    if (pen) {
      const state = !pen.animals.length
        ? 'Chuồng trống'
        : ready
          ? `${ready} sẵn thu`
          : hungry
            ? `${hungry} chờ ăn`
            : 'Đang nuôi';
      this.count.string = `${pen.animals.length}/${pen.capacity} con · ${state}`;
      this.feedQuantity.string = String(feed);
      const item = species ? game.item(species.feed) : undefined;
      this.feedIcon.node.active = !!item;
      if (item) {
        const frame = art.frame(`assets/sprites/${item.image}.png`),
          t = this.feedIcon.node.getComponent(UITransform)!;
        const fit = Math.min(t.width / frame.width, t.height / frame.height);
        this.feedIcon.spriteFrame = frame;
        t.setContentSize(frame.width * fit, frame.height * fit);
      }
    } else this.unlock.string = status.reason || `Mở chuồng kèm ${species ? game.startingAnimals(species.key) : 1} con`;
    this.details[0].string = `${hungry} con · ${feedNeeded} cám`;
    this.details[1].string = `${ready} con sẵn thu`;
    const price = game.penPurchasePrice(plot.id);
    this.details[3].string = `${price ?? 0} xu`;
    const enabled = [
      actions.enabled && hungry > 0 && feed >= feedNeeded,
      actions.enabled && ready > 0,
      true,
      actions.enabled && status.unlocked && game.animalPurchasingReady && price !== null && game.state.coins >= price,
      true,
    ];
    const ids = ['herd-feed', 'herd-collect', 'herd-manage', 'herd-build', 'herd-manage'];
    const handlers = [actions.feed, actions.collect, actions.manage, actions.buy, actions.manage];
    for (let i = 0; i < this.buttons.length; i++) {
      const dw = delta / (i < 3 ? 3 : 2),
        dx = i < 3 ? (i - 1) * dw : ((i === 3 ? -1 : 1) * dw) / 2;
      const node = this.buttons[i];
      widen(node, dw);
      move(node, dx);
      widen(this.titles[i].node, dw);
      widen(this.details[i].node, dw);
      for (const face of [this.faces[i], this.activeFaces[i]]) widen(face.node, dw / face.node.scale.x);
      const primary = enabled[i] && [0, 1, 3].includes(i);
      this.activeFaces[i].node.active = primary;
      this.faces[i].node.active = !primary;
      // State colors apply to the default palette; an explicit Inspector text color stays intact.
      if (primary) {
        if (this.titles[i].color.equals(DEFAULT_TITLE)) this.titles[i].color = this.activeColor;
        if (this.details[i].color.equals(DEFAULT_DETAIL)) this.details[i].color = this.activeColor;
      } else if (!enabled[i] && this.titles[i].color.equals(DEFAULT_TITLE)) this.titles[i].color = this.disabledColor;
      if (i < 3 === !!pen) ui.bindButton(node, ids[i], handlers[i], enabled[i]);
    }
    // Keep the old design-space hit areas and scaled nine-slice corners at every screen density.
    const skins = new Set([this.frame, ...this.faces, ...this.activeFaces].map(s => s.node));
    for (const sprite of this.feedStock.getComponentsInChildren(Sprite))
      if (sprite !== this.feedIcon) skins.add(sprite.node);
    const scale = (node: Node): void => {
      if (node !== this.node) node.setPosition(node.position.x * unit, node.position.y * unit);
      const t = node.getComponent(UITransform);
      if (skins.has(node)) node.setScale(node.scale.x * unit, node.scale.y * unit, node.scale.z);
      else if (t) t.setContentSize(t.width * unit, t.height * unit);
      const label = node.getComponent(Label);
      if (label) {
        const ratio = label.lineHeight / label.fontSize;
        label.fontSize = Math.ceil(label.fontSize * unit);
        label.lineHeight = label.fontSize * ratio;
      }
      for (const child of node.children) scale(child);
    };
    scale(this.node);
  }
}
