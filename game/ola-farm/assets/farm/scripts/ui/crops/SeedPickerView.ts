import { _decorator, Graphics, Label, Node, Prefab, ScrollView } from 'cc';
import { AuthoredUiView } from '../shared/AuthoredUiView';

const { ccclass, property } = _decorator;

/** Complete contextual seed strip and long-press detail card; all artwork is linked in the prefab. */
@ccclass('SeedPickerView')
export class SeedPickerView extends AuthoredUiView {
  @property(Prefab) tilePrefab: Prefab = null!;
  @property(Node) info: Node = null!;
  @property(Label) seedName: Label = null!;
  @property(Label) seedTime: Label = null!;
  @property(ScrollView) scroll: ScrollView = null!;
  @property(Node) selection: Node = null!;
  @property(Node) residentAction: Node = null!;
  @property(Node) rescueAction: Node = null!;
  @property tileSpacing = 146;

  resize(width: number, height: number, seeds: number): void {
    this.place(this.node, 0, 0, width, height);
    this.place(this.scroll.node, 0, -12, width, 141);
    this.place(this.scroll.content!.parent!, 0, 0, width, 141);
    this.place(this.scroll.content!, -width / 2, 0, Math.max(width, seeds * this.tileSpacing), 141);
    for (const action of [this.residentAction, this.rescueAction]) {
      const pose = this.original(action),
        graphics = action.getComponent(Graphics)!;
      graphics.clear();
      graphics.roundRect(-pose.rect.z / 2, -pose.rect.w / 2, pose.rect.z, pose.rect.w, 15);
      graphics.fill();
    }
  }
}
