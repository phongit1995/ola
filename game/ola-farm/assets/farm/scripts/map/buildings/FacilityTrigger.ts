import { _decorator, Component } from 'cc';

const { ccclass, property } = _decorator;

/** A decorative building that opens a panel when tapped. Lives on the placement node inside scenes.prefab/Scenery. */
@ccclass('FacilityTrigger')
export class FacilityTrigger extends Component {
  @property({ tooltip: 'Stable ID reported by diagnostics and tests, e.g. barn.' })
  id = '';

  @property({ tooltip: 'Panel opened on tap, e.g. inventory or pause.' })
  view = '';

  @property({ tooltip: 'Tap area width in map units.' })
  hitWidth = 200;

  @property({ tooltip: 'Tap area height in map units.' })
  hitHeight = 170;

  @property({ tooltip: 'Vertical offset of the tap area from the placement position.' })
  offsetY = 45;
}
