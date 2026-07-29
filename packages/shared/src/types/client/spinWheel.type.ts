import type { WheelConfig, WheelSpinResult } from '../api/wheel.type';

export interface SegmentTheme {
  light: string;
  dark: string;
  stroke: string;
  shadow: string;
}

export interface WheelPoint {
  x: number;
  y: number;
}

export interface WheelDividerLine {
  x1: number;
  y1: number;
  x2: number;
  y2: number;
}

export type WheelConfigStatus = 'idle' | 'loading' | 'ready' | 'error';

export interface SpinWheelState {
  ken: number;
  muted: boolean;
  config: WheelConfig | null;
  configStatus: WheelConfigStatus;
  rotation: number;
  spinning: boolean;
  suppressKenSync: boolean;
  result: WheelSpinResult | null;
  pendingResult: WheelSpinResult | null;
  loadConfig: () => Promise<void>;
  spin: () => Promise<boolean>;
  settle: () => void;
  syncKen: (ken: number) => void;
  closeResult: () => void;
  toggleMute: () => void;
}
