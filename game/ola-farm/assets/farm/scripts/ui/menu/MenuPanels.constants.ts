import { Color } from 'cc';

export const GROUP_NAMES = { crop: 'Ruộng', pen: 'Chuồng', pond: 'Ô ao' } as const;

/** Opened by the "+" on the gem box. Mock only: the farm has no gem source yet, so the packs are shown but not for sale. */
export const GEM_PACKS = [
  { gems: 20, price: '0,99 $' },
  { gems: 120, price: '4,99 $' },
  { gems: 300, price: '9,99 $' },
];

export const MENU_ROW_COLOR = new Color(250, 240, 195);
export const MENU_QUESTION_COLOR = new Color(252, 242, 197, 240);
export const MENU_INPUT_COLOR = new Color(255, 250, 225);
