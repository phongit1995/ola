import type { PlotBubbleKind } from './PlotBubbleView.types';
import { _decorator, Component, Label, Node, Sprite, UITransform } from 'cc';
import { Art } from '../../render/Art';
import { FarmGame } from '../../core/FarmGame';
import type { Plot } from '../../core/types/PlotTypes';
import type { BubbleActions } from './PlotBubbles.types';
import { seedIcon } from '../../render/Icons';
import { Ui } from '../../render/Ui';

const { ccclass, property } = _decorator;

/** Three complete authored states; binding changes content and actions, leaving the artwork editable. */
@ccclass('PlotBubbleView')
export class PlotBubbleView extends Component {
  @property(Node) locked: Node = null!;
  @property(Node) ready: Node = null!;
  @property(Node) growing: Node = null!;
  @property(Node) unlockButton: Node = null!;
  @property(Node) harvestButton: Node = null!;
  @property(Node) finishButton: Node = null!;
  @property(Node) cancelButton: Node = null!;
  @property(Sprite) cropIcon: Sprite = null!;
  @property(Label) amount: Label = null!;
  @property(Label) cropName: Label = null!;
  @property(Label) time: Label = null!;
  @property(Label) price: Label = null!;

  bind(ui: Ui, art: Art, game: FarmGame, plot: Plot, kind: PlotBubbleKind, actions: BubbleActions): void {
    this.locked.active = kind === 'locked';
    this.ready.active = kind === 'ready';
    this.growing.active = kind === 'growing';
    if (kind === 'locked') ui.bindButton(this.unlockButton, `unlock-${plot.id}`, () => actions.unlock(plot.id));
    else if (kind === 'ready') {
      const item = plot.crop === null ? null : game.farm(plot.crop);
      this.cropIcon.node.active = !!item;
      if (item) {
        const frame = art.frame(seedIcon(art, item)),
          t = this.cropIcon.node.getComponent(UITransform)!;
        const fit = Math.min(t.width / frame.width, t.height / frame.height);
        this.cropIcon.spriteFrame = frame;
        t.setContentSize(frame.width * fit, frame.height * fit);
      }
      const quantity = plot.snapshot?.output.quantity ?? 0;
      this.amount.string = 'x' + quantity;
      this.amount.node.active = quantity > 1;
      ui.bindButton(this.harvestButton, `harvest-${plot.id}`, () => actions.harvest(plot.id));
    } else {
      this.cropName.string = plot.crop === null ? '' : (game.farm(plot.crop)?.name ?? '');
      ui.bindButton(
        this.finishButton,
        `finish-${plot.id}`,
        () => actions.finish(plot.id),
        game.state.diamonds >= game.boostPrice(plot)
      );
      ui.bindButton(this.cancelButton, `cancel-${plot.id}`, () => actions.cancel(plot.id));
    }
  }
}
