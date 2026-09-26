import type { ProgressionConfig } from './ProgressionTypes';
import type { FarmCatalogSource } from './TimingTypes';

export interface SlotPrice {
  price: number;
  requiredLevel: number;
}

export interface Named {
  name: string;
}

export interface FieldConfig extends Named {
  initiallyUnlocked: boolean;
  initialLevel: number;
  unlockPrice: number;
  requiredLevel: number;
}

/** One-time XP for each construction purchase, like building in Hay Day or Township. */
export interface BuildXP {
  machine: number;
  pen: number;
  penSlot: number;
  queueSlot: number;
  field: number;
}

export interface FarmEconomyConfig {
  version: 1;
  startingWallet: { coins: number; diamonds: number; xp: number };
  experience: {
    plantingXP: number;
    saleCoinsPerXP: number;
    levelUpDiamonds: number;
    buildXP: BuildXP;
    curve: ProgressionConfig;
  };
  refunds: { cropCancelRate: number; animalSaleRate: number };
  coinPacks: { coins: number; diamonds: number }[];
  gemPacks: { gems: number; price: string }[];
  crops: Record<string, Named & { seedPrice: number; requiredLevel: number; harvestXP: number; yields: number[] }>;
  items: Record<string, Named & { sellPrice: number }>;
  recipes: Record<string, Named & { requiredLevel: number; xp: number }>;
  animals: Record<string, Named & { purchasePrice: number; quantity: number; xp: number; slots: SlotPrice[] }>;
  machines: Record<
    string,
    Named & { sites: { price: number | null; requiredLevel: number }[]; queueSlots: SlotPrice[] }
  >;
  pens: Record<string, Named & { sitePrice: number | null; requiredLevel: number }>;
  fields: Record<string, FieldConfig>;
}

/** JSON catalog before its editable balance and timing have been applied. Art/IDs and recipe topology stay here. */
export type FarmContentSource = Omit<
  FarmCatalogSource,
  | 'farm'
  | 'products'
  | 'livestock'
  | 'items'
  | 'machineTypes'
  | 'residentPens'
  | 'plantingXP'
  | 'saleXpCoins'
  | 'economy'
> & {
  farm: Omit<FarmCatalogSource['farm'][number], 'price' | 'sellPrice' | 'requiredLevel' | 'harvestXP' | 'yields'>[];
  products: Omit<FarmCatalogSource['products'][number], 'price' | 'requiredLevel' | 'xp'>[];
  livestock: Omit<FarmCatalogSource['livestock'][number], 'price' | 'quantity' | 'xp'>[];
  items: Omit<NonNullable<FarmCatalogSource['items']>[number], 'sellPrice'>[];
  machineTypes: (Omit<NonNullable<FarmCatalogSource['machineTypes']>[number], 'buildSites'> & {
    buildSites: Omit<
      NonNullable<NonNullable<FarmCatalogSource['machineTypes']>[number]['buildSites']>[number],
      'price' | 'requiredLevel'
    >[];
  })[];
  residentPens: Omit<NonNullable<FarmCatalogSource['residentPens']>[number], 'purchasePrice' | 'requiredLevel'>[];
};
