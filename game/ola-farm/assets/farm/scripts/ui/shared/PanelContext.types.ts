import type { InventoryTab } from '../inventory/Inventory.types';
import type { ShopTab } from '../shop/Shop.types';
import type { Node } from 'cc';
import type { Art } from '../../render/Art';
import type { FarmGame } from '../../core/FarmGame';
import type { FarmState } from '../../core/types/StateTypes';
import type { AppFacade } from './AppFacade.types';
import type { PanelView } from './PanelView.types';
import type { Ui } from '../../render/Ui';

/** Selection carried between panels and across re-renders (resize, refresh). */
export interface PanelState {
  view: PanelView | '';
  shopTab: ShopTab;
  /** One-time source link; the shop scrolls its requested card into view. */
  shopItemId: string | null;
  machineTypeId: number;
  sourceRecipeId: number;
  selectedRecipeId: number;
  pinnedRecipeId: number;
  /** -1 means no return target; machine 0 is a valid persistent machine. */
  recipeReturnMachineId: number;
  recipeReturnRecipeId: number;
  factoryRecipesExpanded: boolean;
  machineId: number;
  penId: number;
  saleKey: string;
  saleQuantity: number;
  /** Diamonds chosen in the KEN exchange form. */
  gemAmount: number;
  inventoryTab: InventoryTab;
  improveId: number | null;
  saveText: string;
}

/** Everything a panel renderer needs; the host owns the card and the scroll list. */
export interface PanelContext {
  readonly app: AppFacade;
  readonly state: PanelState;
  readonly ui: Ui;
  readonly art: Art;
  readonly game: FarmGame;
  readonly farm: FarmState;
  readonly card: Node;
  readonly width: number;
  readonly height: number;
  readonly canAct: boolean;
  readonly speed: number;
  /** Scrollable content of the given height, placed inside the card. */
  list(contentHeight: number): Node;
  /** Button row at the bottom of the card; `left` places two buttons side by side. */
  footer(id: string, title: string, action: () => void, left?: boolean): void;
  /** Register a per-tick label update (countdowns) that runs without re-rendering. */
  timer(update: () => void): void;
  /** Re-render the current panel after a local state change (tab, quantity). */
  render(): void;
  /** Adopt an existing scroll view so its offset survives re-renders. */
  adoptScroll(scroll: import('cc').ScrollView): void;
}

export interface PanelDefinition {
  title: string | ((ctx: PanelContext) => string);
  render(ctx: PanelContext): void;
}
