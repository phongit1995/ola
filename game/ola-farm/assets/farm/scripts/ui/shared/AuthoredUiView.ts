import { PANEL_BROWN, PANEL_MUTED } from './PanelPalette.constants';
import {
  _decorator,
  Button,
  CCFloat,
  Color,
  Component,
  Label,
  Node,
  Sprite,
  SpriteFrame,
  UITransform,
  Vec2,
  Vec4,
} from 'cc';
import { Art } from '../../render/Art';
import { Ui } from '../../render/Ui';
import type { Pose } from './AuthoredUiView.types';

const { ccclass, property } = _decorator;

/** Responsive placement adds the Inspector's offsets to the original layout; it never rebuilds the artwork. */
@ccclass('AuthoredUiView')
export class AuthoredUiView extends Component {
  @property([Node]) layoutNodes: Node[] = [];
  @property([Vec4]) referenceRects: Vec4[] = [];
  @property([Vec2]) referenceScales: Vec2[] = [];
  @property([CCFloat]) referenceFonts: number[] = [];
  @property([Color]) referenceColors: Color[] = [];
  @property([SpriteFrame]) referenceFrames: Array<SpriteFrame | null> = [];
  private poses = new Map<Node, Pose>();

  private names = new Map<Node, Map<string, Node>>();

  element(parent: Node, name: string): Node {
    let children = this.names.get(parent);
    if (!children) {
      children = new Map(parent.children.map(n => [n.name, n]));
      this.names.set(parent, children);
    }
    const node = children.get(name);
    if (!node) throw Error(`UI prefab thiếu ${parent.name}/${name}`);
    return node;
  }

  label(
    parent: Node,
    name: string,
    value: string,
    x: number,
    y: number,
    w: number,
    h: number,
    size: number,
    u: number,
    color: Color
  ): Label {
    return this.text(this.element(parent, name).getComponent(Label)!, value, x, y, w, h, size, u, color);
  }

  image(parent: Node, name: string, art: Art, source: string, x: number, y: number, size: number, u: number): Node {
    const node = this.element(parent, name);
    this.icon(node.getComponent(Sprite)!, art, source, x, y, size, u);
    return node;
  }

  action(
    node: Node,
    ui: Ui,
    art: Art,
    id: string,
    title: string,
    x: number,
    y: number,
    w: number,
    h: number,
    u: number,
    callback: () => void,
    enabled: boolean,
    key: string
  ): Node {
    this.place(node, x, y, w, h, u);
    this.bind(ui, node, id, callback, enabled);
    const face = this.element(node, 'ButtonFace');
    this.stateFrame(face.getComponent(Sprite)!, art.frame('island-ui/' + key));
    this.skin(face, 0, 0, w, h, u);
    this.label(
      node,
      'Title',
      title,
      0,
      key === 'green' ? 2 : 0,
      w - 12,
      h - 6,
      13,
      u,
      key === 'green' ? Color.WHITE : enabled ? PANEL_BROWN : PANEL_MUTED
    );
    return node;
  }

  begin(ui: Ui): void {
    for (const [id, control] of ui.controls)
      if (control === this.node || control.isChildOf(this.node)) ui.controls.delete(id);
    // Read the complete authored baseline before a responsive parent or child is updated.
    for (const node of this.layoutNodes) this.original(node);
  }

  stateFrame(sprite: Sprite, frame: SpriteFrame): void {
    const original = this.original(sprite.node),
      reference = this.referenceFrames[this.layoutNodes.indexOf(sprite.node)];
    sprite.spriteFrame = original.frame && reference && original.frame !== reference ? original.frame : frame;
  }

  protected original(node: Node): Pose {
    let pose = this.poses.get(node);
    if (!pose) {
      const t = node.getComponent(UITransform)!,
        label = node.getComponent(Label);
      pose = {
        rect: new Vec4(node.position.x, node.position.y, t.width, t.height),
        scaleX: node.scale.x,
        scaleY: node.scale.y,
        font: label?.fontSize ?? 0,
        lineRatio: label && label.fontSize > 0 ? label.lineHeight / label.fontSize : 1.15,
        color: label?.color.clone() ?? null,
        frame: node.getComponent(Sprite)?.spriteFrame ?? null,
      };
      this.poses.set(node, pose);
    }
    return pose;
  }

  place(node: Node, x: number, y: number, width: number, height: number, unit = 1, scaleArtwork = false): Node {
    const original = this.original(node),
      i = this.layoutNodes.indexOf(node),
      reference = this.referenceRects[i] ?? original.rect;
    node.setPosition((x + original.rect.x - reference.x) * unit, (y + original.rect.y - reference.y) * unit);
    node
      .getComponent(UITransform)!
      .setContentSize(
        (width + original.rect.z - reference.z) * (scaleArtwork ? 1 : unit),
        (height + original.rect.w - reference.w) * (scaleArtwork ? 1 : unit)
      );
    node.setScale(original.scaleX * (scaleArtwork ? unit : 1), original.scaleY * (scaleArtwork ? unit : 1), 1);
    return node;
  }

  text(
    label: Label,
    value: string,
    x: number,
    y: number,
    width: number,
    height: number,
    size: number,
    unit = 1,
    tint?: Color
  ): Label {
    const original = this.original(label.node),
      i = this.layoutNodes.indexOf(label.node);
    this.place(label.node, x, y, width, height, unit);
    label.string = value;
    label.fontSize = Math.ceil((size + original.font - (this.referenceFonts[i] ?? original.font)) * unit);
    label.lineHeight = label.fontSize * original.lineRatio;
    // State colors apply to the default palette; a designer's explicit label color wins.
    if (tint && original.color && (!this.referenceColors[i] || original.color.equals(this.referenceColors[i])))
      label.color = tint;
    return label;
  }

  skin(node: Node, x: number, y: number, width: number, height: number, unit = 1): Node {
    const pose = this.original(node),
      reference = this.referenceScales[this.layoutNodes.indexOf(node)];
    return this.place(
      node,
      x,
      y,
      width / (reference?.x ?? pose.scaleX),
      height / (reference?.y ?? pose.scaleY),
      unit,
      true
    );
  }

  icon(sprite: Sprite, art: Art, source: string, x: number, y: number, size: number, unit = 1): void {
    const frame = art.frame(source),
      fit = size / Math.max(frame.width, frame.height);
    sprite.spriteFrame = frame;
    this.place(sprite.node, x, y, frame.width * fit, frame.height * fit, unit);
  }

  bind(ui: Ui, node: Node, id: string, action: () => void, enabled = true): Node {
    node.off(Button.EventType.CLICK);
    node.name = id;
    return ui.bindButton(node, id, action, enabled);
  }
}
