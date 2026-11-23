import lock from '../../../../packages/shared/assets/item-grant/lock.png';
import clock from '../../../../packages/shared/assets/item-grant/clock.png';

export type ItemGrantIconKind = 'lock' | 'clock';

export const ITEM_GRANT_ICONS: Record<ItemGrantIconKind, string> = { lock, clock };
