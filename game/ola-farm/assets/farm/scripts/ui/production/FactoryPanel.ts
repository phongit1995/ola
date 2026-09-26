import { Color, instantiate, Label, Node, UITransform, view } from 'cc';
import { FactoryBodyView } from './FactoryBodyView';
import { FactoryQueueSlotView } from './FactoryQueueSlotView';
import { recipeInputs, recipeOutputs } from '../../core/FarmCatalog';
import type { Machine } from '../../core/types/ProductionTypes';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { rememberProductionTarget, returnToProduction } from './ProductionNavigation';
import { PANEL_BROWN as brown, PANEL_MUTED as muted } from '../shared/PanelPalette.constants';
import { factoryLayout } from './FactoryLayout';
import {
  QUEUE_BOOST_GAP,
  QUEUE_BOOST_HEIGHT,
  QUEUE_ROW_TOP,
  QUEUE_SLOT_GAP,
  QUEUE_SLOT_MAX,
  QUEUE_SLOT_SIZE,
} from './FactoryLayout.constants';
import { PANEL_BOOST_SCALE } from './FactoryPanel.constants';
import { countdown, remainingSeconds } from '../../core/Countdown';

/** One recipe workspace, with fixed queue/actions and a scrollable ingredient or recipe list. */
export const factoryPanel: PanelDefinition = {
  title(ctx) {
    const selected = ctx.farm.machines.find(m => m.id === ctx.state.machineId);
    return selected ? ctx.game.machineName(selected) : 'Nhà máy';
  },
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui, art } = ctx;
    let body = ctx.card.getComponentInChildren(FactoryBodyView);
    if (!body) {
      const node = instantiate(ui.prefabs.factoryBody);
      ctx.card.addChild(node);
      body = node.getComponent(FactoryBodyView)!;
    }
    const v = body,
      card = v.node;
    v.begin(ui);
    card.getComponent(UITransform)!.setContentSize(ctx.width, ctx.height);
    const frame = view.getFrameSize(),
      layout = factoryLayout(app.width, frame.width, frame.height);
    const { unit: u, split, width: frameWidth, height: h, padding } = layout;
    const w = frameWidth - padding * 2,
      left = -w / 2;
    const selected: Machine | undefined = s.machines.find(m => m.id === state.machineId) ?? s.machines[0];
    if (!selected) return;
    state.machineId = selected.id;
    const text = (
      parent: Node,
      name: string,
      value: string,
      x: number,
      y: number,
      width: number,
      height: number,
      size = 13,
      color = brown,
      _align = Label.HorizontalAlign.CENTER
    ) => {
      const label = v.label(parent, name, value, x, y, width, height, size, u, color);
      return label;
    };
    const skin = (parent: Node, key: string, x: number, y: number, width: number, height: number, name = key) =>
      v.skin(v.element(parent, name), x, y, width, height, u);
    const item = (parent: Node, image: string, x: number, y: number, size: number, name = 'Product') =>
      v.image(parent, name, art, `assets/sprites/${image}.png`, x, y, size, u);
    const button = (
      parent: Node,
      id: string,
      title: string,
      x: number,
      y: number,
      width: number,
      height: number,
      action: () => void,
      enabled = true,
      key = 'info'
    ) => {
      const node =
        id.startsWith('collect-') || id.startsWith('boost-machine-')
          ? v.collect
          : id.startsWith('produce-')
            ? v.produce
            : id === 'pin-recipe' || id === 'factory-production-return'
              ? v.pin
              : v.element(parent, id);
      return v.action(
        node,
        ui,
        art,
        id,
        title,
        x,
        y,
        width,
        height,
        u,
        action,
        enabled,
        key === 'green' && !enabled ? 'info' : key
      );
    };
    const all = v.place(
      v.element(card, 'all-buildings'),
      -frameWidth / 2 + 64,
      h / 2 - layout.header.titleTop,
      48,
      44,
      u
    );
    v.bind(ui, all, 'all-buildings', () => app.open('industries'));
    text(all, 'Title', '‹ Máy', 0, 0, 46, 28, 12);
    const wait = (seconds: number): string =>
      `${Math.max(0, Math.ceil(seconds / ctx.speed))} giây${ctx.speed === 1 ? '' : ` · ${ctx.speed}×`}`;
    const product = (id: number) => {
      const r = game.product(id);
      if (!r) throw Error('Công thức không hợp lệ: ' + id);
      return r;
    };
    const recipes = game.catalog.products.filter(r => r.machine === selected.type);
    const r = recipes.find(recipe => recipe.id === state.selectedRecipeId) ?? recipes[0];
    if (!r) return;
    state.selectedRecipeId = r.id;
    const inputs = recipeInputs(r),
      enough = game.has(inputs),
      unlock = game.recipeUnlockStatus(r.id);
    const queueWidth = split ? Math.max(236, w * 0.44) : w;
    const workspaceWidth = split ? w - queueWidth - 18 : w;
    const workspaceX = split ? left + queueWidth + 18 + workspaceWidth / 2 : 0;
    // The queue row opens the panel. Finished batches come first (tap to collect them all), then the running job,
    // queued jobs and free or locked slots. Each job shows its time behind a clock and its own finish-now price.
    for (const name of [
      'MachineStatus',
      'MachineStatusDetail',
      'ProductionProgress',
      'ProductionProgressFill',
      'QueueCount',
    ])
      v.element(card, name).active = false;
    v.collect.active = false;
    const queueLimit = Math.max(selected.capacity, game.queueCapacityLimit(selected.type)),
      ready = selected.tray.length ? 1 : 0,
      slotCount = ready + queueLimit;
    const slots = v.queueSlotNodes(slotCount);
    const boostRow = v.resetBoostRow();
    // Slots that all fit stretch to fill the row (up to QUEUE_SLOT_MAX); when some overflow, size them so the
    // last visible one is cut in half, a hint that the row scrolls.
    const slotGap = QUEUE_SLOT_GAP,
      fit = queueWidth / (QUEUE_SLOT_SIZE + slotGap),
      slotSize =
        slotCount <= fit
          ? Math.min(QUEUE_SLOT_MAX, queueWidth / slotCount - slotGap)
          : queueWidth / (Math.floor(fit) + 0.5) - slotGap,
      rowHeight = slotSize + QUEUE_BOOST_GAP + QUEUE_BOOST_HEIGHT,
      rowTop = h / 2 - QUEUE_ROW_TOP,
      rowY = rowTop - rowHeight / 2,
      slotY = rowHeight / 2 - slotSize / 2,
      boostY = -rowHeight / 2 + QUEUE_BOOST_HEIGHT / 2,
      // A row that fits sits centred; an overflowing one starts at the left edge.
      rowOffset = Math.max(0, (queueWidth - slotCount * (slotSize + slotGap)) / 2);
    // Extra height above and below keeps the cancel badges, which overhang the slot corners, inside the mask.
    v.resizeQueue(left + queueWidth / 2, rowY, queueWidth, rowHeight + 24, slotCount * (slotSize + slotGap), u);
    for (let index = 0; index < slotCount; index++) {
      const slotView = slots[index].getComponent(FactoryQueueSlotView)!,
        slotX = rowOffset + slotGap / 2 + index * (slotSize + slotGap) + slotSize / 2;
      slotView.node.setPosition(slotX * u, slotY * u);
      if (index < ready) {
        const batches = selected.tray.length;
        slotView.render(
          ctx,
          'collect-' + selected.id,
          slotSize,
          u,
          () => app.act({ type: 'collectAll', machine: selected.id }, 'Chon sp'),
          ctx.canAct,
          {
            image: product(selected.tray[0].product).image,
            label: batches > 1 ? `Nhận ${batches}` : 'Nhận',
            tone: 'ready',
          },
          false,
          false,
          0
        );
        continue;
      }
      const slot = index - ready,
        running = slot === 0 && !!selected.job;
      const job = running ? selected.job : selected.waiting[slot - (selected.job ? 1 : 0)];
      const locked = slot >= selected.capacity,
        next = slot === selected.capacity;
      const price = game.queueSlotPrice(selected.id, slot),
        access = game.queueSlotUnlockStatus(selected.id, slot);
      const id = locked ? (next ? 'expand-queue' : 'queue-locked-' + slot) : 'queue-slot-' + slot;
      const queued = job && !running ? job : null;
      slotView.render(
        ctx,
        id,
        slotSize,
        u,
        () => {
          if (locked) app.act({ type: 'expandQueue', machine: selected.id });
        },
        ctx.canAct && locked && next && access.unlocked && s.coins >= price,
        job
          ? {
              image: product(job.product).image,
              label: countdown(running ? remainingSeconds(job.ready, s.time, ctx.speed) : job.duration / ctx.speed),
              tone: running ? 'running' : 'queued',
              ...(queued && {
                cancel: {
                  id: 'cancel-job-' + queued.id,
                  action: () => app.act({ type: 'cancelQueued', machine: selected.id, job: queued.id }),
                  enabled: ctx.canAct,
                },
              }),
            }
          : null,
        locked,
        next,
        price,
        access.unlocked ? undefined : access.requiredLevel
      );
      // Every job has its own finish-now price right under it: time left for the running one, all of it when queued.
      const boostPrice = job ? game.machineBoostPrice(selected.id, job.id) : 0;
      if (job && boostPrice) {
        const pill = ui.node(
          boostRow,
          'boost-job-' + job.id,
          slotX * u,
          boostY * u,
          (slotSize - 4) * u,
          QUEUE_BOOST_HEIGHT * u
        );
        const face = art.island(
          pill,
          'info',
          0,
          0,
          (slotSize - 4) / PANEL_BOOST_SCALE,
          QUEUE_BOOST_HEIGHT / PANEL_BOOST_SCALE,
          'Face'
        );
        face.setScale(PANEL_BOOST_SCALE * u, PANEL_BOOST_SCALE * u, 1);
        const affordable = s.diamonds >= boostPrice;
        const label = ui.text(
          pill,
          'Title',
          String(boostPrice),
          // "N" ends just left of centre and the gem sits just right of it, so the pair reads as one centred group.
          -(slotSize / 4 + 1) * u,
          u,
          (slotSize / 2 - 6) * u,
          22 * u,
          13 * u,
          affordable ? brown : muted
        );
        label.horizontalAlign = Label.HorizontalAlign.RIGHT;
        label.overflow = Label.Overflow.SHRINK;
        if (art.shopFont) label.font = art.shopFont;
        art.plot(pill, 'gem', 10 * u, 0, 16 * u, 16 * u, 'Gem');
        const target = job.id;
        ui.bindButton(
          pill,
          'boost-job-' + job.id,
          () => app.act({ type: 'boostMachine', machine: selected.id, job: target }, 'Chon sp'),
          ctx.canAct && affordable
        );
      }
      if (running && job) {
        const current = job;
        ctx.timer(() => {
          if (slotView.stateLabel.isValid)
            slotView.stateLabel.string = countdown(remainingSeconds(current.ready, s.time, ctx.speed));
        });
      }
    }
    const hasReturn =
      state.recipeReturnMachineId >= 0 &&
      (state.recipeReturnMachineId !== selected.id || state.recipeReturnRecipeId !== r.id);
    const bodyTop = split ? 62 : QUEUE_ROW_TOP + rowHeight + 14,
      footerY = -h / 2 + layout.footerBottom + 22;
    const scrollHeight = h - bodyTop - layout.footerBottom - 44 - 10;
    const cols = workspaceWidth >= 400 ? 3 : 2,
      cellWidth = workspaceWidth / cols,
      recipeRow = 104;
    const heroHeight = split ? 60 : 72,
      ingredientTop = heroHeight + 22;
    const ingredientCols = inputs.length === 1 ? 1 : 2,
      ingredientWidth = workspaceWidth / ingredientCols;
    const contentHeight = state.factoryRecipesExpanded
      ? 32 + Math.ceil(recipes.length / cols) * recipeRow
      : ingredientTop + Math.ceil(inputs.length / ingredientCols) * 60 - 8 + (split ? 16 : 24);
    v.resizeScroll(workspaceX, h / 2 - bodyTop - scrollHeight / 2, workspaceWidth, scrollHeight, contentHeight, u);
    const viewport = { scroll: v.scroll };
    ctx.adoptScroll(v.scroll);
    v.recipe.active = !state.factoryRecipesExpanded;
    v.picker.active = state.factoryRecipesExpanded;
    const cards = v.syncCards(
      state.factoryRecipesExpanded ? recipes.length : 0,
      state.factoryRecipesExpanded ? 0 : inputs.length
    );
    const content = state.factoryRecipesExpanded ? v.picker : v.recipe;
    if (state.factoryRecipesExpanded) {
      text(
        content,
        'RecipePickerTitle',
        'Chọn công thức',
        workspaceWidth / 2,
        -13,
        workspaceWidth,
        25,
        15,
        brown,
        Label.HorizontalAlign.LEFT
      );
      recipes.forEach((recipe, i) => {
        const available = game.recipeUnlockStatus(recipe.id),
          x = cellWidth * ((i % cols) + 0.5),
          y = -32 - recipeRow / 2 - Math.floor(i / cols) * recipeRow;
        cards.choices[i].render(ctx, recipe, recipe.id === r.id, available.unlocked, x, y, cellWidth - 8, u, () => {
          state.selectedRecipeId = recipe.id;
          state.factoryRecipesExpanded = false;
          viewport.scroll.scrollToTop(0);
          ctx.render();
        });
      });
    } else {
      item(content, r.image, 28, -heroHeight / 2, 54, 'RecipeHero');
      const quantity = recipeOutputs(r).reduce((n, output) => n + output.quantity, 0);
      skin(content, 'shopQuantity', 44, -heroHeight / 2 - 20, 26, 15, 'RecipeQuantityBackground');
      text(content, 'RecipeQuantity', `×${quantity}`, 44, -heroHeight / 2 - 20, 24, 15, 10, Color.WHITE);
      const titleWidth = workspaceWidth - 134,
        titleX = 65 + titleWidth / 2;
      text(
        content,
        'RecipeTitle',
        r.name,
        titleX,
        -heroHeight / 2 + 10,
        titleWidth,
        30,
        17,
        brown,
        Label.HorizontalAlign.LEFT
      );
      text(
        content,
        'RecipeMeta',
        `${wait(r.duration)} · +${r.xp ?? 10} XP`,
        titleX,
        -heroHeight / 2 - 14,
        titleWidth,
        20,
        11,
        muted,
        Label.HorizontalAlign.LEFT
      );
      const pinned = state.pinnedRecipeId === r.id;
      button(
        content,
        hasReturn ? 'factory-production-return' : 'pin-recipe',
        hasReturn ? 'Quay lại' : pinned ? 'Bỏ ghim' : 'Ghim',
        workspaceWidth - 28,
        -heroHeight / 2,
        56,
        44,
        () => {
          if (hasReturn) {
            returnToProduction(ctx);
            return;
          }
          state.pinnedRecipeId = pinned ? 0 : r.id;
          if (!pinned) {
            state.recipeReturnMachineId = selected.id;
            state.recipeReturnRecipeId = r.id;
          } else if (state.recipeReturnMachineId === selected.id && state.recipeReturnRecipeId === r.id) {
            state.recipeReturnMachineId = -1;
            state.recipeReturnRecipeId = 0;
          }
          ctx.render();
        }
      );
      text(
        content,
        'IngredientsTitle',
        'Nguyên liệu',
        workspaceWidth / 2,
        -heroHeight - 10,
        workspaceWidth,
        18,
        12,
        muted,
        Label.HorizontalAlign.LEFT
      );
      inputs.forEach((ingredient, i) => {
        const width = ingredientWidth - (ingredientCols > 1 ? 6 : 0);
        cards.ingredients[i].render(
          ctx,
          'recipe-ingredient-' + i,
          ingredient,
          ingredientWidth * ((i % ingredientCols) + 0.5),
          -ingredientTop - 26 - Math.floor(i / ingredientCols) * 60,
          width,
          u,
          () => {
            rememberProductionTarget(ctx, selected.id, r.id);
            state.sourceRecipeId = r.id;
            app.open('ingredients');
          }
        );
      });
      text(
        content,
        'RecipeHint',
        unlock.unlocked ? 'Chạm nguyên liệu để tìm nguồn' : unlock.reason,
        workspaceWidth / 2,
        -contentHeight + 9,
        workspaceWidth - 4,
        18,
        10,
        muted
      );
    }
    const chooseWidth = Math.min(150, w * 0.37),
      produceWidth = w - chooseWidth - 10;
    button(
      card,
      'choose-recipe',
      state.factoryRecipesExpanded ? 'Về món chọn' : 'Chọn món',
      left + chooseWidth / 2,
      footerY,
      chooseWidth,
      44,
      () => {
        state.factoryRecipesExpanded = !state.factoryRecipesExpanded;
        viewport.scroll.scrollToTop(0);
        ctx.render();
      }
    );
    button(
      card,
      'produce-' + r.id,
      !unlock.unlocked
        ? 'Chưa mở món'
        : !enough
          ? 'Tìm nguyên liệu'
          : !game.canQueue(selected)
            ? 'Hàng đợi đầy'
            : 'Chế biến',
      left + chooseWidth + 10 + produceWidth / 2,
      footerY,
      produceWidth,
      44,
      () => {
        if (!enough) {
          rememberProductionTarget(ctx, selected.id, r.id);
          state.sourceRecipeId = r.id;
          app.open('ingredients');
        } else app.act({ type: 'produce', recipe: r.id, machine: selected.id }, 'Lo vi Song');
      },
      unlock.unlocked && (!enough || (ctx.canAct && game.canQueue(selected))),
      'green'
    );
  },
};
