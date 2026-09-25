/** Supported animal-slot ceiling and fallback when gameplay.json is absent. */
export const PEN_CAPACITY_LIMIT = 5;

/** Fallback site-only fees; opening a slot also buys an animal. Indexed by current capacity. */
export const PEN_CAPACITY_PRICES = [0, 45, 75, 120, 180];

/** Fallback chicken/cow player levels, indexed by the zero-based animal slot. */
export const PEN_SLOT_LEVELS = [1, 2, 3, 4, 5];

export const penNames: Record<string, string> = {
  layer: 'Chuồng gà',
  'dairy-cow': 'Chuồng bò',
  pig: 'Chuồng heo',
  sheep: 'Chuồng cừu',
};
