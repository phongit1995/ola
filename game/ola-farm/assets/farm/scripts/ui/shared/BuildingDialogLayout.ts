import { BUILDING_HEADER } from './BuildingDialogLayout.constants';
import type { DialogHeader } from './DialogShellView.types';

/** Native title artwork with the close button anchored to the dialog's top-right corner. */
export function buildingDialogHeader(width: number, frameWidth: number): DialogHeader {
  // Keep the source title scale; fit the 44px close target into the header on every viewport.
  const headerScale = BUILDING_HEADER.scale,
    closeX = Math.min(width / 2 - BUILDING_HEADER.closeHalfTarget, frameWidth / 2 - BUILDING_HEADER.screenCloseInset);
  return {
    scale: headerScale,
    titleTop: (BUILDING_HEADER.height / 2 - BUILDING_HEADER.titleY) * headerScale,
    titleHeight: BUILDING_HEADER.titleHeight * headerScale,
    fontSize: BUILDING_HEADER.fontSize * headerScale,
    closeX,
    closeTop: BUILDING_HEADER.closeTop,
    closeWidth: BUILDING_HEADER.closeWidth * headerScale,
    closeHeight: BUILDING_HEADER.closeHeight * headerScale,
  };
}
