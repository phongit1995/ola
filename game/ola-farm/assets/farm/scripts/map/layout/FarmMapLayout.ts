import { _decorator, Component, Node } from 'cc';

const { ccclass, property } = _decorator;

/**
 * Authored anchors of scenes.prefab. The renderer reads these serialized links, so nodes can be renamed
 * or rearranged in the editor without touching code. `tools/link-prefab-components.cjs` fills the arrays.
 */
@ccclass('FarmMapLayout')
export class FarmMapLayout extends Component {
  @property({ type: [Node], tooltip: 'Bed anchors R001–R040 in play order.' })
  fields: Node[] = [];

  @property({
    type: [Node],
    tooltip: 'Resident-yard anchors Cell12–15 and legacy save geometry Cell16–21; no preview art.',
  })
  livestock: Node[] = [];

  @property({ type: [Node], tooltip: 'Second-yard anchors in catalog plot ID order, separate from the legacy cells.' })
  additionalPens: Node[] = [];

  @property({
    type: Node,
    tooltip: 'Parent of the production-site anchors; each child name is a building ID from the catalog.',
  })
  buildings: Node | null = null;

  @property({ type: Node, tooltip: 'Forest, bushes and decorative buildings; culled by camera distance at runtime.' })
  scenery: Node | null = null;

  @property({
    type: Node,
    tooltip: 'Standing trees and decor; sorted with crops and animals by their ground position.',
  })
  decor: Node | null = null;

  @property({
    type: [Node],
    tooltip:
      'Linked forest quadrants and border sides inside Decor. Their individual placements join the shared runtime depth layer.',
  })
  decorRegions: Node[] = [];

  @property({ type: Node, tooltip: 'Roads, pebbles and meadow flowers below standing objects.' })
  groundDecor: Node | null = null;

  @property({ type: Node, tooltip: 'Tiled grass whose size defines the authored map bounds.' })
  grass: Node | null = null;
}
