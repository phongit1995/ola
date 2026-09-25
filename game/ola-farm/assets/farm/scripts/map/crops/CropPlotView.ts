import { STAGES } from './CropPlotView.constants';
import { _decorator, Component, Node, Prefab, instantiate } from 'cc';

const { ccclass, property } = _decorator;
const dispose = (node: Node): void => {
  node.active = false;
  node.destroy();
};

/** The shell of one bed: a soil slot and a plant slot. Growth stages are the plant prefab's Stage1–Stage3 children. */
@ccclass('CropPlotView')
export class CropPlotView extends Component {
  @property({ type: Node, tooltip: 'Holds the soil prefab for the bed level.' })
  soil: Node | null = null;

  @property({ type: Node, tooltip: 'Holds the crop prefab while something grows.' })
  plant: Node | null = null;

  private stages: Node[] = [];
  private plantNode: Node | null = null;

  /** Replace the authored soil with another level's prefab. */
  replaceSoil(prefab: Prefab): void {
    if (!this.soil) throw Error('CropPlot.prefab thiếu liên kết Soil.');
    for (const child of [...this.soil.children]) dispose(child);
    this.soil.addChild(instantiate(prefab));
  }

  /** Mount a crop prefab; the Farm Town importer and the item prefabs both expose three Stage nodes. */
  setPlant(node: Node | null): void {
    if (!this.plant) throw Error('CropPlot.prefab thiếu liên kết Plant.');
    for (const child of [...this.plant.children]) dispose(child);
    this.stages = [];
    this.plantNode = node;
    if (!node) return;
    this.plant.addChild(node);
    for (let n = 1; n <= STAGES; n++) {
      const stage = node.getChildByName('Stage' + n);
      if (!stage) throw Error(`Prefab cây ${node.name} thiếu Stage${n}.`);
      this.stages.push(stage);
    }
  }

  get currentPlant(): Node | null {
    return this.plantNode;
  }

  setStage(stage: number): void {
    for (let i = 0; i < this.stages.length; i++) this.stages[i].active = i + 1 === stage;
  }
}
