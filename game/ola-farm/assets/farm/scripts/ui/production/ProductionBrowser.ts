import { countdown, remainingSeconds } from '../../core/Countdown';
import { recipeInputs, recipeOutputs, cropItemKey, penPlotId } from '../../core/FarmCatalog';
import { ink } from '../../render/constants/Ui.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { productionReturnLabel, returnToProduction } from './ProductionNavigation';
import { TOUCH } from './ProductionBrowser.constants';

/** Production navigation lists existing workshops; the shop owns construction offers. */
export const industriesPanel: PanelDefinition = {
  title: 'Công trình đã xây',
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui, art } = ctx,
      w = ctx.width - 80;
    const machines = game.machineTypes.flatMap(t => s.machines.filter(m => m.type === t.id));
    const cols = w < 720 ? 2 : 3,
      cw = w / cols,
      content = ctx.list(90 + Math.ceil(machines.length / cols) * 270);
    ui.text(
      content,
      'CatalogSummary',
      `${machines.length} công trình · Mua thêm trong Shop`,
      w / 2,
      -35,
      w - 20,
      50,
      26,
      ink
    );
    machines.forEach((owned, i) => {
      const t = game.machineTypes.find(t => t.id === owned.type)!;
      const count = game.catalog.products.filter(r => r.machine === t.id).length;
      const card = art.island(
        content,
        'card',
        cw * ((i % cols) + 0.5),
        -202 - Math.floor(i / cols) * 270,
        cw - 14,
        252,
        'BuildingCard'
      );
      ui.item(card, `assets/sprites/${t.image}.png`, -cw * 0.25, 47, 88);
      ui.text(
        card,
        'BuildingName',
        `${game.machineName(owned)}\n${count} công thức`,
        cw * 0.19,
        47,
        cw * 0.52,
        118,
        24,
        ink
      );
      ui.button(card, 'building-instance-' + owned.id, 'Mở công trình', 0, -76, cw - 30, TOUCH, () => {
        state.machineTypeId = t.id;
        state.machineId = owned.id;
        state.factoryRecipesExpanded = false;
        app.open('factory');
      });
    });
    ctx.footer('open-building-shop', 'Shop · Công trình', () => app.open('shop', { shopTab: 'buildings' }));
  },
};

export const industryPanel: PanelDefinition = {
  title: ctx => ctx.game.machineTypes.find(type => type.id === ctx.state.machineTypeId)?.name ?? 'Công trình',
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui, art } = ctx,
      w = ctx.width - 80,
      enabled = ctx.canAct;
    const t = game.machineTypes.find(type => type.id === state.machineTypeId);
    if (!t) return;
    const owned =
        s.machines.find(m => m.id === state.machineId && m.type === t.id) ?? s.machines.find(m => m.type === t.id),
      recipes = game.catalog.products.filter(r => r.machine === t.id);
    const unlock = game.machineConstructionOffer(t.id),
      price = unlock.price,
      content = ctx.list(270 + recipes.length * 132);
    ui.button(
      ctx.card,
      'all-buildings',
      'Máy',
      -ctx.width / 2 + 53,
      ctx.height / 2 - 48,
      TOUCH,
      TOUCH,
      () => app.open('industries'),
      { variant: 'blue' }
    );
    const info = art.island(content, 'panelInfo', w / 2, -114, w - 12, 210, 'BuildingInfo');
    ui.item(info, `assets/sprites/${t.image}.png`, -w * 0.3, 8, 155);
    ui.text(info, 'IndustryName', t.name, w * 0.14, 48, w * 0.56, 65, 31, ink);
    ui.text(
      info,
      'IndustryDescription',
      owned
        ? `${recipes.length} món có thể chế biến`
        : unlock.unlocked
          ? `Xây một lần · ${recipes.length} công thức`
          : unlock.reason,
      w * 0.14,
      -30,
      w * 0.56,
      98,
      25,
      ink
    );
    ui.text(content, 'IndustryRecipesTitle', 'Chế biến tại đây', w / 2, -251, w, 38, 26, ink);
    const footerY = -ctx.height / 2 + 57,
      buttonWidth = w / 2 - 8;
    ui.button(
      ctx.card,
      'purchase-industry',
      owned ? 'Mở sản xuất' : unlock.unlocked ? `Xây · ${price} xu` : 'Chưa mở',
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
            { type: 'buyMachine', machineType: t.id, building: unlock.buildingId ?? undefined },
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
      state.recipeReturnMachineId >= 0 ? productionReturnLabel(ctx) : owned ? 'Tới vị trí' : 'Shop',
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
  title: 'Nguồn nguyên liệu',
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui } = ctx,
      w = ctx.width - 80;
    const r = game.product(state.sourceRecipeId);
    if (!r) return;
    const rows: Array<{ name: string; image?: string; act?: () => void }> = [];
    for (const ingredient of recipeInputs(r)) {
      const item = game.item(ingredient.key);
      if (!item) continue;
      rows.push({ name: `${item.name} · Kho ${game.quantity(item.key)}/${ingredient.quantity}`, image: item.image });
      for (const f of game.catalog.farm.filter(crop => cropItemKey(crop) === item.key))
        rows.push({
          name: `Đến ruộng · ${f.name}${game.cropUnlockStatus(f.id).unlocked ? '' : ' · ' + game.cropUnlockStatus(f.id).reason}`,
          act: () => {
            app.close();
            app.focusHome();
          },
        });
      for (const source of game.catalog.products.filter(recipe =>
        recipeOutputs(recipe).some(o => o.key === item.key)
      )) {
        const t = game.machineTypes.find(type => type.id === source.machine);
        if (!t) continue;
        const owned = s.machines.filter(m => m.type === t.id),
          offer = game.machineConstructionOffer(t.id),
          unlock = game.recipeUnlockStatus(source.id);
        if (!owned.length)
          rows.push({
            name: `${t.name}\n${offer.unlocked ? `Chưa mua · ${offer.price} xu` : offer.reason}`,
            act: () => app.open('shop', { shopTab: 'buildings', shopItem: 'shop-machine-' + t.id }),
          });
        for (const machine of owned)
          rows.push({
            name: `${game.machineName(machine)}\n${unlock.unlocked ? `Làm ${source.name}` : unlock.reason}`,
            act: () => {
              state.machineTypeId = t.id;
              state.machineId = machine.id;
              state.selectedRecipeId = source.id;
              state.factoryRecipesExpanded = false;
              app.open('factory');
            },
          });
      }
      for (const animal of (game.catalog.livestock ?? []).filter(t => t.output === item.key)) {
        const definition = game.catalog.residentPens?.find(pen => pen.species === animal.key);
        const pens = s.plots.filter(plot => plot.residents?.species === animal.key);
        if (!pens.length && definition) {
          const offer = game.penConstructionOffer(animal.key);
          rows.push({
            name: `${animal.name}\n${offer.unlocked ? 'Mua chuồng và con giống' : offer.reason}`,
            act: () => app.open('shop', { shopTab: 'animals', shopItem: 'shop-animal-' + penPlotId(definition) }),
          });
        }
        for (const pen of pens)
          rows.push({
            name: `${game.penName(pen.id)}\nCho ăn rồi nhận sản phẩm`,
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
      `${state.pinnedRecipeId === r.id ? 'Đang ghim · ' : ''}${r.name}`,
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
