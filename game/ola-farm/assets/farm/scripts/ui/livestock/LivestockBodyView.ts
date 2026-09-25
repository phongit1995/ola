import { _decorator, Node, ScrollView } from 'cc';
import { AuthoredUiView } from '../shared/AuthoredUiView';

const { ccclass, property } = _decorator;

/** A single pen: feed stock, horizontal resident row, care actions and unopened-yard preview. */
@ccclass('LivestockBodyView')
export class LivestockBodyView extends AuthoredUiView {
  @property(Node) owned: Node = null!;
  @property(Node) unopened: Node = null!;
  @property(ScrollView) scroll: ScrollView = null!;
  @property(Node) careActions: Node = null!;

  resizeScroll(y: number, width: number, height: number, contentWidth: number, unit: number): void {
    this.place(this.scroll.node, 0, y, width, height, unit);
    const content = this.scroll.content!;
    this.place(content.parent!, 0, 0, width, height, unit);
    this.place(content, -width / 2, height / 2, contentWidth, height, unit);
  }
}
