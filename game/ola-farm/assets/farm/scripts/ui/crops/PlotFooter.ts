import { runtimeConfig } from '../../core/FarmRuntime';
import { EventTouch, instantiate, Label, Node, UITransform, Vec3 } from 'cc';
import { SeedPickerView } from './SeedPickerView';
import { SeedTileView } from './SeedTileView';
import { Art } from '../../render/Art';
import { FarmGame } from '../../core/FarmGame';
import type { FarmItem, Plot } from '../../core/types/PlotTypes';
import { countdown, remainingSeconds } from '../../core/Countdown';
import { seedIcon } from '../../render/Icons';
import { Ui } from '../../render/Ui';
import type { FooterActions, SeedHoldState } from './PlotFooter.types';
import { PLOT_FOOTER_TOP, FOOTER_BOTTOM, FOOTER_MAX_WIDTH } from './PlotFooter.constants';

/**
 * Seed picker for an empty plot: a scrollable row of Golden Island's hex tiles with no panel behind them, so the
 * farm stays visible. Holding a tile peeks at the seed — its name and how long it takes — on the card above,
 * where the source game puts DetailSeeds beside the tiles.
 */
export class PlotFooter {
  readonly node: Node;
  private view!: SeedPickerView;
  private card!: Node;
  private cardName!: Label;
  private cardTime!: Label;
  private ring!: Node;
  private held: SeedHoldState = {
    timer: null,
    start: null,
    fired: false,
  };

  constructor(
    parent: Node,
    private ui: Ui,
    private art: Art,
    private game: FarmGame,
    plot: Plot,
    canvasWidth: number,
    private speed: number,
    private actions: FooterActions
  ) {
    const w = Math.min(FOOTER_MAX_WIDTH, canvasWidth - 16),
      h = PLOT_FOOTER_TOP - FOOTER_BOTTOM;
    this.node = instantiate(ui.prefabs.seedPicker);
    parent.addChild(this.node);
    this.node.name = 'PlotFooter';
    this.view = this.node.getComponent(SeedPickerView)!;
    this.view.begin(ui);
    const seeds = game.catalog.farm
      .filter(f => f.group === plot.group)
      .sort((a, b) => (a.requiredLevel ?? 1) - (b.requiredLevel ?? 1));
    this.view.resize(w, h, seeds.length);
    this.node.once(Node.EventType.NODE_DESTROYED, () => this.release());
    ui.align(this.node, { bottom: FOOTER_BOTTOM, centerX: 0 });
    this.buildCard();
    this.buildSeeds(w, seeds);
    const resident = this.view.residentAction;
    resident.active = plot.group === 'pen';
    this.view.place(resident, w / 2 - 113, -12, 190, 92);
    if (resident.active) this.view.bind(ui, resident, 'resident-pen', actions.livestock, actions.enabled);
    const rescue = this.view.rescueAction;
    rescue.active = plot.group === 'crop' && game.canRescue();
    if (rescue.active) this.view.bind(ui, rescue, 'rescue', actions.rescue, actions.enabled);
  }

  /** Hidden until a tile is held, then it sits just over that tile and stays until the next hold or a tap on it. */
  private buildCard(): void {
    this.card = this.view.info;
    this.cardName = this.view.seedName;
    this.cardTime = this.view.seedTime;
    this.card.on(Node.EventType.TOUCH_END, () => this.hideCard());
    this.card.active = false;
  }

  /** The prefab owns the horizontal mask and complete seed cards; only catalog bindings change. */
  private buildSeeds(w: number, seeds: FarmItem[]): void {
    const content = this.view.scroll.content!,
      width = Math.max(w, seeds.length * this.view.tileSpacing);
    this.ring = this.view.selection;
    this.ring.active = false;
    const tiles = content.children.filter(n => !!n.getComponent(SeedTileView));
    while (tiles.length < seeds.length) {
      const tile = instantiate(this.view.tilePrefab);
      content.addChild(tile);
      tiles.push(tile);
    }
    tiles.forEach((tile, i) => {
      tile.active = i < seeds.length;
    });
    const margin = (width - seeds.length * this.view.tileSpacing) / 2;
    seeds.forEach((seed, i) => {
      const tile = tiles[i],
        v = tile.getComponent(SeedTileView)!;
      tile.setPosition(margin + this.view.tileSpacing * (i + 0.5), 0);
      const access = this.game.cropUnlockStatus(seed.id);
      const affordable = this.actions.enabled && access.unlocked && this.game.state.coins >= seed.price;
      v.render(
        this.ui,
        this.art,
        `plant-${seed.id}`,
        seedIcon(this.art, seed),
        seed.price,
        affordable,
        () => {
          if (!this.held.fired) this.actions.plant(seed.id);
        },
        access.unlocked ? undefined : access.requiredLevel
      );
      this.watchHold(tile, seed);
    });
  }

  /** Press and hold to read the seed; the touch that ends the hold must not plant it. */
  private watchHold(tile: Node, seed: FarmItem): void {
    tile.on(Node.EventType.TOUCH_START, (e: EventTouch) => {
      const p = e.getUILocation();
      this.held = {
        start: new Vec3(p.x, p.y, 0),
        fired: false,
        timer: setTimeout(
          () => {
            if (!this.node.isValid || !tile.isValid) return;
            this.held.fired = true;
            this.peek(tile, seed);
          },
          runtimeConfig(this.game.catalog).input.longPressSeconds * 1000
        ),
      };
    });
    tile.on(Node.EventType.TOUCH_MOVE, (e: EventTouch) => {
      const start = this.held.start,
        p = e.getUILocation();
      if (start && Math.hypot(p.x - start.x, p.y - start.y) > runtimeConfig(this.game.catalog).input.seedDragSlop)
        this.release();
    });
    tile.on(Node.EventType.TOUCH_END, () => this.release());
    tile.on(Node.EventType.TOUCH_CANCEL, () => this.release());
  }

  private peek(tile: Node, seed: FarmItem): void {
    const transform = this.node.getComponent(UITransform)!;
    const local = transform.convertToNodeSpaceAR(tile.worldPosition);
    const limit = Math.max(0, transform.width / 2 - this.card.getComponent(UITransform)!.width / 2);
    this.card.setPosition(Math.max(-limit, Math.min(limit, local.x)), this.card.position.y);
    this.card.active = true;
    const access = this.game.cropUnlockStatus(seed.id);
    this.cardName.string = seed.name + (access.unlocked ? '' : ` · Lv ${access.requiredLevel}`);
    this.cardTime.string = countdown(remainingSeconds(seed.duration, 0, this.speed));
    this.ring.active = true;
    this.ring.setPosition(tile.position.x, tile.position.y);
    this.ring.setSiblingIndex(this.ring.parent!.children.length - 1);
  }

  /** Letting go leaves the card up to read; it closes on the next hold, on a tap on it, or with the strip. */
  private release(): void {
    if (this.held.timer) clearTimeout(this.held.timer);
    this.held.timer = null;
    this.held.start = null;
    // The click that ends this touch is dispatched right after, so clear the flag only once it has run.
    setTimeout(() => {
      this.held.fired = false;
    }, 0);
  }

  private hideCard(): void {
    if (!this.card.isValid) return;
    this.card.active = false;
    this.ring.active = false;
  }
}
