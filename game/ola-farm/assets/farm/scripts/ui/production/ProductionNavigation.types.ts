/** Structural route state keeps navigation testable without loading the Cocos engine. */
export interface ProductionContext {
  state: {
    machineId: number;
    selectedRecipeId: number;
    recipeReturnMachineId: number;
    recipeReturnRecipeId: number;
    factoryRecipesExpanded: boolean;
  };
  game: { state: { machines: { id: number }[] }; product(id: number): { name: string } | undefined };
  app: { open(view: 'factory'): void };
}
