import { _decorator, Component, Label, Node, Sprite, UITransform, Vec3, Widget } from 'cc';

const { ccclass, property } = _decorator;

/** Original UI artwork, authored entirely in the prefab. Widgets own its responsive placement. */
@ccclass('FactoryDialogFrameView')
export class FactoryDialogFrameView extends Component {
  @property(Sprite) background: Sprite = null!;
  @property(Sprite) closeFace: Sprite = null!;
  @property(Label) title: Label = null!;
  @property(Node) closeButton: Node = null!;
  private authoredScale: Vec3 | null = null;

  present(width: number, height: number, unit: number, title: string): void {
    this.authoredScale ??= this.node.scale.clone();
    this.node.getComponent(UITransform)!.setContentSize(width / unit, height / unit);
    this.node.setScale(unit * this.authoredScale.x, unit * this.authoredScale.y, this.authoredScale.z);
    this.title.string = title;
    for (const widget of this.node.getComponentsInChildren(Widget)) widget.updateAlignment();
  }
}
