import type { SHOP_TABS } from './Shop.enum';

export type ShopTab = (typeof SHOP_TABS)[keyof typeof SHOP_TABS];
