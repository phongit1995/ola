import { Color } from 'cc';

/** String keys for each plot group's name; translate with `t` where it is shown. */
export const GROUP_NAMES = { crop: 'plots.groupCrop', pen: 'plots.groupPen', pond: 'plots.groupPond' } as const;

export const MENU_ROW_COLOR = new Color(250, 240, 195);
export const MENU_QUESTION_COLOR = new Color(252, 242, 197, 240);
export const MENU_INPUT_COLOR = new Color(255, 250, 225);
