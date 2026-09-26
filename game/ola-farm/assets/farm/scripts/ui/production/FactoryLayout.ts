import { buildingDialogHeader } from '../shared/BuildingDialogLayout';
import { FACTORY_LAYOUT } from './FactoryLayout.constants';
import { CLOSE_SIDE_MARGIN } from './FactoryDialogFrame.constants';

/** Shared CSS geometry keeps the host frame and the production content in the same coordinate system. */
export function factoryLayout(designWidth: number, frameWidth: number, frameHeight: number) {
  const unit = designWidth / Math.max(1, frameWidth);
  const split = frameWidth >= FACTORY_LAYOUT.splitMinWidth && frameHeight < FACTORY_LAYOUT.splitMaxHeight;
  // The close button sits outside the right border; a narrow screen narrows the frame so it stays visible.
  const width = Math.min(split ? FACTORY_LAYOUT.splitWidth : FACTORY_LAYOUT.width, frameWidth - CLOSE_SIDE_MARGIN * 2);
  const height = Math.min(
    split ? FACTORY_LAYOUT.splitHeight : FACTORY_LAYOUT.height,
    frameHeight - FACTORY_LAYOUT.screenMargin
  );
  // Body navigation aligns with the title band in FactoryDialogFrame.prefab.
  const header = buildingDialogHeader(width, frameWidth);
  return {
    unit,
    split,
    width,
    height,
    padding: FACTORY_LAYOUT.padding,
    footerBottom: FACTORY_LAYOUT.footerBottom,
    header,
  };
}
