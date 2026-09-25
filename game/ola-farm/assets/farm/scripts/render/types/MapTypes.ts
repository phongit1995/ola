import type { Plot } from '../../core/types/PlotTypes';

/** Unity-exported TRS pose: position [x,y,z], scale [x,y,z], rotation quaternion [x,y,z,w]. */
export interface Pose {
  position: number[];
  scale: number[];
  rotation: number[];
}

/** One drawable part of an exported animal rig. */
export interface RigWidget {
  path: string;
  local: Pose;
  active: boolean;
  width: number;
  height: number;
  depth?: number;
  sprite?: string;
  [extra: string]: unknown;
}
export interface RigTrack {
  path: string;
  property: string;
  curves: number[][][];
}
export interface RigClip {
  duration: number;
  tracks: RigTrack[];
}
export interface AnimalRig {
  widgets: RigWidget[];
  animations: RigClip[];
}

/** Authored cell geometry: size in the widget, a 2D affine matrix [a,b,c,d,x,y] and the tap collider. */
export interface CellGeometry {
  widget: { width: number; height: number; depth?: number; [extra: string]: unknown };
  matrix: number[];
  collider: { center: number[]; size: number[] };
  [extra: string]: unknown;
}

export interface MapBounds {
  left: number;
  right: number;
  bottom: number;
  top: number;
}

/** A plot resolved to its authored cell and world rectangle. */
export interface PlotPosition {
  plot: Plot;
  cell: CellGeometry;
  x: number;
  y: number;
  w: number;
  h: number;
}

/** A draw command produced by the model; the renderer binds it to prefab parts. */
export interface DrawWidget {
  width: number;
  height: number;
  matrix: number[];
  active: boolean;
  depth: number;
  sprite?: string;
  itemType?: 'pens' | 'ponds' | 'animals';
  itemIndex?: number;
  itemInstance?: string;
  itemPart?: number;
  local?: Pose;
  path?: string;
  [extra: string]: unknown;
}

export interface SceneData {
  cells: CellGeometry[];
  plantStageSizes: number[][];
  [extra: string]: unknown;
}

export interface RuntimeData {
  animals: Record<string, AnimalRig>;
  animalPositions: { pen: number[][]; pond: number[][] };
  [extra: string]: unknown;
}
