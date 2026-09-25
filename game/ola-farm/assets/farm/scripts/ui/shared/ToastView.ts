import { _decorator, Component, Graphics, Label, UITransform, Widget } from 'cc';
import { Ui } from '../../render/Ui';
import { TOAST_HEIGHT, MAX_WIDTH, SIDE_MARGIN } from './ToastView.constants';

const { ccclass } = _decorator;

/** A dark rounded snackbar above panels, sized to its message and anchored above whatever owns the bottom. */
@ccclass('ToastView')
export class ToastView extends Component {
  private label!: Label;
  private widget!: Widget;
  private remaining = 0;
  private seconds = 4;
  private maxWidth = MAX_WIDTH;

  setup(ui: Ui, seconds = 4): void {
    this.seconds = seconds;
    this.label = ui.text(this.node, 'Text', '', 0, 0, MAX_WIDTH - 24, 38, 23);
    this.widget = ui.align(this.node, { bottom: 0, centerX: 0 });
    this.node.active = false;
  }

  get visible(): boolean {
    return this.remaining > 0 && this.node.active;
  }
  get text(): string {
    return this.label.string;
  }

  show(message: string, canvasWidth: number): void {
    this.maxWidth = Math.min(canvasWidth - SIDE_MARGIN, MAX_WIDTH);
    this.label.fontSize = canvasWidth < 900 ? 21 : 23;
    const width = Math.round(Math.min(this.maxWidth, 32 + message.length * this.label.fontSize * 0.56));
    this.label.string = message;
    this.label.node.getComponent(UITransform)!.setContentSize(width - 24, 38);
    const g = this.node.getComponent(Graphics)!;
    g.clear();
    g.roundRect(-width / 2, -TOAST_HEIGHT / 2, width, TOAST_HEIGHT, 10);
    g.fill();
    this.node.getComponent(UITransform)!.setContentSize(width, TOAST_HEIGHT);
    this.node.active = true;
    this.remaining = this.seconds;
  }

  hide(): void {
    this.remaining = 0;
    this.node.active = false;
    this.label.string = '';
  }

  /** Distance from the canvas bottom to the toast's center, in design units. */
  placeAt(centerFromBottom: number): void {
    this.widget.bottom = centerFromBottom - TOAST_HEIGHT / 2;
    this.widget.updateAlignment();
  }

  tick(dt: number): void {
    if (!this.node.active) return;
    this.remaining -= dt;
    if (this.remaining <= 0) this.hide();
  }
}
