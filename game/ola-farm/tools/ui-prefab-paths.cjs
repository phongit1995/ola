'use strict';
// Authoring paths only. Runtime keeps the scene's typed Inspector/UUID links.
const { stableId } = require('./cocos-ids.cjs');

const UI_PREFAB_PATHS = Object.freeze({
  DialogShell: 'prefabs/ui/DialogShell.prefab',
  HUD: 'prefabs/ui/HUD.prefab',
  LoadingScreen: 'prefabs/ui/LoadingScreen.prefab',
  Shop: 'prefabs/ui/Shop.prefab',
  ShopCard: 'prefabs/ui/ShopCard.prefab',
  FactoryDialogFrame: 'prefabs/ui/FactoryDialogFrame.prefab',
  FactoryBody: 'prefabs/ui/FactoryBody.prefab',
  FactoryQueueSlot: 'prefabs/ui/FactoryQueueSlot.prefab',
  RecipeChoice: 'prefabs/ui/RecipeChoice.prefab',
  IngredientItem: 'prefabs/ui/IngredientItem.prefab',
  LivestockBody: 'prefabs/ui/LivestockBody.prefab',
  HerdSlot: 'prefabs/ui/HerdSlot.prefab',
  HerdQuickBar: 'prefabs/ui/HerdQuickBar.prefab',
  InventoryBody: 'prefabs/ui/InventoryBody.prefab',
  StockCard: 'prefabs/ui/StockCard.prefab',
  SeedPicker: 'prefabs/ui/SeedPicker.prefab',
  SeedTile: 'prefabs/ui/SeedTile.prefab',
  PlotBubble: 'prefabs/ui/PlotBubble.prefab',
  LandPurchase: 'prefabs/ui/LandPurchase.prefab',
});

function uiPrefabPath(name) {
  if (!Object.hasOwn(UI_PREFAB_PATHS, name)) throw Error('Unknown UI prefab: ' + name);
  return UI_PREFAB_PATHS[name];
}

/** Asset identity predates feature folders; moving an asset must never change its UUID. */
function uiPrefabUuid(name) {
  uiPrefabPath(name);
  if (name === 'Shop') return 'c4d68108-fcd0-4760-a648-4814f9326261';
  if (name === 'ShopCard') return 'bbf14ac8-fad6-49a1-866d-bcd142245aed';
  return stableId('prefabs/ui/' + name + '.prefab');
}

module.exports = { UI_PREFAB_PATHS, uiPrefabPath, uiPrefabUuid };
