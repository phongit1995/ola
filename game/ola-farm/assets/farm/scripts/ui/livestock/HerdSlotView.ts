import { _decorator, Label, Node, Sprite } from 'cc';
import { AuthoredUiView } from '../shared/AuthoredUiView';

const { ccclass, property } = _decorator;

/** One complete paid/locked resident slot. The card and its action remain authored across state changes. */
@ccclass('HerdSlotView')
export class HerdSlotView extends AuthoredUiView {
  @property(Sprite) face: Sprite = null!;
  @property(Label) number: Label = null!;
  @property(Label) status: Label = null!;
  @property(Node) portrait: Node = null!;
  @property(Node) lock: Node = null!;
  @property(Label) empty: Label = null!;
  @property(Sprite) product: Sprite = null!;
  @property(Node) actionButton: Node = null!;
  @property(Node) clockIcon: Node = null!;
  @property(Node) boostIcon: Node = null!;
  @property(Node) purchaseIcon: Node = null!;

  setState(locked: boolean, occupied: boolean, ready: boolean, working = false): void {
    this.lock.active = locked;
    this.empty.node.active = !locked && !occupied;
    this.portrait.active = occupied;
    this.product.node.active = occupied && ready;
    this.clockIcon.active = this.boostIcon.active = occupied && working;
    this.purchaseIcon.active = locked;
  }
}
