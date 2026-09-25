import { buildingDialogHeader } from '../shared/BuildingDialogLayout';
import { LIVESTOCK_LAYOUT } from './LivestockLayout.constants';

/** Fit whole resident cards in one row; swipe horizontally to reach the remaining slots. */
export function livestockLayout(designWidth: number, frameWidth: number, frameHeight: number) {
  const unit = designWidth / Math.max(1, frameWidth),
    compact = frameWidth >= LIVESTOCK_LAYOUT.compactMinWidth && frameHeight < LIVESTOCK_LAYOUT.compactMaxHeight;
  const width = Math.min(
    frameWidth >= LIVESTOCK_LAYOUT.wideMinWidth ? LIVESTOCK_LAYOUT.wideWidth : LIVESTOCK_LAYOUT.width,
    frameWidth - LIVESTOCK_LAYOUT.screenMargin
  );
  const height = Math.min(LIVESTOCK_LAYOUT.height, frameHeight - LIVESTOCK_LAYOUT.screenMargin),
    short = height < LIVESTOCK_LAYOUT.shortHeight;
  const footerY = -height / 2 + LIVESTOCK_LAYOUT.footerInset,
    feedHeight = short ? LIVESTOCK_LAYOUT.shortFeedHeight : LIVESTOCK_LAYOUT.feedHeight,
    feedSize = LIVESTOCK_LAYOUT.feedSize;
  const feedY = footerY + LIVESTOCK_LAYOUT.feedOffset + LIVESTOCK_LAYOUT.sectionGap + feedHeight / 2;
  const gridTop = short ? LIVESTOCK_LAYOUT.shortGridTop : LIVESTOCK_LAYOUT.gridTop,
    gridHeight = height / 2 - gridTop - (feedY + feedHeight / 2 + LIVESTOCK_LAYOUT.sectionGap);
  const gap = LIVESTOCK_LAYOUT.cellGap,
    contentWidth = width - LIVESTOCK_LAYOUT.contentInset;
  const columns = Math.max(
    1,
    Math.min(
      LIVESTOCK_LAYOUT.maxColumns,
      Math.round((contentWidth + gap) / (LIVESTOCK_LAYOUT.preferredCellWidth + gap))
    )
  );
  const cellWidth = (contentWidth - (columns - 1) * gap) / columns;
  const cellHeight = gridHeight;
  return {
    unit,
    width,
    height,
    compact,
    gap,
    gridTop,
    gridHeight,
    cellWidth,
    cellHeight,
    footerY,
    feedY,
    feedHeight,
    feedSize,
    header: buildingDialogHeader(width, frameWidth),
  };
}
