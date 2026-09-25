import { instantiate, Node, view } from 'cc';
import { Art } from '../../render/Art';
import { FarmGame } from '../../core/FarmGame';
import type { Plot } from '../../core/types/PlotTypes';
import { Ui } from '../../render/Ui';
import { HERD_BAR_BOTTOM } from '../../render/constants/Metrics.constants';
import { HerdQuickBarView } from './HerdQuickBarView';
import type { HerdBarActions } from './LivestockQuickBar.types';

/** Golden Island artwork around the existing on-map herd actions; management remains a separate view. */
export class LivestockQuickBar {
  readonly node: Node;
  constructor(parent: Node, ui: Ui, art: Art, game: FarmGame, plot: Plot, width: number, actions: HerdBarActions) {
    const frameWidth = Math.max(1, view.getFrameSize().width),
      u = width / frameWidth;
    const w = Math.min(560, frameWidth - 24);
    this.node = instantiate(ui.prefabs.herdQuickBar);
    this.node.name = 'LivestockQuickBar';
    parent.addChild(this.node);
    const authored = this.node.getComponent(HerdQuickBarView);
    if (!authored) throw Error('HerdQuickBar prefab thiếu HerdQuickBarView.');
    authored.bind(ui, art, game, plot, w, u, actions);
    ui.align(this.node, { bottom: HERD_BAR_BOTTOM * u, centerX: 0 });
  }
}
