import test from 'node:test';
import assert from 'node:assert/strict';
import {
  productionReturnLabel,
  rememberProductionTarget,
  returnToProduction,
} from '../assets/farm/scripts/ui/production/ProductionNavigation';

function context() {
  const opened: string[] = [];
  const state = {
    machineId: 4,
    selectedRecipeId: 105003,
    recipeReturnMachineId: -1,
    recipeReturnRecipeId: 0,
    factoryRecipesExpanded: true,
  };
  const ctx = {
    state,
    game: {
      state: { machines: [{ id: 0 }, { id: 4 }] },
      product: (id: number) => (id === 101604 ? { name: 'Burger' } : undefined),
    },
    app: { open: (view: string) => opened.push(view) },
  };
  return { ctx, state, opened };
}

test('ingredient chains return to the original machine 0 and selected recipe after nested sources', () => {
  const { ctx, state, opened } = context();
  rememberProductionTarget(ctx, 0, 101604);
  rememberProductionTarget(ctx, 4, 105003);
  assert.equal(productionReturnLabel(ctx), 'Về Burger');
  returnToProduction(ctx);
  assert.equal(state.machineId, 0);
  assert.equal(state.selectedRecipeId, 101604);
  assert.equal(state.factoryRecipesExpanded, false);
  assert.equal(state.recipeReturnMachineId, -1);
  assert.equal(state.recipeReturnRecipeId, 0);
  assert.deepEqual(opened, ['factory']);
});

test('a removed return target never replaces the valid current machine with a stale id', () => {
  const { ctx, state, opened } = context();
  rememberProductionTarget(ctx, 99, 101604);
  returnToProduction(ctx);
  assert.equal(state.machineId, 4);
  assert.equal(state.selectedRecipeId, 105003);
  assert.equal(state.recipeReturnMachineId, -1);
  assert.deepEqual(opened, ['factory']);
});
