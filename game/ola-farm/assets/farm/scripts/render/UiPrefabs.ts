import { _decorator, Component, Prefab } from 'cc';

const { ccclass, property } = _decorator;

/** Editor-linked UI modules. The scene keeps dependencies explicit without loading by filename. */
@ccclass('UiPrefabs')
export class UiPrefabs extends Component {
  @property(Prefab) dialogShell: Prefab = null!;
  @property(Prefab) landPurchase: Prefab = null!;
  @property(Prefab) plotBubble: Prefab = null!;
  @property(Prefab) factoryBody: Prefab = null!;
  @property(Prefab) livestockBody: Prefab = null!;
  @property(Prefab) inventoryBody: Prefab = null!;
  @property(Prefab) seedPicker: Prefab = null!;
  @property(Prefab) herdQuickBar: Prefab = null!;
}
