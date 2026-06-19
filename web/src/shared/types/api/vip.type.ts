export interface VipIconCatalogItem {
  id: string;
  vipTypeId: number;
  kenPrice: number;
}

export interface VipIconCatalogResult {
  total: number;
  items: VipIconCatalogItem[];
}

export interface VipIconInstance {
  instanceId: string;
  typeId: number;
  isLocked: boolean;
  isUsing: boolean;
  source: string;
  acquiredAt: string;
}

export interface BuyVipIconResult {
  item: VipIconInstance;
  kenBalance: number;
}
