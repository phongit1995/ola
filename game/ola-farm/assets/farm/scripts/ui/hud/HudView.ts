import { _decorator, Component, Label, Node, Sprite, UITransform } from 'cc';
import { GameSession } from '../../core/GameSession';
import { format, formatWallet } from '../../core/Format';
import { Ui } from '../../render/Ui';
import type { HudActions } from './HudView.types';
import { COMPACT_WIDTH } from './HudView.constants';
import { t } from '../../core/i18n/I18n';

const { ccclass, property, executeInEditMode } = _decorator;

/**
 * Header after Golden Island's GameplayMainUI/PanelTop: avatar in its frame, the level star over the start of the XP
 * bar; coin box with its "+" top-up, gem box and the settings gear on the right; navigation bar at the bottom with the
 * hint strip above it. Everything is Widget-aligned to the root, so nothing is rebuilt on rotation.
 */
@ccclass('HudView')
@executeInEditMode
export class HudView extends Component {
  @property(Label) coins: Label = null!;
  @property(Label) diamonds: Label = null!;
  @property(Label) level: Label = null!;
  @property(Label) xp: Label = null!;
  /** Full-length XP fill sprite; its parent is the Mask clip whose width follows the level progress, like Unity's Slider. */
  @property(Sprite) xpFill: Sprite = null!;
  @property(Label) hint: Label = null!;
  @property(Label) stock: Label = null!;
  @property(Node) navigation: Node = null!;
  @property(Node) header: Node = null!;
  @property(Node) pauseButton: Node = null!;
  @property(Node) coinsPlusButton: Node = null!;
  @property(Node) gemsPlusButton: Node = null!;
  @property(Node) shopButton: Node = null!;
  @property(Node) inventoryButton: Node = null!;
  @property(Node) factoryButton: Node = null!;

  setup(ui: Ui, actions: HudActions): void {
    if (
      ![
        this.coins,
        this.diamonds,
        this.level,
        this.xp,
        this.xpFill,
        this.hint,
        this.stock,
        this.navigation,
        this.header,
        this.pauseButton,
        this.coinsPlusButton,
        this.gemsPlusButton,
        this.shopButton,
        this.inventoryButton,
        this.factoryButton,
      ].every(Boolean)
    )
      throw Error('HUD chưa liên kết đủ node trong scene.');
    ui.bindButton(this.pauseButton, 'pause-menu', actions.pause);
    ui.bindButton(this.coinsPlusButton, 'coins-plus', () => actions.open('coins'));
    ui.bindButton(this.gemsPlusButton, 'gems-plus', () => actions.open('gems'));
    ui.bindButton(this.shopButton, 'shop', () => actions.open('shop'));
    ui.bindButton(this.inventoryButton, 'inventory', () => actions.open('inventory'));
    ui.bindButton(this.factoryButton, 'factory', () => actions.open('factory'));
    // The prefab carries the Vietnamese titles; the stock button's title is rewritten on every refresh.
    for (const [button, key] of [
      [this.shopButton, 'hud.shop'],
      [this.factoryButton, 'hud.factory'],
    ] as const)
      button.getChildByName('Title')!.getComponent(Label)!.string = t(key);
    this.layout();
  }

  onEnable(): void {
    this.layout();
    this.header?.on(Node.EventType.SIZE_CHANGED, this.layout, this);
  }
  onDisable(): void {
    this.header?.off(Node.EventType.SIZE_CHANGED, this.layout, this);
  }

  /** Only the hint size depends on the header width; the wallets and the level group are Widget-anchored. */
  private layout(): void {
    if (!this.header || !this.hint) return;
    this.hint.fontSize = this.header.getComponent(UITransform)!.width < COMPACT_WIDTH ? 19 : 21;
  }

  refresh(session: GameSession): void {
    const s = session.game.state,
      p = session.game.progress;
    this.coins.string = formatWallet(s.coins);
    this.diamonds.string = formatWallet(s.diamonds);
    this.level.string = String(p.level);
    this.xp.string = `${p.current}/${p.need}`;
    this.fillXp(p.current / p.need);
    this.stock.string = t('hud.stock', { count: format(Object.values(s.inventory).reduce((n, v) => n + v, 0)) });
  }

  private fillXp(ratio: number): void {
    const clip = this.xpFill.node.parent,
      track = clip?.parent?.getComponent(UITransform),
      transform = clip?.getComponent(UITransform);
    if (!clip || !track || !transform) return;
    const visible = Math.max(0, Math.min(1, ratio)) * track.width;
    clip.active = visible >= 1;
    if (clip.active) transform.setContentSize(visible / clip.scale.x, transform.height);
  }

  setHint(text: string): void {
    this.hint.string = text;
  }
  setNavigationVisible(visible: boolean): void {
    this.navigation.active = visible;
  }
}
