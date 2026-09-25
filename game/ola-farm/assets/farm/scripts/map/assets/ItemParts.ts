import { _decorator, Component, Node } from 'cc';

const { ccclass, property } = _decorator;

/** Animated parts of a pen, pond slot or animal prefab, in the order of the exported rig. */
@ccclass('ItemParts')
export class ItemParts extends Component {
  @property({ type: [Node], tooltip: 'Part0, Part1, … matching the animation rig; each holds the authored visual.' })
  parts: Node[] = [];
}
