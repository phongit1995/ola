import { _decorator, Button, EventTouch, Vec2 } from 'cc';

const { ccclass } = _decorator;
/** Design units a finger may drift before a press turns into a map drag instead of a tap. */

/** The engine Button with one farm rule: dragging away from the press point cancels the tap. */
@ccclass('FarmButton')
export class FarmButton extends Button {
  dragSlop = 10;
  private pressPoint = new Vec2();
  private tracking = false;

  protected _onTouchBegan(event?: EventTouch): void {
    super._onTouchBegan(event);
    if (event && this.interactable) {
      event.getUILocation(this.pressPoint);
      this.tracking = true;
    }
  }

  protected _onTouchMove(event?: EventTouch): void {
    if (event && this.tracking && Vec2.distance(this.pressPoint, event.getUILocation()) > this.dragSlop) {
      this.tracking = false;
      super._onTouchCancel(event);
      return;
    }
    super._onTouchMove(event);
  }

  protected _onTouchEnded(event?: EventTouch): void {
    this.tracking = false;
    super._onTouchEnded(event);
  }
  protected _onTouchCancel(event?: EventTouch): void {
    this.tracking = false;
    super._onTouchCancel(event);
  }
}
