import { countdown, remainingSeconds } from '../../core/Countdown';
import { recipeInputs, recipeOutputs, cropItemKey, penPlotId } from '../../core/FarmCatalog';
import { ink } from '../../render/constants/Ui.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { productionReturnLabel, returnToProduction } from './ProductionNavigation';
import { TOUCH } from './ProductionBrowser.constants';
import { t } from '../../core/i18n/I18n';

/** Production navigation lists existing workshops; the shop owns construction offers. */
export const industriesPanel: PanelDefinition = {
  title: () => t('buildings.title'),
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui, art } = ctx,
      w = ctx.width - 80;
    const machines = game.machineTypes.flatMap(type => s.machines.filter(m => m.type === type.id));
    const cols = w < 720 ? 2 : 3,
      cw = w / cols,
      content = ctx.list(90 + Math.ceil(machines.length / cols) * 270);
    ui.text(
      content,
      'CatalogSummary',
      t('buildings.summary', { count: machines.length }),
      w / 2,
      -35,
      w - 20,
      50,
      26,
      ink
    );
    machines.forEach((owned, i) => {
      const machineType = game.machineTypes.find(type => type.id === owned.type)!;
      const count = game.catalog.products.filter(r => r.machine === machineType.id).length;
      const card = art.island(
        content,
        'card',
        cw * ((i % cols) + 0.5),
        -202 - Math.floor(i / cols) * 270,
        cw - 14,
        252,
        'BuildingCard'
      );
      ui.item(card, `assets/sprites/${machineType.image}.png`, -cw * 0.25, 47, 88);
      ui.text(
        card,
        'BuildingName',
        t('buildings.card', { name: game.machineName(owned), count }),
        cw * 0.19,
        47,
        cw * 0.52,
        118,
        24,
        ink
      );
      ui.button(card, 'building-instance-' + owned.id, t('buildings.open'), 0, -76, cw - 30, TOUCH, () => {
        state.machineTypeId = machineType.id;
        state.machineId = owned.id;
        state.factoryRecipesExpanded = false;
        app.open('factory');
      });
    });
    ctx.footer('open-building-shop', t('buildings.shop'), () => app.open('shop', { shopTab: 'buildings' }));
  },
};

export const industryPanel: PanelDefinition = {
  title: ctx =>
    ctx.game.machineTypes.find(type => type.id === ctx.state.machineTypeId)?.name ?? t('buildings.fallback'),
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui, art } = ctx,
      w = ctx.width - 80,
      enabled = ctx.canAct;
    const machineType = game.machineTypes.find(type => type.id === state.machineTypeId);
    if (!machineType) return;
    const owned =
        s.machines.find(m => m.id === state.machineId && m.type === machineType.id) ??
        s.machines.find(m => m.type === machineType.id),
      recipes = game.catalog.products.filter(r => r.machine === machineType.id);
    const unlock = game.machineConstructionOffer(machineType.id),
      price = unlock.price,
      content = ctx.list(270 + recipes.length * 132);
    ui.button(
      ctx.card,
      'all-buildings',
      t('industry.machine'),
      -ctx.width / 2 + 53,
      ctx.height / 2 - 48,
      TOUCH,
      TOUCH,
      () => app.open('industries'),
      { variant: 'blue' }
    );
    const info = art.island(content, 'panelInfo', w / 2, -114, w - 12, 210, 'BuildingInfo');
    ui.item(info, `assets/sprites/${machineType.image}.png`, -w * 0.3, 8, 155);
    ui.text(info, 'IndustryName', machineType.name, w * 0.14, 48, w * 0.56, 65, 31, ink);
    ui.text(
      info,
      'IndustryDescription',
      owned
        ? t('industry.recipes', { count: recipes.length })
        : unlock.unlocked
          ? t('industry.buildOnce', { count: recipes.length })
          : unlock.reason,
      w * 0.14,
      -30,
      w * 0.56,
      98,
      25,
      ink
    );
    ui.text(content, 'IndustryRecipesTitle', t('industry.madeHere'), w / 2, -251, w, 38, 26, ink);
    const footerY = -ctx.height / 2 + 57,
      buttonWidth = w / 2 - 8;
    ui.button(
      ctx.card,
      'purchase-industry',
      owned
        ? t('industry.openProduction')
        : unlock.unlocked
          ? t('industry.build', { coins: String(price) })
          : t('common.locked'),
      w * 0.25,
      footerY,
      buttonWidth,
      TOUCH,
      () => {
        if (owned) {
          state.machineId = owned.id;
          state.factoryRecipesExpanded = false;
          app.open('factory');
        } else
          app.act(
            { type: 'buyMachine', machineType: machineType.id, building: unlock.buildingId ?? undefined },
            'Click 1',
            () => {
              const bought = app.game.state.machines.find(m => m.buildingId === unlock.buildingId);
              if (bought) {
                state.machineId = bought.id;
                state.factoryRecipesExpanded = false;
                app.open('factory');
              }
            }
          );
      },
      { enabled: owned ? true : enabled && unlock.unlocked && price !== null && s.coins >= price }
    );
    recipes.forEach((r, i) => {
      const recipeUnlock = game.recipeUnlockStatus(r.id);
      const row = art.island(content, 'card', w / 2, -334 - i * 132, w - 16, 120, 'BuildingRecipe');
      ui.item(row, `assets/sprites/${r.image}.png`, -w / 2 + 65, 0, 76);
      ui.text(
        content,
        'IndustryRecipe',
        `${r.name} · ${countdown(remainingSeconds(r.duration, 0, ctx.speed))}\n${
          recipeUnlock.unlocked
            ? recipeInputs(r)
                .map(v => `${v.quantity} ${game.item(v.key)?.name ?? v.key}`)
                .join(' + ')
            : recipeUnlock.reason
        }`,
        w * 0.6,
        -334 - i * 132,
        w * 0.71,
        108,
        23,
        ink
      );
    });
    ui.button(
      ctx.card,
      'focus-industry',
      state.recipeReturnMachineId >= 0 ? productionReturnLabel(ctx) : owned ? t('industry.goTo') : 'Shop',
      -w * 0.25,
      footerY,
      buttonWidth,
      TOUCH,
      () => {
        if (state.recipeReturnMachineId >= 0) returnToProduction(ctx);
        else if (!owned) app.open('shop', { shopTab: 'buildings' });
        else {
          app.close();
          app.focusBuilding(owned.buildingId!);
        }
      },
      { variant: 'blue' }
    );
  },
};

export const ingredientsPanel: PanelDefinition = {
  title: () => t('sources.title'),
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui } = ctx,
      w = ctx.width - 80;
    const r = game.product(state.sourceRecipeId);
    if (!r) return;
    const rows: Array<{ name: string; image?: string; act?: () => void }> = [];
    for (const ingredient of recipeInputs(r)) {
      const item = game.item(ingredient.key);
      if (!item) continue;
      rows.push({
        name: t('sources.stock', { name: item.name, have: game.quantity(item.key), need: ingredient.quantity }),
        image: item.image,
      });
      for (const f of game.catalog.farm.filter(crop => cropItemKey(crop) === item.key))
        rows.push({
          name:
            t('sources.goToField', { name: f.name }) +
            (game.cropUnlockStatus(f.id).unlocked ? '' : ' · ' + game.cropUnlockStatus(f.id).reason),
          act: () => {
            app.close();
            app.focusHome();
          },
        });
      for (const source of game.catalog.products.filter(recipe =>
        recipeOutputs(recipe).some(o => o.key === item.key)
      )) {
        const machineType = game.machineTypes.find(type => type.id === source.machine);
        if (!machineType) continue;
        const owned = s.machines.filter(m => m.type === machineType.id),
          offer = game.machineConstructionOffer(machineType.id),
          unlock = game.recipeUnlockStatus(source.id);
        if (!owned.length)
          rows.push({
            name: `${machineType.name}\n${offer.unlocked ? t('sources.notBought', { coins: String(offer.price) }) : offer.reason}`,
            act: () => app.open('shop', { shopTab: 'buildings', shopItem: 'shop-machine-' + machineType.id }),
          });
        for (const machine of owned)
          rows.push({
            name: `${game.machineName(machine)}\n${unlock.unlocked ? t('sources.make', { name: source.name }) : unlock.reason}`,
            act: () => {
              state.machineTypeId = machineType.id;
              state.machineId = machine.id;
              state.selectedRecipeId = source.id;
              state.factoryRecipesExpanded = false;
              app.open('factory');
            },
          });
      }
      for (const animal of (game.catalog.livestock ?? []).filter(type => type.output === item.key)) {
        const definition = game.catalog.residentPens?.find(pen => pen.species === animal.key);
        const pens = s.plots.filter(plot => plot.residents?.species === animal.key);
        if (!pens.length && definition) {
          const offer = game.penConstructionOffer(animal.key);
          rows.push({
            name: `${animal.name}\n${offer.unlocked ? t('sources.buyPen') : offer.reason}`,
            act: () => app.open('shop', { shopTab: 'animals', shopItem: 'shop-animal-' + penPlotId(definition) }),
          });
        }
        for (const pen of pens)
          rows.push({
            name: t('sources.feedPen', { name: game.penName(pen.id) }),
            act: () => {
              state.penId = pen.id;
              app.open('livestock');
            },
          });
      }
    }
    const content = ctx.list(100 + rows.length * 110);
    ui.text(
      content,
      'RecipeTitle',
      `${state.pinnedRecipeId === r.id ? t('recipe.pinnedPrefix') : ''}${r.name}`,
      w / 2,
      -35,
      w - 25,
      65,
      29,
      ink
    );
    rows.forEach((row, i) => {
      const y = -128 - i * 110;
      if (row.act)
        ui.button(content, 'ingredient-source-' + i, row.name, w / 2, y, w - 25, 98, row.act, { variant: 'blue' });
      else {
        if (row.image) ui.item(content, `assets/sprites/${row.image}.png`, 48, y, 67);
        ui.text(content, 'IngredientHeading', row.name, w * 0.56, y, w - 112, 96, 26, ink);
      }
    });
    ui.button(
      ctx.card,
      'ingredients-back',
      productionReturnLabel(ctx),
      0,
      -ctx.height / 2 + 55,
      ctx.width - 104,
      TOUCH,
      () => {
        if (state.recipeReturnMachineId >= 0) returnToProduction(ctx);
        else {
          const machine = s.machines.find(machine => machine.type === r.machine);
          if (machine) state.machineId = machine.id;
          state.selectedRecipeId = r.id;
          app.open('factory');
        }
      },
      { variant: 'blue' }
    );
  },
};
