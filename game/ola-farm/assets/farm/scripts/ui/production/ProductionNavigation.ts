import type { ProductionContext } from './ProductionNavigation.types';
import { t } from '../../core/i18n/I18n';

/** Keep the original paid machine/selected recipe while inspecting a chain of ingredient sources. */
export function rememberProductionTarget(ctx: ProductionContext, machineId: number, recipeId: number): void {
  if (ctx.state.recipeReturnMachineId >= 0) return;
  ctx.state.recipeReturnMachineId = machineId;
  ctx.state.recipeReturnRecipeId = recipeId;
}

export function returnToProduction(ctx: ProductionContext): void {
  const { state, game, app } = ctx;
  const target = game.state.machines.find(machine => machine.id === state.recipeReturnMachineId);
  if (target) {
    state.machineId = target.id;
    state.selectedRecipeId = state.recipeReturnRecipeId;
  }
  state.recipeReturnMachineId = -1;
  state.recipeReturnRecipeId = 0;
  state.factoryRecipesExpanded = false;
  app.open('factory');
}

export function productionReturnLabel(ctx: ProductionContext): string {
  const recipe = ctx.game.product(ctx.state.recipeReturnRecipeId);
  return recipe ? t('factory.backTo', { name: recipe.name }) : t('factory.backToBuilding');
}
