import type { ShopTab } from '../shop/Shop.types';
import type { Art } from '../../render/Art';
import type { FarmGame } from '../../core/FarmGame';
import type { FarmAction } from '../../core/types/ActionTypes';
import type { AudioKind, SaveExport } from '../../core/types/SessionTypes';
import type { GameSession } from '../../core/GameSession';
import type { Ui } from '../../render/Ui';
import type { PanelView } from './PanelView.types';

/** Selection handed to a panel as it opens; the host stores it in `PanelState` before rendering. */
export interface OpenOptions {
  machineType?: number;
  shopTab?: ShopTab;
  /** Control ID the shop scrolls into view once. */
  shopItem?: string;
  penId?: number;
  improveId?: number;
  machineId?: number;
  /** Jump straight to a recipe: the list collapses and any pending return target is consumed. */
  recipeId?: number;
  saveText?: string;
}

/** What panels and the footer may ask of the application shell. UI modules depend on this, never on GameApp. */
export interface AppFacade {
  readonly ui: Ui;
  readonly art: Art;
  readonly session: GameSession;
  readonly game: FarmGame;
  /** Current canvas size in design units. */
  readonly width: number;
  readonly height: number;

  /** Apply a player action with feedback; returns whether it was committed. */
  act(action: FarmAction, sound?: string, after?: () => void): boolean;
  open(view: PanelView, options?: OpenOptions): void;
  close(): void;
  beginArrangement(): void;
  toast(message: string): void;
  /** Same routing as tapping the plot on the map: harvest when ripe, open the pen, offer the upgrade when locked, else select. */
  tapPlot(id: number): void;
  focusHome(): void;
  focusBuilding(id: string): void;
  canFocusBuilding(id: string | null): boolean;
  exportSave(kind?: SaveExport): void;
  importSave(): void;
  importText(text: string): void;
  retrySave(): void;
  setSpeed(speed: number): void;
  toggleAudio(kind: AudioKind): void;
  restart(): void;
}
