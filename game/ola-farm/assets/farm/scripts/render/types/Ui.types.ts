import type { UI_THEMES, BUTTON_VARIANTS } from '../enums/UiTheme.enum';

export type Theme = (typeof UI_THEMES)[keyof typeof UI_THEMES];

export type ButtonVariant = (typeof BUTTON_VARIANTS)[keyof typeof BUTTON_VARIANTS];

export interface ButtonOptions {
  icon?: string;
  enabled?: boolean;
  variant?: ButtonVariant;
}

/** Widget edges in design units; set both opposite edges to stretch. Centers are offsets from the parent center. */
export interface Alignment {
  top?: number;
  bottom?: number;
  left?: number;
  right?: number;
  centerX?: number;
  centerY?: number;
}
