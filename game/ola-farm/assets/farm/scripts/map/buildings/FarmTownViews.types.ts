import type { Node, Label, UIOpacity } from 'cc';
import type { Machine } from '../../core/types/ProductionTypes';
import type { FarmTownMotion } from './FarmTownMotion';
import type { MapBounds } from '../../render/types/MapTypes';

export interface BuildingView {
  node: Node;
  label: Label;
  model: Node;
  badge: Node;
  opacity: UIOpacity;
  motion: FarmTownMotion;
  visualKey: string;
}

export interface YardView {
  node: Node;
  front: Node;
  key: string;
  slots: Map<number, number>;
  badge: Node;
  label: Label;
  opacity: UIOpacity;
  frontOpacity: UIOpacity;
  frontNames: string[];
  bounds: MapBounds;
}

export interface AnimalView {
  node: Node;
  label: Label;
  visual: Node;
  motion: FarmTownMotion;
  prefab: string;
  slot: number;
  pen: number;
  walking: boolean;
}

export interface Site {
  key: string;
  prefab: string;
  name: string;
  machine: Machine;
}

export interface BadgeBounds {
  node: Node;
  x: number;
  y: number;
  w: number;
  h: number;
  ground: number;
  selected: boolean;
}

export interface HerdBadge extends BadgeBounds {
  plot: number;
}

export interface MachineBadge extends BadgeBounds {
  building: string;
}
