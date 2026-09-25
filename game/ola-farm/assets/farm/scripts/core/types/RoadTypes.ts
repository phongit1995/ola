import type { BuildingPosition } from './BuildingTypes';

export interface RoadTile extends BuildingPosition {
  id: string;
  asset: string;
  u: number;
  v: number;
  mask: number;
  scale: number;
  zone: string;
}

export interface RoadNetwork {
  tiles: RoadTile[];
  links: { id: string; x: number; y: number; distance: number }[];
  stepX: number;
  stepY: number;
  origin: BuildingPosition;
}
