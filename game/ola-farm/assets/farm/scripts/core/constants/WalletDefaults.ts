/** Fallback diamond-to-coin packs for catalogs that predate economy.json. */
export const COIN_PACKS: ReadonlyArray<{ coins: number; diamonds: number }> = [
  { coins: 1000, diamonds: 5 },
  { coins: 2200, diamonds: 10 },
  { coins: 5000, diamonds: 20 },
];
