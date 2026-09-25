export interface ShopEntry {
  id: string;
  name: string;
  prefab?: string;
  quantity: string;
  description: string;
  detail: boolean;
  label: string;
  /** A construction price is shown as the amount and the existing wallet coin sprite. */
  coinPrice?: number;
  locked: boolean;
  enabled: boolean;
  buy: () => void;
}

export interface AuthoredNode {
  x: number;
  y: number;
  width: number;
  height: number;
  scaleX: number;
  scaleY: number;
}
