import type { Node, Prefab } from 'cc';
import type { FarmTownMotion } from '../buildings/FarmTownMotion';
import type { CropPlotView } from '../crops/CropPlotView';

export interface DrawEntry {
  node: Node;
  depth: number;
}

export interface CropView {
  root: Node;
  shell: CropPlotView;
  key: string;
  unlocked: boolean;
  motion: FarmTownMotion | null;
}

export interface ItemView {
  root: Node;
  parts: Map<number, Node>;
  prefab: Prefab;
}
