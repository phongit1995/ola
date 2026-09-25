import type { FarmCatalog } from '../../core/types/CatalogTypes';
import type { RuntimeData, SceneData } from './MapTypes';

/** A Unity widget exported to `ported/game.json`; only the fields the UI reads are typed. */
export interface ArtWidget {
  texture: string;
  width: number;
  height: number;
  [extra: string]: unknown;
}

export interface UiData {
  widgets: Record<string, ArtWidget>;
  icons: Record<string, string>;
  timer: Array<{ component: number; texture: string }>;
  [extra: string]: unknown;
}

export interface PanelsData {
  widgets: Record<string, ArtWidget>;
  icons: { raw: Record<string, string>; goods: Record<string, string>; [extra: string]: unknown };
  [extra: string]: unknown;
}

export interface ArtData {
  data: FarmCatalog;
  scene: SceneData;
  runtime: RuntimeData;
  ui: UiData;
  panels: PanelsData;
}

export interface TownProvenance {
  bounds?: number[];
  scale?: number;
  [extra: string]: unknown;
}
export interface TownManifest {
  images: Record<string, { resource: string; [extra: string]: unknown }>;
  prefabs: Record<string, { resource: string; [extra: string]: unknown }>;
  provenance: Record<string, TownProvenance>;
  [extra: string]: unknown;
}
export interface TownUiManifest {
  images: Record<string, { resource: string; border: number[]; [extra: string]: unknown }>;
  [extra: string]: unknown;
}
