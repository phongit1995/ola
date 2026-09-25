export interface BuildingPosition {
  x: number;
  y: number;
}

export interface BuildingLayout {
  version: 1 | 2 | 3 | 4 | 5 | 6;
  positions: Record<string, BuildingPosition>;
}

export interface RoadPlan {
  version: 2;
  origin: BuildingPosition;
  stepX: number;
  stepY: number;
  scale: number;
  /** Move a terminal sprite towards its sole neighbour so its fading tip ends at the authored endpoint. */
  endInset?: number;
  paths: { id: string; points: [number, number][] }[];
}

export type Polygon = BuildingPosition[];

export interface LayoutBuilding {
  id: string;
  name: string;
  kind: 'facility' | 'machine' | 'pen';
  node: string;
  position: BuildingPosition;
  footprints: Polygon[];
  entrance: BuildingPosition;
  depthOffset: number;
}

export interface FarmLayoutManifest {
  version: 1;
  snap: { x: number; y: number };
  bounds: {
    left: number;
    right: number;
    bottom: number;
    top: number;
    radius: number;
    shape?: 'diamond';
    cut?: { x: number; y: number };
  };
  buildings: LayoutBuilding[];
  obstacles: { id: string; polygon: Polygon }[];
  /** Fixed scenery; small props do not reserve extra ground around a movable building. */
  decor: { id: string; polygon: Polygon }[];
  fieldEntrance: BuildingPosition;
  /** Absent only from the frozen geometry used to validate old saves. */
  roadPlan?: RoadPlan;
}
