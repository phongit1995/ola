import { _decorator, Button, Component, Graphics, Label, Node, Sprite, UITransform, Vec3 } from 'cc';
import { orderedCrops } from '../../core/FarmGame';
import { formatWallet } from '../../core/Format';
import type { AppFacade } from '../shared/AppFacade.types';
import { t } from '../../core/i18n/I18n';

const { ccclass, property, executeInEditMode } = _decorator;

/** The complete land dialog is authored here; binding changes text/state and scales the card as a whole. */
@ccclass('LandPurchaseView')
@executeInEditMode
export class LandPurchaseView extends Component {
  @property(Node) card: Node = null!;
  @property(Label) title: Label = null!;
  @property(Label) ownership: Label = null!;
  @property(Label) offer: Label = null!;
  @property(Label) requirement: Label = null!;
  @property(Label) wallet: Label = null!;
  @property(Node) lock: Node = null!;
  @property(Node) coin: Node = null!;
  @property(Node) buyButton: Node = null!;
  @property(Sprite) buyFace: Sprite = null!;
  @property(Label) buyTitle: Label = null!;
  @property(Node) closeButton: Node = null!;
  @property(Node) laterButton: Node = null!;
  @property({ tooltip: 'Maximum card width in screen pixels.' }) maxScreenWidth = 380;
  @property({ tooltip: 'Space kept between the card and screen edge, in screen pixels.' }) screenMargin = 16;

  private authoredScale: Vec3 | null = null;

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

  present(app: AppFacade, id: number, screenWidth: number, screenHeight: number): void {
    this.authoredScale ??= this.card.scale.clone();
    const bounds = this.card.getComponent(UITransform)!,
      margin = Math.max(0, this.screenMargin),
      fit = Math.min(
        this.maxScreenWidth / (bounds.width * this.authoredScale.x),
        (screenWidth - margin * 2) / (bounds.width * this.authoredScale.x),
        (screenHeight - margin * 2) / (bounds.height * this.authoredScale.y)
      ),
      unit = app.width / Math.max(1, screenWidth);
    this.node.getComponent(UITransform)!.setContentSize(app.width, app.height);
    this.card.setScale(this.authoredScale.x * fit * unit, this.authoredScale.y * fit * unit, 1);
    this.paintShield();

    const game = app.game,
      fields = orderedCrops(game.state.plots),
      field = game.fieldUnlockOffer(id),
      belowLevel = game.progress.level < field.requiredLevel,
      available = field.unlocked && field.price !== null,
      affordable = available && game.state.coins >= field.price!,
      canBuy = app.session.canAct && affordable;
    // Fixed wording authored in the prefab, rewritten for the player's language.
    for (const [label, key] of [
      [this.card.getChildByName('Eyebrow'), 'land.eyebrow'],
      [this.card.getChildByName('Benefit'), 'land.benefit'],
      [this.laterButton.getChildByName('Title'), 'land.later'],
    ] as const)
      label!.getComponent(Label)!.string = t(key);
    this.title.string = t('land.title', { number: fields.findIndex(plot => plot.id === id) + 1 });
    this.ownership.string = t('land.ownership', {
      open: fields.filter(plot => plot.unlocked).length,
      total: fields.length,
    });
    this.lock.active = !available;
    this.coin.active = available;
    this.offer.string = available
      ? t('common.coins', { coins: formatWallet(field.price!) })
      : belowLevel
        ? t('common.needLevel', { level: field.requiredLevel })
        : field.reason;
    this.requirement.string = belowLevel
      ? t('land.yourLevel', { level: game.progress.level })
      : available
        ? t('land.moreLand')
        : t('land.inOrder');
    this.wallet.string = app.session.storageFailed
      ? t('land.saveFailed')
      : !app.session.canAct
        ? app.session.blockedMessage.replace(/\.$/, '')
        : available && !affordable
          ? t('land.missingCoins', { coins: formatWallet(field.price! - game.state.coins) })
          : t('land.balance', { coins: formatWallet(game.state.coins) });
    this.buyTitle.string = belowLevel
      ? t('land.reachLevel', { level: field.requiredLevel })
      : !available
        ? t('land.cannotBuy')
        : !affordable
          ? t('land.notEnoughCoins')
          : t('land.buy');
    this.buyFace.grayscale = !canBuy;
    const bind = (node: Node, key: string, callback: () => void, enabled = true): void => {
      node.off(Button.EventType.CLICK);
      app.ui.bindButton(node, key, callback, enabled);
    };
    bind(this.buyButton, 'confirm', () => app.act({ type: 'improve', plot: id }, 'Click 1', () => app.close()), canBuy);
    bind(this.closeButton, 'close-panel', () => app.close());
    bind(this.laterButton, 'cancel-confirm', () => app.close());
  }
}
