/** Pure layout shared by the prefab generator and the camera's extra forest. Coordinates own their random seed. */
export interface ForestBounds {
  left: number;
  right: number;
  bottom: number;
  top: number;
}

export type Polygon = { x: number; y: number }[];

export interface ForestConfig {
  seed: number;
  stepX: number;
  stepY: number;
  jitterX: number;
  jitterY: number;
  /** The farmed ground. A diamond joins the four side midpoints; `cut` supports the previous chamfered outline. */
  clearing: ForestBounds & { radius: number; shape?: 'diamond'; cut?: { x: number; y: number } };
  /** Amplitude and frequency of the wobble that keeps the treeline off the bare outline. */
  wobble?: { amount: number; frequency: number };
  /** Coarse cell size and strength of the clumping noise; without it the scatter reads as a grid. */
  cluster?: { size: number; strength: number };
  species: {
    id: string;
    weight: number;
    scale: number;
    band?: [number, number];
    canopy: { width: number; height: number; anchorY: number };
  }[];
  rocks: {
    borderStep: number;
    treeClearance: number;
    stepX: number;
    stepY: number;
    density: number;
    /** Rocks arrive in groups of one to `clusterSize`, scattered inside `clusterSpread`. */
    clusterSize?: number;
    clusterSpread?: number;
    /** Small variations follow the four sides without opening holes or moving stones onto playable ground. */
    edging?: { kinds: string[]; scale: number; scaleVariation?: number; jitterAlong?: number; jitterOut?: number };
    types: { id: string; weight: number; scale: number; radius: number; band?: [number, number] }[];
  };
}

export interface ForestPlacement {
  id: string;
  species: number;
  x: number;
  y: number;
  scale: number;
}

export interface RockPlacement {
  id: string;
  kind: number;
  x: number;
  y: number;
  scale: number;
  zone: 'rock-border' | 'forest-rocks';
}
