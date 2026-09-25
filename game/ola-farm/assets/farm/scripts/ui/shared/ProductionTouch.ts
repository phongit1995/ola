import { Button, Label, Node, UITransform, view } from 'cc';
import { TOUCH_TARGET } from './ProductionTouch.constants';

/** Production controls use CSS-sized targets while the world/crop design resolution stays unchanged. */
export function productionTargetSize(designWidth: number): number {
  return Math.max(
    TOUCH_TARGET.designMinimum,
    Math.ceil((TOUCH_TARGET.cssMinimum * designWidth) / Math.max(1, view.getFrameSize().width))
  );
}

export function fitProductionTarget(node: Node, designWidth: number): void {
  const ratio = designWidth / Math.max(1, view.getFrameSize().width);
  const minimum = productionTargetSize(designWidth);
  const transform = node.getComponent(UITransform);
  if (!transform) return;
  transform.setContentSize(Math.max(transform.width, minimum), Math.max(transform.height, minimum));
  const title = node.getChildByName('Title')?.getComponent(Label);
  if (title) {
    title.fontSize = Math.max(TOUCH_TARGET.designFontMinimum, Math.ceil(TOUCH_TARGET.cssFontMinimum * ratio));
    title.lineHeight = title.fontSize + TOUCH_TARGET.lineHeightGap;
    title.node
      .getComponent(UITransform)!
      .setContentSize(transform.width - TOUCH_TARGET.titleInsetX, transform.height - TOUCH_TARGET.titleInsetY);
  }
}

export function fitProductionTargets(parent: Node, designWidth: number): void {
  for (const button of parent.getComponentsInChildren(Button)) fitProductionTarget(button.node, designWidth);
}
