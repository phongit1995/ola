import type { Prefab } from 'cc';
import type { Art } from '../../render/Art';
import type { Ui } from '../../render/Ui';
import type { FarmGame } from '../../core/FarmGame';
import type { BubbleActions } from '../crops/PlotBubbles.types';

export interface ScreenPoint {
  x: number;
  y: number;
}

export interface MapTarget {
  id: number;
  cell: number | null;
  locked: boolean;
  x: number;
  y: number;
  w: number;
  h: number;
  screen: ScreenPoint;
}

export interface BuildingTarget {
  id: number | string;
  buildingId: string;
  view?: string;
  x: number;
  y: number;
  w: number;
  h: number;
  screen: ScreenPoint;
}

export interface MapCallbacks {
  onPlot(id: number | null): void;
  onMachine(id: number): void;
  onFacility(view: string): void;
  /** Enter arrangement without dropping the pointer that is already holding a building. */
  onLongPress(): boolean;
  /** A real pointer release places the building; cancelled gestures discard the preview. */
  onMoveEnd(cancelled: boolean): void;
  /** True while a modal panel owns input; the map ignores gestures. */
  isBlocked(): boolean;
}

export interface MapSetup {
  ui: Ui;
  art: Art;
  getGame: () => FarmGame;
  /** Farm units tick per real second at speed 1; the bubbles turn what is left into a real countdown. */
  getSpeed: () => number;
  /** Presentation time advances at real speed while the farm is running. */
  canAnimate: () => boolean;
  bubbles: BubbleActions;
  cropPrefab: Prefab;
  /** Design units reserved by the HUD at the top and the contextual footer at the bottom. */
  inset: { top: number; bottom: number };
  callbacks: MapCallbacks;
}
