import { HERD_BAR_HEIGHT, HERD_BAR_BOTTOM } from './constants/Metrics.constants';
import { view } from 'cc';

/** Design units from the bottom of the canvas to the top of the herd quick bar at the current frame width. */
export function herdBarTop(designWidth: number): number {
  return ((HERD_BAR_HEIGHT + HERD_BAR_BOTTOM) * designWidth) / Math.max(1, view.getFrameSize().width);
}
