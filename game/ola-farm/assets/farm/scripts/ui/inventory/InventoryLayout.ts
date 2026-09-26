import { buildingDialogHeader } from '../shared/BuildingDialogLayout';
import { INVENTORY_LAYOUT } from './InventoryLayout.constants';
import { CLOSE_SIDE_MARGIN } from '../production/FactoryDialogFrame.constants';

/**
 * Warehouse window in CSS pixels, drawn in the factory frame: a wider split window on short landscape screens,
 * the same inner padding, and footer buttons inset from the border.
 */
export function inventoryLayout(designWidth: number, frameWidth: number, frameHeight: number) {
  const L = INVENTORY_LAYOUT,
    unit = designWidth / Math.max(1, frameWidth),
    split = frameWidth >= L.splitMinWidth && frameHeight < L.splitMaxHeight;
  // The close button sits outside the right border like the factory's; a narrow screen narrows the frame instead.
  const width = Math.min(split ? L.splitWidth : L.width, frameWidth - CLOSE_SIDE_MARGIN * 2),
    height = Math.min(L.height, frameHeight - L.screenMargin),
    short = height < L.shortHeight;
  const contentWidth = width - L.padding * 2,
    columns = Math.max(L.minColumns, Math.min(L.maxColumns, Math.round(contentWidth / L.preferredCellWidth)));
  const footerHeight = short ? L.shortFooterHeight : L.footerHeight,
    gridTop = height / 2 - L.gridTop,
    gridBottom = -height / 2 + footerHeight,
    buttonY = -height / 2 + L.footerBottom + L.buttonHeight / 2;
  const header = buildingDialogHeader(width, frameWidth);
  return {
    unit,
    width,
    height,
    short,
    contentWidth,
    /** Footer buttons keep a gap from the frame border on both sides. */
    buttonWidth: contentWidth - L.buttonInset * 2,
    columns,
    cellWidth: contentWidth / columns,
    rowHeight: short ? L.shortRowHeight : L.rowHeight,
    summaryY: height / 2 - L.summaryTop,
    tabsY: height / 2 - L.tabsTop,
    tabHeight: L.tabHeight,
    gridY: (gridTop + gridBottom) / 2,
    gridHeight: gridTop - gridBottom,
    hintY: buttonY + L.hintOffset,
    buttonY,
    buttonHeight: L.buttonHeight,
    header,
  };
}
