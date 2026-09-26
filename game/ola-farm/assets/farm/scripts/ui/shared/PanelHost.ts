import type { InventoryTab } from '../inventory/Inventory.types';
import type { ShopTab } from '../shop/Shop.types';
import {
  _decorator,
  Button,
  Component,
  Node,
  BlockInputEvents,
  Prefab,
  instantiate,
  ScrollView,
  UITransform,
  Vec2,
  view as cocosView,
} from 'cc';
import { FarmGame } from '../../core/FarmGame';
import type { AppFacade, OpenOptions } from './AppFacade.types';
import type { PanelView } from './PanelView.types';
import { DialogShellView } from './DialogShellView';
import { LandPurchaseView } from '../land/LandPurchaseView';
import type { PanelContext, PanelState } from './PanelContext.types';
import { PANELS } from '../panels/index';
import { factoryLayout } from '../production/FactoryLayout';
import { livestockLayout } from '../livestock/LivestockLayout';
import { fitProductionTarget, fitProductionTargets, productionTargetSize } from './ProductionTouch';
import { AUTHORED_BODIES } from './PanelHost.constants';

const { ccclass } = _decorator;

/**
 * Hosts one modal at a time over the map. Panels are pure render functions; this component owns the
 * shield, the Golden Island popup, the scroll list and re-renders when state or canvas size changes.
 */
@ccclass('PanelHost')
export class PanelHost extends Component implements PanelState {
  view: PanelView | '' = '';
  shopTab: ShopTab = 'animals';
  shopItemId: string | null = null;
  machineTypeId = 1;
  sourceRecipeId = 0;
  selectedRecipeId = 0;
  pinnedRecipeId = 0;
  recipeReturnMachineId = -1;
  recipeReturnRecipeId = 0;
  factoryRecipesExpanded = false;
  machineId = 0;
  penId = 12;
  saleKey = '';
  saleQuantity = 1;
  inventoryTab: InventoryTab = 'raw';
  improveId: number | null = null;
  saveText = '';
  scroll: ScrollView | null = null;
  card!: Node;
  width = 900;
  height = 600;
  /** True only while a close animation would run; kept for the debug API. */
  readonly closing = false;

  private app!: AppFacade;
  private shopPrefab!: Prefab;
  private shopInstance: Node | null = null;
  private dialogInstance: DialogShellView | null = null;
  private landInstance: LandPurchaseView | null = null;
  private renderedBodyView: PanelView | '' = '';
  private hash = '';
  private timers: Array<() => void> = [];
  /** Set by SIZE_CHANGED; the re-render runs in update() so it happens inside the engine's update phase. */
  private sizeDirty = false;
  private frameWidth = 0;
  private renderedPenId: number | null = null;
  private renderedMachineId: number | null = null;
  /** Every committed action replaces the game object, so identity alone says whether state changed. */
  private renderedGame: FarmGame | null = null;

  setup(app: AppFacade, shopPrefab: Prefab): void {
    this.app = app;
    this.shopPrefab = shopPrefab;
    this.node.on(
      Node.EventType.SIZE_CHANGED,
      () => {
        this.sizeDirty = true;
      },
      this
    );
  }

  update(): void {
    if (!this.sizeDirty) return;
    this.sizeDirty = false;
    if (this.view) this.render();
  }

  hide(): void {
    this.view = '';
    this.hash = '';
    this.scroll = null;
    this.timers = [];
    this.renderedPenId = null;
    this.renderedMachineId = null;
    this.renderedGame = null;
    this.shopInstance = null;
    this.dialogInstance = null;
    this.landInstance = null;
    this.renderedBodyView = '';
    this.app.ui.clear(this.node);
  }

  close(done: () => void): void {
    this.hide();
    done();
  }

  show(view: PanelView): void {
    const changed = view !== this.view;
    if (changed) {
      this.scroll = null;
      if (view === 'inventory' && !['inventory-item', 'inventory-sales'].includes(this.view)) this.inventoryTab = 'raw';
    }
    this.view = view;
    this.render();
  }

  /** Store the caller's selection so the next render shows it. */
  prepare(options: OpenOptions): void {
    if (options.machineType !== undefined) this.machineTypeId = options.machineType;
    if (options.shopTab !== undefined && options.shopTab !== this.shopTab) {
      this.shopTab = options.shopTab;
      this.scroll = null;
    }
    if (options.shopItem !== undefined) {
      this.shopItemId = options.shopItem;
      this.scroll = null;
    }
    if (options.penId !== undefined) this.penId = options.penId;
    if (options.improveId !== undefined) this.improveId = options.improveId;
    if (options.machineId !== undefined) this.machineId = options.machineId;
    if (options.recipeId !== undefined) {
      this.selectedRecipeId = options.recipeId;
      this.factoryRecipesExpanded = false;
      this.recipeReturnMachineId = -1;
      this.recipeReturnRecipeId = 0;
    }
    if (options.saveText !== undefined) this.saveText = options.saveText;
  }

  /** Forget every machine and recipe selection, for example after a restart removed the machines. */
  resetProductionNavigation(): void {
    this.machineId = 0;
    this.machineTypeId = 1;
    this.selectedRecipeId = 0;
    this.sourceRecipeId = 0;
    this.pinnedRecipeId = 0;
    this.recipeReturnMachineId = -1;
    this.recipeReturnRecipeId = 0;
    this.factoryRecipesExpanded = false;
  }

  refresh(force = false): void {
    if (!this.view) return;
    if (this.frameWidth !== cocosView.getFrameSize().width || this.app.game !== this.renderedGame) force = true;
    for (const update of this.timers) update();
    const hash = this.snapshot();
    if (force || hash !== this.hash) {
      this.hash = hash;
      if (this.view !== 'save-text') this.render();
    }
  }

  /**
   * Only what the clock changes without an action: ripe plots, finished jobs and animal/machine boost prices.
   * Everything else arrives through a committed action, which `refresh` detects by game identity.
   */
  private snapshot(): string {
    const g = this.app.game,
      s = g.state;
    const plots = s.plots
      .map(p => {
        const herd = p.residents?.animals.map(a =>
          a.job ? (a.job.ready <= s.time ? 'r' : g.animalBoostPrice(p.id, a.id)) : '-'
        );
        return (g.isReady(p) ? 'r' : '.') + (herd?.join(',') ?? '');
      })
      .join('|');
    const machines = s.machines.map(m => `${m.job?.id ?? '-'}:${m.tray.length}:${g.machineBoostPrice(m.id)}`).join('|');
    const field = this.view === 'improve' && g.simple ? g.fieldUnlockOffer(this.improveId ?? -1) : null;
    // The open land offer must reflect wallet, level and sequential eligibility on every refresh.
    const land = field ? `${s.coins}:${g.progress.level}:${field.unlocked}:${field.price}:${field.reason}` : '';
    return `${plots}#${machines}#${this.app.session.paused}#${this.app.session.canAct}#${land}`;
  }

  private markRendered(): void {
    this.renderedGame = this.app.game;
    this.hash = this.snapshot();
  }

  render(): void {
    const app = this.app,
      ui = app.ui,
      view = this.view;
    if (!view) return;
    const samePen = view !== 'livestock' || this.renderedPenId === this.penId;
    const sameMachine = view !== 'factory' || this.renderedMachineId === this.machineId;
    const previousOffset = samePen && sameMachine && this.scroll?.isValid ? this.scroll.getScrollOffset() : null;
    if (!sameMachine) this.factoryRecipesExpanded = false;
    this.renderedMachineId = view === 'factory' ? this.machineId : null;
    this.renderedPenId = view === 'livestock' ? this.penId : null;
    this.timers = [];
    this.scroll = null;
    if (view === 'improve' && app.game.simple) {
      this.shopInstance = null;
      this.dialogInstance = null;
      this.renderedBodyView = '';
      if (!this.landInstance?.isValid) {
        ui.clear(this.node);
        const node = instantiate(ui.prefabs.landPurchase);
        this.node.addChild(node);
        this.landInstance = node.getComponent(LandPurchaseView);
        if (!this.landInstance) throw Error('LandPurchase.prefab thiếu LandPurchaseView.');
      }
      const frame = cocosView.getFrameSize();
      this.landInstance.present(app, this.improveId ?? -1, frame.width, frame.height);
      this.card = this.landInstance.card;
      this.frameWidth = frame.width;
      this.markRendered();
      return;
    }
    this.landInstance = null;
    if (view === 'shop') {
      this.dialogInstance = null;
      this.renderedBodyView = '';
      // Rebind the authored Shop without replacing its static nodes on tabs, refresh or resize.
      this.width = app.width;
      this.height = app.height;
      if (!this.shopInstance?.isValid) {
        ui.clear(this.node);
        const shield = ui.node(this.node, 'ModalShield', 0, 0, this.width, this.height);
        shield.addComponent(BlockInputEvents);
        this.shopInstance = instantiate(this.shopPrefab);
        shield.addChild(this.shopInstance);
        this.shopInstance.name = 'GoldenIslandShop';
      }
      this.card = this.shopInstance;
      this.card.parent!.getComponent(UITransform)!.setContentSize(this.width, this.height);
      this.card.getComponent(UITransform)!.setContentSize(this.width, this.height);
      ui.theme = 'island';
      try {
        PANELS.shop.render(this.context());
      } finally {
        ui.theme = 'farm';
      }
      this.frameWidth = cocosView.getFrameSize().width;
      this.restoreScroll(previousOffset);
      this.markRendered();
      return;
    }
    this.shopInstance = null;
    if (!this.dialogInstance?.isValid) {
      ui.clear(this.node);
      const prefab = ui.prefabs.dialogShell;
      if (!prefab) throw Error('UiPrefabs thiếu DialogShell.');
      const node = instantiate(prefab);
      this.node.addChild(node);
      node.name = 'ModalShield';
      this.dialogInstance = node.getComponent(DialogShellView);
      if (!this.dialogInstance) throw Error('DialogShell.prefab thiếu DialogShellView.');
      this.renderedBodyView = '';
    }
    const shell = this.dialogInstance;
    this.card = shell.card;
    if (this.renderedBodyView !== view || !AUTHORED_BODIES.has(view)) ui.clear(shell.body);
    this.renderedBodyView = view;
    this.width = Math.min(shell.authoredWidth, app.width - shell.marginX);
    this.height = Math.min(shell.authoredHeight, app.height - shell.marginY);
    const responsive = view === 'factory' || view === 'livestock';
    const building = responsive || view === 'industry';
    const frame = cocosView.getFrameSize();
    // Unbuilt-building details retain their compact large-screen scale.
    const buildingScale = view === 'industry' && Math.min(frame.width, frame.height) >= 600 ? 0.8 : 1;
    if (building) {
      this.width = Math.min(shell.buildingMaxWidth, app.width - shell.marginX);
      this.height = Math.min(shell.buildingMaxHeight, app.height - shell.marginY);
      if (responsive) {
        const layout =
          view === 'livestock'
            ? livestockLayout(app.width, frame.width, frame.height)
            : factoryLayout(app.width, frame.width, frame.height);
        this.width = layout.width * layout.unit;
        this.height = layout.height * layout.unit;
      }
    }
    ui.theme = 'island';
    try {
      const header = responsive
        ? (view === 'factory'
            ? factoryLayout(app.width, frame.width, frame.height)
            : livestockLayout(app.width, frame.width, frame.height)
          ).header
        : null;
      const definition = PANELS[view],
        ctx = this.context();
      const title = typeof definition.title === 'function' ? definition.title(ctx) : definition.title;
      shell.present({
        width: this.width,
        height: this.height,
        screenWidth: app.width,
        screenHeight: app.height,
        unit: app.width / Math.max(1, frame.width),
        kind: view === 'factory' ? 'factory' : view === 'livestock' ? 'livestock' : building ? 'building' : 'window',
        scale: buildingScale,
        header,
        title,
      });
      shell.activeCloseButton.off(Button.EventType.CLICK);
      ui.bindButton(shell.activeCloseButton, 'close-panel', () => {
        if (view === 'welcome') app.act({ type: 'dismissGuide' }, 'Click 1', () => app.close());
        else if (view === 'restart-confirm') app.open('pause');
        else app.close();
      });
      definition.render(ctx);
      if (!responsive) {
        // Authored inventory labels apply CSS minimums themselves so Inspector font edits survive.
        if (view === 'inventory') fitProductionTarget(shell.activeCloseButton, app.width);
        else fitProductionTargets(this.card, app.width);
      }
      this.frameWidth = cocosView.getFrameSize().width;
    } finally {
      ui.theme = 'farm';
    }
    this.restoreScroll(previousOffset);
    this.markRendered();
  }

  private restoreScroll(offset: Vec2 | null): void {
    if (!offset || !this.scroll) return;
    // Cocos reports horizontal displacement as negative, but scrollToOffset expects a positive distance.
    if (this.view === 'livestock' && this.scroll.horizontal) {
      this.scroll.scrollToOffset(new Vec2(Math.max(0, Math.min(-offset.x, this.scroll.getMaxScrollOffset().x)), 0), 0);
    } else this.scroll.scrollToOffset(offset, 0);
  }

  private context(): PanelContext {
    const app = this.app,
      host = this;
    return {
      app,
      state: this,
      ui: app.ui,
      art: app.art,
      game: app.game,
      farm: app.game.state,
      card: this.view === 'shop' ? this.card : this.dialogInstance!.body,
      width: this.width,
      height: this.height,
      canAct: app.session.canAct,
      speed: app.session.speed,
      list: height => host.list(height),
      footer: (id, title, action, left) => host.footer(id, title, action, left),
      timer: update => {
        host.timers.push(update);
        update();
      },
      render: () => host.render(),
      adoptScroll: scroll => {
        host.scroll = scroll;
      },
    };
  }

  private list(contentHeight: number): Node {
    const touch = productionTargetSize(this.app.width),
      top = this.height / 2 - 110,
      bottom = -this.height / 2 + touch + 28;
    const result = this.app.ui.scroll(this.dialogInstance!.body, this.width - 80, top - bottom, contentHeight);
    result.scroll.node.setPosition(0, (top + bottom) / 2);
    this.scroll = result.scroll;
    return result.content;
  }

  private footer(id: string, title: string, action: () => void, left?: boolean): void {
    const x = left === undefined ? 0 : (left ? -1 : 1) * this.width * 0.235;
    const variant = /^(focus-|inventory-sales|show-json|back-stock)/.test(id) ? 'blue' : 'green';
    const touch = productionTargetSize(this.app.width);
    this.app.ui.button(
      this.dialogInstance!.body,
      id,
      title,
      x,
      -this.height / 2 + touch / 2 + 14,
      left === undefined ? this.width - 130 : this.width * 0.42,
      touch,
      action,
      { variant }
    );
  }
}
