import type { FarmState } from './StateTypes';

export interface StoragePort {
  getItem(key: string): string | null;
  setItem(key: string, value: string): void;
}

export interface FarmSettings {
  speed: number;
  sound: boolean;
  music: boolean;
}

export interface FarmClock {
  version: 1;
  savedAt: number;
  running: boolean;
}

export interface FarmPack {
  version: 2 | 4 | 5 | 6;
  contentProfile?: 'simple-1';
  current: 'free';
  free: FarmState;
  settings: FarmSettings;
  clock?: FarmClock;
}
