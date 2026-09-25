import { _decorator, Component, JsonAsset, Prefab } from 'cc';
const { ccclass, property } = _decorator;

/** Serialized links also preload the item prefabs when the map loads. */
@ccclass('FarmItemLibrary')
export class FarmItemLibrary extends Component {
  @property([Prefab]) crops: Prefab[] = [];
  @property([Prefab]) soils: Prefab[] = [];
  @property([Prefab]) pens: Prefab[] = [];
  @property([Prefab]) ponds: Prefab[] = [];
  @property([Prefab]) animals: Prefab[] = [];
  /** Same ordered species as forestConfig; used in both authored and extended forest. */
  @property([Prefab]) scenery: Prefab[] = [];
  /** Same ordered rock types as forestConfig, also used beyond the authored map. */
  @property([Prefab]) rocks: Prefab[] = [];
  @property([Prefab]) roads: Prefab[] = [];
  @property({ type: JsonAsset }) forestConfig: JsonAsset | null = null;
}
