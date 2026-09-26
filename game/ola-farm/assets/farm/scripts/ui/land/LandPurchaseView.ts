import { _decorator, Button, Component, Graphics, Label, Node, Sprite, UITransform, Vec3 } from 'cc';
import { orderedCrops } from '../../core/FarmGame';
import { formatWallet } from '../../core/Format';
import type { AppFacade } from '../shared/AppFacade.types';

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
    this.title.string = `Mua ô đất #${fields.findIndex(plot => plot.id === id) + 1}`;
    this.ownership.string = `${fields.filter(plot => plot.unlocked).length} / ${fields.length} ô đã mở`;
    this.lock.active = !available;
    this.coin.active = available;
    this.offer.string = available
      ? `${formatWallet(field.price!)} xu`
      : belowLevel
        ? `Cần level ${field.requiredLevel}`
        : field.reason;
    this.requirement.string = belowLevel
      ? `Bạn đang ở level ${game.progress.level}`
      : available
        ? 'Thêm đất, trồng thêm cây!'
        : 'Mở lần lượt từng ô đất';
    this.wallet.string = app.session.storageFailed
      ? 'Chưa lưu được. Hãy thử lưu lại.'
      : !app.session.canAct
        ? app.session.blockedMessage.replace(/\.$/, '')
        : available && !affordable
          ? `Còn thiếu ${formatWallet(field.price! - game.state.coins)} xu`
          : `Số dư: ${formatWallet(game.state.coins)} xu`;
    this.buyTitle.string = belowLevel
      ? `Đạt level ${field.requiredLevel} để mở`
      : !available
        ? 'Chưa thể mua'
        : !affordable
          ? 'Chưa đủ xu'
          : 'Mua ô đất';
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
