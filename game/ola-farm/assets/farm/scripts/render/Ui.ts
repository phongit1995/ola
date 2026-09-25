import type { Theme, ButtonOptions, Alignment } from './types/Ui.types';
import { cream, ink, islandInk } from './constants/Ui.constants';
import { runtimeConfig } from '../core/FarmRuntime';
import {
  Node,
  UITransform,
  Label,
  Color,
  Graphics,
  Layers,
  ScrollView,
  Mask,
  Sprite,
  LabelOutline,
  Button,
  Widget,
} from 'cc';
import { Art } from './Art';
import { UiPrefabs } from './UiPrefabs';
import { UI_THEMES } from './enums/UiTheme.enum';
import { FarmButton } from './FarmButton';

/**
 * Small factory for code-built widgets. The caller chooses the skin for each screen,
 * and every tappable control registers under a stable ID for tests and diagnostics.
 */
export class Ui {
  prefabs!: UiPrefabs;
  controls = new Map<string, Node>();
  theme: Theme = UI_THEMES.Farm;
  constructor(public art: Art) {}

  node(parent: Node, name: string, x: number, y: number, w: number, h: number): Node {
    const n = new Node(name);
    n.layer = Layers.Enum.UI_2D;
    parent.addChild(n);
    n.setPosition(x, y);
    n.addComponent(UITransform).setContentSize(w, h);
    return n;
  }

  /** Anchor a node to its parent with a Widget and align it immediately so callers can read the resulting size. */
  align(node: Node, a: Alignment): Widget {
    const w = node.getComponent(Widget) ?? node.addComponent(Widget);
    w.alignMode = Widget.AlignMode.ON_WINDOW_RESIZE;
    if (a.top !== undefined) {
      w.isAlignTop = true;
      w.top = a.top;
    }
    if (a.bottom !== undefined) {
      w.isAlignBottom = true;
      w.bottom = a.bottom;
    }
    if (a.left !== undefined) {
      w.isAlignLeft = true;
      w.left = a.left;
    }
    if (a.right !== undefined) {
      w.isAlignRight = true;
      w.right = a.right;
    }
    if (a.centerX !== undefined) {
      w.isAlignHorizontalCenter = true;
      w.horizontalCenter = a.centerX;
    }
    if (a.centerY !== undefined) {
      w.isAlignVerticalCenter = true;
      w.verticalCenter = a.centerY;
    }
    w.updateAlignment();
    return w;
  }

  /** A node that always covers its parent. */
  fill(parent: Node, name: string): Node {
    const n = this.node(parent, name, 0, 0, 1, 1);
    this.align(n, { top: 0, bottom: 0, left: 0, right: 0 });
    return n;
  }

  box(
    parent: Node,
    name: string,
    x: number,
    y: number,
    w: number,
    h: number,
    color = new Color(69, 96, 42, 240),
    radius = 15
  ): Node {
    if (this.theme === 'town') return this.art.town(parent, 'paper', x, y, w, h, name);
    if (this.theme === 'island') return this.art.island(parent, 'card', x, y, w, h, name);
    const n = this.node(parent, name, x, y, w, h),
      g = n.addComponent(Graphics);
    g.fillColor = color;
    g.roundRect(-w / 2, -h / 2, w, h, radius);
    g.fill();
    return n;
  }

  text(
    parent: Node,
    name: string,
    text: string,
    x: number,
    y: number,
    width: number,
    height = 42,
    size = 24,
    color = cream
  ): Label {
    const n = this.node(parent, name, x, y, width, height),
      label = n.addComponent(Label);
    // A Label starts in auto-size mode and would replace the node's dimensions; fix overflow before the string.
    label.overflow = Label.Overflow.SHRINK;
    if (this.art.font) label.font = this.art.font;
    label.fontSize = size;
    label.lineHeight = size + 7;
    label.color = this.theme === 'island' && color === ink ? islandInk : color;
    label.string = text;
    label.horizontalAlign = Label.HorizontalAlign.CENTER;
    label.verticalAlign = Label.VerticalAlign.CENTER;
    n.getComponent(UITransform)!.setContentSize(width, height);
    return label;
  }

  button(
    parent: Node,
    id: string,
    title: string,
    x: number,
    y: number,
    w: number,
    h: number,
    action: () => void,
    options: ButtonOptions = {}
  ): Node {
    const enabled = options.enabled ?? true;
    if (this.theme === 'town')
      return this.townButton(parent, id, title, x, y, w, h, action, enabled, options.variant ?? 'green');
    if (this.theme === 'island') {
      if (options.icon) {
        const n = this.art.island(parent, 'card', x, y, w, h, id);
        this.item(n, options.icon, 0, 19, Math.min(w - 30, h - 54, 86), 'MenuIcon');
        this.text(n, 'Title', title, 0, -h / 2 + 25, w - 20, 42, 23, ink);
        return this.bindButton(n, id, action, enabled);
      }
      return this.islandButton(
        parent,
        id,
        title,
        x,
        y,
        w,
        h,
        action,
        enabled,
        options.variant === 'blue' ? 'card' : 'green'
      );
    }
    const n = options.icon
      ? this.node(parent, id, x, y, w, h)
      : this.box(parent, id, x, y, w, h, enabled ? new Color(97, 121, 49) : new Color(125, 125, 107));
    if (options.icon) {
      this.art.image(n, options.icon, 0, title ? 10 : 0, w - 8, title ? h - 22 : h);
      if (title) this.text(n, 'Title', title, 0, -h / 2 + 10, w + 18, 25, 19);
    } else this.text(n, 'Title', title, 0, 0, w - 12, h - 4, 23);
    return this.bindButton(n, id, action, enabled);
  }

  /** Invisible hit area for controls whose artwork is drawn separately. */
  buttonArea(
    parent: Node,
    id: string,
    x: number,
    y: number,
    w: number,
    h: number,
    action: () => void,
    enabled = true
  ): Node {
    return this.bindButton(this.node(parent, id, x, y, w, h), id, action, enabled);
  }

  townButton(
    parent: Node,
    id: string,
    title: string,
    x: number,
    y: number,
    w: number,
    h: number,
    action: () => void,
    enabled = true,
    skin = 'green'
  ): Node {
    const n = this.art.town(parent, skin, x, y, w, h, id);
    n.getComponent(Sprite)!.grayscale = !enabled;
    const label = this.text(n, 'Title', title, 0, 2, w - 24, h - 10, 23, Color.WHITE);
    const outline = label.node.addComponent(LabelOutline);
    outline.color = new Color(75, 87, 55);
    outline.width = 1.5;
    return this.bindButton(n, id, action, enabled);
  }

  islandButton(
    parent: Node,
    id: string,
    title: string,
    x: number,
    y: number,
    w: number,
    h: number,
    action: () => void,
    enabled = true,
    skin = 'green'
  ): Node {
    const n = this.art.island(parent, skin, x, y, w, h, id);
    n.getComponent(Sprite)!.grayscale = !enabled;
    const primary = skin === 'green';
    const label = this.text(n, 'Title', title, 0, primary ? 4 : 1, w - 24, h - 12, 25, primary ? Color.WHITE : ink);
    if (primary) {
      const outline = label.node.addComponent(LabelOutline);
      outline.color = new Color(54, 105, 15);
      outline.width = 2;
    }
    return this.bindButton(n, id, action, enabled);
  }

  item(parent: Node, source: string, x: number, y: number, size: number, name = 'Product'): Node {
    const texture = this.art.textures.get(source);
    if (!texture) throw Error(`Thiếu ảnh: ${source}`);
    const fit = size / Math.max(texture.width, texture.height);
    return this.art.image(parent, source, x, y, texture.width * fit, texture.height * fit, name);
  }

  /** Register either an authored control or a newly created button without replacing its artwork. */
  bindButton(n: Node, id: string, action: () => void, enabled = true): Node {
    const button = n.getComponent(FarmButton) ?? n.addComponent(FarmButton);
    button.dragSlop = runtimeConfig(this.art.data?.data).input.buttonDragSlop;
    button.transition = Button.Transition.NONE;
    button.interactable = enabled;
    n.on(Button.EventType.CLICK, () => action());
    this.controls.set(id, n);
    return n;
  }

  static isEnabled(control: Node): boolean {
    return control.getComponent(Button)?.interactable ?? true;
  }

  clear(node: Node): void {
    for (const child of [...node.children]) {
      child.removeFromParent();
      child.destroy();
    }
    // Hidden navigation is still registered while the contextual footer is open.
    for (const [id, n] of this.controls) if (!n.isValid || !n.parent || !n.scene) this.controls.delete(id);
  }

  scroll(parent: Node, width: number, height: number, contentHeight: number): { content: Node; scroll: ScrollView } {
    const root = this.node(parent, 'Scroll', 0, 0, width, height),
      scroll = root.addComponent(ScrollView);
    const viewport = this.node(root, 'Viewport', 0, 0, width, height);
    viewport.addComponent(Mask);
    const content = this.node(viewport, 'Content', -width / 2, height / 2, width, Math.max(height, contentHeight));
    content.getComponent(UITransform)!.setAnchorPoint(0, 1);
    scroll.content = content;
    scroll.horizontal = false;
    scroll.vertical = true;
    scroll.inertia = true;
    scroll.cancelInnerEvents = true;
    return { content, scroll };
  }
}
