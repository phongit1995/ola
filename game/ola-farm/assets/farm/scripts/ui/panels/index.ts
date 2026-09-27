import { PANEL_VIEWS } from '../shared/PanelView.enum';
import type { PanelView } from '../shared/PanelView.types';
import type { PanelDefinition } from '../shared/PanelContext.types';
import { factoryPanel } from '../production/FactoryPanel';
import { inventoryPanel, quickSalePanel, salePanel } from '../inventory/InventoryPanel';
import { livestockPanel } from '../livestock/LivestockPanel';
import {
  coinsPanel,
  helpPanel,
  improvePanel,
  pausePanel,
  plotsPanel,
  restartConfirmPanel,
  saveTextPanel,
  welcomePanel,
} from '../menu/MenuPanels';
import { gemsPanel } from '../menu/GemExchangePanel';
import { industriesPanel, industryPanel, ingredientsPanel } from '../production/ProductionBrowser';
import { shopPanel } from '../shop/ShopPanel';

/** Every modal the host can show, keyed by the view name used in navigation and tests. */
export const PANELS: Record<PanelView, PanelDefinition> = {
  [PANEL_VIEWS.WELCOME]: welcomePanel,
  [PANEL_VIEWS.SHOP]: shopPanel,
  [PANEL_VIEWS.INDUSTRIES]: industriesPanel,
  [PANEL_VIEWS.INDUSTRY]: industryPanel,
  [PANEL_VIEWS.INGREDIENTS]: ingredientsPanel,
  [PANEL_VIEWS.LIVESTOCK]: livestockPanel,
  [PANEL_VIEWS.FACTORY]: factoryPanel,
  [PANEL_VIEWS.INVENTORY]: inventoryPanel,
  [PANEL_VIEWS.INVENTORY_ITEM]: salePanel,
  [PANEL_VIEWS.INVENTORY_SALES]: quickSalePanel,
  [PANEL_VIEWS.PAUSE]: pausePanel,
  [PANEL_VIEWS.RESTART_CONFIRM]: restartConfirmPanel,
  [PANEL_VIEWS.HELP]: helpPanel,
  [PANEL_VIEWS.PLOTS]: plotsPanel,
  [PANEL_VIEWS.IMPROVE]: improvePanel,
  [PANEL_VIEWS.SAVE_TEXT]: saveTextPanel,
  [PANEL_VIEWS.COINS]: coinsPanel,
  [PANEL_VIEWS.GEMS]: gemsPanel,
};

export const isPanelView = (view: string): view is PanelView => view in PANELS;
