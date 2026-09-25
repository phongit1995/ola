import { MOVE_TOOLBAR_COLOR, MOVE_ERROR_COLOR, MOVE_MESSAGE_COLOR } from './BuildingMoveToolbar.constants';
import { BlockInputEvents, Label, Node } from 'cc';
import { BuildingMoveController } from '../../map/buildings/BuildingMoveController';
import { Ui } from '../../render/Ui';

export class BuildingMoveToolbar {
  readonly node: Node;
  private title: Label;
  private message: Label;
  constructor(
    parent: Node,
    ui: Ui,
    width: number,
    private controller: BuildingMoveController,
    direct: boolean,
    actions: { cancel(): void; finish(): void; cycle(delta: number): void }
  ) {
    const theme = ui.theme;
    ui.theme = 'farm';
    const w = Math.min(980, width - 16);
    this.node = ui.box(parent, 'BuildingMoveToolbar', 0, 0, w, direct ? 86 : 176, MOVE_TOOLBAR_COLOR);
    ui.align(this.node, { bottom: 8, centerX: 0 });
    this.title = ui.text(this.node, 'MoveTitle', '', 0, direct ? 20 : 59, w - 155, 34, 27);
    this.message = ui.text(this.node, 'MoveMessage', '', 0, direct ? -19 : 14, w - 24, 40, 22);
    // The direct-drag hint must not intercept the pointer when the building crosses it.
    if (!direct) {
      this.node.addComponent(BlockInputEvents);
      ui.button(this.node, 'move-prev', '‹', -w / 2 + 34, 59, 48, 40, () => actions.cycle(-1));
      ui.button(this.node, 'move-next', '›', w / 2 - 34, 59, 48, 40, () => actions.cycle(1));
      const cw = (w - 30) / 2;
      ui.button(this.node, 'move-cancel', 'Bỏ chọn', -(cw + 6) / 2, -47, cw, 56, actions.cancel);
      ui.button(this.node, 'move-finish', 'Xong', (cw + 6) / 2, -47, cw, 56, actions.finish);
    }
    ui.theme = theme;
    this.update();
  }
  update(): void {
    this.title.string = this.controller.title;
    this.message.string = this.controller.message;
    this.message.color = this.controller.error ? MOVE_ERROR_COLOR : MOVE_MESSAGE_COLOR;
  }
}
