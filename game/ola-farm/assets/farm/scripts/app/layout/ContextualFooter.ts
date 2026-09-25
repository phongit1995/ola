import { Node } from 'cc';
import type { GameApp } from '../bootstrap/GameApp';
import { penDefinition } from '../../core/FarmCatalog';
import { FARM_LAYOUT, canMoveBuilding } from '../../core/BuildingPlacement';
import { BuildingMoveToolbar } from '../../ui/shared/BuildingMoveToolbar';
import { HEADER_HEIGHT } from '../../ui/hud/HudView.constants';
import { PlotFooter } from '../../ui/crops/PlotFooter';
import { fitProductionTarget } from '../../ui/shared/ProductionTouch';

/**
 * The strip under the map that follows what the player is doing: the seed picker for an empty plot, the move
 * toolbar while arranging buildings, and the "back to production" shortcut in the top corner. Each widget is
 * rebuilt only when its cheap key changes; the canvas width is part of every key.
 */
export class ContextualFooter {
  /** Browser tests and the debug API find the strip by this node name. */
  readonly menu: Node;
  private plotFooter: PlotFooter | null = null;
  private footerKey = '';
  private moveToolbar: BuildingMoveToolbar | null = null;
  private moveToolbarWidth = 0;
  private productionReturn: Node | null = null;
  private productionReturnKey = '';

  constructor(
    private readonly app: GameApp,
    private readonly root: Node
  ) {
    this.menu = app.ui.fill(root, 'CellMenu');
  }

  /** True while a code-built strip occupies the bottom edge, so the toast moves above it. */
  get occupied(): boolean {
    return !!(this.plotFooter || this.moveToolbar);
  }

  /** Force the next render to rebuild the strip, for example after the canvas resized. */
  invalidate(): void {
    this.footerKey = '';
  }

  /** Drop every strip. The caller decides whether the plot selection survives. */
  clear(): void {
    this.app.ui.clear(this.menu);
    this.footerKey = '';
    this.plotFooter = null;
    this.moveToolbar = null;
  }

  /** Runs every frame; cheap when nothing changed. */
  render(): void {
    this.renderStrip();
    this.renderProductionReturn();
  }

  /**
   * A selected plot that is already growing is described by its own bubble on the map, the way Golden Island
   * does it; an empty one opens the seed picker. Pens never use the strip: they open their panel directly.
   */
  private renderStrip(): void {
    const app = this.app;
    if (app.map.movement.active) {
      this.renderArrangement();
      return;
    }
    const game = app.game;
    const p = game.state.plots.find(plot => plot.id === app.selected);
    if (!p || app.panels.view) {
      if (this.menu.children.length) app.closeCell();
      return;
    }
    if (penDefinition(game.catalog, p)) {
      if (p.residents) app.open('livestock', { penId: p.id });
      else app.open('shop', { shopTab: 'animals', shopItem: 'shop-animal-' + p.id, penId: p.id });
      return;
    }
    if (p.crop !== null) {
      if (this.menu.children.length) app.clearCell();
      return;
    }
    const state = game.state,
      enabled = app.session.canAct;
    const affordable = game.catalog.farm
      .filter(f => f.group === p.group)
      .map(f => (state.coins >= f.price ? '1' : '0'))
      .join('');
    const key = `${p.id}|${enabled}|${affordable}|${state.xp}|${game.canRescue()}|${app.width}`;
    if (key === this.footerKey) return;
    app.ui.clear(this.menu);
    this.footerKey = key;
    this.moveToolbar = null;
    this.plotFooter = new PlotFooter(this.menu, app.ui, app.art, game, p, app.width, app.session.speed, {
      enabled,
      plant: crop => app.act({ type: 'plant', plot: p.id, crop }, 'Cuoc dat'),
      livestock: () => app.open('livestock', { penId: p.id }),
      rescue: () => app.act({ type: 'rescue' }, 'Cuoc dat', () => app.closeCell()),
    });
    app.hud.setNavigationVisible(false);
    app.hud.setHint('');
    app.placeToast();
  }

  private renderArrangement(): void {
    const app = this.app,
      movement = app.map.movement;
    if (!this.moveToolbar || this.moveToolbarWidth !== app.width) {
      app.ui.clear(this.menu);
      this.footerKey = '';
      this.plotFooter = null;
      this.moveToolbarWidth = app.width;
      this.moveToolbar = new BuildingMoveToolbar(this.menu, app.ui, app.width, movement, app.directArrangement, {
        cancel: () => {
          app.map.cancelGesture();
          movement.cancel();
        },
        finish: () => app.finishArrangement(),
        cycle: delta => {
          app.map.cancelGesture();
          const ids = FARM_LAYOUT.buildings.filter(b => canMoveBuilding(app.game.state, b.id)).map(b => b.id);
          const i = ids.indexOf(movement.selected ?? '');
          const id = ids[(i + delta + ids.length) % ids.length];
          movement.select(id);
          app.map.focusBuilding(id);
        },
      });
    }
    this.moveToolbar.update();
    app.hud.setNavigationVisible(false);
    app.hud.setHint('');
  }

  /** A pinned production target stays reachable after visiting an ingredient's plot or pen. */
  private renderProductionReturn(): void {
    const app = this.app;
    const machine = app.panels.recipeReturnMachineId,
      recipe = app.panels.recipeReturnRecipeId;
    const product = app.game.product(recipe),
      target = app.game.state.machines.find(m => m.id === machine);
    const show =
      !app.panels.view && !app.map.movement.active && !!target && !!product && product.machine === target.type;
    const key = `${show}:${machine}:${recipe}:${app.width}:${app.frameWidth}`;
    if (key === this.productionReturnKey) return;
    this.productionReturnKey = key;
    if (this.productionReturn) {
      this.productionReturn.active = false;
      this.productionReturn.destroy();
      this.productionReturn = null;
    }
    if (!show || !product) return;
    const width = Math.min(390, app.width - 40);
    const button = app.ui.townButton(
      this.root,
      'return-production',
      `Về ${product.name}`,
      0,
      0,
      width,
      90,
      () => app.open('factory', { machineId: machine, recipeId: recipe }),
      true,
      'blue'
    );
    fitProductionTarget(button, app.width);
    app.ui.align(button, { top: HEADER_HEIGHT + 10, right: 20 });
    this.productionReturn = button;
  }
}
