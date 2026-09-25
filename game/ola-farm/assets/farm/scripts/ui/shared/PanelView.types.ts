import type { PANEL_VIEWS } from './PanelView.enum';

export type PanelView = (typeof PANEL_VIEWS)[keyof typeof PANEL_VIEWS];
