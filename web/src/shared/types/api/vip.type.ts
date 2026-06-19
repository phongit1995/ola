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

export interface VipPackageItem {
  id: string;
  name: string;
  days: number;
  kenPrice: number;
  isActive: boolean;
  sortOrder: number;
}

export interface VipPackageListResult {
  total: number;
  limit: number;
  offset: number;
  items: VipPackageItem[];
}

export interface BuyVipPackageResult {
  purchaseId: string;
  packageName: string;
  days: number;
  kenSpent: number;
  kenBalance: number;
  vipEndTime: string;
}

export interface VipStoreResult {
  userId: string;
  activeTypeId: number | null;
  vipEndTime: string | null;
  days: number | null;
  privacy: number;
  total: number;
  limit: number;
  offset: number;
  items: VipIconInstance[];
}
