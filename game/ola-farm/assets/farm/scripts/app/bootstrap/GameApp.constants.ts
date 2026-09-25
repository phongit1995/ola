import { HEADER_HEIGHT } from '../../ui/hud/HudView.constants';
import { PLOT_FOOTER_TOP } from '../../ui/crops/PlotFooter.constants';

export const MAP_INSET = { top: HEADER_HEIGHT, bottom: PLOT_FOOTER_TOP + 12 };

export const PAUSED_MESSAGE = 'Nông trại đang tạm dừng.';

/** Toast center above navigation, the seed footer or a panel's footer buttons. */
export const TOAST_ABOVE_NAVIGATION = 148,
  TOAST_ABOVE_FOOTER = PLOT_FOOTER_TOP + 128,
  TOAST_ABOVE_PANEL = 24;
