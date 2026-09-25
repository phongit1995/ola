import { buildingDialogHeader } from '../shared/BuildingDialogLayout';
import { FACTORY_LAYOUT } from './FactoryLayout.constants';

/** Shared CSS geometry keeps the host frame and the production content in the same coordinate system. */
export function factoryLayout(designWidth: number, frameWidth: number, frameHeight: number) {
  const unit = designWidth / Math.max(1, frameWidth);
  const split = frameWidth >= FACTORY_LAYOUT.splitMinWidth && frameHeight < FACTORY_LAYOUT.splitMaxHeight;
  const width = Math.min(
    split ? FACTORY_LAYOUT.splitWidth : FACTORY_LAYOUT.width,
    frameWidth - FACTORY_LAYOUT.screenMargin
  );
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
