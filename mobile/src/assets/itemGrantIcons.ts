import type { ImageSourcePropType } from 'react-native';

export type ItemGrantIconKind = 'lock' | 'clock';

export const ITEM_GRANT_ICONS: Record<ItemGrantIconKind, ImageSourcePropType> = {
  lock: require('@shared-assets/item-grant/lock.png'),
  clock: require('@shared-assets/item-grant/clock.png'),
};
