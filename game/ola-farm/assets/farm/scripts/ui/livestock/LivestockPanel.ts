import { penDefinition } from '../../core/FarmCatalog';
import { instantiate, Label, Node, Prefab, Sprite, UITransform, Vec3, view } from 'cc';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { LivestockBodyView } from './LivestockBodyView';
import { HerdSlotView } from './HerdSlotView';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import { countdown, remainingSeconds } from '../../core/Countdown';
import { penNames, yardPrefabs, READY_LABELS } from './LivestockPanel.constants';
import {
  PANEL_BROWN as brown,
  PANEL_MUTED as muted,
  PANEL_GREEN as green,
  PANEL_WARNING,
} from '../shared/PanelPalette.constants';
import { livestockLayout } from './LivestockLayout';
import { t } from '../../core/i18n/I18n';

/** Prefab roots include a generic canvas; fit the visible animal parts, not that empty canvas. */
function animalPortrait(parent: Node, prefab: Prefab, width: number, height: number): void {
  let model = parent.children[0];
  const source = (model as unknown as { prefab?: { asset?: Prefab } } | undefined)?.prefab?.asset;
  if (!model || source !== prefab) {
    for (const child of [...parent.children]) {
      child.removeFromParent();
      child.destroy();
    }
    model = instantiate(prefab);
    parent.addChild(model);
  }
  model.setPosition(0, 0);
  model.setScale(1, 1, 1);
  const sprites = model
    .getComponentsInChildren(Sprite)
    .filter(sprite => sprite.node.activeInHierarchy && sprite.spriteFrame);
  const bounds = sprites.map(sprite => sprite.node.getComponent(UITransform)!.getBoundingBoxToWorld());
  if (!bounds.length) return;
  const left = Math.min(...bounds.map(box => box.xMin)),
    right = Math.max(...bounds.map(box => box.xMax));
  const bottom = Math.min(...bounds.map(box => box.yMin)),
    top = Math.max(...bounds.map(box => box.yMax));
  const scale = parent.worldScale;
  const fit = Math.min(width / ((right - left) / scale.x), height / ((top - bottom) / scale.y));
  if (!Number.isFinite(fit) || fit <= 0) return;
  const center = parent
    .getComponent(UITransform)!
    .convertToNodeSpaceAR(new Vec3((left + right) / 2, (bottom + top) / 2));
  model.setScale(fit, fit, 1);
  model.setPosition(-center.x * fit, -center.y * fit);
}

/** Each paid slot owns one resident and its hunger, feeding and product state. */
export const livestockPanel: PanelDefinition = {
  title(ctx) {
    return ctx.game.penName(ctx.state.penId);
  },
  render(ctx: PanelContext): void {
    const { app, state, game, farm: s, ui, art } = ctx;
    let body = ctx.card.getComponentInChildren(LivestockBodyView);
    if (!body) {
      const node = instantiate(ui.prefabs.livestockBody);
      ctx.card.addChild(node);
      body = node.getComponent(LivestockBodyView)!;
    }
    const v = body;
    v.begin(ui);
    v.node.getComponent(UITransform)!.setContentSize(ctx.width, ctx.height);
    let current: AuthoredUiView = v,
      card = v.owned;
    const frame = view.getFrameSize(),
      layout = livestockLayout(app.width, frame.width, frame.height);
    const { unit: u, width: frameWidth, height: h, compact, gap, cellWidth, cellHeight } = layout;
    const w = frameWidth - 52,
      left = -w / 2,
      enabled = ctx.canAct;
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
      const label = current.label(parent, name, value, x, y, width, height, size, u, color);
      label.horizontalAlign = _align;
      return label;
    };
    const skin = (parent: Node, key: string, x: number, y: number, width: number, height: number, name = key) => {
      const node = current.element(parent, name);
      current.stateFrame(node.getComponent(Sprite)!, art.frame('island-ui/' + key));
      return current.skin(node, x, y, width, height, u);
    };
    const button = (
      parent: Node,
      id: string,
      title: string,
      x: number,
      y: number,
      width: number,
      height: number,
      action: () => void,
      active = true,
      primary = false
    ) => {
      const target =
        current instanceof HerdSlotView
          ? current.actionButton
          : current.element(['feed-all', 'collect-all-animals'].includes(id) ? v.careActions : parent, id);
      return current.action(
        target,
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
        active,
        primary && active ? 'green' : 'info'
      );
    };
    const portrait = (
      parent: Node,
      prefabKey: string,
      x: number,
      y: number,
      width: number,
      height: number,
      name = 'AnimalPortrait'
    ) => {
      const node = current.place(current.element(parent, name), x, y, width, height, u),
        prefab = art.prefabs.get(prefabKey);
      if (prefab) animalPortrait(node, prefab, width * u, height * u);
    };
    const p = s.plots.find(p => p.id === state.penId && p.group === 'pen');
    const definition = penDefinition(game.catalog, p);
    const type = game.catalog.livestock?.find(animal => animal.key === (p?.residents?.species ?? definition?.species));
    if (!p || !type) return;
    const name = penNames[type.key] ? t(penNames[type.key]) : type.name.toLowerCase();
    const pen = p.residents;
    v.owned.active = !!pen;
    v.unopened.active = !pen;
    card = pen ? v.owned : v.unopened;
    const footerY = layout.footerY,
      hasMill = game.animalPurchasingReady;
    if (!pen) {
      const unlock = game.penUnlockStatus(p.id),
        price = game.penPurchasePrice(p.id);
      const top = h / 2 - 64,
        bottom = footerY + 32,
        areaHeight = top - bottom;
      const previewWidth = compact ? w * 0.4 : w,
        previewHeight = compact ? areaHeight - 12 : Math.min(160, areaHeight * 0.55);
      portrait(
        card,
        yardPrefabs[type.key] ?? type.prefab,
        compact ? left + previewWidth / 2 : 0,
        compact ? (top + bottom) / 2 : top - previewHeight / 2,
        previewWidth - 20,
        previewHeight,
        'NewPenPortrait'
      );
      const detailWidth = compact ? w - previewWidth - 14 : w - 16;
      text(
        card,
        'PenUnlock',
        !unlock.unlocked
          ? unlock.reason
          : !hasMill
            ? t('pen.needFeedMillToRaise')
            : t('pen.buildHint', { count: game.startingAnimals(type.key), name, max: game.penCapacityLimit(type.key) }),
        compact ? left + previewWidth + 14 + detailWidth / 2 : 0,
        compact ? (top + bottom) / 2 : bottom + (areaHeight - previewHeight) / 2,
        detailWidth,
        compact ? areaHeight : areaHeight - previewHeight,
        14,
        muted
      );
      button(
        card,
        'purchase-pen',
        unlock.unlocked ? t('pen.buildButton', { name, coins: String(price) }) : t('pen.locked'),
        0,
        footerY,
        w,
        44,
        () => app.act({ type: 'buyPen', plot: p.id }),
        enabled && unlock.unlocked && hasMill && price !== null && s.coins >= price,
        true
      );
      return;
    }
    const capacityLimit = Math.max(pen.capacity, game.penCapacityLimit(type.key)),
      feedPerAnimal = game.feedPerAnimal(type.key);
    const hungry = pen.animals.filter(animal => !animal.job).length;
    const ready = pen.animals.filter(animal => animal.job && animal.job.ready <= s.time).length;
    const feed = game.item(type.feed),
      feedStock = game.quantity(type.feed);
    const feedLink = v.place(v.element(card, 'FeedStockDisplay'), 0, layout.feedY, w, layout.feedHeight, u);
    if (feed) v.image(feedLink, 'FeedIcon', art, `assets/sprites/${feed.image}.png`, -96, 0, layout.feedSize, u);
    text(
      feedLink,
      'FeedStock',
      t('pen.feedStock', { count: feedStock, name: feed?.name.toLowerCase() ?? t('pen.feedFallback') }),
      26,
      0,
      168,
      36,
      16,
      feedStock > 0 ? green : muted,
      Label.HorizontalAlign.LEFT
    );
    v.resizeScroll(
      h / 2 - layout.gridTop - layout.gridHeight / 2,
      w,
      layout.gridHeight,
      capacityLimit * cellWidth + (capacityLimit - 1) * gap,
      u
    );
    const grid = { scroll: v.scroll, content: v.scroll.content! };
    ctx.adoptScroll(v.scroll);
    v.careActions.active = true;
    const content = grid.content;
    content.children.forEach((node, i) => {
      node.active = i < capacityLimit;
    });
    for (let slot = 0; slot < capacityLimit; slot++) {
      const x = cellWidth / 2 + slot * (cellWidth + gap),
        y = -cellHeight / 2;
      const cell = content.children[slot],
        slotView = cell.getComponent(HerdSlotView)!;
      current = slotView;
      slotView.begin(ui);
      cell.name = 'herd-slot-' + slot;
      cell.setPosition(x * u, y * u);
      cell.getComponent(UITransform)!.setContentSize(cellWidth * u, cellHeight * u);
      const animal = pen.animals.find(a => a.slot === slot),
        locked = slot >= pen.capacity,
        small = cellHeight < 176;
      slotView.setState(
        locked,
        !!animal,
        !!animal?.job && animal.job.ready <= s.time,
        !!animal?.job && animal.job.ready > s.time
      );
      skin(cell, locked ? 'info' : 'material', 0, 0, cellWidth, cellHeight, 'SlotFace');
      const artX = small ? -cellWidth / 2 + 24 : 0,
        artY = small ? cellHeight / 2 - 24 : cellHeight / 2 - 46;
      const titleX = small ? 22 : 0,
        titleWidth = small ? cellWidth - 52 : cellWidth - 10;
      text(
        cell,
        'SlotNumber',
        t('pen.slotNumber', { number: slot + 1 }),
        titleX,
        cellHeight / 2 - 11,
        titleWidth,
        16,
        11,
        muted
      );
      const statusY = small ? cellHeight / 2 - 36 : -24;
      const statusWidth = small ? cellWidth - 52 : cellWidth - 10;
      const actionY = -cellHeight / 2 + 26,
        actionWidth = cellWidth - 8;
      if (locked) {
        slotView.place(slotView.lock, artX, small ? artY : cellHeight / 2 - 58, small ? 36 : 48, small ? 40.5 : 54, u);
        const access = game.penSlotUnlockStatus(p.id, slot);
        text(
          cell,
          'SlotStatus',
          access.unlocked ? t('common.locked') : t('pen.levelTooLow'),
          titleX,
          statusY,
          statusWidth,
          20,
          11,
          muted
        );
        const price = game.penSlotPrice(p.id, slot),
          next = slot === pen.capacity;
        button(
          cell,
          'unlock-pen-slot-' + slot,
          access.unlocked ? String(price) : `Level ${access.requiredLevel}`,
          0,
          actionY,
          actionWidth,
          44,
          () => app.act({ type: 'expandPen', plot: p.id, slot }),
          enabled && next && access.unlocked && hasMill && s.coins >= price,
          true
        );
        slotView.purchaseIcon.active = access.unlocked;
        if (access.unlocked) {
          slotView.text(
            slotView.actionButton.getChildByName('Title')!.getComponent(Label)!,
            String(price),
            -18,
            0,
            54,
            32,
            18,
            u
          );
          slotView.place(slotView.purchaseIcon, 26, 0, 26, 26, u);
        }
        continue;
      }
      if (!animal) {
        text(cell, 'SlotEmpty', '+', artX, artY, 36, 36, 26, muted);
        text(cell, 'SlotStatus', t('plots.empty'), titleX, statusY, statusWidth, small ? 26 : 20, 11, muted);
        button(
          cell,
          'buy-animal-' + slot,
          t('pen.buyAnimal', { name, coins: type.price }),
          0,
          actionY,
          actionWidth,
          44,
          () => app.act({ type: 'buyAnimal', plot: p.id, slot }),
          enabled && hasMill && s.coins >= type.price,
          true
        );
        continue;
      }
      const portraitY = small ? artY : cellHeight / 2 - 64;
      portrait(cell, type.prefab, artX, portraitY, small ? 40 : 72, small ? 44 : 76);
      const isReady = !!animal.job && animal.job.ready <= s.time;
      if (isReady) {
        const output = game.item(type.output);
        if (output)
          slotView.icon(
            slotView.product,
            art,
            `assets/sprites/${output.image}.png`,
            artX + (small ? 12 : 30),
            portraitY - (small ? 12 : 16),
            22,
            u
          );
      }
      const readyLabel = READY_LABELS[type.key] ? t(READY_LABELS[type.key]) : t('livestock.ready');
      const timeLeft = () => countdown(remainingSeconds(animal.job!.ready, s.time, ctx.speed));
      const boosting = !!animal.job && !isReady;
      const status = text(
        cell,
        'SlotStatus',
        !animal.job ? t('livestock.hungry') : isReady ? readyLabel : timeLeft(),
        titleX + (boosting ? 11 : 0),
        statusY,
        boosting ? 56 : statusWidth,
        20,
        12,
        !animal.job ? PANEL_WARNING : isReady ? green : muted
      );
      if (boosting) slotView.place(slotView.clockIcon, titleX - 28, statusY, 18, (18 * 37) / 44, u);
      {
        const collectLabel =
          type.key === 'layer'
            ? t('livestock.collectEggs')
            : type.key === 'dairy-cow'
              ? t('livestock.collectMilk')
              : type.key === 'pig'
                ? t('livestock.collectBacon')
                : t('livestock.collectWool');
        const price = game.animalBoostPrice(p.id, animal.id);
        button(
          cell,
          (boosting ? 'boost-animal-' : 'animal-') + animal.id,
          isReady ? collectLabel : boosting ? String(price) : t('livestock.feed'),
          0,
          actionY,
          actionWidth,
          44,
          () =>
            app.act(
              isReady
                ? { type: 'collectAnimals', plot: p.id, animal: animal.id }
                : boosting
                  ? { type: 'boostAnimal', plot: p.id, animal: animal.id }
                  : { type: 'feedAnimals', plot: p.id, animal: animal.id },
              'Chon sp'
            ),
          enabled && (isReady || (boosting ? s.diamonds >= price : feedStock >= feedPerAnimal)),
          true
        );
        if (boosting) {
          slotView.text(
            slotView.actionButton.getChildByName('Title')!.getComponent(Label)!,
            String(price),
            -16,
            0,
            32,
            32,
            18,
            u
          );
          slotView.place(slotView.boostIcon, 18, 0, 26, 26, u);
        }
        ctx.timer(() => {
          if (status.isValid && animal.job && animal.job.ready > s.time) status.string = timeLeft();
        });
      }
    }
    current = v;
    {
      const bw = (w - 8) / 2;
      button(
        card,
        'feed-all',
        t('livestock.feedAll', { count: hungry * feedPerAnimal }),
        -(bw / 2 + 4),
        footerY,
        bw,
        44,
        () => app.act({ type: 'feedAnimals', plot: p.id }),
        enabled && hungry > 0 && feedStock >= hungry * feedPerAnimal,
        true
      );
      button(
        card,
        'collect-all-animals',
        t('livestock.collectAll', { count: ready }),
        bw / 2 + 4,
        footerY,
        bw,
        44,
        () => app.act({ type: 'collectAnimals', plot: p.id }, 'Chon sp'),
        enabled && ready > 0,
        true
      );
    }
  },
};
