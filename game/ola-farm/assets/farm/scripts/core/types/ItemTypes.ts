export interface StockItem {
  key: string;
  name: string;
  image: string;
  sellPrice: number;
  tab: 'raw' | 'goods';
  legacyId?: number;
}

export interface Ingredient {
  id?: number;
  key?: string;
  quantity: number;
}

export interface ItemAmount {
  key: string;
  quantity: number;
}
