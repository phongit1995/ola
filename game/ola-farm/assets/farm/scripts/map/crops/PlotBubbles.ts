import type { BubbleActions, BubbleKind, BubbleView } from './PlotBubbles.types';
import { penDefinition } from '../../core/FarmCatalog';
import { instantiate, Node } from 'cc';
import { Art } from '../../render/Art';
import { Ui } from '../../render/Ui';
import { FarmGame } from '../../core/FarmGame';
import type { Plot } from '../../core/types/PlotTypes';
import { countdown, remainingSeconds } from '../../core/Countdown';
import { PlotBubbleView } from './PlotBubbleView';
import type { PlotPosition } from '../../render/types/MapTypes';

/**
 * The Golden Island bubbles that hang over a plot: a lock over a slot that is not cleared yet, the crop icon with its
 * yield once it ripens, and — only while the plot is selected — the name, the countdown and the "finish now" button.
 * Each bubble counter-scales with the camera like Unity's ZoomByCamera, so it keeps one size on screen.
 */
export class PlotBubbles {
  private views = new Map<number, BubbleView>();

  constructor(
    private layer: Node,
    private ui: Ui,
    private art: Art,
    private actions: BubbleActions
  ) {}

  update(
    positions: PlotPosition[],
    game: FarmGame,
    selected: number | null,
    scale: number,
    speed: number,
    visible: (x: number, y: number) => boolean
  ): void {
    const alive = new Set<number>();
    for (const p of positions) {
      const plot = p.plot;
      if (!game.isActivePlot(plot) || !visible(p.x, p.y)) continue;
      const kind = this.kindOf(game, plot, selected);
      if (kind === 'none') continue;
      alive.add(plot.id);
      const key = this.keyOf(game, plot, kind);
      let view = this.views.get(plot.id);
      if (view && view.key !== key) {
        this.dispose(view);
        this.views.delete(plot.id);
        view = undefined;
      }
      if (!view) {
        view = this.build(plot, game, kind, key);
        this.views.set(plot.id, view);
      }
      view.root.setPosition(p.x, p.y + p.h / 2);
      view.root.setScale(1 / scale, 1 / scale, 1);
      if (view.time) view.time.string = countdown(remainingSeconds(plot.ready, game.state.time, speed));
      if (view.price) view.price.string = String(game.boostPrice(plot));
    }
    for (const [id, view] of this.views)
      if (!alive.has(id)) {
        this.dispose(view);
        this.views.delete(id);
      }
  }

  private kindOf(game: FarmGame, plot: Plot, selected: number | null): BubbleKind {
    // Future resident yards use the herd badge and coin purchase, including before they own animals.
    if (plot.group === 'pen' && penDefinition(game.catalog, plot)) return 'none';
    // The green crop itself opens the land modal; show its lock/level or price there after a click.
    if (!plot.unlocked) return game.simple && plot.group === 'crop' ? 'none' : 'locked';
    if (plot.residents) return 'none';
    if (game.isReady(plot)) return 'ready';
    return plot.crop !== null && plot.id === selected ? 'growing' : 'none';
  }

  /** Only what changes the artwork; the countdown and the gem price are written into the existing labels. */
  private keyOf(game: FarmGame, plot: Plot, kind: BubbleKind): string {
    const snapshot = plot.snapshot;
    return `${kind}|${plot.crop}|${kind === 'ready' ? (snapshot?.output.quantity ?? 0) : ''}|${game.state.diamonds >= game.boostPrice(plot)}`;
  }

  private build(plot: Plot, game: FarmGame, kind: BubbleKind, key: string): BubbleView {
    if (kind === 'none') throw Error('Cannot create an empty plot bubble.');
    const root = instantiate(this.ui.prefabs.plotBubble);
    root.name = 'Bubble-' + plot.id;
    this.layer.addChild(root);
    const authored = root.getComponent(PlotBubbleView);
    if (!authored) throw Error('PlotBubble prefab thiếu PlotBubbleView.');
    authored.bind(this.ui, this.art, game, plot, kind, this.actions);
    return {
      root,
      kind,
      key,
      time: kind === 'growing' ? authored.time : null,
      price: kind === 'growing' ? authored.price : null,
    };
  }

  private dispose(view: BubbleView): void {
    view.root.active = false;
    view.root.destroy();
  }

  diagnostics(): Record<string, unknown>[] {
    return Array.from(this.views.entries()).map(([id, v]) => ({
      id,
      kind: v.kind,
      time: v.time?.string ?? null,
      price: v.price?.string ?? null,
    }));
  }
}
