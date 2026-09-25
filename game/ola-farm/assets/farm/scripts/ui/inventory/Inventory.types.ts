import type { INVENTORY_TABS } from './Inventory.enum';

export type InventoryTab = (typeof INVENTORY_TABS)[keyof typeof INVENTORY_TABS];
